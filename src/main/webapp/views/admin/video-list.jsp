<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container mt-4">
    
    <h2 class="mb-4 border-bottom pb-2"><i class="fas fa-film text-primary"></i> Video Management</h2>
    
    <c:if test="${not empty selectedCategory}">
        <div class="alert alert-info d-flex justify-content-between align-items-center">
            <span>
                Current Category: <strong>${selectedCategory.name}</strong>
            </span>
            <a href="${pageContext.request.contextPath}/admin/video" class="btn-close" aria-label="Close" title="View All Videos"></a>
        </div>
    </c:if>

    <div class="row mb-3 align-items-center">
        <div class="col-md-6 d-flex">
            <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary me-2">
                <i class="fas fa-arrow-left"></i> Back to Categories
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/video/add" class="btn btn-success">
                <i class="fas fa-plus"></i> Add New Video
            </a>
        </div>
        
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/admin/video" method="get" class="d-flex justify-content-end">
                <c:if test="${not empty selectedCategory}">
                    <input type="hidden" name="categoryId" value="${selectedCategory.id}">
                </c:if>
                
                <input class="form-control me-2 w-50" type="search" name="keyword" placeholder="Search by title..." value="${param.keyword}">
                <button class="btn btn-outline-primary" type="submit"><i class="fas fa-search"></i></button>
            </form>
        </div>
    </div>

    <c:if test="${empty videos}">
        <div class="alert alert-warning text-center shadow-sm">
            <i class="fas fa-exclamation-triangle me-2"></i> No videos found in the list!
        </div>
    </c:if>

    <c:if test="${not empty videos}">
        <div class="table-responsive">
            <table class="table table-bordered table-hover shadow-sm align-middle">
                <thead class="table-dark text-center">
                    <tr>
                        <th style="width: 5%;">ID</th>
                        <th style="width: 15%;">Poster</th>
                        <th style="width: 30%;">Title</th>
                        <c:if test="${empty selectedCategory}">
				            <th style="width: 15%;">Category</th>
				        </c:if>
                        <th style="width: 15%;">Status</th>
                        <th style="width: 20%;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${videos}" var="v">
                        <tr> 
                            <td class="text-center fw-bold">${v.id}</td>
                            <td class="text-center">
                                <c:if test="${not empty v.poster}">
                                    <c:url value="/image?fname=${v.poster}" var="imgUrl"/>
                                    <img src="${imgUrl}" class="rounded border shadow-sm" width="100" height="60" style="object-fit:cover">
                                </c:if>
                                <c:if test="${empty v.poster}">
                                    <div class="text-muted bg-light border rounded d-flex align-items-center justify-content-center" style="width: 100px; height: 60px; margin: auto;">
                                        <small>No Img</small>
                                    </div>
                                </c:if>
                            </td>
                            <td class="text-center fw-bold text-primary">${v.title}</td>
                            
                            <c:if test="${empty selectedCategory}">
				                <td class="text-center">
				                    <span class="badge bg-info text-dark">${v.category.name}</span>
				                </td> 
				            </c:if>
                            
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${v.active == 1}">
                                        <span class="badge bg-success rounded-pill"><i class="fas fa-check-circle me-1"></i> Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary rounded-pill"><i class="fas fa-lock me-1"></i> Hidden</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            
                            <td class="text-center">
                                <a href="#" class="btn btn-info btn-sm text-white me-1" title="Xem thử" onclick="alert('ID video: ${v.id} - Tính năng đang phát triển')">
                                    <i class="fas fa-play"></i>
                                </a>
                
                                <a href="${pageContext.request.contextPath}/admin/video/edit?id=${v.id}" class="btn btn-warning btn-sm me-1 text-white" title="Chỉnh sửa">
                                    <i class="fas fa-edit"></i>
                                </a>
                                
                                <a href="${pageContext.request.contextPath}/admin/video/delete?id=${v.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa video: ${v.title}?')" title="Xóa">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>