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
import util.PasswordHasher;
import util.EmailSender;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            // Step 1: Check credentials
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng nhập email và mật khẩu!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            DAO dao = new DAO();
            
            // Check if email exists
            if (!dao.checkEmailExists(email)) {
                request.setAttribute("errorMessage", "Email không tồn tại trong hệ thống!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Check password
            if (!dao.checkPassword(email, password)) {
                request.setAttribute("errorMessage", "Mật khẩu không đúng!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Generate verification code
            String verificationCode = PasswordHasher.generateVerificationCode();
            
            // Save verification code to database
            dao.saveVerificationCode(email, verificationCode, "login");
            
            // Send verification code to email
            EmailSender.sendVerificationCode(email, verificationCode, "login");
            
            // Save email in session for later use
            HttpSession session = request.getSession();
            session.setAttribute("loginEmail", email);
            
            // Redirect to verification page
            response.sendRedirect("login?action=verify");
            
        } else if (action.equals("verify")) {
            // Step 2: Verify email
            request.getRequestDispatcher("login-verify.jsp").forward(request, response);
            
        } else if (action.equals("complete")) {
            // Step 3: Complete login
            String verificationCode = request.getParameter("verificationCode");
            
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("loginEmail");
            
            if (email == null || verificationCode == null || email.isEmpty() || verificationCode.isEmpty()) {
                request.setAttribute("errorMessage", "Thông tin không hợp lệ!");
                request.getRequestDispatcher("login-verify.jsp").forward(request, response);
                return;
            }
            
            DAO dao = new DAO();
            
            // Verify the code
            if (dao.verifyCode(email, verificationCode, "login")) {
                // Login successful, get user from database
                User user = dao.getUserByEmail(email);
                
                // Save user in session
                session.setAttribute("user", user);
                
                // Clean up session
                session.removeAttribute("loginEmail");
                
                // Check if there's a redirect URL
                String redirectURL = (String) session.getAttribute("redirectURL");
                if (redirectURL != null) {
                    session.removeAttribute("redirectURL");
                    response.sendRedirect(redirectURL);
                } else {
                    // Redirect to home page
                    response.sendRedirect("Home");
                }
            } else {
                request.setAttribute("errorMessage", "Mã xác nhận không đúng hoặc đã hết hạn!");
                request.getRequestDispatcher("login-verify.jsp").forward(request, response);
            }
        }
    }
}
