package util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailSender {
    
    private static final String EMAIL_USERNAME = "your-email@gmail.com"; // Thay bằng email của bạn
    private static final String EMAIL_PASSWORD = "your-app-password"; // Thay bằng mật khẩu ứng dụng
    
    public static void sendVerificationCode(String recipientEmail, String verificationCode, String purpose) {
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        
        Session session = Session.getInstance(prop,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(recipientEmail)
            );
            
            String subject = "";
            String content = "";
            
            if (purpose.equals("login")) {
                subject = "Mã xác nhận đăng nhập";
                content = "Mã xác nhận đăng nhập của bạn là: " + verificationCode;
            } else if (purpose.equals("register")) {
                subject = "Xác nhận đăng ký tài khoản";
                content = "Mã xác nhận đăng ký tài khoản của bạn là: " + verificationCode;
            } else if (purpose.equals("booking")) {
                subject = "Xác nhận đặt phòng";
                content = "Mã xác nhận đặt phòng của bạn là: " + verificationCode;
            }
            
            message.setSubject(subject);
            message.setText(content);
            
            Transport.send(message);
            
            System.out.println("Email sent successfully to " + recipientEmail);
            
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
