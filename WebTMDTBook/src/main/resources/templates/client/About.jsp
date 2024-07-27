<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Giới Thiệu Trang Web</title>
<link rel="shortcut icon" href="/assets/images/logobook.ico"
	type="image/x-icon">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<!-- Navbar -->
	<jsp:include page="../client_layout/header.jsp"></jsp:include>
	<div class="page-heading normal-space">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h1 style="color: white;">Giới thiệu trang Web</h1>
				</div>
			</div>
		</div>
	</div>
	<!-- Main content -->
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-12">
				<h1 class="text-center">Chào Mừng Đến Với QIBook</h1>
			</div>
		</div>
		<div class="row mt-4">
			<div class="col-md-4">
				<h3 class="text-center">Dịch Vụ</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
					Vivamus lacinia odio vitae vestibulum vestibulum.</p>
			</div>
			<div class="col-md-4">
				<h3 class="text-center">Sản Phẩm</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
					Vivamus lacinia odio vitae vestibulum vestibulum.</p>
			</div>
			<div class="col-md-4">
				<h3 class="text-center">Liên Hệ</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
					Vivamus lacinia odio vitae vestibulum vestibulum.</p>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!-- Footer -->
	<jsp:include page="../client_layout/footer.jsp"></jsp:include>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
