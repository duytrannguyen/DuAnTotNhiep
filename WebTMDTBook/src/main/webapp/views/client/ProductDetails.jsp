<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib
	uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi Tiết Sản Phẩm</title>
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

<!-- link icon -->
<!-- FontAwesome 6.2.0 CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
	integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- (Optional) Use CSS or JS implementation -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/js/all.min.js"
	integrity="sha512-naukR7I+Nk6gp7p5TMA4ycgfxaZBJ7MO5iC3Fp6ySQyKFHOGfpkSZkYVWV5R7u7cfAicxanwYQ5D1e17EfJcMA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<!-- 	css -->
<style type="text/css">
.card {
	padding: 10px;
}
/* cho sản phẩm */
.giaBann {
	color: red;
	font-size: medium;
	font-weight: bold;
}

.giaGiamm {
	font-weight: 300 !important;
	color: #999999;
	text-decoration: line-through;
	font-size: small;
}

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

img {
	max-height: 390px;
	max-width: 100%;
	height: auto;
	width: auto;
}

.btnn {
	margin-top: 40px;
	margin-left: 20px;
	margin-bottom: 10px;
	width: 220px;
	height: 40px;
	width: 220px;
}

.giamGia {
	text-decoration: line-through;
}

.giaBan {
	padding-right: 30px;
	font-size: xx-large;
	font-weight: normal;
}

.nccap {
	font-size: small;
}
</style>
</head>
<body>
	<jsp:include page="/views/client_layout/header.jsp" />
	<div class="page-heading normal-space">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <h1>Chi tiết sản phẩm</h1>
                </div>
            </div>
        </div>
    </div>
	<div class="container">
		<div class="card">
			<div class="col-md-12">
				<div class="row">


					<!-- 				chi tiết sản phẩm -->
					<div class="col-md-5">
						<img src="/Image_SP/${product.imageId.imageName}"
							class="card-img-top" style="width: 300px; margin-left: 100px"
							alt="...">
						<!-- <img src="/images/sach3.jpg" class="card-img-top" alt="..."> -->
						<a href="cart/${productId}">
							<button type="button" class="btn btn-outline-primary btnn">
								<i class="fa-solid fa-cart-plus"></i> Thêm Vào Giỏ Hàng
							</button>
						</a>
						</button>
						</a> <a href="/products/details/cart/paynow?productId=${productId}" class="btn btn-primary btnn">Mua Ngay</a>


					</div>
					<div class="col-md-7">
						<h4>${product.productName}</h4>
						<br> <p class="nccap">Nhà cung cấp: <strong
							class="nccap">Kim đồng</strong></p> <p class="nccap">Nhà
							Xuất bản: <strong class="nccap">${product.manufacturer}</strong>
						</p> <br>
						<hr>
						<br> <p class="giaBan"><strong><fmt:formatNumber>${product.price}</fmt:formatNumber> VNĐ</strong></p>
						<p class="giamGia">99.000đ</span> <span
							class="badge text-bg-danger">-10%</p> <br>
						<br>
						<hr>
