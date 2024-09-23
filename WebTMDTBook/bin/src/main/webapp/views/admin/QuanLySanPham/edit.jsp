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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="/css/style.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style type="text/css">
.card {
	margin-top: 15px;
	padding: 20px;
}

.form-control {
	font-size: small;
}

.col-form-label {
	font-size: small;
}

a {
	color: black;
	text-decoration: none;
}
</style>
</head>
<body>
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="/admin/products/list">List
					Products</a></li>
			<li class="breadcrumb-item active text-primary" aria-current="page">Form
											Products</li>
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
	<div class="card">
		<div class="card-header">
			<h3>Cập Nhật Khách hàng</h3>
		</div>
		<form
			action="${pageContext.request.contextPath}/admin/products/update/${itemProd.productId}"
			method="post" enctype="multipart/form-data">
			<div class="card col-1000">
				<div class="card-body">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label>Tên sản phẩm:</label> <input type="text"
									class="form-control" id="productName" name="productName"
									value="${itemProd.productName}" placeholder="">
							</div>
							<br>
							<div class="form-group">
								<label>Giá bán:</label> <input type="number"
									class="form-control" id="price" name="price"
									value="${itemProd.price}" placeholder="">
							</div>
							<br>
							<div class="form-group">
								<label>Nhà sản xuất:</label> <input type="text"
									class="form-control" id="manufacturer" name="manufacturer"
									value="${itemProd.manufacturer}" placeholder="">
							</div>
							<br>
							<div class="form-group">
								<label>Ngày đăng bán:</label> <input type="date"
									class="form-control" id="postingDate" name="postingDate"
									value="${itemProd.postingDate}" placeholder="">
							</div>
							<div class="form-group">
								<label>Hình ảnh:</label> <input type="file" class="form-control"
									name="img" /> <br>
								<c:if test="${itemProd.imageId != null}">
									<img
										src="${pageContext.request.contextPath}/Image_SP/${itemProd.imageId.imageName}"
										alt="Product Image" style="max-width: 200px;">
								</c:if>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label>Năm xuất bản:</label> <input type="number"
									class="form-control" id="publishingYear" name="publishingYear"
									value="${itemProd.publishingYear}" placeholder="">
							</div>
							<br>
							<div class="form-group">
								<label>Khối lượng:</label> <input type="text"
									class="form-control" id="weight" name="weight"
									value="${itemProd.weight}" placeholder="">
							</div>
							<br>
							<div class="form-group">
								<label>Kích thước:</label> <input type="text"
									class="form-control" id="size" name="size"
									value="${itemProd.size}" placeholder="">
							</div>
							<br>
							<div class="form-group">
								<label>Số trang:</label> <input type="text" class="form-control"
									id="numberOfPages" name="numberOfPages"
									value="${itemProd.numberOfPages}" placeholder="">
							</div>
							<br>
							<div class="form-group">
								<label>Ngôn ngữ:</label> <input type="text" class="form-control"
									id="language" name="language" value="${itemProd.language}"
									placeholder="">
							</div>
							<br>
							<div class="form-group">
								<label>Tác giả:</label> <input type="text" class="form-control"
									id="author" name="author" value="${itemProd.author}"
									placeholder="">
							</div>
							<br>
							<div class="form-group">
								<label>Mô tả:</label>
								<textarea class="form-control" id="description"
									name="description" rows="5">${itemProd.description}</textarea>
							</div>
							<br>
							<div class="form-group">
								<label>Số lượng:</label> <input type="number" name="quantity"
									id="quantity" value="${itemProd.quantity}" class="form-control"
									placeholder="Số lượng">
							</div>
							<br>
							<div class="form-group">
								<label for="category" class="form-label">Loại:</label> <select
									class="form-select" name="category.categoryId">
									<c:forEach var="category" items="${categories}">
										<option value="${category.categoryId}"
											<c:if test="${itemProd.category.categoryId == category.categoryId}">
                                    selected
                                </c:if>>
											${category.categoryName}</option>
									</c:forEach>
								</select>
							</div>

						</div>
					</div>
				</div>
				<div class="card-footer text-muted">
					<!-- <button class="btn btn-outline-primary"
						formaction="/admin/products/create">Create</button> -->
					<button class="btn btn-outline-success"
						formaction="/admin/products/update/${itemProd.productId}">Update</button>
					<%-- <button class="btn btn-outline-danger"
						formaction="/admin/products/delete/${itemProd.productId}">Delete</button> --%>
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
