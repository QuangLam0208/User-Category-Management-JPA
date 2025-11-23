<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container mt-4">
    <div class="row mb-4">
        <div class="col-12 text-center"> <h2 class="text-uppercase fw-bold text-primary">
                <i class="fas fa-user-tie me-2"></i> Manager Dashboard
            </h2>
            <p class="text-muted">Hello <strong>${sessionScope.account.fullname}</strong>. Welcome back to the management system.</p>
        </div>
    </div>

    <div class="row g-4 justify-content-center">
        
        <div class="col-md-4">
            <div class="card shadow-sm h-100 border-primary dashboard-card">
                <div class="card-body text-center p-4 d-flex flex-column">
                    <div class="mb-3">
                        <i class="fas fa-layer-group fa-4x text-primary"></i>
                    </div>
                    <h4 class="card-title text-primary">Category Management</h4>
                    <p class="card-text text-muted">View a list and manage the categories you create.</p>
                    
                    <a href="${pageContext.request.contextPath}/manager/category" class="btn btn-outline-primary mt-auto">
                        <i class="fas fa-arrow-right me-1"></i> Access
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm h-100 border-success dashboard-card">
                <div class="card-body text-center p-4 d-flex flex-column">
                    <div class="mb-3">
                        <i class="fas fa-id-card fa-4x text-success"></i>
                    </div>
                    <h4 class="card-title text-success">Personal Profile</h4>
                    <p class="card-text text-muted">Update account information.</p>
                    
                    <a href="${pageContext.request.contextPath}/manager/profile" class="btn btn-outline-success mt-auto">
                        <i class="fas fa-user-edit me-1"></i> Update
                    </a>
                </div>
            </div>
        </div>

    </div>
</div>