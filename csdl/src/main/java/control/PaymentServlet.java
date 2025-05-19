package control;

import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.DAO;
import entity.User;
import util.QRCodeGenerator;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    // Check if user is logged in
	    HttpSession session = request.getSession();
	    User user = (User) session.getAttribute("user");
	    
	    if (user == null) {
	        response.sendRedirect("login");
	        return;
	    }
	    
	    // Check if booking exists
	    Integer bookingId = (Integer) session.getAttribute("bookingId");
	    BigDecimal roomPrice = (BigDecimal) session.getAttribute("roomPrice");
	    
	    if (bookingId == null || roomPrice == null) {
	        response.sendRedirect("Home");
	        return;
	    }
	    
	    // Generate QR code for payment
	    String paymentInfo = "Chuyển khoản đến STK: 0123456789, Ngân hàng: VCB, Số tiền: " + 
	                         roomPrice + " VND, Nội dung: BOOKING " + bookingId;
	    
	    try {
	        String qrCodeBase64 = QRCodeGenerator.generateQRCodeBase64(paymentInfo, 300, 300);
	        request.setAttribute("qrCode", qrCodeBase64);
	        request.setAttribute("amount", roomPrice);
	        request.getRequestDispatcher("payment.jsp").forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Có lỗi xảy ra khi tạo mã QR. Vui lòng thử lại!");
	        request.getRequestDispatcher("payment.jsp").forward(request, response);
	    }
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    User user = (User) session.getAttribute("user");
	    
	    if (user == null) {
	        response.sendRedirect("login");
	        return;
	    }
	    
	    Integer bookingId = (Integer) session.getAttribute("bookingId");
	    BigDecimal roomPrice = (BigDecimal) session.getAttribute("roomPrice");
	    
	    if (bookingId == null || roomPrice == null) {
	        response.sendRedirect("Home");
	        return;
	    }
	    
	    // Generate transaction ID
	    String transactionId = "TX" + System.currentTimeMillis();
	    
	    // Save payment information
	    DAO dao = new DAO();
	    dao.savePayment(transactionId, bookingId, user.getUserId(), roomPrice);
	    
	    // Update booking status
	    dao.updateBookingStatus(bookingId, "confirmed");
	    
	    // Save transaction ID in session
	    session.setAttribute("transactionId", transactionId);
	    
	    // Clean up session
	    session.removeAttribute("bookingRoomId");
	    session.removeAttribute("bookingCheckIn");
	    session.removeAttribute("bookingCheckOut");
	    session.removeAttribute("bookingGuests");
	    session.removeAttribute("bookingId");
	    session.removeAttribute("roomPrice");
	    
	    // Redirect to success page
	    response.sendRedirect("payment-success.jsp");
	}
}
