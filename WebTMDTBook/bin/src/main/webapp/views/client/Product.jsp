<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sản Phẩm</title>
<link rel="shortcut icon" href="/assets/images/logobook.ico"
	type="image/x-icon">
<style type="text/css">
body, html {
	margin: 0;
	padding: 0;
	height: 100%;
	width: 100%;
}

.page-heading {
	padding: 20px 0;
	background: #f5f5f5;
}

.container-fluid {
	padding: 20px;
}

.card {
	margin-bottom: 20px;
}

.pagination .page-item .page-link.selected {
	font-weight: bold;
}

.lb {
	padding: 5px;
}

.a-product {
	text-decoration: none;
}

.card-img-top {
	object-fit: cover;
	height: 230px;
	width: 100%;
}

.card-footer {
	background: #fff;
}

.pagination .page-item .page-link {
	border-radius: 0;
	color: #000;
}

.page-link:hover {
	background-color: #007bff;
	color: #fff;
}

.pagination .page-item .page-link.selected {
	font-weight: bold;
}

.lb {
	padding: 5px;
}
</style>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/client/products.css">
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
</head>

<body>
	<jsp:include page="/views/client_layout/header.jsp" />
	<div class="page-heading normal-space">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<h1 style="color: white;">Sản phẩm</h1>
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="col-md-12 mt-5">
			<div class="row">
				<!-- NỘI DUNG TRÁI -->
				<div class="col-md-3">
					<div class="card">
						<!-- GIÁ -->
						<br>
						<ul>
							<a><strong>GIÁ</strong></a>
							<form action="/home/products" method="post"
								id="product-filter-form" onchange="this.submit()">
								<ul class="list-group">
									<li class="list-group-item"><input
										class="form-check-input me-1 price-filter" type="checkbox"
										value="0-50000" name="price_range" id="price0-50"> <label
										class="form-check-label" for="price0-50">Dưới 50,000đ</label>
									</li>
									<li class="list-group-item"><input
										class="form-check-input me-1 price-filter" type="checkbox"
										value="50000-150000" name="price_range" id="price50-150">
										<label class="form-check-label" for="price50-150">50,000đ
											- 150,000đ</label></li>
									<li class="list-group-item"><input
										class="form-check-input me-1 price-filter" type="checkbox"
										value="150000-250000" name="price_range" id="price150-250">
										<label class="form-check-label" for="price150-250">150,000đ
											- 250,000đ</label></li>
									<li class="list-group-item"><input
										class="form-check-input me-1 price-filter" type="checkbox"
										value="250000-350000" name="price_range" id="price250-350">
										<label class="form-check-label" for="price250-350">250,000đ
											- 350,000đ</label></li>
									<li class="list-group-item"><input
										class="form-check-input me-1 price-filter" type="checkbox"
										value="350000-500000" name="price_range" id="price350-500">
										<label class="form-check-label" for="price350-500">350,000đ
											- 500,000đ</label></li>
									<li class="list-group-item"><input
										class="form-check-input me-1 price-filter" type="checkbox"
										value="500000-700000" name="price_range" id="price500-700">
										<label class="form-check-label" for="price500-700">500,000đ
											- 700,000đ</label></li>
									<li class="list-group-item"><input
										class="form-check-input me-1 price-filter" type="checkbox"
										value="700000-999999999" name="price_range" id="price700-">
										<label class="form-check-label" for="price700-">Trên
											700,000đ</label></li>
								</ul>
							</form>

						</ul>
						</ul>
						<hr>
						<!-- THỂ LOẠI -->
						<ul class="ul">
							<ul>
								<a><strong>THỂ LOẠI</strong></a>

								<form id="filter-form">
									<div class="form-group">
										<div class="form-check">
											<input class="form-check-input" type="radio"
												name="categoryId" id="categoryIdAll" value="0"
												<c:if test="${empty param.categoryId or param.categoryId == 0}">checked</c:if>
												onchange="redirectToProductPage()"> <label
												class="form-check-label" for="categoryIdAll">Tất cả</label>
										</div>

										<c:forEach var="c" items="${categories}">
											<div class="form-check">
												<input class="form-check-input" type="radio"
													value="${c.categoryId}" name="categoryId"
													id="category-${c.categoryId}"
													<c:if test="${param.categoryId == c.categoryId}">checked</c:if>
													onchange="submitFilterForm()"> <label
													class="form-check-label" for="category-${c.categoryId}">${c.categoryName}</label>
											</div>
										</c:forEach>
									</div>
								</form>

							</ul>
						</ul>
					</div>
				</div>
				<!-- NỘI DUNG PHẢI -->
				<div class="col-md-9">
					<div class="card" style="padding: 20px">
						<div class="row">

							<div class="col-md-5">
								<label class="lb"><em><b>Tìm kiếm sản phẩm</b></em></label>
								<form class="d-flex" role="search" action="/home/products"
									method="get">
									<input class="form-control me-2" type="search"
										aria-label="Search" name="keyName">
									<button class="btn btn-outline-primary" type="submit"
										id="liveToastBtn">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</form>
							</div>

						</div>
						<hr>
						<!-- DANH SÁCH SẢN PHẨM -->
						<div class="row row-cols-1 g-4">
							<h6>DANH SÁCH SẢN PHẨM</h6>

							<c:forEach var="p" items="${products}">

								<div class="col-md-3">
									<a href="products/details/${p.productId}"
										class="a-product text-decoration-none">
										<div class="card h-100 border-0 shadow-sm hover-shadow-lg">
											<img src="/Image_SP/${p.imageId.imageName}"
												class="card-img-top"
												style="height: 230px; width: 210px; margin-left: 18px;">
											<div class="card-body">
												<p class="card-title mb-1">${p.productName}</p>
												<div class="d-flex flex-column">
													<span class="giaBan"> <fmt:formatNumber>${p.price}</fmt:formatNumber> VNĐ</span>
												</div>
											</div>
										</div>
									</a>
								</div>

								<br>
							</c:forEach>

							<hr>
							<br>


							<!-- CHUYỂN TRANG -->
							<div class="card-footer d-flex justify-content-center">
								<nav aria-label="Page navigation example">
									<ul class="pagination mb-0">
										<li class="page-item"><a
											class="page-link bg-black bg-gradient text-info hover-bg-primary hover-color-white btn-lg"
											href="?pageNo=${pageClick > 0 ? pageClick - 1 : 0}"
											aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										</a></li>
										<c:forEach var="pageNum" items="${totalPageProduct}">
											<li class="page-item"><a
												class="page-link bg-black bg-gradient text-info hover-bg-primary hover-color-white btn-lg ${pageClick == pageNum - 1 ? 'selected' : ''}"
												href="?pageNo=${pageNum - 1}"> ${pageNum} </a></li>
										</c:forEach>
										<li class="page-item"><a
											class="page-link bg-black bg-gradient text-info hover-bg-primary hover-color-white btn-lg"
											href="?pageNo=${pageClick < totalPageProduct.size() - 1 ? pageClick + 1 : totalPageProduct.size() - 1}"
											aria-label="Next"> <span aria-hidden="true">&raquo;</span>
										</a></li>
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/views/client_layout/footer.jsp" />

	<script>
