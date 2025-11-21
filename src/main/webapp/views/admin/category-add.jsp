<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Category</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5" style="max-width: 600px;">
	<h2>Add New Category</h2>
	
	<form role="form" action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
		
		<div class="mb-3">
			<label for="name" class="form-label">Category name:</label> 
			<input class="form-control" placeholder="Nhập tên danh mục" name="name" id="name" required />
		</div>

		<div class="mb-3">
			<label for="icon" class="form-label">Image:</label> 
			<input type="file" name="icon" id="icon" class="form-control" required />
		</div>

		<button type="submit" class="btn btn-success">Add</button>
		<a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary">Cancel</a>
	</form>
</div>

</body>
</html>