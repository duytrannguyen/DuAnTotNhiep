<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-md-7 col-lg-8">
	<form class="needs-validation" action="/admin/Category/create"
		method="post" enctype="multipart/form-data">
		<div class="row g-3">
			<div class="col-sm-6">
				<label for="name" class="form-label">Tên thể loại</label> <input
					type="text" class="form-control" id="categoryName"
					name="categoryName" value="${category.categoryName}" required>
				<div class="invalid-feedback">Vui lòng nhập tên loại!</div>
			</div>
		</div>

		<hr class="my-4">

		<div class="d-flex gap-2">
			<button class=" btn btn-success text-capitalize"
				formaction="/admin/Category/create">create</button>
			<button class="btn btn-warning text-capitalize"
				formaction="/admin/Category/update/${category.categoryId}" type="submit">Update</button>
			<button class="btn btn-danger text-capitalize"
				formaction="/admin/Category/delete/${category.categoryId}" type="submit">Delete</button>
			<button class="btn btn-primary text-capitalize"
				formaction="/admin/Category/reset">Reset</button>

		</div>
	</form>

</div>