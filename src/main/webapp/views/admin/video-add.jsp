<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
    <c:when test="${sessionScope.account.roleid == 3}"><c:set var="rolePrefix" value="/admin"/></c:when>
    <c:when test="${sessionScope.account.roleid == 2}"><c:set var="rolePrefix" value="/manager"/></c:when>
    <c:otherwise><c:set var="rolePrefix" value="/user"/></c:otherwise>
</c:choose>

<div class="container mt-4" style="max-width: 800px;">
    <h2>Add New Video</h2>
    
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${sessionScope.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% session.removeAttribute("error"); %>
    </c:if>
    
    <form action="${pageContext.request.contextPath}${rolePrefix}/video/add" method="post" enctype="multipart/form-data">
        
        <input type="hidden" name="fromCateId" value="${preCateId}">

        <div class="mb-3">
            <label>Title:</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label>Category:</label>
            <select name="categoryId" class="form-select">
                <c:forEach items="${categories}" var="cate">
                    <option value="${cate.id}" ${cate.id == preCateId ? 'selected' : ''}>
                        ${cate.name}
                    </option>
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
        
        <c:choose>
            <c:when test="${not empty preCateId}">
                <a href="${pageContext.request.contextPath}${rolePrefix}/video?categoryId=${preCateId}" class="btn btn-secondary">Cancel</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}${rolePrefix}/video" class="btn btn-secondary">Cancel</a>
            </c:otherwise>
        </c:choose>
    </form>
</div>