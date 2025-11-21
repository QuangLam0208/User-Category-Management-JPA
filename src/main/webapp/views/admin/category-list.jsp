<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %> <div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-primary">Category Management</h2>
        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary">
            <i class="fas fa-plus"></i> Add New Category
        </a>
    </div>
    
    <div class="card shadow-sm">
        <div class="card-body p-0">
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
                    <c:forEach items="${cateList}" var="cate" varStatus="STT">
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
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này không? (Các video bên trong cũng sẽ bị ảnh hưởng)')">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>