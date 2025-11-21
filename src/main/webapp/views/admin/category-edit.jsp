<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sửa Category</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5" style="max-width: 600px;">
	<h2>Edit Category</h2>
	
	<c:url value="/admin/category/edit" var="edit"></c:url>
	<form role="form" action="${edit}" method="post" enctype="multipart/form-data">
		
		<!-- Gửi ID của category đi -->
		<input name="id" value="${category.id}" type="hidden">

		<div class="mb-3">
			<label for="name" class="form-label">Category name:</label> 
			<input type="text" class="form-control" value="${category.name}" name="name" id="name" required />
		</div>

		<div class="mb-3">
			<label class="form-label">Current image:</label><br>
			<c:url value="/image?fname=${category.images.replace('\\\\','/')}" var="imgUrl"></c:url>
			<img class="img-responsive" width="150px" src="${imgUrl}" alt="Ảnh danh mục">
		</div>

		<div class="mb-3">
			<label for="icon" class="form-label">Upload new image (leave blank if you don't want to change):</label> 
			<input type="file" name="icon" id="icon" class="form-control" />
		</div>

		<button type="submit" class="btn btn-success">Update</button>
		<a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary">Cancel</a>
	</form>
</div>

</body>
</html>