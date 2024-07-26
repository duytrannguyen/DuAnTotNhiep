<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản trị viên</title>
<!-- icon -->
<link rel="shortcut icon" href="/assets/images/logobook.ico"
	type="image/x-icon">
<!-- Link boostrap -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
	integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/js/all.min.js"
	integrity="sha512-naukR7I+Nk6gp7p5TMA4ycgfxaZBJ7MO5iC3Fp6ySQyKFHOGfpkSZkYVWV5R7u7cfAicxanwYQ5D1e17EfJcMA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- 	Link css -->

<link rel="stylesheet" href="/assets/css/adminTem.css">
<style type="text/css">
.main-sidebar {
	width: 250px; /* Adjust the width as desired */
	transition: width 0.3s ease-in-out;
	/* Add a smooth transition effect */
}

.sidebar-collapse .main-sidebar {
	width: 250px; /* Adjust the collapsed width as desired */
}

.sidebar-collapse .main-sidebar {
	width: 50px !important;
}
</style>
</head>
<body>
	<div class="wrapper">
		<!-- Navbar -->
		<nav
			class="main-header navbar navbar-expand navbar-white navbar-light">
			<div class="container-fluid">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-7">
							<!-- Left navbar links -->
							<ul class="navbar-nav">
								<li class="nav-item">
									<button class="btn btn-sidebar" data-widget="pushmenu"
										role="button">
										<i class="fas fa-bars"></i>
									</button>
								</li>
								<li class="nav-item d-none d-sm-inline-block"><a
									href="/admin/index" class="nav-link">Home</a></li>
								<li class="nav-item d-none d-sm-inline-block"><a
									href="/home/index" class="nav-link">Web</a></li>
							</ul>
						</div>
						<!-- 						<div class="col-md-5"> -->
						<!-- 							Right navbar links -->
						<!-- 							<ul class="navbar-nav ms-auto"> -->
						<!-- 								Navbar Search -->
						<!-- 								<li class="nav-item"> -->
						<!-- 									<div class="collapse navbar-collapse" id="navbarSearch"> -->
						<!-- 										<form class="d-flex mb-3" role="search"> -->
						<!-- 											<input class="form-control me-2" type="search" -->
						<!-- 												placeholder="Search" aria-label="Search"> -->
						<!-- 											<button class="btn btn-outline-secondary" type="submit">Search</button> -->
						<!-- 										</form> -->
						<!-- 									</div> -->
						<!-- 								</li> -->
						<!-- 								Notifications Dropdown Menu -->
						<!-- 								<li class="nav-item dropdown"><a -->
						<!-- 									class="nav-link dropdown-toggle" href="#" -->
						<!-- 									data-bs-toggle="dropdown" aria-expanded="false"> <i -->
						<!-- 										class="far fa-bell"></i> <span -->
						<!-- 										class="badge bg-warning navbar-badge">15</span> -->
						<!-- 								</a> -->
						<!-- 									<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end"> -->
						<!-- 										<span class="dropdown-header">15 Notifications</span> -->
						<!-- 										<div class="dropdown-divider"></div> -->
						<!-- 										<a href="#" class="dropdown-item"> <i -->
						<!-- 											class="fas fa-envelope mr-2"></i> 4 new messages <span -->
						<!-- 											class="float-end text-muted text-sm">3 mins</span> -->
						<!-- 										</a> -->
						<!-- 										<div class="dropdown-divider"></div> -->
						<!-- 										<a href="#" class="dropdown-item"> <i -->
						<!-- 											class="fas fa-users mr-2"></i> 8 friend requests <span -->
						<!-- 											class="float-end text-muted text-sm">12 hours</span> -->
						<!-- 										</a> -->
						<!-- 										<div class="dropdown-divider"></div> -->
						<!-- 										<a href="#" class="dropdown-item"> <i -->
						<!-- 											class="fas fa-file mr-2"></i> 3 new reports <span -->
						<!-- 											class="float-end text-muted text-sm">2 days</span> -->
						<!-- 										</a> -->
						<!-- 										<div class="dropdown-divider"></div> -->
						<!-- 										<a href="#" class="dropdown-item dropdown-footer">See All -->
						<!-- 											Notifications</a> -->
						<!-- 									</div></li> -->
						<!-- 							</ul> -->
						<!-- 						</div> -->
					</div>
				</div>
			</div>
		</nav>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<aside
			class="main-sidebar sidebar-dark-primary elevation-4 sidebar-collapse">
			<!-- Brand Logo -->
			<a href="/admin/index" class="brand-link"> <img
				src="/images/logo.jpg" alt="AdminLTE Logo"
				class="brand-image img-circle elevation-3" style="opacity: .8">
				<span class="brand-text font-weight-light">Admin</span>
			</a>

			<!-- Sidebar -->
			<div class="sidebar">
				<!-- Sidebar user panel (optional) -->
				<div class="user-panel mt-3 pb-3 mb-3 d-flex">
					<div class="image">
						<img src="/images/logo.jpg" class="img-circle elevation-2"
							alt="User Image">
					</div>
					<div class="info">
						<a href="#" class="d-block"><c:out
								value="${sessionScope.user.fullName}" /></a>
					</div>
				</div>

				<!-- Sidebar Menu -->
				<nav class="mt-2">
					<ul class="nav flex-column">
						<li class="nav-item"><a class="nav-link" href="/admin/index">
								<i class="bi bi-house-door"></i><span>Dashboard</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/admin/client/list"> <i class="bi bi-people"></i><span>Customer</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/admin/products/list"> <i class="bi bi-clipboard-data"></i><span>Product</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/admin/payment/list"> <i class="bi bi-bag"></i><span>Order</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/admin/Category"> <i class="bi bi-receipt"></i><span>Category</span>
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#"> <i
								class="bi bi-person-circle"></i><span>Account</span>
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#"> <i
								class="bi bi-check2-square"></i><span>Tasks</span>
						</a></li>
					</ul>
				</nav>
			</div>
		</aside>
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<section>
						<jsp:include page="${view}"></jsp:include>
					</section>
				</div>
			</div>
		</div>
		<footer class="main-footer">
			<strong>Copyright &copy; 2022-2024 <a
				href="https://adminlte.io">Cao đẳng FPT Poly</a>.
			</strong> Nhóm 2.
			<!-- <div class="float-right d-none d-sm-inline-block">
				<b>Version</b> 3.1.0
			</div> -->
		</footer>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$('[data-widget="pushmenu"]').on('click', function() {
		$('body').toggleClass('sidebar-collapse');
	});
</script>
</html>