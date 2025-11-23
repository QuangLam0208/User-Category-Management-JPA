<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %> <c:choose>
    <c:when test="${sessionScope.account.roleid == 3}"><c:set var="rolePrefix" value="/admin"/></c:when>
    <c:when test="${sessionScope.account.roleid == 2}"><c:set var="rolePrefix" value="/manager"/></c:when>
    <c:otherwise><c:set var="rolePrefix" value="/user"/></c:otherwise>
</c:choose>

<div class="container mt-4" style="max-width: 800px;">
    <h2>Edit Video</h2>
    
    <form action="${pageContext.request.contextPath}${rolePrefix}/video/edit" method="post" enctype="multipart/form-data">
        
        <input type="hidden" name="id" value="${video.id}">
        
        <input type="hidden" name="fromCateId" value="${param.categoryId}"> 
        
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
            
            <c:if test="${not empty video.poster}">
                <c:set var="posterPath" value="${fn:replace(video.poster, '\\\\', '/')}" />
                <c:url value="/image?fname=${posterPath}" var="imgUrl"/>
                <img src="${imgUrl}" height="100" class="mb-2 rounded border" onerror="this.src='https://via.placeholder.com/100?text=No+Img'">
            </c:if>
            
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
        
        <c:choose>
            <c:when test="${not empty param.categoryId}">
                 <a href="${pageContext.request.contextPath}${rolePrefix}/video?categoryId=${param.categoryId}" class="btn btn-secondary">Cancel</a>
            </c:when>
            <c:otherwise>
                 <a href="${pageContext.request.contextPath}${rolePrefix}/video" class="btn btn-secondary">Cancel</a>
            </c:otherwise>
        </c:choose>
    </form>
</div>