<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container mt-4">
    <h2>Quản Lý Video</h2>
    
    <div class="row mb-3">
        <div class="col-md-6">
            <a href="${pageContext.request.contextPath}/admin/video/add" class="btn btn-success">Thêm Video Mới</a>
        </div>
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/admin/video" method="get" class="d-flex">
                <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm theo tiêu đề..." value="${param.keyword}">
                <button class="btn btn-outline-primary" type="submit">Tìm</button>
            </form>
        </div>
    </div>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Poster</th>
                <th>Tiêu đề</th>
                <th>Mô tả</th>
                <th>Danh mục</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
		    <c:forEach items="${videos}" var="v">
		        <tr>
		            <td>${v.id}</td>
		            <td>
		                <c:url value="/image?fname=${v.poster}" var="imgUrl"/>
		                <img src="${imgUrl}" width="80" height="50" style="object-fit:cover">
		            </td>
		            <td>${v.title}</td>
		            <td>${v.category.name}</td> 
		            <td>
		                <span class="badge bg-${v.active == 1 ? 'success' : 'danger'}">
		                    ${v.active == 1 ? 'Active' : 'Inactive'}
		                </span>
		            </td>
		            <td>
		                <a href="video/edit?id=${v.id}" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
		                <a href="video/delete?id=${v.id}" class="btn btn-danger btn-sm" onclick="return confirm('Xóa?')"><i class="fas fa-trash"></i></a>
		            </td>
		        </tr>
		    </c:forEach>
		</tbody>
    </table>
</div>