<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container py-5">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h1 class="h3 mb-0">Thanh toán</h1>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("errorMessage") %>
                            </div>
                        <% } %>
                        
                        <div class="alert alert-info">
                            <p>Vui lòng quét mã QR bên dưới để thanh toán.</p>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="payment-details mb-4">
                                    <h4>Thông tin thanh toán</h4>
                                    <hr>
                                    <p><strong>Số tiền:</strong> ${amount} VND</p>
                                    <p><strong>Số tài khoản:</strong> 0123456789</p>
                                    <p><strong>Ngân hàng:</strong> VCB</p>
                                    <p><strong>Chủ tài khoản:</strong> RBOOK HOTEL BOOKING</p>
                                    <p><strong>Nội dung chuyển khoản:</strong> BOOKING ${sessionScope.bookingId}</p>
                                </div>
                            </div>
                            <div class="col-md-6 text-center">
                                <div class="qr-code mb-4">
                                    <img src="data:image/png;base64,${qrCode}" alt="QR Code" class="img-fluid border p-2" style="max-width: 250px;">
                                </div>
                            </div>
                        </div>
                        
                        <form action="payment" method="post" class="text-center">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="fas fa-check-circle me-2"></i>Tôi đã thanh toán
                            </button>
                        </form>
                    </div>
                </div>
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
