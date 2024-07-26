<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<!-- Bootstrap Icons CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="/css/style.css">
<!-- Font Awesome CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<!-- JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/js/all.min.js"
	integrity="sha512-naukR7I+Nk6gp7p5TMA4ycgfxaZBJ7MO5iC3Fp6ySQyKFHOGfpkSZkYVWV5R7u7cfAicxanwYQ5D1e17EfJcMA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Custom Toast CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<style type="text/css">
.toast-container {
	z-index: 1050;
}

.toast {
	width: 350px;
}

.toast-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0.5rem 1rem;
	border-bottom: 1px solid rgba(0, 0, 0, 0.1);
	border-top-left-radius: calc(0.25rem - 1px);
	border-top-right-radius: calc(0.25rem - 1px);
}

.toast-body {
	padding: 0.75rem 1rem;
}

.toast .btn-close {
	padding: 0.25rem 0.5rem;
	margin: -0.25rem -0.5rem -0.25rem auto;
}

.toast-header.bg-danger {
	background-color: #dc3545;
}

.toast-header.bg-success {
	background-color: #198754;
}

.toast-header.text-white {
	color: #fff;
}

.toast-header .btn-close-white {
	filter: invert(1);
}
</style>
</head>
<body>
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item active text-primary" aria-current="page">Form
				Products</li>
			<li class="breadcrumb-item"><a href="/admin/products/list">List
					Products</a></li>

		</ol>
	</nav>
	<div aria-live="polite" aria-atomic="true" class="position-relative">
		<div class="toast-container position-absolute p-3"
			style="top: 0; right: 0;">
			<!-- Toast for error messages -->
			<c:if test="${not empty errorMessages}">
				<div class="toast show" role="alert" aria-live="assertive"
					aria-atomic="true">
					<div class="toast-header bg-danger text-white">
						<strong class="me-auto">Lỗi</strong>
						<button type="button" class="btn-close btn-close-white"
							data-bs-dismiss="toast" aria-label="Close"></button>
					</div>
					<div class="toast-body">
						<ul>
							<c:forEach var="error" items="${errorMessages}">
								<li>${error}</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty successMessage}">
				<div class="toast show" role="alert" aria-live="assertive"
					aria-atomic="true">
					<div class="toast-header bg-success text-white">
						<strong class="me-auto">Thành công</strong>
						<button type="button" class="btn-close btn-close-white"
							data-bs-dismiss="toast" aria-label="Close"></button>
					</div>
					<div class="toast-body">${successMessage}</div>
				</div>
			</c:if>
		</div>
	</div>

	<div class="container">
		<h1>Cập Nhật Sản Phẩm</h1>
		<!-- Your form here -->
		<form action="${pageContext.request.contextPath}/admin/product/create"
			method="post" enctype="multipart/form-data" class="needs-validation"
			novalidate>
			<div class="card col-1000">
				<div class="card-body">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="productName">Tên sản phẩm:</label> <input
									type="text" class="form-control" id="productName"
									name="productName" value="${itemProd.productName}"
									placeholder="">

							</div>
							<div class="form-group">
								<label for="price">Giá bán:</label> <input type="number"
									class="form-control" id="price" name="price"
									value="${itemProd.price}" placeholder="">

							</div>
							<div class="form-group">
								<label for="manufacturer">Nhà sản xuất:</label> <input
									type="text" class="form-control" id="manufacturer"
									name="manufacturer" value="${itemProd.manufacturer}"
									placeholder="">

							</div>
							<div class="form-group">
								<label for="postingDate">Ngày đăng bán:</label> <input
									type="date" class="form-control" id="postingDate"
									name="postingDate" value="${itemProd.postingDate}"
									placeholder="">

							</div>
							<div class="form-group">
								<label for="img">Hình ảnh:</label> <input type="file"
									class="form-control" id="img" name="img">

								<c:if test="${itemProd.imageId != null}">
									<img
										src="${pageContext.request.contextPath}/Image_SP/${itemProd.imageId.imageName}"
										alt="Product Image"
										style="max-width: 200px; margin-top: 10px;">
								</c:if>
							</div>
							<div class="form-group">
								<label for="publishingYear">Năm xuất bản:</label> <input
									type="number" class="form-control" id="publishingYear"
									name="publishingYear" value="${itemProd.publishingYear}"
									placeholder="">

							</div>
							<div class="form-group">
								<label for="weight">Khối lượng:</label> <input type="text"
									class="form-control" id="weight" name="weight"
									value="${itemProd.weight}" placeholder="">

							</div>

							<div class="form-group">
								<label for="size">Kích thước:</label> <input type="text"
									class="form-control" id="size" name="size"
									value="${itemProd.size}" placeholder="">

							</div>
						</div>
						<div class="col-md-6">

							<div class="form-group">
								<label for="numberOfPages">Số trang:</label> <input type="text"
									class="form-control" id="numberOfPages" name="numberOfPages"
									value="${itemProd.numberOfPages}" placeholder="">

							</div>
							<div class="form-group">
								<label for="language">Ngôn ngữ:</label> <input type="text"
									class="form-control" id="language" name="language"
									value="${itemProd.language}" placeholder="">

							</div>
							<div class="form-group">
								<label for="author">Tác giả:</label> <input type="text"
									class="form-control" id="author" name="author"
									value="${itemProd.author}" placeholder="">

							</div>
							<div class="form-group">
								<label for="description">Mô tả:</label>
								<textarea class="form-control" id="description"
									name="description" rows="5">${itemProd.description}</textarea>

							</div>
							<div class="form-group">
								<label for="quantity">Số lượng:</label> <input type="number"
									class="form-control" id="quantity" name="quantity"
									value="${itemProd.quantity}" placeholder="Số lượng">

							</div>
							<div class="form-group">
								<label for="category" class="form-label">Loại:</label> <select
									class="form-select" name="categoryId">
									<c:forEach var="category" items="${categories}">
										<option value="${category.categoryId}"
											<c:if test="${itemProd.category.categoryId == category.categoryId}">selected</c:if>>${category.categoryName}</option>
									</c:forEach>
								</select>

							</div>
						</div>
					</div>
				</div>
				<div class="card-footer text-muted">
					<button class="btn btn-outline-primary"
						formaction="/admin/products/create">Create</button>
					<!-- <button class="btn btn-outline-success" formaction="/admin/products/update/${itemProd.productId}">Update</button> -->
					<!-- <button class="btn btn-outline-danger" formaction="/admin/products/delete/${itemProd.productId}">Delete</button> -->
					<button class="btn btn-outline-warning"
						formaction="/admin/products/reset">Reset</button>
				</div>
			</div>
		</form>
	</div>

	<script>
		// Auto show toast after 5 seconds
		document.addEventListener('DOMContentLoaded', function() {
			var toastElList = [].slice
					.call(document.querySelectorAll('.toast'));
			var toastList = toastElList.map(function(toastEl) {
				return new bootstrap.Toast(toastEl, {
					delay : 5000
				});
			});
			toastList.forEach(function(toast) {
				toast.show();
			});

			// Custom validation for form
			var forms = document.querySelectorAll('.needs-validation');
			Array.prototype.slice.call(forms).forEach(function(form) {
				form.addEventListener('submit', function(event) {
					if (!form.checkValidity()) {
						event.preventDefault();
						event.stopPropagation();
					}
					form.classList.add('was-validated');
				}, false);
			});
		});
	</script>
</body>
</html>
