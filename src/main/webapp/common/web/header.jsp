<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %> <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/">
            <i class="fas fa-store me-2"></i>My Website
        </a>

        <div class="collapse navbar-collapse" id="navbarWeb">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/home">Home</a>
                </li>
                <c:if test="${not empty sessionScope.account}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/user/category/list">Category</a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-dark" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <c:if test="${not empty sessionScope.account.images}">
                                     <c:set var="imagePath" value="${fn:replace(sessionScope.account.images, '\\\\', '/')}" />
                                     <c:url value="/image?fname=${imagePath}" var="imgUrlHeader"></c:url>
                                     <img src="${imgUrlHeader}" class="rounded-circle me-1" style="width: 30px; height: 30px; object-fit: cover;" onerror="this.src='https://via.placeholder.com/30'">
                                </c:if>
                                <c:if test="${empty sessionScope.account.images}">
                                     <i class="fas fa-user-circle fa-lg me-1"></i>
                                </c:if>
                                <span>${sessionScope.account.fullname}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Personal profile</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="btn btn-outline-primary me-2" href="${pageContext.request.contextPath}/login">Sign In</a></li>
                        <li class="nav-item"><a class="btn btn-primary" href="${pageContext.request.contextPath}/register">Sign Up</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>