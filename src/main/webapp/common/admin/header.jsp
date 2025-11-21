<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand navbar-dark bg-dark topbar mb-4 static-top shadow">

    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/admin/home">
            <div class="sidebar-brand-icon rotate-n-15 me-2">
                <i class="fas fa-user-shield fa-lg text-warning"></i>
            </div>
            <div class="sidebar-brand-text mx-1">Admin<span class="text-warning">Panel</span></div>
        </a>

        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
        </button>

        <form class="d-none d-sm-inline-block form-inline ms-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
                <input type="text" class="form-control bg-light border-0 small" placeholder="Tìm kiếm..." aria-label="Search" aria-describedby="basic-addon2">
                <div class="input-group-append">
                    <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                    </button>
                </div>
            </div>
        </form>

        <ul class="navbar-nav ms-auto">

            <li class="nav-item dropdown no-arrow mx-1">
                <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-bell fa-fw"></i>
                    <span class="badge bg-danger badge-counter">3+</span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow animated--grow-in" aria-labelledby="alertsDropdown">
                    <li><h6 class="dropdown-header">Thông báo mới</h6></li>
                    <li><a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="me-3"><div class="icon-circle bg-primary"><i class="fas fa-file-alt text-white"></i></div></div>
                        <div><span class="small text-gray-500">12/12/2024</span><br/>Báo cáo tháng mới đã sẵn sàng!</div>
                    </a></li>
                </ul>
            </li>

            <li class="nav-item dropdown no-arrow mx-1">
                <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-envelope fa-fw"></i>
                    <span class="badge bg-warning badge-counter">7</span>
                </a>
            </li>

            <div class="topbar-divider d-none d-sm-block" style="width: 0; border-right: 1px solid #e3e6f0; height: 2rem; margin: auto 1rem;"></div>

            <li class="nav-item dropdown no-arrow">
                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <span class="me-2 d-none d-lg-inline text-white-600 small">${sessionScope.account.fullname}</span>
                    
                    <c:if test="${not empty sessionScope.account.images}">
                        <c:url value="/image?fname=${sessionScope.account.images}" var="imgUrlAdmin"></c:url>
                        <img class="img-profile rounded-circle" src="${imgUrlAdmin}" style="width: 32px; height: 32px; object-fit: cover;">
                    </c:if>
                    <c:if test="${empty sessionScope.account.images}">
                         <img class="img-profile rounded-circle" src="https://via.placeholder.com/32" style="width: 32px; height: 32px;">
                    </c:if>
                </a>
                
                <ul class="dropdown-menu dropdown-menu-end shadow animated--grow-in" aria-labelledby="userDropdown">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Hồ sơ cá nhân
                    </a></li>
                    <li><a class="dropdown-item" href="#">
                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> Cài đặt
                    </a></li>
                    <li><a class="dropdown-item" href="#">
                        <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> Nhật ký hoạt động
                    </a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2"></i> Đăng xuất
                    </a></li>
                </ul>
            </li>

        </ul>
    </div>
</nav>