<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="author" content="templatemo">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<title>Liberty Template - NFT Item Detail Page</title>

<!-- Bootstrap core CSS -->
<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Additional CSS Files -->
<link rel="stylesheet" href="/assets/css/fontawesome.css">
<link rel="stylesheet" href="/assets/css/templatemo-liberty-market.css">
<link rel="stylesheet" href="/assets/css/owl.css">
<link rel="stylesheet" href="/assets/css/animate.css">
<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />

<style type="text/css">
.a-product {
	transition: all 0.3s ease-in-out;
}
.a-product:hover {
	transform: translateY(-5px);
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
}
.hover-shadow-lg:hover {
	box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.175) !important;
}
.btnn {
	margin-top: 40px;
	margin-left: 20px;
	margin-bottom: 10px;
	width: 220px;
	height: 40px;
}
</style>
</head>

<body>
	<header class="header-area header-sticky">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav navbar navbar-expand-lg navbar-light bg-light">
						<!-- Logo Start -->
						<a href="/home/index" class="logo navbar-brand">
							<img src="/assets/images/logobook.jpg" alt="Logo">
						</a>
						<!-- Logo End -->

						<!-- Menu Start -->
						<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse" id="navbarNav">
							<ul class="nav navbar-nav">
								<li class="nav-item"><a href="/home/index" class="nav-link active">Trang Chủ</a></li>
								<li class="nav-item"><a href="/home/about" class="nav-link">Giới Thiệu</a></li>
								<li class="nav-item"><a href="/home/Contact" class="nav-link">Liên Hệ</a></li>
								<li class="nav-item"><a href="/home/products" class="nav-link">Sản Phẩm</a></li>
								<li class="nav-item dropdown">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" id="accountDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                 Xin chào, <c:out value="${sessionScope.user.fullName}" />
            </c:when>
            <c:otherwise>
                Tài Khoản
            </c:otherwise>
        </c:choose>
    </a>
    <ul class="dropdown-menu" aria-labelledby="accountDropdown">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
            <li><a class="dropdown-item" href="#">Cập Nhật Thông Tin</a></li>
                <li><a class="dropdown-item" href="/home/login/changePassword">Đổi Mật Khẩu</a></li>
                <li><a class="dropdown-item" href="/home/products/details/cart">Giỏ Hàng</a></li>
                <li><a class="dropdown-item" href="#">Đơn Hàng Đã Mua</a></li>
                <li><a class="dropdown-item" href="#">Lịch Sử Đơn Hàng</a></li>
                <li><a class="dropdown-item" href="/home/logout">Đăng Xuất</a></li>
            </c:when>
            <c:otherwise>
                <li><a class="dropdown-item" href="/home/dangky">Đăng Ký</a></li>
                <li><a class="dropdown-item" href="/home/login">Đăng Nhập</a></li>
                <li><a class="dropdown-item" href="/home/forgot-password">Quên Mật Khẩu</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</li>

</li>

							</ul>
						</div>
						<!-- Menu End -->
					</nav>
				</div>
			</div>
		</div>
	</header>
	<!-- Header Area End -->

	

	<!-- Bootstrap core JavaScript -->
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.min.js"></script>

	<script src="/assets/js/isotope.min.js"></script>
	<script src="/assets/js/owl-carousel.js"></script>
	<script src="/assets/js/tabs.js"></script>
	<script src="/assets/js/popup.js"></script>
	<script src="/assets/js/custom.js"></script>
</body>
</html>
