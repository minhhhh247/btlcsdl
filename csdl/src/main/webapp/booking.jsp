<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt phòng</title>
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
                        <h1 class="h3 mb-0">Đặt phòng</h1>
                    </div>
                    <div class="card-body">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="room-info">
                                    <h4>Thông tin phòng</h4>
                                    <hr>
                                    <p><strong>Loại phòng:</strong> ${room.type}</p>
                                    <p><strong>Khách sạn:</strong> ${room.hotelName}</p>
                                    <p><strong>Địa chỉ:</strong> ${room.address}</p>
                                    <p><strong>Giá:</strong> ${room.price} VND/đêm</p>
                                    <p><strong>Check-in:</strong> ${checkIn}</p>
                                    <p><strong>Check-out:</strong> ${checkOut}</p>
                                    <p><strong>Số khách:</strong> ${guests}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="user-info">
                                    <h4>Thông tin người đặt</h4>
                                    <hr>
                                    <p><strong>Họ tên:</strong> ${sessionScope.user.fullName}</p>
                                    <p><strong>Email:</strong> ${sessionScope.user.email}</p>
                                    <p><strong>CCCD:</strong> ${sessionScope.user.citizenId}</p>
                                    <p><strong>Địa chỉ:</strong> ${sessionScope.user.address}</p>
                                </div>
                            </div>
                        </div>
                        
                        <form action="booking" method="post" class="text-center">
                            <input type="hidden" name="roomId" value="${room.id}">
                            <input type="hidden" name="checkIn" value="${checkIn}">
                            <input type="hidden" name="checkOut" value="${checkOut}">
                            <input type="hidden" name="guests" value="${guests}">
                            
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-calendar-check me-2"></i>Tiếp tục đặt phòng
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
