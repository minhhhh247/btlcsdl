package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.DAO;
import entity.User;
import entity.room;
import util.PasswordHasher;
import util.EmailSender;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    // Check if user is logged in
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    
    if (user == null) {
        // If not logged in, redirect to login page
        session.setAttribute("redirectURL", "booking?roomId=" + request.getParameter("roomId") + 
                                           "&checkIn=" + request.getParameter("checkIn") + 
                                           "&checkOut=" + request.getParameter("checkOut") + 
                                           "&guests=" + request.getParameter("guests"));
        response.sendRedirect("login");
        return;
    }
    
    String roomId = request.getParameter("roomId");
    String checkIn = request.getParameter("checkIn");
    String checkOut = request.getParameter("checkOut");
    String guests = request.getParameter("guests");
    
    DAO dao = new DAO();
    room roomDetail = dao.GetRoom(roomId);
    
    request.setAttribute("room", roomDetail);
    request.setAttribute("checkIn", checkIn);
    request.setAttribute("checkOut", checkOut);
    request.setAttribute("guests", guests);
    
    request.getRequestDispatcher("booking.jsp").forward(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    
    String action = request.getParameter("action");
    
    if (action == null) {
        // Step 1: Collect booking information
        String roomId = request.getParameter("roomId");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");
        String guests = request.getParameter("guests");
        
        // Validate input
        if (roomId == null || checkIn == null || checkOut == null || guests == null || 
            roomId.isEmpty() || checkIn.isEmpty() || checkOut.isEmpty() || guests.isEmpty()) {
            
            response.sendRedirect("Home");
            return;
        }
        
        // Save booking information in session
        session.setAttribute("bookingRoomId", roomId);
        session.setAttribute("bookingCheckIn", checkIn);
        session.setAttribute("bookingCheckOut", checkOut);
        session.setAttribute("bookingGuests", guests);
        
        // Generate verification code
        String verificationCode = PasswordHasher.generateVerificationCode();
        
        // Save verification code to database
        DAO dao = new DAO();
        dao.saveVerificationCode(user.getEmail(), verificationCode, "booking");
        
        // Send verification code to email
        EmailSender.sendVerificationCode(user.getEmail(), verificationCode, "booking");
        
        // Redirect to verification page
        response.sendRedirect("booking?action=verify");
        
    } else if (action.equals("verify")) {
        // Step 2: Verify email
        request.getRequestDispatcher("booking-verify.jsp").forward(request, response);
        
    } else if (action.equals("complete")) {
        // Step 3: Complete booking
        String verificationCode = request.getParameter("verificationCode");
        
        if (verificationCode == null || verificationCode.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập mã xác nhận!");
            request.getRequestDispatcher("booking-verify.jsp").forward(request, response);
            return;
        }
        
        DAO dao = new DAO();
        
        // Verify the code
        if (dao.verifyCode(user.getEmail(), verificationCode, "booking")) {
            // Booking verification successful
            String roomId = (String) session.getAttribute("bookingRoomId");
            String checkIn = (String) session.getAttribute("bookingCheckIn");
            String checkOut = (String) session.getAttribute("bookingCheckOut");
            String guests = (String) session.getAttribute("bookingGuests");
            
            // Create booking in database
            int bookingId = dao.createBooking(user.getUserId(), roomId, checkIn, checkOut, Integer.parseInt(guests));
            
            if (bookingId > 0) {
                // Save booking ID in session
                session.setAttribute("bookingId", bookingId);
                
                // Get room details for payment
                room roomDetail = dao.GetRoom(roomId);
                session.setAttribute("roomPrice", roomDetail.getPrice());
                
                // Redirect to payment page
                response.sendRedirect("payment");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi đặt phòng. Vui lòng thử lại!");
                request.getRequestDispatcher("booking.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Mã xác nhận không đúng hoặc đã hết hạn!");
            request.getRequestDispatcher("booking-verify.jsp").forward(request, response);
        }
    }
}
}