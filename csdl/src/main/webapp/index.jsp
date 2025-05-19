<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RBook - Đặt Phòng Khách Sạn</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.replit.com/agent/bootstrap-agent-dark-theme.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="custom.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="Home">
                <i class="fas fa-hotel me-2"></i>RBook
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="home">
                            <i class="fas fa-home me-1"></i> Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="search">
                            <i class="fas fa-search me-1"></i> Tìm Kiếm
                        </a>
                    </li>
                </ul>
            </div>
            
            <div class="d-flex">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <div class="dropdown">
                                <button class="btn btn-outline-primary dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-user me-1"></i> Xin chào, ${sessionScope.user.fullName}
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                    <li><a class="dropdown-item" href="profile"><i class="fas fa-user-circle me-2"></i>Thông tin cá nhân</a></li>
                                    <li><a class="dropdown-item" href="booking-history"><i class="fas fa-history me-2"></i>Lịch sử đặt phòng</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="login" class="btn btn-outline-primary me-2">Đăng nhập</a>
                            <a href="register" class="btn btn-primary">Đăng ký</a>
                        </c:otherwise>
                    </c:choose>
                </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mb-5">
        <!-- Hero Banner -->
        <div class="p-5 mb-5 bg-dark text-white rounded-3">
            <div class="container py-5">
                <h1 class="display-4 fw-bold">Tìm Khách Sạn Hoàn Hảo</h1>
                <p class="col-md-8 fs-5">Khám phá hàng ngàn khách sạn trên toàn quốc, đặt phòng nhanh chóng và dễ dàng với giá tốt nhất.</p>
            </div>
        </div>

        <!-- Popular Destinations -->
        <div class="mb-5">
            <div class="container">
                <h2 class="h3 mb-4">Khám Phá Điểm Đến Nổi Tiếng</h2>
                <div class="row g-4">
                	<c:forEach items="${listL}" begin="0" end="7" var="o">
                    	<div class="col-6 col-md-4 col-lg-3">
	                        <div class="card border-0 shadow h-100 overflow-hidden">
	                            <div class="ratio ratio-1x1">
	                                <img src="${o.image}" class="card-img-top" alt="Hà Nội" style="object-fit: cover;">
	                            </div>
								<a href="search?locationID=${o.id}" class="card-img-overlay d-flex align-items-end text-white" style="background: linear-gradient(to top, rgba(0,0,0,0.7), transparent); text-decoration: none;">
	                                <div>
	                                    <h5 class="card-title mb-0">${o.city}</h5>
	                                    <p class="card-text">${o.hotelNumber}+ khách sạn</p>
	                                </div>
	                            </a>
	                        </div>
                    	</div>
                    </c:forEach>                                                  
                </div>
            </div>
        </div>

        <!-- Search Form -->
        <div class="card border-0 shadow mb-5">
            <div class="card-body p-4">
                <h4 class="mb-4">Tìm Kiếm Khách Sạn</h4>
                <form id="searchForm" class="row g-3" action="search.html" method="get">
                    <div class="col-md-3">
                        <label for="location" class="form-label">Nơi ở</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                            <input type="text" class="form-control" id="location" name="location" placeholder="Tất cả địa điểm">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="checkInDate" class="form-label">Ngày Nhận Phòng</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                            <input type="date" class="form-control" id="checkInDate" name="check_in">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="checkOutDate" class="form-label">Ngày Trả Phòng</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                            <input type="date" class="form-control" id="checkOutDate" name="check_out">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <label for="guests" class="form-label">Số khách</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <select class="form-select" id="guests" name="guests">
                                <option value="1">1 khách</option>
                                <option value="2" selected>2 khách</option>
                                <option value="3">3 khách</option>
                                <option value="4">4 khách</option>
                                <option value="5">5 khách</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-1 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search"></i> Tìm
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Loading Indicator -->
        <div id="loadingIndicator" class="text-center my-5 d-none">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Đang tải...</span>
            </div>
            <p class="mt-2">Đang tìm kiếm khách sạn...</p>
        </div>

        <!-- Hotels List -->
        <div id="hotelsList">
            <h2 class="mb-4">Khách Sạn Phổ Biến</h2>
            <div class="row" id="hotelsContainer">


