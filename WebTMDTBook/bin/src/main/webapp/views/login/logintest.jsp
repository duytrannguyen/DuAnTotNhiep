<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookStore</title>
<link rel="shortcut icon" href="/assets/images/logobook.ico"
	type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js">
	
</script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js">
	
</script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js">
	
</script>
<style type="text/css">
body {
	background-image: url('/images/bgLogin.jpg');
	height: 100%;
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
}

.btn-login {
	font-size: 0.9rem;
	letter-spacing: 0.05rem;
	padding: 0.75rem 1rem;
}
</style>

</head>
<body>
	<jsp:include page="../client_layout/header.jsp"></jsp:include>
	<div class="page-heading normal-space">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<h1 style="color: white;">Đăng nhập</h1>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-7">
				<div class="img" style="margin-top: 80px; border: 1px black solid; margin-right: 60px;width: auto;">
					<img alt="" src="../images/login.jpg">
				</div>

			</div>
			<div class="col-md-5">
				<h2 class="text-center mt-5">Login</h2>
				<form class="mx-auto" action="/home/login" method="post">
					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="username"
							name="username" placeholder="Tài khoản" required> <label
							for="username">Tài khoản</label>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control" id="floatingPassword"
							name="password" placeholder="Mật khẩu" required> <label
							for="floatingPassword">Mật khẩu</label>
					</div>
					<div class="form-check mb-3">
						<input class="form-check-input" type="checkbox" value=""
							id="rememberPasswordCheck"> <label
							class="form-check-label" for="rememberPasswordCheck"> Ghi
							nhớ tôi </label>
					</div>
					<div class="d-grid">
						<button class="btn btn-danger btn-login text-uppercase fw-bold"
							type="submit">Sign in</button>
					</div>
					<div class="mt-3">
						<c:if test="${not empty mess}">
							<div class="alert alert-danger" role="alert">${mess}</div>
						</c:if>
					</div>
				</form>
			</div>
		</div>
	</div>
	<br>
	<jsp:include page="../client_layout/footer.jsp"></jsp:include>

	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

</body>
</html>