<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${empty sessionScope.account}">
    <% response.sendRedirect(request.getContextPath() + "/login"); %>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .dashboard-card {
            transition: all 0.3s;
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
            cursor: pointer;
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        .bg-gradient-primary {
            background: linear-gradient(45deg, #4e73df, #224abe);
        }
        .text-white-opacity {
            color: rgba(255, 255, 255, 0.8);
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-5">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="fas fa-user-shield me-2"></i>Admin Panel</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item me-3">
                        <span class="text-light">Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">
                            <i class="fas fa-sign-out-alt me-1"></i> Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="text-center text-uppercase fw-bold text-primary">Bảng Điều Khiển Quản Trị</h2>
                <p class="text-center text-muted">Chào mừng bạn quay trở lại hệ thống quản lý.</p>
            </div>
        </div>

        <div class="row g-4 justify-content-center">
            
            <div class="col-md-4">
                <div class="card dashboard-card h-100 text-white bg-primary">
                    <div class="card-body text-center p-5">
                        <div class="card-icon">
                            <i class="fas fa-layer-group"></i>
                        </div>
                        <h4 class="card-title">Quản lý Danh Mục</h4>
                        <p class="card-text text-white-opacity">Xem, thêm, sửa và xóa các danh mục sản phẩm.</p>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-light text-primary fw-bold mt-3">
                            Truy cập ngay <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card dashboard-card h-100 text-white bg-success">
                    <div class="card-body text-center p-5">
                        <div class="card-icon">
                            <i class="fas fa-id-card"></i>
                        </div>
                        <h4 class="card-title">Thông tin cá nhân</h4>
                        <p class="card-text text-white-opacity">Cập nhật họ tên, số điện thoại và ảnh đại diện.</p>
                        <a href="${pageContext.request.contextPath}/profile" class="btn btn-light text-success fw-bold mt-3">
                            Cập nhật ngay <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card dashboard-card h-100 text-white bg-warning">
                    <div class="card-body text-center p-5">
                        <div class="card-icon">
                            <i class="fas fa-video"></i>
                        </div>
                        <h4 class="card-title">Quản lý Video</h4>
                        <p class="card-text text-dark">Quản lý danh sách video khóa học.</p>
                        <a href="#" class="btn btn-light text-warning fw-bold mt-3">
                            Sắp ra mắt <i class="fas fa-clock ms-1"></i>
                        </a>
                    </div>
                </div>
            </div> 

        </div>
    </div>

    <footer class="text-center mt-5 py-4 text-muted">
        <small>&copy; 2025 FIT - HCMUTE.</small>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>