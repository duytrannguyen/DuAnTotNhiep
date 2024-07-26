<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Category Management</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style>
.b-example-divider {
	width: 100%;
	height: 3rem;
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh;
}

.bi {
	vertical-align: -.125em;
	fill: currentColor;
}
</style>
</head>
<body>
	<div class="container">
		<main class="d-flex flex-nowrap">

			<div class="b-example-divider b-example-vr"></div>
			<div class="tab-content flex-grow-1">
				<div class="tab-pane show active container" id="/category/index">
					<div class="row p-3">
						<h3>Loại</h3>
						<jsp:include page="form.jsp"></jsp:include>
						<hr>
						<jsp:include page="page.jsp"></jsp:include>
						
					</div>
				</div>
			</div>
		</main>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
	<script>
			(() => {
				'use strict'
				const forms = document.querySelectorAll('.needs-validation')
				Array.from(forms).forEach(form => {
					form.addEventListener('submit', event => {
						if (!form.checkValidity()) {
							event.preventDefault()
							event.stopPropagation()
						}

						form.classList.add('was-validated')
					}, false)
				})
			})()
		</script>
</body>
</html>