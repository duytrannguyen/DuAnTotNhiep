<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <main class="mt-5">
                    <div class="card">
                        <div class="card-header">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/admin/products/list">List Products</a></li>
                                    <li class="breadcrumb-item active text-primary" aria-current="page"><a href="/admin/products/form">Form Products</a></li>
                                </ol>
                            </nav>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead class="table-primary">
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá Bán</th>
                                            <th>Năm xuất bản</th>
                                            <th>Khối lượng</th>
                                            <th>Kích thước</th>
                                            <th>Số trang</th>
                                            <th>Ngôn ngữ</th>
                                            <th>Tác giả</th>
                                            <th>Nhà sản xuất</th>
                                            <th>Ngày đăng bán</th>
                                            <th>Số lượng</th>
                                            <th>Mô tả</th>
                                            <th>Loại SP</th>
                                            <th>Hình ảnh</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${pageProd}" varStatus="loop">
                                            <tr>
                                                <td>${loop.index + 1}</td>
                                                <td>${item.productName}</td>
                                                <td><fmt:formatNumber>${item.price}</fmt:formatNumber></td>
                                                <td>${item.publishingYear}</td>
                                                <td>${item.weight}</td>
                                                <td>${item.size}</td>
                                                <td>${item.numberOfPages}</td>
                                                <td>${item.language}</td>
                                                <td>${item.author}</td>
                                                <td>${item.manufacturer}</td>
                                                <td><fmt:formatDate value="${item.postingDate}" pattern="dd-MM-yyyy" /></td>
                                                <td>${item.quantity}</td>
                                                <td>${item.description}</td>
                                                <td>${item.category.categoryName}</td>
                                                <td><img src="/Image_SP/${item.imageId.imageName}" width="100px" height="100px"></td>
                                                <td><a href="/admin/products/edit/${item.productId}" class="btn btn-danger">Edit</a></td>
                                                <td colspan="1"><a href="#" class="btn btn-danger" onclick="confirmDelete(${item.productId})"><i class="fa-solid fa-trash"></i></a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="pagination">
                                <c:if test="${totalPages > 0}">
                                    <c:forEach var="i" begin="0" end="${totalPages - 1}">
                                        <c:choose>
                                            <c:when test="${i == pageClick}">
                                                <span class="page-link active">${i + 1}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/admin/products/list?pageNo=${i}" class="page-link">${i + 1}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </c:if>
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
        function confirmDelete(productId) {
            var confirmDeleteModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
            confirmDeleteModal.show();
            var confirmDeleteButton = document.getElementById('confirmDeleteButton');
            confirmDeleteButton.setAttribute('href', '/admin/products/delete/' + productId);
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
