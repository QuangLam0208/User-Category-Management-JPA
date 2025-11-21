<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container mt-4" style="max-width: 800px;">
    <h2>Add New Video</h2>
    
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${sessionScope.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% session.removeAttribute("error"); // Xóa lỗi sau khi hiện %>
    </c:if>
    
    <form action="add" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label>Title:</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label>Category:</label>
            <select name="categoryId" class="form-select">
                <c:forEach items="${categories}" var="cate">
                    <option value="${cate.id}">${cate.name}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="mb-3">
            <label>Description:</label>
            <textarea name="description" class="form-control" rows="3"></textarea>
        </div>
        
        <div class="mb-3">
            <label>Poster:</label>
            <input type="file" name="poster" class="form-control" accept="image/*">
        </div>
        
        <div class="mb-3">
            <label>Status:</label>
            <select name="active" class="form-select">
                <option value="1" selected>Active</option>
                <option value="0">Inactive</option>
            </select>
        </div>
        
        <button type="submit" class="btn btn-primary">Add</button>
        <a href="${pageContext.request.contextPath}/admin/video" class="btn btn-secondary">Cancel</a>
    </form>
</div>