<div class="container my-4">
    <div class="row g-4">
        <!-- Hotel Card Start -->
        
        <c:forEach items="${listHotel}" begin="0" end="5" var="o" >
        	<div class="col-12 col-sm-6 col-lg-4">
	            <div class="card h-100 border-0 shadow rounded-4 overflow-hidden">
	                <div class="ratio ratio-16x9">
	                    <img src="${o.image}" 
	                         class="card-img-top" alt="Sunrise Hotel" style="object-fit: cover;">
	                </div>
	                <div class="card-body p-4">
	                    <h5 class="card-title mb-2 fw-semibold text-primary">${o.name}</h5>
	                    <p class="text-muted small mb-2">
	                        <i class="fas fa-map-marker-alt me-1 text-danger"></i> ${o.address}
	                    </p>
	                    <div class="d-flex align-items-center mb-3">
	                        <i class="fas fa-star text-warning me-1"></i>
	                        <span class="fw-medium text-muted">${o.rate}/5.0</span>
	                    </div>
	                    <p class="card-text text-secondary small mb-4">
	                    	${o.description}
	                    </p>
	                    <div class="d-flex justify-content-between align-items-center">
	                        <span class="fs-5 fw-bold text-success">
	                        <fmt:formatNumber value="${o.price}" type="number" groupingUsed="true" maxFractionDigits="0" />
	                         VNĐ</span>
	                        <a href="hotel?hotelId=${o.id}" class="btn btn-outline-primary btn-sm rounded-pill">
	                            Xem chi tiết
	                        </a>
	                    </div>
	                </div>
	            </div>
	        </div>
        </c:forEach>
        
        <!-- Có thể copy thêm các khối col-... này cho khách sạn khác -->
    </div>
</div>




            </div>
        </div>

        <!-- No Results Found -->
        <div id="noResults" class="text-center my-5 d-none">
            <i class="fas fa-search fa-3x mb-3 text-muted"></i>
            <h4>Không tìm thấy kết quả</h4>
            <p>Vui lòng thử lại với tiêu chí tìm kiếm khác.</p>
        </div>

        <!-- Recently Viewed Hotels -->
        <div class="mb-5">
            <div class="container">
                <h2 class="h3 mb-4">Khách Sạn Đã Tham Khảo Gần Đây</h2>
                <div class="row">
                    <div class="col-md-6 col-lg-3 mb-4">
                        <div class="card h-100 border-0 shadow-sm">
                            <div class="ratio ratio-16x9">
                                <img src="https://placehold.co/600x400?text=Grand+Plaza+Hotel" class="card-img-top" alt="Grand Plaza Hotel" style="object-fit: cover;">
                            </div>
							<div class="card-body">
								<h5 class="card-title mb-2 fw-semibold text-primary">Sunrise
									Hotel</h5>
								<p class="text-muted small mb-2">
									<i class="fas fa-map-marker-alt me-1 text-danger"></i> Hà Nội
								</p>
								<div class="d-flex align-items-center mb-3">
									<i class="fas fa-star text-warning me-1"></i> <span
										class="fw-medium text-muted">4.0/5.0</span>
								</div>
								<p class="card-text small mb-3">Khách sạn 5 sao sang trọng
									nằm ở trung tâm thành phố, gần các điểm tham quan nổi tiếng như
									Hồ Hoàn Kiếm và Phố Cổ.</p>
								<div class="d-flex justify-content-between align-items-center">
									<span class="fs-5 fw-bold text-success">2.000.000 VNĐ</span> <a
										href="/hotel/${hotel.id}"
										class="btn btn-outline-primary btn-sm rounded-pill"> Xem
										chi tiết </a>
								</div>
							</div>
						</div>
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
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS -->
    <script src="js/main.js"></script>
    <script>

    </script>
</body>
</html>