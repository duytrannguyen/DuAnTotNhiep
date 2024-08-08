<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thanh Toán</title>
<link rel="stylesheet" href="/css/style.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.card {
	margin-top: 15px;
	padding: 20px;
}

body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
}

form {
	font-size: small;
}

.footer {
	position: fixed;
	bottom: 0;
	width: 100%;
}

.form-control {
	font-size: small;
}

.giaGiam {
	text-decoration: line-through;
}
</style>
</head>

<body>
	<jsp:include page="/views/client_layout/header.jsp" /><br><br>
	<form:form modelAttribute="invoice" action="/products/details/cart/pay"
		method="post">
		<div class="container">
			<div class="card mt-5">
				<strong>ĐỊA CHỈ GIAO HÀNG</strong>
				<hr>

				<div class="row mb-3">
					<label for="inputEmail3" class="col-sm-2 col-form-label">Họ
						và tên người nhận</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="inputEmail3"
							placeholder="Nhập họ và tên" name="fullName"
							value="${user.fullName}" required>
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputPassword33" class="col-sm-2 col-form-label">Email</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="inputPassword33"
							placeholder="Nhập email" name="email" value="${user.email}"
							required>
					</div>
				</div>
				<div class="row mb-3">
    <label for="inputPassword33" class="col-sm-2 col-form-label">Địa Chỉ Nhận Hàng</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="inputPassword33" name="email"
            value="${address.commune.commune_name}, ${address.district.district_name}, ${address.province.province_name}" required>
    </div>
</div>

				<div class="row mb-3">
					<label for="inputEmail1" class="col-sm-2 col-form-label">Số
						điện thoại</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="inputEmail1"
							placeholder="10 ký tự số" name="phone" value="${user.phone}"
							required>
					</div>
				</div>
				<!-- 				<div class="row mb-3"> -->
				<!-- 					<label for="inputPassword2" class="col-sm-2 col-form-label">Tỉnh/Thành -->
				<!-- 						Phố</label> -->
				<!-- 					<div class="col-sm-10"> -->
				<!-- 						<select class="form-select form-control" id="tinh" -->
				<!-- 							name="province_Id" aria-label="Default select example" required> -->
				<!-- 							<option value="0">Tỉnh Thành</option> -->
				<!-- 						</select> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
				<!-- 				<div class="row mb-3"> -->
				<!-- 					<label for="inputPassword4" class="col-sm-2 col-form-label">Quận/Huyện</label> -->
				<!-- 					<div class="col-sm-10"> -->
				<!-- 						<select class="form-select form-control" id="quan" -->
				<!-- 							name="district_Id" aria-label="Default select example" required> -->
				<!-- 							<option value="0">Quận/Huyện</option> -->
				<!-- 						</select> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
				<!-- 				<div class="row mb-3"> -->
				<!-- 					<label for="inputPassword5" class="col-sm-2 col-form-label">Phường/Xã</label> -->
				<!-- 					<div class="col-sm-10"> -->
				<!-- 						<select class="form-select form-control" id="phuong" -->
				<!-- 							name="commune_Id" aria-label="Default select example"required> -->
				<!-- 							<option value="0">Phường/Xã</option> -->
				<!-- 						</select> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
				<!-- 				<div class="row mb-3"> -->
				<!-- 					<label for="inputPassword6" class="col-sm-2 col-form-label">Địa -->
				<!-- 						chỉ nhận hàng</label> -->
				<!-- 					<div class="col-sm-10"> -->
				<!-- 						<input type="text" class="form-control" id="inputPassword3" -->
				<!-- 							placeholder="Nhập địa chỉ nhận hàng" name="street"required> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
				<!-- 			</div> -->

				<div class="card">
					<strong>PHƯƠNG THỨC VẬN CHUYỂN</strong>
					<hr>
					<div class="form-check">
						<input class="form-check-input" type="radio" name="shipping_id"
							id="exampleRadios1" value="1" checked> <label
							class="form-check-label" for="exampleRadios1"> <strong>Giao
								hàng tiêu chuẩn: 32.000 VNĐ</strong><br> <p
							style="font-size: small;">Thứ 6 - 25/6</p>
						</label>
					</div>
				</div>
				<div class="card">
					<strong>PHƯƠNG THỨC THANH TOÁN</strong>
					<hr>
					<div class="form-check">
						<input class="form-check-input" type="radio"
							name="payment_method_id" id="exampleRadios11" value="2">
						<label class="form-check-label" for="exampleRadios11"> <i
							class="fa-regular fa-credit-card" style="font-size: x-large;"></i>
							VNPay
						</label>
					</div>
					<div class="form-check">
						<input class="form-check-input" type="radio"
							name="payment_method_id" id="exampleRadios2" value="1" checked>
						<label class="form-check-label" for="exampleRadios2"> <i
							class="fa-regular fa-money-bill-1" style="font-size: x-large;"></i>
							Thanh toán khi nhận hàng
						</label>
					</div>
				</div>
				<div class="card">
					<strong>MÃ KHUYẾN MÃI/MÃ QUÀ TẶNG</strong>
					<hr>
					<div class="row g-3 align-items-center">
						<div class="col-sm-7">
							<div class="col-auto">
								<label for="inputPassword6" class="col-form-label">Mã
									Khuyến Mãi</label>
							</div>
							<div class="col-auto">
								<div class="input-group">
									<input type="password" id="inputPassword6"
										class="form-control w-auto"
										aria-describedby="passwordHelpInline"
										placeholder="Nhập mã khuyến mãi" name="discount_id">
									<div class="input-group-append">
										<button class="btn btn-primary btn-xs col-auto" type="submit">Áp
											dụng</button>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
				<div class="card">
					<strong>THÔNG TIN KHÁC</strong>
					<hr>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							id="flexCheckDefault"> <label class="form-check-label"
							for="flexCheckDefault"> Ghi Chú </label>
					</div>
					<div id="email-input-container" style="display: none;">
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="floatingInput"
								placeholder="Ghi chú"> <label for="floatingInput">Ghi
								chú</label>
						</div>
					</div>
				</div>
				<div class="card" style="margin-bottom: 250px;">
					<strong>KIỂM TRA LẠI ĐƠN HÀNG</strong>
					<hr>
					<div class="col-md-12">
						<c:forEach var="item" items="${cartItems}">
							<div class="row">
								<div class="col-md-2">
									<img src="/images/${item.productId.imageId.imageName}"
										style="width: 150px; height: 150px;">
								</div>
								<div class="col-md-5">
									<p>${item.productId.productName}</p>
								</div>
								<div class="col-md-1">
									<p>${item.quantity}</p>
								</div>
								<div class="col-md-2"> 
									<p><fmt:formatNumber> ${item.productId.price}</fmt:formatNumber>VNĐ</p><br>
									<input type="hidden"> <p
										class="giaGiam text-body-tertiary"><fmt:formatNumber> ${item.productId.price}</fmt:formatNumber>VNĐ</p>
								</div>
								<div class="col-md-2">
									<p class="text-primary fw-bold"><fmt:formatNumber>${item.productId.price * item.quantity}</fmt:formatNumber>VNĐ</p>
								</div>
							</div>
							<hr>
						</c:forEach>
					</div>
				</div>
			</div>
			<br> 
		</div>
