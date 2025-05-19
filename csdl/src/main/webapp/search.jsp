<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm khách sạn & phòng - RBook</title>
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
                        <a class="nav-link active" href="search">
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
                    <li class="breadcrumb-item"><a href="Home">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Tìm kiếm</li>
                </ol>
            </nav>
        </div>

		<div class="card border-0 shadow mb-5">
            <div class="card-body p-4">
                <form id="searchForm" class="row g-3" action="Search" method="get">
                    <div class="col-md-3">
                        <label for="location" class="form-label">Nơi ở</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                            <input type="text" class="form-control" id="location" name="location" placeholder="Tất cả địa điểm" value="${param.location}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="checkInDate" class="form-label">Ngày Nhận Phòng</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
							<input type="date" class="form-control" id="checkInDate" name="check_in" value="${param.check_in}">                        
       					</div>
                    </div>
                    <div class="col-md-3">
                        <label for="checkOutDate" class="form-label">Ngày Trả Phòng</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                            <input type="date" class="form-control" id="checkOutDate" name="check_out" value="${param.check_out}">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <label for="guests" class="form-label">Số khách</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <select class="form-select" id="guests" name="guests">
							    <option value="1" ${param.guests == '1' ? 'selected' : ''}>1 khách</option>
							    <option value="2" ${param.guests == '2' ? 'selected' : ''}>2 khách</option>
							    <option value="3" ${param.guests == '3' ? 'selected' : ''}>3 khách</option>
							    <option value="4" ${param.guests == '4' ? 'selected' : ''}>4 khách</option>
							    <option value="5" ${param.guests == '5' ? 'selected' : ''}>5 khách</option>
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
		
        <div class="row">
            <!-- Filters Sidebar -->
            <div class="col-lg-3 mb-4">
                <div class="card border-0 shadow sticky-top" style="top: 2rem">
                    <div class="card-body p-4">
                        <h2 class="h5 mb-4">Bộ lọc tìm kiếm</h2>
                        <form id="filterForm">
                            <!-- Price Range Filter -->
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Khoảng giá (VNĐ/đêm)</h6>
                                <div class="mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input price-filter" type="checkbox" value="0-1000000" id="price1">
                                        <label class="form-check-label" for="price1">Dưới 1.000.000đ</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input price-filter" type="checkbox" value="1000000-2000000" id="price2">
                                        <label class="form-check-label" for="price2">1.000.000đ - 2.000.000đ</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input price-filter" type="checkbox" value="2000000-3000000" id="price3">
                                        <label class="form-check-label" for="price3">2.000.000đ - 3.000.000đ</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input price-filter" type="checkbox" value="3000000-5000000" id="price4">
                                        <label class="form-check-label" for="price4">3.000.000đ - 5.000.000đ</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input price-filter" type="checkbox" value="5000000-0" id="price5">
                                        <label class="form-check-label" for="price5">Trên 5.000.000đ</label>
                                    </div>
                                </div>
                            </div>
                            <!-- Bed Type Filter -->
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Loại giường</h6>
                                <div class="mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input bed-filter" type="checkbox" value="single" id="bed1">
                                        <label class="form-check-label" for="bed1">Giường đơn</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input bed-filter" type="checkbox" value="double" id="bed2">
                                        <label class="form-check-label" for="bed2">Giường đôi</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input bed-filter" type="checkbox" value="queen" id="bed3">
                                        <label class="form-check-label" for="bed3">Giường Queen size</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input bed-filter" type="checkbox" value="king" id="bed4">
                                        <label class="form-check-label" for="bed4">Giường King size</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input bed-filter" type="checkbox" value="twin" id="bed5">
                                        <label class="form-check-label" for="bed5">Hai giường đơn</label>
                                    </div>
                                </div>
                            </div>
                            <!-- Room Capacity Filter -->
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Sức chứa</h6>
                                <div class="mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input capacity-filter" type="checkbox" value="1" id="capacity1">
                                        <label class="form-check-label" for="capacity1">1 người</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input capacity-filter" type="checkbox" value="2" id="capacity2">
                                        <label class="form-check-label" for="capacity2">2 người</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input capacity-filter" type="checkbox" value="3" id="capacity3">
                                        <label class="form-check-label" for="capacity3">3 người</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input capacity-filter" type="checkbox" value="4" id="capacity4">
                                        <label class="form-check-label" for="capacity4">4 người</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input capacity-filter" type="checkbox" value="5" id="capacity5">
                                        <label class="form-check-label" for="capacity5">5+ người</label>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 d-flex justify-content-center align-items-center gap-2">
                                <i class="fas fa-filter"></i> Áp dụng bộ lọc
                            </button>
                            <button type="button" id="resetFilters" class="btn btn-outline-secondary w-100 mt-2 d-flex justify-content-center align-items-center gap-2">
                                <i class="fas fa-redo"></i> Xóa bộ lọc
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Search Results -->
            <div class="col-lg-9">
                <!-- Search Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3">Kết quả tìm kiếm</h1>
                    <div class="d-flex align-items-center">
                        <span class="me-2">Sắp xếp theo:</span>
                        <select class="form-select form-select-sm" id="sortBy" style="width: auto;">
                            <option value="price_asc">Giá: thấp đến cao</option>
                            <option value="price_desc">Giá: cao đến thấp</option>
                        </select>
                    </div>
                </div>
                <!-- Search Results Container -->
                <div id="searchResults">
                    <!-- Results Count -->
                    <div class="alert alert-light border mb-4" role="alert">
                        <i class="fas fa-info-circle me-2"></i>
                        <span id="resultsCount">${fn:length(listRooms)}</span> kết quả phù hợp với tiêu chí tìm kiếm của bạn
                    </div>
                    <!-- Results List -->
                    <div id="resultsList">

	                    <c:forEach items="${listRooms}" var="o">
		                    <div class="card border-0 shadow-sm mb-4 overflow-hidden">
	                            <div class="row g-0">
	                                <div class="col-md-4">
	                                    <div class="ratio ratio-4x3 h-100">
	                                        <img src="${o.image }" class="img-fluid rounded-start" alt="Phòng Deluxe Hướng Biển" style="object-fit: cover;">
	                                    </div>
	                                </div>
	                                <div class="col-md-8">
	                                    <div class="card-body p-4">
	                                        <div class="d-flex justify-content-between align-items-start mb-2">
	                                            <div>
	                                                <h5 class="card-title mb-1">${o.type }</h5>
	                                                <p class="card-subtitle mb-2">
	                                                    <a href="hotel?hotelId=${o.hotel_id }" class="text-decoration-none bg-opacity-25 bg-secondary text-light rounded-1">${o.htname }</a>
	                                                    <span class="text-muted ms-2"><i class="fas fa-map-marker-alt me-1"></i>${o.address }</span>
	                                                </p>
	                                            </div>
	                                            <div class="text-end">
	                                                <div class="h5 mb-0 text-primary"><fmt:formatNumber value="${o.price}" type="number" groupingUsed="true" maxFractionDigits="0" />VNĐ</div>
	                                                <small class="text-muted">một đêm</small>
	                                            </div>
	                                        </div>
	                                        <div class="d-flex mb-3">
	                                            <div class="me-3"><i class="fas fa-bed text-primary me-1"></i> Giường ${o.bed_type}</div>
	                                            <div class="me-3"><i class="fas fa-user-friends text-primary me-1"></i> ${o.max } khách</div>
	                                            <div><i class="fas fa-expand-arrows-alt text-primary me-1"></i> ${o.size } m²</div>
	                                        </div>
	                                        <p class="card-text mb-3">${o.des}</p>
	                                        <div class="d-flex flex-wrap mb-3">
	                                            <span class="badge bg-light text-dark border me-1 mb-1">WiFi miễn phí</span>
	                                        </div>
	                                        <div class="d-flex justify-content-between align-items-center mt-auto">
	                                            <div class="small rating" data-rating="${o.rate}">

												    <small class="text-muted ms-1">(${o.rate})</small>
												</div>
	                                            <div>
	                                                <a href="room?roomID=${o.id }" class="btn btn-sm btn-outline-primary me-2"><i class="fas fa-info-circle me-1"></i> Chi tiết</a>
	                                                <a href="#" class="btn btn-sm btn-primary"><i class="fas fa-check-circle me-1"></i> Đặt ngay</a>
	                                            </div>
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
                        <li><i class="fas fa-envelope me-2"></i><a href="mailto:support@rbook.com">support@rbook.com</a></li>
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
                <p class="mb-0">© 2025 RBook. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- JavaScript -->
    <script>
    function generateRatingStars(rating) {
        const fullStars = Math.floor(rating);
        const hasHalfStar = rating % 1 >= 0.5;
        let stars = '';
        
        for (let i = 0; i < fullStars; i++) {
            stars += '<i class="fas fa-star text-warning"></i>';
        }
        
        if (hasHalfStar) {
            stars += '<i class="fas fa-star-half-alt text-warning"></i>';
        }
        
        const emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
        for (let i = 0; i < emptyStars; i++) {
            stars += '<i class="far fa-star text-warning"></i>';
        }
        
        return stars;
    }

    document.addEventListener("DOMContentLoaded", function () {
        const ratingElements = document.querySelectorAll(".rating");

        ratingElements.forEach(function (el) {
            const rating = parseFloat(el.getAttribute("data-rating"));
            const stars = generateRatingStars(rating);

            // Tìm phần tử <small> để giữ nguyên
            const small = el.querySelector("small");
            el.innerHTML = stars;

            // Thêm lại phần <small> vào sau
            if (small) {
                el.appendChild(small);
            }
        });
    });
	    

	 // Hàm xử lý cho radio behavior với checkboxes (chỉ cho phép chọn một trong mỗi nhóm filter)
	 function setupFilterGroups() {
	     const filterGroups = [
	         document.querySelectorAll('input.price-filter'),
	         document.querySelectorAll('input.bed-filter'),
	         document.querySelectorAll('input.capacity-filter')
	     ];
	     
	     filterGroups.forEach(group => {
	         group.forEach(checkbox => {
	             checkbox.addEventListener('change', function() {
	                 if (this.checked) {
	                     // Bỏ chọn tất cả checkbox khác trong cùng nhóm
	                     group.forEach(item => {
	                         if (item !== this) {
	                             item.checked = false;
	                         }
	                     });
	                 }
	             });
	         });
	     });
	 }

	 // Hàm thiết lập ngày mặc định cho form tìm kiếm
	 function setupDefaultDates() {
	     const today = new Date();
	     const tomorrow = new Date(today);
	     tomorrow.setDate(tomorrow.getDate() + 1);
	     
	     // Format dates as YYYY-MM-DD
	     const formatDate = (date) => {
	         const year = date.getFullYear();
	         const month = String(date.getMonth() + 1).padStart(2, '0');
	         const day = String(date.getDate()).padStart(2, '0');
	         return `${year}-${month}-${day}`;
	     };
	     
	     document.getElementById('checkInDate').value = formatDate(today);
	     document.getElementById('checkOutDate').value = formatDate(tomorrow);
	 }

	 // Hàm đặt lại tất cả các bộ lọc
	 function resetFilters() {
	     document.querySelectorAll('input[type="checkbox"]').forEach(checkbox => {
	         checkbox.checked = false;
	     });
	     document.getElementById('sortBy').value = 'price_asc';
	     displaySearchResults(roomData);
	 }

	 document.addEventListener('DOMContentLoaded', function() {
	     // Thiết lập nhóm bộ lọc hoạt động như radio buttons
	     setupFilterGroups();

	 });
    </script>
</body>
</html>