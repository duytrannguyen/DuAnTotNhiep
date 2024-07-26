<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<body>
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<p>
						Copyright 2024 <a href="#">QLBook</a> Store Co., Ltd. All rights
						reserved. &nbsp;&nbsp; Designed by <a title="HTML CSS Templates"
							rel="sponsored" href="#" target="_blank">Nhóm 2</a>
					</p>
				</div>
			</div>
		</div>
	</footer>
	<!-- <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">Chọn Địa
						Chỉ Giao Hàng</h1>
										<button type="button" class="btn-close" data-bs-dismiss="modal"
											aria-label="Close"></button>
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


	</div> -->
	<!-- Scripts -->
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
</script>
	<!-- Bootstrap core JavaScript -->
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.min.js"></script>

	<script src="/assets/js/isotope.min.js"></script>
	<script src="/assets/js/owl-carousel.js"></script>

	<script src="/assets/js/tabs.js"></script>
	<script src="/assets/js/popup.js"></script>
	<script src="/assets/js/custom.js"></script>
</body>
</html>