<!-- 		<footer class="footer"> -->
<div class="footer">
			<div class="card">
				<div class="container">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-6"></div>
							<div class="col-md-3">
								<p class="text-end">Thành tiền</p>
								<p class="text-end">Khuyến mãi</p>
								<p class="text-end">Phí vận chuyển (Giao hàng tiêu chuẩn)</p>
								<p class="text-end fw-bold">Tổng tiền (gồm VAT)</p>
							</div>

							<div class="col-md-2">
								<p class="text-end">
									<fmt:formatNumber>${total}</fmt:formatNumber>
									VNĐ
								</p>
								<p class="text-end">
									<fmt:formatNumber>0</fmt:formatNumber>
									VNĐ
								</p>
								<input type="hidden" name="total_amount">
								<p class="text-end">32.000 VNĐ</p>
								<p class="text-end text-primary fw-bold">
									<fmt:formatNumber>${total+32000}</fmt:formatNumber>
									VNĐ
								</p>
								<input type="hidden" name="totalAmount" value="${total+32000}">
								<input type="hidden" value="Chưa Thanh Toán"
									name="payment_status"> <input type="hidden"
									value="${cartId}" name="cart_id"> <input type="hidden"
									value="1" name="status_id">
							</div>
							<div class="col-md-1"></div>
						</div>
					</div>
					<hr>
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-7">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" value=""
										id="flexCheckChecked"> <label class="form-check-label"
										for="flexCheckChecked"> Bằng việc xác nhận mua hàng,
										bạn đã hoàn toàn đồng ý với
										<p>
											<a href="#"
												class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover fw-bold">Điều
												khoản & Điều kiện</a> của chúng tôi.
										</p>
									</label>
								</div>
							</div>
							<div
								class="col-md-5 d-flex justify-content-center align-items-center">
								<button type="submit" id="confirmBtn"
									class="btn btn-outline-primary my-0" disabled>XÁC NHẬN
									ĐẶT HÀNG</button>
							</div>
						</div>
					</div>
				</div>
			</div></div>
<!-- 		</footer> -->
	</form:form>
	<script type="text/javascript">
		// Lấy reference tới các phần tử
		var checkbox1 = document.getElementById('flexCheckChecked');
		var confirmBtn = document.getElementById('confirmBtn');
		var checkbox2 = document.getElementById('flexCheckDefault');
		var emailInputContainer = document
				.getElementById('email-input-container');
		var emailInput = document.getElementById('floatingInput');

		// Thêm sự kiện change cho checkbox
		checkbox1.addEventListener('change', function() {
			// Nếu checkbox1 được chọn, bật nút thanh toán, ngược lại vô hiệu hóa
			if (this.checked) {
				confirmBtn.disabled = false;
			} else {
				confirmBtn.disabled = true;
			}
		});

		// Thêm sự kiện change cho checkbox2
		checkbox2.addEventListener('change', function() {
			// Nếu checkbox2 được chọn, hiển thị email input, ngược lại ẩn đi
			if (this.checked) {
				emailInputContainer.style.display = 'block';
				emailInput.focus();
			} else {
				emailInputContainer.style.display = 'none';
			}
		});
	</script>


	<script src="/js/address.js"></script>
</body>

</html>