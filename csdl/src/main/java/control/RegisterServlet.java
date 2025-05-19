package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.DAO;
import util.PasswordHasher;
import util.EmailSender;
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if (action == null) {
            // Bước 1: Thu thập thông tin
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String citizenId = request.getParameter("citizenId");
            String address = request.getParameter("address");
            
            // Kiểm tra dữ liệu
            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            DAO dao = new DAO();
            
            if (dao.checkEmailExists(email)) {
                request.setAttribute("errorMessage", "Email đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            // Tạo mã xác nhận
            String verificationCode = PasswordHasher.generateVerificationCode();
            
            // Lưu mã xác nhận vào database
            dao.saveVerificationCode(email, verificationCode, "register");
            
            // Gửi mã xác nhận qua email
            EmailSender.sendVerificationCode(email, verificationCode, "register");
            
            // Lưu thông tin vào session
            HttpSession session = request.getSession();
            session.setAttribute("registerFullName", fullName);
            session.setAttribute("registerEmail", email);
            session.setAttribute("registerPassword", password);
            session.setAttribute("registerCitizenId", citizenId);
            session.setAttribute("registerAddress", address);
            
            // Chuyển đến trang xác nhận
            response.sendRedirect("register?action=verify");
            
        } else if (action.equals("verify")) {
            // Bước 2: Hiển thị form nhập mã xác nhận
            request.getRequestDispatcher("register-verify.jsp").forward(request, response);
            
        } else if (action.equals("complete")) {
            // Bước 3: Xác minh mã và hoàn tất đăng ký
            String verificationCode = request.getParameter("verificationCode");
            
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("registerEmail");
            
            DAO dao = new DAO();
            
            // Kiểm tra mã xác nhận
            if (dao.verifyCode(email, verificationCode, "register")) {
                // Đăng ký thành công, lưu vào database
                String fullName = (String) session.getAttribute("registerFullName");
                String password = (String) session.getAttribute("registerPassword");
                String citizenId = (String) session.getAttribute("registerCitizenId");
                String address = (String) session.getAttribute("registerAddress");
                
                dao.registerUser(fullName, email, password, citizenId, address);
                
                // Xóa dữ liệu session
                session.removeAttribute("registerFullName");
                session.removeAttribute("registerEmail");
                session.removeAttribute("registerPassword");
                session.removeAttribute("registerCitizenId");
                session.removeAttribute("registerAddress");
                
                // Thông báo thành công
                request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Mã xác nhận không đúng hoặc đã hết hạn!");
                request.getRequestDispatcher("register-verify.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Chuyển hướng đến trang register.jsp
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

}

