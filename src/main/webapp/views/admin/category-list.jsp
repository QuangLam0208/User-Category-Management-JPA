<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-primary">Category Management</h2>
        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary">
            <i class="fas fa-plus"></i> Add New Category
        </a>
    </div>

    <ul class="nav nav-tabs" id="cateTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab">
                All Categories
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="my-tab" data-bs-toggle="tab" data-bs-target="#my" type="button" role="tab">
                My Categories 
                <span class="badge bg-secondary ms-1">${myCateList != null ? myCateList.size() : 0}</span>
            </button>
        </li>
    </ul>

    <div class="tab-content mt-3" id="cateTabContent">
        
        <div class="tab-pane fade show active" id="all" role="tabpanel">
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <c:set var="listToRender" value="${cateList}" scope="request"/>
                    
                    <jsp:include page="/views/admin/fragments/cate-table.jsp" />
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="my" role="tabpanel">
            <div class="card shadow-sm border-info">
                <div class="card-header bg-info text-white">
                    Lists you create
                </div>
                <div class="card-body p-0">
                    <c:set var="listToRender" value="${myCateList}" scope="request"/>
                    
                    <jsp:include page="/views/admin/fragments/cate-table.jsp" />
                </div>
            </div>
        </div>
    </div>
</div>