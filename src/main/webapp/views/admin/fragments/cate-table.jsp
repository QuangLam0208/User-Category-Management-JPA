<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:if test="${empty listToRender}">
    <div class="p-4 text-center text-muted">No data available.</div>
</c:if>

<c:if test="${not empty listToRender}">
    <table class="table table-striped table-hover mb-0 align-middle">
        <thead class="table-dark text-center">
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Name</th>
                <th>Creator</th>
                <th>Status</th>
                <th>Act</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listToRender}" var="cate" varStatus="STT">
                <tr>
                    <td class="text-center">${cate.id}</td>
                    <td class="text-center">
                        <c:if test="${not empty cate.images}">
                            <c:set var="imagePath" value="${fn:replace(cate.images, '\\\\', '/')}" />
                            <c:url value="/image?fname=${imagePath}" var="imgUrl"></c:url>
                            <img src="${imgUrl}" class="img-thumbnail" style="width: 80px; height: 50px; object-fit: cover;" 
                                 onerror="this.src='https://via.placeholder.com/80x50?text=No+Img'"/> 
                        </c:if>
                        <c:if test="${empty cate.images}"><span>No Image</span></c:if>
                    </td>
                    <td class="fw-bold">${cate.name}</td>
                    
                    <td class="text-center"><small class="text-muted">${cate.user.fullname}</small></td>
                    
                    <td class="text-center">
                        <span class="badge bg-${cate.active == 1 ? 'success' : 'secondary'}">
                            ${cate.active == 1 ? 'Active' : 'Inactive'}
                        </span>
                    </td>
                    
                    <td class="text-center">
                        <a href="${pageContext.request.contextPath}${rolePrefix}/video?categoryId=${cate.id}" 
                           class="btn btn-info btn-sm text-white me-1" title="Manage Videos">
                            <i class="fas fa-video"></i>
                        </a>

                        <c:set var="roleId" value="${sessionScope.account.roleid}" />
                        <c:set var="isOwner" value="${cate.user.id == sessionScope.account.id}" />

                        <c:if test="${roleId == 3 or (roleId == 2 and isOwner)}">
                            <a href="${pageContext.request.contextPath}${rolePrefix}/category/edit?id=${cate.id}" 
                               class="btn btn-warning btn-sm me-1">
                                <i class="fas fa-edit"></i>
                            </a>

                            <a href="${pageContext.request.contextPath}${rolePrefix}/category/delete?id=${cate.id}" 
                               class="btn btn-danger btn-sm" 
                               onclick="return confirm('Are you sure?')">
                                <i class="fas fa-trash"></i>
                            </a>
                        </c:if>
                        
                        <c:if test="${roleId == 1 or (roleId == 2 and !isOwner)}">
                            <button class="btn btn-secondary btn-sm" disabled title="View Only">
                                <i class="fas fa-lock"></i>
                            </button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>