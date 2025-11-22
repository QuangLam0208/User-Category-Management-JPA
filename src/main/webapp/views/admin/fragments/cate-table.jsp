<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:if test="${empty listToRender}">
    <div class="p-4 text-center text-muted">No categories found.</div>
</c:if>

<c:if test="${not empty listToRender}">
    <table class="table table-striped table-hover mb-0 align-middle">
        <thead class="table-dark">
            <tr>
                <th>No.</th>
                <th>Image</th>
                <th>Category Name</th>
                <th>Author</th> <th>Status</th>
                <th class="text-center">Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listToRender}" var="cate" varStatus="STT">
                <tr>
                    <td>${STT.index + 1}</td>
                    <td>
                        <c:if test="${not empty cate.images}">
                            <c:set var="imagePath" value="${fn:replace(cate.images, '\\\\', '/')}" />
                            <c:url value="/image?fname=${imagePath}" var="imgUrl"></c:url>
                            <img src="${imgUrl}" class="img-thumbnail" style="width: 80px; height: 50px; object-fit: cover;" 
                                 onerror="this.src='https://via.placeholder.com/80x50?text=No+Img'"/> 
                        </c:if>
                        <c:if test="${empty cate.images}"><span>No Image</span></c:if>
                    </td>
                    <td class="fw-bold">${cate.name}</td>
                    
                    <td><small class="text-muted">${cate.user.fullname}</small></td>
                    
                    <td>
                        <span class="badge bg-${cate.active == 1 ? 'success' : 'secondary'}">
                            ${cate.active == 1 ? 'Active' : 'Inactive'}
                        </span>
                    </td>
                    
                    <td class="text-center">
                        <a href="${pageContext.request.contextPath}${rolePrefix}/video?categoryId=${cate.id}" 
                           class="btn btn-info btn-sm text-white me-1" title="Manage Videos">
                            <i class="fas fa-video"></i>
                        </a>

                        <c:set var="isAdmin" value="${sessionScope.account.roleid == 3}" />
                        <c:set var="isOwner" value="${cate.user.id == sessionScope.account.id}" />

                        <c:if test="${isAdmin or isOwner}">
                            <a href="${pageContext.request.contextPath}${rolePrefix}/category/edit?id=${cate.id}" 
                               class="btn btn-warning btn-sm me-1">
                                <i class="fas fa-edit"></i>
                            </a>

                            <a href="${pageContext.request.contextPath}${rolePrefix}/category/delete?id=${cate.id}" 
                               class="btn btn-danger btn-sm" 
                               onclick="return confirm('Are you sure you want to delete this category?')">
                                <i class="fas fa-trash"></i>
                            </a>
                        </c:if>
                        
                        <c:if test="${!isAdmin and !isOwner}">
                            <button class="btn btn-outline-secondary btn-sm" disabled title="View Only">
                                <i class="fas fa-eye"></i>
                            </button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>