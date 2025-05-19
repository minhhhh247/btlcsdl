<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán thành công</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container py-5">
        <div class="card border-success p-4 mx-auto" style="max-width: 600px;">
            <div class="text-center mb-4">
                <i class="fas fa-check-circle text-success" style="font-size: 5rem;"></i>
                <h1 class="mt-3">Thanh toán thành công!</h1>
            </div>
            
            <div class="success-details">
                <p>Cảm ơn bạn đã đặt phòng tại RBook!</p>
                <p>Mã giao dịch: <strong>${sessionScope.transactionId}</strong></p>
                <p>Chúng tôi đã gửi xác nhận đặt phòng đến email của bạn.</p>
                <p>Bạn có thể xem chi tiết đặt phòng trong phần "Lịch sử đặt phòng" trong tài khoản của mình.</p>
            </div>
            
            <div class="text-center mt-4">
                <a href="Home" class="btn btn-primary">Quay lại trang chủ</a>
                <a href="booking-history" class="btn btn-outline-primary ms-2">Xem lịch sử đặt phòng</a>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <h5>RBook</h5>
                    <p>Trang web đặt phòng khách sạn hàng đầu.</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Liên Hệ</h5>
                    <ul class="list-unstyled">
                        <li><i class="fas fa-envelope me-2"></i><a href="#" class="text-light">support@rbook.com</a></li>
                        <li><i class="fas fa-phone me-2"></i>+84 123 456 789</li>
                    </ul>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Theo Dõi</h5>
                    <div class="d-flex gap-3 fs-4">
                        <a href="#" class="text-light"><i class="fab fa-facebook"></i></a>
                        <a href="#" class="text-light"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-light"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <hr>
            <div class="text-center">
                <p class="mb-0">&copy; 2025 RBook. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
