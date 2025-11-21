<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <title>Admin Dashboard</title> </head>

<body>
    <div class="row mb-4">
        <div class="col-12">
            <h2 class="text-center text-uppercase fw-bold text-primary">Administration Control Panel</h2>
        </div>
    </div>

    <div class="row g-4 justify-content-center">
        <div class="col-md-4">
            <div class="card dashboard-card h-100 text-white bg-primary">
                <div class="card-body text-center p-5">
                    <i class="fas fa-layer-group fa-3x mb-3"></i>
                    <h4>Category Management</h4>
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-light mt-3">Access</a>
                </div>
            </div>
        </div>
        </div>
</body>