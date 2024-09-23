<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(135deg, #7fb3d5, #EBF5FB);
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.container {
	background-color: rgba(255, 255, 255, 0.9);
	border-radius: 8px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	padding: 40px;
	max-width: 600px;
	text-align: center;
	transition: transform 0.3s ease;
}

.container:hover {
	transform: translateY(-5px);
}

.success-icon {
	width: 80px;
	height: 80px;
	margin-bottom: 20px;
}

h1 {
	color: #4CAF50;
	font-size: 2.5rem;
	margin-bottom: 20px;
}

p {
	font-size: 1.2rem;
	line-height: 1.6;
	margin-bottom: 10px;
}

strong {
	font-weight: bold;
}

.return-link {
	margin-top: 20px;
}

.return-link a {
	color: #4CAF50;
	text-decoration: none;
	font-weight: bold;
	transition: color 0.3s ease;
}

.return-link a:hover {
	color: #2E8B57;
}
</style>
</head>
<body>
	<div class="container">
		<h1>Thanh toán thành công!</h1>
		<img
			src="https://ich.edu.vn/App_Files/Upload/2019/icon-thanh-cong.png"
			style="width: 100px;">
		<p>Cảm ơn bạn đã thanh toán thành công. Giao dịch của bạn đã được
			xác nhận.</p>
		<p>
			Mã đơn hàng: <strong>${orderId}</strong>
		</p>
		<p>
			Số tiền thanh toán: <strong>${totalAmount} VNĐ</strong>
		</p>
		<p>
			Phương thức thanh toán: <strong>${paymentMethod}</strong>
		</p>
		<p>
			Thời gian: <strong>${orderTime}</strong>
		</p>
		<p>Một email xác nhận đã được gửi đến địa chỉ email của bạn.</p>
		<div class="return-link">
			<a href="/home/index">Quay về Trang chủ</a>
		</div>
	</div>
</body>
</html>