// 	của thể loại
    const showMoreBtn = document.getElementById('showMoreBtn');
	const showLessBtn = document.getElementById('showLessBtn');
	const extraList = document.getElementById('extraList');
	const priceFilters = document.querySelectorAll('.price-filter');
	  
    // Lưu trạng thái của checkbox
	function saveCheckboxState() {
	  const checkboxes = document.querySelectorAll('.price-filter');
	  const checkedValue = Array.from(checkboxes).find(checkbox => checkbox.checked)?.value;
	  localStorage.setItem('checkedPriceRange', checkedValue);
	}

	// Khôi phục trạng thái của checkbox
	function restoreCheckboxState() {
	  const checkedValue = localStorage.getItem('checkedPriceRange');
	  if (checkedValue) {
	    const checkboxes = document.querySelectorAll('.price-filter');
	    checkboxes.forEach(checkbox => {
	      checkbox.checked = checkbox.value === checkedValue;
	    });
	  }
	}

	// Thêm sự kiện click cho các checkbox
	const priceFilterCheckboxes = document.querySelectorAll('.price-filter');
	priceFilterCheckboxes.forEach(checkbox => {
	  checkbox.addEventListener('click', () => {
	    // Tắt tất cả các checkbox khác
	    priceFilterCheckboxes.forEach(otherCheckbox => {
	      if (otherCheckbox !== checkbox) {
	        otherCheckbox.checked = false;
	      }
	    });
	    saveCheckboxState();
	  });
	});

	// Khôi phục trạng thái khi trang được tải
	restoreCheckboxState();

	// Gọi các hàm này khi cần thiết
	document.addEventListener('DOMContentLoaded', restoreCheckboxState);
	document.querySelectorAll('.price-filter').forEach(checkbox => {
	  checkbox.addEventListener('change', saveCheckboxState);
	});
	  
	showMoreBtn.addEventListener('click', () => {
		  extraList.classList.remove('d-none');
		  showMoreBtn.classList.add('d-none');
		  showLessBtn.classList.remove('d-none');
		});

		showLessBtn.addEventListener('click', () => {
		  extraList.classList.add('d-none');
		  showMoreBtn.classList.remove('d-none');
		  showLessBtn.classList.add('d-none');
		});
		
	
	function submitFilterForm() {
	    document.getElementById('filter-form').submit();
	  }

	  function redirectToProductPage() {
	    window.location.href = "/home/products";
	  }
	  
	</script>
</body>
</html>
