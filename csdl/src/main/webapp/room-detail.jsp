<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phòng - RBook</title>
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
                        <a class="nav-link" href="Home">
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
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mb-5">
        <div class="mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="#">Chi tiết khách sạn</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Chi tiết phòng</li>
                </ol>
            </nav>
        </div>

        <!-- Room Details Content -->
        <div id="roomDetails">
            <!-- Room Header -->
            <div class="row">
                <div class="col-lg-8">
                    <h1 class="h3 mb-2">${rDetail.type}</h1>
                    <p class="mb-3">
                        <span class="fw-bold">${rDetail.hotel_name}</span> - 
                        <span class="text-muted">${rDetail.address}</span>
                    </p>
                </div>
                <div class="col-lg-4 text-lg-end">
                    <div class="h4 mb-1 text-primary"><fmt:formatNumber value="${rDetail.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ
                    </div>
                    <p class="text-muted small">một đêm, đã bao gồm thuế</p>
                </div>
            </div>

            <!-- Room Images -->
            <div class="card border-0 shadow mb-4 overflow-hidden">
                <div id="roomImagesCarousel" class="carousel slide" data-bs-ride="carousel">
                    <ol class="carousel-indicators">
					  <c:forEach var="o" items="${rImage}" varStatus="status">
					    <button type="button"
					            data-bs-target="#roomImagesCarousel"
					            data-bs-slide-to="${status.index}"
					            class="${status.first ? 'active' : ''}"
					            aria-current="${status.first ? 'true' : 'false'}"
					            aria-label="Slide ${status.index + 1}">
					    </button>
					  </c:forEach>
					</ol>
                    <div class="carousel-inner">
                    
                    
                    	<c:forEach var="o" items="${rImage}" varStatus="status">
						    <div class="carousel-item ${status.first ? 'active' : ''}">
						        <div class="ratio ratio-16x9">
						            <img src="${o.image}" class="d-block w-100" alt="Room image" style="object-fit: cover;">
						        </div>
						    </div>
						</c:forEach>


                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#roomImagesCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#roomImagesCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>

            <!-- Room Details -->
            <div class="row gx-4 mb-5">
                <!-- Main Content -->
                <div class="col-lg-8 mb-4 mb-lg-0">
                    <div class="card border-0 shadow">
                        <div class="card-body p-4">
                            <!-- Room Description -->
                            <h2 class="h5 mb-3">Thông tin phòng</h2>
                            <p>${rDetail.description }</p>

                            <!-- Room Key Features -->
                            <div class="row mb-4">
                                <div class="col-md-4 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-ruler-combined text-primary me-2"></i>
                                        <div>
                                            <div class="small text-muted">Kích thước</div>
                                            <div class="fw-bold">${rDetail.roomsize } m²</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-bed text-primary me-2"></i>
                                        <div>
                                            <div class="small text-muted">Loại giường</div>
                                            <div class="fw-bold">${rDetail.bed_num} Giường ${rDetail.bed_type}</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-user-friends text-primary me-2"></i>
                                        <div>
                                            <div class="small text-muted">Sức chứa</div>
                                            <div class="fw-bold">${rDetail.max} người</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Room Features -->
                            <h2 class="h5 mb-3">Tiện nghi phòng</h2>
                            <div class="row">
                                <div class="col-md-6 col-lg-4 mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-wifi text-primary me-2"></i>
                                        <span>Wifi miễn phí</span>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-wind text-primary me-2"></i>
                                        <span>Máy lạnh</span>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-tv text-primary me-2"></i>
                                        <span>TV màn hình phẳng</span>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-glass-whiskey text-primary me-2"></i>
                                        <span>Minibar</span>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-door-open text-primary me-2"></i>
                                        <span>Ban công</span>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4 mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-mountain text-primary me-2"></i>
                                        <span>Tầm nhìn biển</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Booking Panel -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow sticky-top">
                        <div class="card-body p-4">
                            <h2 class="h5 mb-3">Đặt phòng này</h2>
                            <form id="bookingDateForm">
                                <div class="mb-3">
                                    <label for="checkInDateDetail" class="form-label">Ngày nhận phòng</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                                        <input type="date" class="form-control" id="checkInDateDetail" value="2025-05-12">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="checkOutDateDetail" class="form-label">Ngày trả phòng</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                                        <input type="date" class="form-control" id="checkOutDateDetail" value="2025-05-13">
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label for="guestsDetail" class="form-label">Số khách</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <select class="form-select" id="guestsDetail">
                                            <option value="1">1 khách</option>
                                            <option value="2" selected>2 khách</option>
                                            <option value="3">3 khách</option>
                                            <option value="4">4 khách</option>
                                            <option value="5">5 khách</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="mb-4 px-3 py-2 bg-opacity-25 bg-secondary text-light rounded-1">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>1 đêm</span>
                                        <span><fmt:formatNumber value="${rDetail.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <span>Thuế và phí:</span>
                                        <span><fmt:formatNumber value="${rDetail.price*0.1}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ</span>
                                    </div>
                                    <div class="d-flex justify-content-between fw-bold">
                                        <span>Tổng cộng:</span>
                                        <span class="text-primary"><span><fmt:formatNumber value="${rDetail.price*1.1}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ</span></span>
                                    </div>
                                </div>

                                <button type="button" class="btn btn-primary w-100 d-flex justify-content-center align-items-center gap-2" onclick="alert('Đặt phòng thành công! (Đây chỉ là phiên bản tĩnh)')">
                                    <i class="fas fa-check-circle"></i> Đặt ngay
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Similar Rooms -->
            <h2 class="h4 mb-4">Các phòng tương tự</h2>
            <div class="row">
            
            
            	<c:forEach items="${rooms}" var="o">
	            	<div class="col-md-6 col-lg-4 mb-4">
	                    <div class="card h-100 border-0 shadow-sm">
	                        <div class="ratio ratio-4x3">
	                            <img src="${o.image }" class="card-img-top" alt="Phòng Superior" style="object-fit: cover;">
	                        </div>
	                        <div class="card-body">
	                            <h5 class="card-title mb-1">${o.type}</h5>
	                            <p class="text-muted small mb-2">
	                                <i class="fas fa-users me-1"></i> Tối đa ${o.max } khách
	                            </p>
	                            <p class="card-text small mb-3">${o.des}</p>
	                            <div class="d-flex justify-content-between align-items-center">
	                                <span class="fs-5 fw-bold"><fmt:formatNumber value="${o.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ</span>
	                                <a href="room?roomID=${o.id}" class="btn btn-sm btn-outline-primary">Chi tiết</a>
	                            </div>
	                        </div>
	                    </div>
	                </div>
            	</c:forEach>
            
            
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
                        <li><i class="fas fa-envelope me-2"></i><a href="#">support@rbook.com</a></li>
                        <li><i class="fas fa-phone me-2"></i>+84 123 456 789</li>
                    </ul>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Theo Dõi</h5>
                    <div class="d-flex gap-3 fs-4">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
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
    <!-- Simple inline script for the booking button -->
    <script>
        // Set today's date and tomorrow as default values for date inputs
        document.addEventListener('DOMContentLoaded', function() {
            // For demonstration purposes, dates are already set statically in HTML
            
            // Handle click on booking button
            document.querySelector('.btn-primary').addEventListener('click', function() {
                alert('Đặt phòng thành công! (Đây chỉ là phiên bản tĩnh)');
            });
        });
    </script>
</body>
</html>