<!-- 						<div class="col-md-3"> -->
<!-- 							<div class="d-flex align-items-center"> -->
<!-- 								<button class="btn btn-secondary btn-sm" -->
<!-- 									onclick="decrementValue()">-</button> -->
<!-- 								<p class="mx-2" id="value">1</p> -->
<!-- 								<button class="btn btn-secondary btn-sm" -->
<!-- 									onclick="incrementValue()">+</button> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div>
				</div>
			</div>
		</div>

		<!-- 					mô tải sản phẩm -->
		<div class="card" style="margin-top: 10px;">
			<h5>THÔNG TIN SẢN PHẨM</h5>
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-3">
						<p>Nhà Cung Cấp:</p>
						<p>Nhà Xuất Bản:</p>
						<p>Tác Giả:</p>
						<p>Năm Xuất Bản:</p>
						<p>Ngôn Ngữ:</p>
						<p>Trọng Lượng:</p>
						<p>Kích Thước:</p>
						<p>Số Trang:</p>
					</div>
					<!-- 				thông tin -->



					<div class="col-md-9">
						<p>Kim đồng</p>
						<p>${product.manufacturer}</p>
						<p>${product.author}</p>
						<p>${product.publishingYear}</p>
						<p>${product.language}</p>
						<p>${product.weight}</p>
						<p>${product.size}</p>
						<p>${product.numberOfPages}</p>
					</div>
				</div>

				<p>Giá sản phẩm trên Fahasa.com đã bao gồm thuế theo luật
					hiện hành. Bên cạnh đó, tuỳ vào loại sản phẩm, hình thức và địa chỉ
					giao hàng mà có thể phát sinh thêm chi phí khác như Phụ phí đóng
					gói, phí vận chuyển, phụ phí hàng cồng kềnh,...</p>
				<hr>
				<p class="d-none" id="extraListMota">
				
						<strong> ${product.productName}</strong>
					
					<h6>GIỚI THIỆU TÁC PHẨM</h6>
					<p>${product.description}</p>
				</p>

				<button id="showMoreMota" type="button"
					class="btn btn-outline-primary" style="margin-left: 550px;">Xem
					Thêm Thông Tin</button>
				<button id="collapseBtn" type="button"
					class="btn btn-outline-primary d-none" style="margin-left: 550px;">Thu
					Gọn</button>
			</div>
		</div>



		<br>
		<div class="card">
			<h5>SẢN PHẨM GỢI Ý</h5>
			<div class="col-md-12">
				<div class="row">

					<c:forEach var="p" items="${products}">

						<div class="col-md-3">
							<a href="${p.productId}" class="a-product text-decoration-none">
								<div class="card h-100 border-0 shadow-sm hover-shadow-lg"
									style="display: block;">
									<img src="/Image_SP/${p.imageId.imageName}"
										class="card-img-top"
										style="height: 250px; width: 220px; padding: 5px 20px 5px 20px; margin-left: 27px;">

									<div class="card-body">
										<span
											style="font-size: medium; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; max-width: 100%;">
											${p.productName}</span>
										<div class="d-flex flex-column">
											<span class="giaBann">${p.price}</span> <span
												class="giaGiamm text-muted">98.000đ</span>
										</div>
									</div>
								</div>
							</a>
						</div>

					</c:forEach>

				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/views/client_layout/footer.jsp" />


	<!-- modal -->
	<!-- Vertically centered modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">Chọn Địa
						Chỉ Giao Hàng</h1>
					<!-- 					<button type="button" class="btn-close" data-bs-dismiss="modal" -->
					<!-- 						aria-label="Close"></button> -->
				</div>
				<div class="modal-body">
					<div class="form-check">
						<div class="form-check form-switch">
							<input class="form-check-input" type="radio" role="switch"
								id="flexSwitchCheckDefault" name="radio" value="0"> <label
								class="form-check-label nccap" for="flexSwitchCheckDefault">Giao
								Hàng Đến: Phường Lê Bình, Quận Cái Răng, Cần Thơ </label>
						</div>
						<div class="form-check form-switch">
							<input class="form-check-input" type="radio" role="switch"
								id="flexSwitchCheckChecked" name="radio" value="1" checked>
							<label class="form-check-label nccap"
								for="flexSwitchCheckChecked">Giao Hàng Đến Địa Chỉ Khác</label><br>
							<span class="nccap">Tỉnh/Thành Phố:</span> <select
								class="form-select nccap" aria-label="Default select example">
								<option selected>Hà Nội</option>
								<option value="1">TP.Hồ Chí Minh</option>
								<option value="2">Cần Thơ</option>
								<option value="3">Bạc Liêu</option>
							</select> <span class="nccap">Quận/Huyện:</span> <select
								class="form-select nccap" aria-label="Default select example">
								<option value="4">Ninh Kiều</option>
								<option value="1">Cái Răng</option>
								<option value="2">Bình Thuỷ</option>
								<option value="3">Cờ Đỏ</option>
							</select> <span class="nccap">Phường/Xã:</span> <select
								class="form-select nccap" aria-label="Default select example">
								<option value="4">Lê Bình</option>
								<option value="1">Hưng Thạnh</option>
								<option value="2">Hưng Phú</option>
								<option value="3">Thường Thạnh</option>
							</select>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Hủy</button>
					<button type="button" class="btn btn-primary">Xác Nhận</button>
				</div>
			</div>
		</div>
	</div>
	<script>
	const showMoreNCC = document.getElementById('showMoreMota');
	const showLessNCC = document.getElementById('collapseBtn');
	const extraListNCC = document.getElementById('extraListMota');
	
	showMoreNCC.addEventListener('click', () => {
		extraListNCC.classList.remove('d-none');
		  showMoreNCC.classList.add('d-none');
		  showLessNCC.classList.remove('d-none');
		});

	showLessNCC.addEventListener('click', () => {
		extraListNCC.classList.add('d-none');
		showMoreNCC.classList.remove('d-none');
		showLessNCC.classList.add('d-none');
		});
	
	let value = 1;
	function decrementValue() {
		if (value > 1) {
			value--;
			document.getElementById("value").textContent = value;
		}
	}
	function incrementValue() {
		value++;
		document.getElementById("value").textContent = value;
	}
</script>
</body>
</html>