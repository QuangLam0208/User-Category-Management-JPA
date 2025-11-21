<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container mt-4" style="max-width: 800px;">
    <h2>Edit</h2>
    
    <form action="edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${video.id}">
        
        <div class="mb-3">
            <label>Title:</label>
            <input type="text" name="title" class="form-control" value="${video.title}" required>
        </div>
        
        <div class="mb-3">
            <label>Category:</label>
            <select name="categoryId" class="form-select">
                <c:forEach items="${categories}" var="cate">
                    <option value="${cate.id}" ${cate.id == video.category.id ? 'selected' : ''}>${cate.name}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="mb-3">
            <label>Description:</label>
            <textarea name="description" class="form-control" rows="3">${video.description}</textarea>
        </div>
        
        <div class="mb-3">
            <label>Posters in use:</label><br>
            <c:url value="/image?fname=${video.poster}" var="imgUrl"/>
            <img src="${imgUrl}" height="100" class="mb-2">
            <input type="file" name="poster" class="form-control" accept="image/*">
        </div>
        
        <div class="mb-3">
            <label>Status:</label>
            <select name="active" class="form-select">
                <option value="1" ${video.active == 1 ? 'selected' : ''}>Active</option>
                <option value="0" ${video.active == 0 ? 'selected' : ''}>Inactive</option>
            </select>
        </div>
        
        <button type="submit" class="btn btn-warning">Update</button>
        <a href="${pageContext.request.contextPath}/admin/video" class="btn btn-secondary">Cancel</a>
    </form>
</div>