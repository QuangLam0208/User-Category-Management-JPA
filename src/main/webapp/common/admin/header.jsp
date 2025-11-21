<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

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

        <ul class="navbar-nav ms-auto">

            <li class="nav-item mx-1">
                <a class="nav-link" href="javascript:void(0)" style="cursor: default;">
                    <i class="fas fa-bell fa-fw"></i>
                    <span class="badge bg-danger badge-counter">0</span>
                </a>
                </li>

            <li class="nav-item mx-1">
                <a class="nav-link" href="javascript:void(0)" style="cursor: default;">
                    <i class="fas fa-envelope fa-fw"></i>
                    <span class="badge bg-warning badge-counter">0</span>
                </a>
            </li>

            <div class="topbar-divider d-none d-sm-block" style="width: 0; border-right: 1px solid #e3e6f0; height: 2rem; margin: auto 1rem;"></div>

            <li class="nav-item dropdown no-arrow">
                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <span class="me-2 d-none d-lg-inline text-white-600 small">${sessionScope.account.fullname}</span>
                    
                    <c:if test="${not empty sessionScope.account.images}">
					    <c:set var="imagePath" value="${fn:replace(sessionScope.account.images, '\\\\', '/')}" />
					    
					    <c:url value="/image?fname=${imagePath}" var="imgUrlAdmin"></c:url>
					    
					    <img class="img-profile rounded-circle" 
					         src="${imgUrlAdmin}" 
					         style="width: 32px; height: 32px; object-fit: cover;"
					         onerror="this.src='https://via.placeholder.com/32'"> 
         			</c:if>
                    <c:if test="${empty sessionScope.account.images}">
                         <img class="img-profile rounded-circle" src="https://via.placeholder.com/32" style="width: 32px; height: 32px;">
                    </c:if>
                </a>
                
                <ul class="dropdown-menu dropdown-menu-end shadow animated--grow-in" aria-labelledby="userDropdown">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/profile">
                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Personal Profile
                    </a></li>
                    
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2"></i> Logout
                    </a></li>
                </ul>
            </li>

        </ul>
    </div>
</nav>