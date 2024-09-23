<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<!-- <!-- link icon -->
<!-- <!-- FontAwesome 6.2.0 CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
	integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- <!-- (Optional) Use CSS or JS implementation -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/js/all.min.js"
	integrity="sha512-naukR7I+Nk6gp7p5TMA4ycgfxaZBJ7MO5iC3Fp6ySQyKFHOGfpkSZkYVWV5R7u7cfAicxanwYQ5D1e17EfJcMA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style type="text/css">
.card {
	margin-top: 15px;
	padding: 20px;
}

.form-check {
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
			<li class="breadcrumb-item text-primary"><a href="/admin">Home</a></li>
			<li class="breadcrumb-item active text-primary" aria-current="page">Vouchers</li>
		</ol>
	</nav>
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-2">
				<h4>Voucher</h4>
				<br>
				<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
					<strong form-check>Loại Voucher</strong>
					<hr>
					<form id="filter-form" onchange="this.submit()">
						<div class="form-group">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="discountTypeId" id="discountTypeAll" value=""
									<c:if test="${empty param.discountTypeId}">checked</c:if>>
								<label class="form-check-label" for="discountTypeAll">Tất
									Cả</label>
							</div>
							<br>
							<c:forEach var="discountType" items="${discountTypes}">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio"
										name="discountTypeId"
										id="discountType-${discountType.discountTypeId}"
										value="${discountType.discountTypeId}"
										<c:if test="${param.discountTypeId == discountType.discountTypeId}">checked</c:if>>
									<label class="form-check-label"
										for="discountType-${discountType.discountTypeId}">${discountType.discountTypeName}</label>
								</div>
							</c:forEach>
						</div>
					</form>
				</div>
			</div>
			<div class="col-md-10">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-2"></div>
						<div class="col-md-5">
							<form class="d-flex" role="search" action="/admin/voucher/list"
								method="get">
								<input class="form-control me-2" type="search"
									placeholder="Tìm kiếm mã voucher" aria-label="Search"
									name="key">
								<button class="btn btn-outline-primary" type="submit"
									id="liveToastBtn">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</form>
						</div>
						<div class="col-md-5 d-flex justify-content-end">
							<a href="/admin/voucher/add">
								<button class="btn btn-primary me-2">
									<i class="fa-solid fa-plus"></i> Thêm mới
								</button>
							</a>
							<!-- 							<a href="/admin/voucher/add" class="btn btn-primary">Thêm</a> -->
							<div class="btn-group">
								<button type="button" class="btn btn-primary dropdown-toggle"
									data-bs-toggle="dropdown" aria-expanded="false">File</button>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="#"><i
											class="fa-solid fa-file-import"></i> Import</a></li>
									<li><a class="dropdown-item" href="#"><i
											class="fa-solid fa-up-right-from-square"></i> Xuất danh sách</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<br>
				<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
					<table class="table table-hover " id="myTable">
						<thead>
							<tr>
								<th>Mã Voucher</th>
								<th>Số Lượng</th>
								<th>Loại Voucher</th>
								<th>Ngày Bắt Đầu</th>
								<th>Ngày Kết Thúc</th>
								<th>Giá Trị Voucher</th>
								<th>Giá Áp Dụng</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${noVouchersFound}">
									<tr>
										<td colspan="9"><label class="text-danger"> Không
												tìm thấy voucher.</label></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="c" items="${vouchers}">
										<tr>
											<td>${c.discountCode}</td>
											<td>${c.quantity}</td>
											<td>${c.discountType.discountTypeName}</td>
											<td>${c.startDate }</td>
											<td>${c.endDate }</td>
											<td><fmt:formatNumber> ${c.discountValue}</fmt:formatNumber> VNĐ</td>
											<td><fmt:formatNumber> ${c.minInvoiceAmount}</fmt:formatNumber>VNĐ</td>
											<td><a href="/admin/voucher/edit/${c.discountId}"
												class="text-primary"> <i
													class="fa-regular fa-pen-to-square"></i>
											</a>|</td>
											<td colspan="1"><a href="#" class="text-danger"
												onclick="confirmDelete(${c.discountId})"> <i
													class="fa-solid fa-trash"></i>
											</a></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="d-flex justify-content-center"
						aria-label="Page navigation example">
						<c:if test="${totalPages > 1}">
							<ul class="pagination">
								<li class="page-item ${pageNo == 0 ? 'disabled' : ''}"><a
									class="page-link" href="/admin/voucher/list?pageNo=0">First</a>
								</li>
								<li class="page-item ${pageNo == 0 ? 'disabled' : ''}"><a
									class="page-link"
									href="/admin/voucher/list?pageNo=${pageNo - 1}">Previous</a></li>
								<c:forEach var="i" begin="0" end="${totalPages - 1}">
									<li class="page-item ${pageNo == i ? 'active' : ''}"><a
										class="page-link" href="/admin/voucher/list?pageNo=${i}">${i + 1}</a>
									</li>
								</c:forEach>
								<li
									class="page-item ${pageNo == totalPages - 1 ? 'disabled' : ''}">
									<a class="page-link"
									href="/admin/voucher/list?pageNo=${pageNo + 1}">Next</a>
								</li>
								<li
									class="page-item ${pageNo == totalPages - 1 ? 'disabled' : ''}">
									<a class="page-link"
									href="/admin/voucher/list?pageNo=${totalPages - 1}">Last</a>
								</li>
							</ul>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<div class="modal fade" id="confirmDeleteModal" tabindex="-1"
	aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="confirmDeleteModalLabel">Xác Nhận
					Xóa</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">Bạn có chắc chắn muốn xóa voucher này
				không?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Hủy</button>
				<a id="confirmDeleteButton" class="btn btn-danger" href="#">Xóa</a>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="messageModal" tabindex="-1"
	aria-labelledby="messageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="messageModalLabel">Thông Báo</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">${message}</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Đóng</button>
			</div>
		</div>
	</div>
</div>
<!-- JavaScript -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(discountId) {
        var confirmDeleteModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
        confirmDeleteModal.show();
        var confirmDeleteButton = document.getElementById('confirmDeleteButton');
        confirmDeleteButton.setAttribute('href', '/admin/voucher/remove/' + discountId);
    }

    $(document).ready(function() {
        var deleteSuccess = "${deleteSuccess}";
        if (deleteSuccess === 'true' || deleteSuccess === 'false') {
            var messageModal = new bootstrap.Modal(document.getElementById('messageModal'));
            messageModal.show();
        }
    });
</script>

</html>