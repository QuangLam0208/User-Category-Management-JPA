<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:if test="${empty listToRender}">
    <p class="text-center p-4 text-muted">Không có dữ liệu danh mục nào.</p>
</c:if>

<c:if test="${not empty listToRender}">
    <table class="table table-striped table-hover mb-0 align-middle">
        <thead class="table-dark">
            <tr>
                <th>No.</th>
                <th>Image</th>
                <th>Category Name</th>
                <th>Status</th>
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
                            
                            <img src="${imgUrl}" 
                                 alt="${cate.name}" 
                                 class="img-thumbnail"
                                 style="width: 80px; height: 50px; object-fit: cover;"
                                 onerror="this.src='https://via.placeholder.com/80x50?text=No+Img'"/> 
                        </c:if>
                        <c:if test="${empty cate.images}">
                            <span>No Image</span>
                        </c:if>
                    </td>
                    <td class="fw-bold">${cate.name}</td>
                    <td>
                        <span class="badge bg-${cate.active == 1 ? 'success' : 'secondary'}">
                            ${cate.active == 1 ? 'Active' : 'Inactive'}
                        </span>
                    </td>
                    <td class="text-center">
                        <a href="${pageContext.request.contextPath}/admin/video?categoryId=${cate.id}" 
                           class="btn btn-info btn-sm text-white me-1" 
                           title="Xem các video thuộc danh mục này">
                            <i class="fas fa-video"></i> Videos
                        </a>

                        <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" 
                           class="btn btn-warning btn-sm me-1">
                            <i class="fas fa-edit"></i> Edit
                        </a>

                        <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" 
                           class="btn btn-danger btn-sm" 
                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này không?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>