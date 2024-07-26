<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script>
        function submitForm() {
            document.getElementById("filter-form").submit();
        }
    </script>
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

.pagination {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.page-link {
	display: inline-block;
	padding: 10px 15px;
	margin: 0 5px;
	border: 1px solid #007bff;
	color: #007bff;
	text-decoration: none;
	border-radius: 5px;
}

.page-link.active {
	background-color: #007bff;
	color: white;
}

.page-link:hover {
	background-color: #0056b3;
	color: white;
}
 .toast-container {
            position: fixed;
            top: 10px; /* Điều chỉnh khoảng cách từ trên xuống */
            right: 10px; /* Điều chỉnh khoảng cách từ phải sang trái */
            z-index: 10000; /* Đảm bảo hiển thị trên top của các phần tử khác */
        }
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-10">
				<main class="mt-5">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-3">
								<h4>Khách Hàng</h4>
								<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
									<strong form-check>Giới Tính</strong>
									<hr>
									<form id="filter-form">
										<div class="form-group">
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="gender"
													id="genderAll" value=""
													${empty param.gender ? 'checked' : ''}
													onchange="submitForm()"> <label
													class="form-check-label" for="genderAll">Tất Cả</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="gender"
													id="genderMale" value="true"
													${param.gender == 'true' ? 'checked' : ''}
													onchange="submitForm()"> <label
													class="form-check-label" for="genderMale">Nam</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="gender"
													id="genderFemale" value="false"
													${param.gender == 'false' ? 'checked' : ''}
													onchange="submitForm()"> <label
													class="form-check-label" for="genderFemale">Nữ</label>
											</div>
										</div>
										<input type="hidden" name="pageNo" value="${currentPage}">
										<input type="hidden" name="size" value="${size}">
									</form>

								</div>
							</div>
							<div class="col-md-9">
								<div class="col-md-12">
									<div class="row">
										<div class="col-md-6">
											<form class="d-flex" role="search"
												action="/admin/client/list" method="get">
												<input type="text" name="keyword" class="form-control"
													placeholder="Tìm kiếm theo tên" value="${keyword}"
													placeholder="Tìm kiếm số điện thoại/ tên khách hàng">
												<button class="btn btn-outline-primary" type="submit">
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</form>

										</div>
										<div class="col-md-6 d-flex justify-content-end">

											<div class="btn-group">
												<button type="button"
													class="btn btn-primary dropdown-toggle"
													data-bs-toggle="dropdown" aria-expanded="false">File
												</button>
												<ul class="dropdown-menu">
													<li><a class="dropdown-item" href="#"><i
															class="fa-solid fa-file-import"></i> Import</a></li>
													<li><a class="dropdown-item" href="#"><i
															class="fa-solid fa-up-right-from-square"></i> Xuất danh
															sách</a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
								<br>
								<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
									<table class="table table-hover" id="list">
										<thead>
											<tr>
												<th>Số thứ tự</th>
												<th>Tên Đăng Nhập</th>
												<th>Tên Khách Hàng</th>
												<th>Số Điện Thoại</th>
												<th>Email</th>
												<th>Giới Tính</th>
												<!-- <th>Địa Chỉ</th> -->
												<th>Vai trò</th>
												<th></th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<c:set var="i" value="${currentPage * size + 1}" />
											<c:forEach var="item" items="${Users}">
												<tr>
													<td>${i}</td>
													<td>${item.username}</td>
													<td>${item.fullName}</td>
													<td>${item.phone}</td>
													<td>${item.email}</td>
													<td>${item.gender ? 'Nam' : 'Nữ'}</td>
													<%-- <td>${item.address}</td> --%>
													<td>${item.roleId.roleName}</td>
													<td><a href="/admin/client/edit/${item.usersId}">Edit</a>
													</td>
													<td colspan="1"><a href="#" class="btn btn-danger"
														onclick="confirmDelete(${item.usersId})"><i
															class="fa-solid fa-trash"></i></a></td>

												</tr>
												<c:set var="i" value="${i + 1}" />
											</c:forEach>
										</tbody>
									</table>

									<div class="pagination">
										<c:if test="${totalPages > 0}">
											<c:forEach var="i" begin="0" end="${totalPages - 1}">
												<c:choose>
													<c:when test="${i == pageClick}">
														<span class="page-link active">${i + 1}</span>
													</c:when>
													<c:otherwise>
														<a
															href="${pageContext.request.contextPath}/admin/client/list?pageNo=${i}"
															class="page-link">${i + 1}</a>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</main>
			</div>
		</div>
	</div>
	<!-- Modal Confirm Delete -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteModalLabel">Xác Nhận Xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn xóa sản phẩm này không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <a id="confirmDeleteButton" class="btn btn-danger" href="#">Xóa</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Message -->
    <c:if test="${not empty toastMessage}">
        <div class="toast-container">
            <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-delay="5000">
                <div class="toast-header">
                    <strong class="me-auto">Thông báo</strong>
                    <button type="button" class="btn-close" data-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    ${toastMessage}
                </div>
            </div>
        </div>
    </c:if>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Function to show confirm delete modal
        function confirmDelete(usersId) {
            var confirmDeleteModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
            confirmDeleteModal.show();
            var confirmDeleteButton = document.getElementById('confirmDeleteButton');
            confirmDeleteButton.setAttribute('href', '/admin/client/delete/' + usersId);
        }

        // Function to show toast message
        $(document).ready(function() {
            var toastMessage = "${toastMessage}";
            if (toastMessage) {
                var liveToast = document.getElementById('liveToast');
                var bsToast = new bootstrap.Toast(liveToast);
                bsToast.show();
                
                // Auto hide toast after 5 seconds
                setTimeout(function() {
                    bsToast.hide();
                }, 5000);
            }
        });
    </script>
</body>

</html>