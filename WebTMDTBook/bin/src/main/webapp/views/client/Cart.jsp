<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giỏ Hàng</title>
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

<style type="text/css">
.card {
	padding: 20px;
}

a {
	color: black;
	text-decoration: none;
}
</style>
<body>
	<jsp:include page="/views/client_layout/header.jsp" /><br>
	<br>
	<br>
	<br>
	<div class="page-heading normal-space">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <h1>Giỏ hàng</h1>
                </div>
            </div>
        </div>
    </div>
<div class="container" style="padding-top: 50px;">
	<c:choose>
		<c:when test="${empty user}">
			<div class="alert alert-warning">
				Vui lòng <a href="/home/login">đăng nhập</a> hoặc <a
					href="/home/dangky">đăng ký</a> để mua hàng.
			</div>
		</c:when>
		<c:otherwise>
			 <c:if test="${not empty cartItems}">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-9">
                    <br>
                    <div class="card">
                        <div class="col-md-12">
                            <div class="row">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th><input class="form-check-input check-all" type="checkbox" id="checkAll" onchange="handleCheckboxChange()"> Tất cả</th>
                                            <th scope="col">Hình ảnh</th>
                                            <th scope="col">Tên sản phẩm</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Giá</th>
                                            <th scope="col">Thành tiền</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cartItems}">
                                            <form action="/cart/update" method="post">
                                                <input value="${item.cartItemId}" name="cartItemId" type="hidden" />
                                                <tr>
                                                    <td><input class="form-check-input item-checkbox" type="checkbox" name="cartItemIds" value="${item.cartItemId}" data-price="${item.productId.price * item.quantity}" onchange="calculateTotal()"></td>
                                                    <td><img alt="" src="/Image_SP/${item.productId.imageId.imageName}" style="width: 80px; height: 80px;"></td>
                                                    <td>${item.productId.productName}</td>
                                                    <td>
                                                        <button type="button" class="btn btn-secondary btn-sm" onclick="decrementValue(this.nextElementSibling)">-</button>
                                                        <input style="width: 30px;" value="${item.quantity}" name="quantity" onblur="this.form.submit();" />
                                                        <button type="button" class="btn btn-secondary btn-sm" onclick="incrementValue(this.previousElementSibling)">+</button>
                                                    </td>
                                                    <td><b><fmt:formatNumber value="${item.productId.price}" /></b> VNĐ</td>
                                                    <td><b><fmt:formatNumber value="${item.productId.price * item.quantity}" /></b> VNĐ</td>
                                                    <td><a href="/cart/remove/${item.cartItemId}"><i class="fa-solid fa-trash" style="color: #ed2323;"></i></a></td>
                                                </tr>
                                            </form>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <br>
                    <div class="card">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-9">
                                    Thành tiền: <p id="totalPrice">0 VNĐ</p>
                                </div>
                                <div class="col-md-3">
                                    <span style="font-size: medium;"></span>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-12">
                                    <strong>Tổng Số Tiền (gồm VAT)</strong>
                                    <p id="grandTotal">0 VNĐ</p>
                                </div>
                            </div>
                        </div>
                        <br>
                        <button type="button" id="paymentButton" class="btn btn-outline-primary" disabled onclick="proceedToPayment()">
                            Thanh Toán
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty cartItems}">
        <div class="alert alert-info mt-3">
            Giỏ hàng trống
        </div>
    </c:if>
		</c:otherwise>
	</c:choose></div>
	<jsp:include page="/views/client_layout/footer.jsp" />

	<script type="text/javascript">
    // Function to handle checkbox state changes
    function handleCheckboxChange() {
        updateCheckboxes();
        calculateTotal();
    }

    // Function to update all item checkboxes based on 'checkAll' checkbox
    function updateCheckboxes() {
        var checkAllCheckbox = document.getElementById('checkAll');
        var itemCheckboxes = document.querySelectorAll('.item-checkbox');
        itemCheckboxes.forEach(function(checkbox) {
            checkbox.checked = checkAllCheckbox.checked;
        });
        calculateTotal();
    }

    // Function to calculate total price and update display
    function calculateTotal() {
        let checkboxes = document.querySelectorAll('.item-checkbox');
        let totalPrice = 0;

        checkboxes.forEach(function(checkbox) {
            if (checkbox.checked) {
                totalPrice += parseFloat(checkbox.getAttribute('data-price'));
            }
        });

        // Update the total price and grand total in the HTML
        document.getElementById('totalPrice').innerText = totalPrice.toLocaleString('vi-VN') + " VNĐ";
        document.getElementById('grandTotal').innerText = totalPrice.toLocaleString('vi-VN') + " VNĐ";

        // Enable/disable payment button based on checkbox status
        var paymentButton = document.getElementById('paymentButton');
        paymentButton.disabled = totalPrice === 0; // Disable if no items are checked
    }

    // Function to handle payment button click
    function proceedToPayment() {
        let checkboxes = document.querySelectorAll('.item-checkbox:checked');
        let cartItemIds = Array.from(checkboxes).map(checkbox => checkbox.value).join(',');

        // Redirect to payment page with selected cart item IDs
        if (cartItemIds !== '') {
            window.location.href = "/products/details/cart/pay?cartItemIds=" + cartItemIds;
        } else {
            alert("Please select at least one item to proceed to payment.");
        }
    }

    // Function to increment quantity
    function incrementValue(inputField) {
        var currentValue = parseInt(inputField.value);
        inputField.value = currentValue + 1;
        inputField.form.submit();
    }

    // Function to decrement quantity
    function decrementValue(inputField) {
        var currentValue = parseInt(inputField.value);
        if (currentValue > 1) {
            inputField.value = currentValue - 1;
            inputField.form.submit();
        }
    }
</script>
</body>
</html>