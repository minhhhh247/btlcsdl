<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RBook - Chi tiết khách sạn</title>
    <link rel="stylesheet" href="https://cdn.replit.com/agent/bootstrap-agent-dark-theme.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="custom.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Custom styles */
        .hotel-image {
            height: 350px;
            background-size: cover;
            background-position: center;
            background-image: url('${h.image}');
        }
        
        .sticky-sidebar {
            position: sticky;
            top: 20px;
        }
        
        .room-card {
            transition: transform 0.2s ease-in-out;
        }
        
        .room-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-hotel me-2"></i>RBook
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-home me-1"></i> Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-search me-1"></i> Tìm Kiếm
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mb-5">
        <div class="mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Chi tiết khách sạn</li>
                </ol>
            </nav>
        </div>

        <!-- Hotel Details Container -->
        <div id="hotelDetails">
            <!-- Hotel Header -->
            <div class="card border-0 shadow mb-4">
                <div class="hotel-image"></div>
                <div class="card-body p-4">
                    <div class="row">
                        <div class="col-md-8">
                            <h1 class="card-title h3 mb-2">${h.name}</h1>
                            <p class="mb-2">
                                <i class="fas fa-map-marker-alt text-primary me-2"></i>
                                ${h.address}
                            </p>
                            <div class="mb-2">
                                <i class="fas fa-star text-warning me-1"></i>
				                <span class="fw-medium text-muted">${h.rate}/5.0</span>
                            </div>
                            <p class="mb-0">Giá từ: 
                            <fmt:formatNumber value="${h.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ/ đêm</p>
                        </div>
                        <div class="col-md-4 text-md-end mt-3 mt-md-0">
                            <a href="#roomsSection" class="btn btn-primary">
                                <i class="fas fa-check-circle me-2"></i>Đặt phòng ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hotel Description -->
            <div class="row mb-5 gx-4">
                <div class="col-lg-8 mb-4 mb-lg-0">
                    <div class="card border-0 shadow">
                        <div class="card-body p-4">
                            <h2 class="h5 mb-3">Mô tả</h2>
                            <p class="mb-4">${h.description}</p>
                            
                            <h2 class="h5 mb-3">Tiện nghi</h2>
                            <div class="row mb-4">
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-wifi text-primary me-2"></i>
                                        <span>Wifi miễn phí</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-swimming-pool text-primary me-2"></i>
                                        <span>Hồ bơi ngoài trời</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-spa text-primary me-2"></i>
                                        <span>Spa</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-utensils text-primary me-2"></i>
                                        <span>Nhà hàng</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-glass-martini-alt text-primary me-2"></i>
                                        <span>Quầy bar</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-dumbbell text-primary me-2"></i>
                                        <span>Phòng gym</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-shuttle-van text-primary me-2"></i>
                                        <span>Đưa đón sân bay</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-parking text-primary me-2"></i>
                                        <span>Bãi đậu xe</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-concierge-bell text-primary me-2"></i>
                                        <span>Dịch vụ phòng 24/7</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-handshake text-primary me-2"></i>
                                        <span>Phòng họp / Hội nghị</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-tshirt text-primary me-2"></i>
                                        <span>Dịch vụ giặt ủi</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-wind text-primary me-2"></i>
                                        <span>Máy lạnh</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="card border-0 shadow sticky-sidebar">
                        <div class="card-body p-4">
                            <h2 class="h5 mb-3">Tìm kiếm phòng</h2>
                            <form action="#roomsSection">
                                <div class="mb-3">
                                    <label for="checkInDate" class="form-label">Ngày nhận phòng</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                                        <input type="date" class="form-control" id="checkInDate" value="2025-05-11">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="checkOutDate" class="form-label">Ngày trả phòng</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                                        <input type="date" class="form-control" id="checkOutDate" value="2025-05-12">
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label for="guests" class="form-label">Số khách</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <select class="form-select" id="guests">
                                            <option value="1">1 khách</option>
                                            <option value="2" selected>2 khách</option>
                                            <option value="3">3 khách</option>
                                            <option value="4">4 khách</option>
                                            <option value="5">5 khách</option>
                                        </select>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 d-flex justify-content-center align-items-center gap-2">
                                    <i class="fas fa-search"></i> Tìm phòng
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Rooms Section -->
            <div id="roomsSection">
            <h2 class="h4 mb-4">Danh sách các phòng</h2>
            <div>
            
		            <c:forEach items="${r}" var="o">
		            	<!-- Room 1 -->
		                    <div class="card border-0 shadow-sm mb-4 room-card">
		                        <div class="card-body p-4">
		                            <div class="row">
		                                <div class="col-md-8">
		                                    <h3 class="h5 mb-2">${o.type}</h3>
		                                    <div class="mb-3">
												<span class="badge ${o.status == 'Còn trống' ? 'bg-success' : 'bg-danger'} me-2">${o.status}</span>
		                                        <span class="text-muted small">
		                                            <i class="fas fa-user me-1"></i> Tối đa ${o.max} khách
		                                        </span>
		                                    </div>
		                                    <p class="mb-3 small">${o.description}</p>
		                                    
		                                    
		                                    <div class="d-flex flex-wrap mb-0 gap-2">
		                                        <div class="small px-2 py-1 bg-opacity-25 bg-secondary text-light rounded-1">
		                                            <i class="fas fa-bed text-primary me-1"></i> ${o.bed_num} giường ${o.bed_type} size
		                                        </div>
		                                        <div class="small px-2 py-1 bg-opacity-25 bg-secondary text-light rounded-1">
		                                            <i class="fas fa-expand-arrows-alt text-primary me-1"></i> ${o.roomsize} m²
		                                        </div>
		                                        <div class="small px-2 py-1 bg-opacity-25 bg-secondary text-light rounded-1">
		                                            <i class="fas fa-wifi text-primary me-1"></i> Wifi miễn phí
		                                        </div>
		                                    </div>                         
		                                    
		                                </div>
		                                
		                                <div class="col-md-4 mt-3 mt-md-0 d-flex flex-column align-items-md-end justify-content-between">
		                                    <div class="text-md-end mb-3 mb-md-0">
		                                        <div class="fs-4 fw-bold mb-1"><fmt:formatNumber value="${o.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ</div>
		                                        <div class="text-muted small">một đêm, đã bao gồm thuế</div>
		                                    </div>
		                                    
		                                    <div class="d-flex flex-column gap-2 w-100 align-items-end">
		                                        <a href="room?roomID=${o.room_id}" class="btn btn-sm btn-outline-primary">
		                                            <i class="fas fa-info-circle me-1"></i> Chi tiết phòng
		                                        </a>
		                                        <c:choose>
											        <c:when test="${o.status == 'Còn trống'}">
											            <a href="room?roomID=${o.room_id}" class="btn btn-primary">
											                <i class="fas fa-check-circle me-2"></i>Đặt phòng
											            </a>
											        </c:when>
											        <c:otherwise>
											            <button class="btn btn-secondary" disabled>
											                <i class="fas fa-times-circle me-2"></i>Đã hết phòng
											            </button>
											        </c:otherwise>
											    </c:choose>
		                                    </div>
		                                    
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		            </c:forEach>
		            
		            
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
                        <li><i class="fas fa-envelope me-2"></i>info@rbook.com</li>
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

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>