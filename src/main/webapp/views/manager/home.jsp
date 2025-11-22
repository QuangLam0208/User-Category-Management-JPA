<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container mt-4">
    <div class="row mb-4">
        <div class="col-12">
            <h2 class="text-uppercase fw-bold text-primary">
                <i class="fas fa-tasks me-2"></i> Quản lý của tôi
            </h2>
            <p class="text-muted">Hi <strong>${sessionScope.account.fullname}</strong>, this is a list of categories you manage.</p>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="m-0 font-weight-bold text-primary">Danh sách Category</h5>
            
            <a href="${pageContext.request.contextPath}/manager/category/add" class="btn btn-success btn-sm">
                <i class="fas fa-plus"></i> Thêm mới
            </a>
        </div>
        
        <div class="card-body p-0">
            <c:set var="listToRender" value="${cateList}" scope="request"/>
            
            <c:set var="rolePrefix" value="/manager" scope="request"/>
            
            <jsp:include page="/views/admin/fragments/cate-table.jsp" />
        </div>
    </div>
</div>