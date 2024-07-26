<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sorting</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
	<div class="container mt-5">
		<h2 class="mb-3">List of Categories</h2>
		<table class="table table-striped">
			<thead>
				<tr>
					<th scope="col">Category ID</th>
					<th scope="col">Category Name</th>
				</tr>
			</thead>
			<tbody>
				<!-- Thực hiện vòng lặp để hiển thị danh sách categories -->
				<c:forEach items="${categories}" var="category">
					<tr>
						<td>${category.categoryId}</td>
						<td>${category.categoryName}</td>
						<td> <a href="/admin/Category/edit/${category.categoryId}" class="btn btn-primary">
                        Edit
                    </a>
					</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>