<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    /* Navbar chính */ 
    .luxury-navbar {
        background-color: white;
        border-bottom: 1px solid #eee;
        padding: 15px 20px;
        position: sticky;
        top: 0;
        z-index: 1030;
    }

    /* Nút Menu và Search */
    .nav-icon-btn {
        background: none;
        border: none;
        font-size: 1.2rem;
        color: #333;
        cursor: pointer;
        transition: color 0.3s;
    }
    .nav-icon-btn:hover {
        color: #000;
    }

    /* Logo ở giữa */
    .brand-center {
        font-family: 'Times New Roman', serif;
        font-size: 2rem;
        text-transform: uppercase;
        letter-spacing: 3px;
        color: #000;
        text-decoration: none;
        font-weight: 500;
    }
    .brand-center:hover {
        color: #000;
    }

    /* Khung tìm kiếm */
    .search-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 300px; 
        background: white;
        z-index: 1050;
        display: none;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        animation: slideDown 0.3s ease-out;
    }

    @keyframes slideDown {
        from { transform: translateY(-100%); }
        to { transform: translateY(0); }
    }

    .search-input-container {
        border-bottom: 1px solid #ccc;
        padding-bottom: 10px;
        margin-top: 50px;
    }

    .search-input {
        border: none;
        width: 100%;
        font-size: 1.5rem;
        outline: none;
        color: #333;
        font-family: 'Times New Roman', serif;
    }

    .btn-close-search {
        position: absolute;
        top: 20px;
        left: 20px;
        font-size: 1.2rem;
        cursor: pointer;
        border: none;
        background: none;
        display: flex;
        align-items: center;
    }

    /* Menu bên trái */
    .offcanvas-luxury {
        width: 350px !important;
    }
    .menu-list {
        list-style: none;
        padding: 0;
        margin-top: 20px;
    }
    .menu-item {
        padding: 15px 0;
        border-bottom: 1px solid #f0f0f0;
    }
    .menu-link {
        text-decoration: none;
        color: #333;
        font-size: 1.1rem;
        display: block;
        transition: padding-left 0.3s;
    }
    .menu-link:hover {
        padding-left: 10px;
        color: #000;
        font-weight: 500;
    }
</style>

<nav class="luxury-navbar d-flex justify-content-between align-items-center">
    
    <button class="nav-icon-btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#menuDrawer">
        <i class="fas fa-bars"></i>
    </button>

    <a href="${pageContext.request.contextPath}/user/home" class="brand-center">
        ĐI Ỏ
    </a>

    <div class="d-flex align-items-center">
        <button class="nav-icon-btn me-3" onclick="openSearch()">
            <i class="fas fa-search"></i>
        </button>

        <c:choose>
            <c:when test="${not empty sessionScope.account}">
                <a href="${pageContext.request.contextPath}/profile" class="nav-icon-btn" title="Hồ sơ">
                    <c:if test="${not empty sessionScope.account.images}">
                        <c:set var="imagePath" value="${fn:replace(sessionScope.account.images, '\\\\', '/')}" />
                        <c:url value="/image?fname=${imagePath}" var="imgUrlHeader"/>
                        <img src="${imgUrlHeader}" class="rounded-circle" style="width: 25px; height: 25px; object-fit: cover;" onerror="this.src='https://via.placeholder.com/25'">
                    </c:if>
                    <c:if test="${empty sessionScope.account.images}">
                        <i class="far fa-user"></i>
                    </c:if>
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="nav-icon-btn" title="Đăng nhập">
                    <i class="far fa-user"></i>
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<div id="searchOverlay" class="search-overlay">
    <div class="container h-100 position-relative">
        <button class="btn-close-search" onclick="closeSearch()">
            <i class="fas fa-times me-2"></i> Close
        </button>

        <div class="d-flex flex-column justify-content-center h-100">
            <form action="${pageContext.request.contextPath}/user/video" method="get">
                <div class="search-input-container d-flex align-items-center">
                    <i class="fas fa-search me-3 text-muted"></i>
                    <input type="text" name="keyword" class="search-input" placeholder="What are you looking for?" autofocus autocomplete="off">
                    <button type="submit" class="nav-icon-btn ms-2">
                        <i class="fas fa-arrow-right"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="offcanvas offcanvas-start offcanvas-luxury" tabindex="-1" id="menuDrawer">
    <div class="offcanvas-header">
        <button type="button" class="btn-close-search" data-bs-dismiss="offcanvas" style="top: 20px; left: 20px;">
            <i class="fas fa-times me-2"></i> Close
        </button>
    </div>
    <div class="offcanvas-body mt-5">
        <ul class="menu-list">
            <li class="menu-item"><a href="${pageContext.request.contextPath}/user/home" class="menu-link">Home</a></li>
            
            <c:if test="${not empty sessionScope.account}">
                <li class="menu-item"><a href="${pageContext.request.contextPath}/user/category" class="menu-link">My Categories</a></li>
                <li class="menu-item"><a href="${pageContext.request.contextPath}/profile" class="menu-link">My Profile</a></li>
                <li class="menu-item"><a href="${pageContext.request.contextPath}/logout" class="menu-link text-danger">Log Out</a></li>
            </c:if>
            
            <c:if test="${empty sessionScope.account}">
                <li class="menu-item"><a href="${pageContext.request.contextPath}/login" class="menu-link">Sign In</a></li>
                <li class="menu-item"><a href="${pageContext.request.contextPath}/register" class="menu-link">Register</a></li>
            </c:if>
            
            <!-- <li class="menu-item mt-4"><a href="#" class="menu-link text-muted small">Noble Gambling</a></li> -->
            <li class="menu-item mt-4"><a href="#" class="menu-link text-muted small">Contact Us</a></li>
        </ul>
    </div>
</div>

<script>
    function openSearch() {
        document.getElementById("searchOverlay").style.display = "block";
        // Tự động focus vào ô input khi mở
        document.querySelector(".search-input").focus();
    }

    function closeSearch() {
        document.getElementById("searchOverlay").style.display = "none";
    }
    
    document.addEventListener('keydown', function(event) {
        if (event.key === "Escape") {
            closeSearch();
        }
    });
</script>