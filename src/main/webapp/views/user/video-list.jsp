<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>

    .product-card {
        border: none;
        background: transparent;
        margin-bottom: 40px; /* Khoảng cách giữa các hàng */
        transition: all 0.3s ease;
    }

    .image-container {
        position: relative;
        width: 100%;
        height: 350px; 
        background-color: #f8f9fa; 
        overflow: hidden; 
        margin-bottom: 15px;
    }

    .product-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
        transition: transform 0.6s ease;
    }

    .product-card:hover .product-image {
        transform: scale(1.05);
    }

    .product-title {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 1rem;
        color: #333;
        text-align: center;
        margin: 0;
        font-weight: 500;
        letter-spacing: 0.5px;
    }

    .product-card:hover .product-title {
        color: #000;
    }
    
    a.card-link {
        text-decoration: none;
        color: inherit;
    }
</style>

<div class="container mt-5">
    <div class="text-center mb-5">
        <h2 style="font-family: serif; letter-spacing: 2px;">${category.name}</h2>
        <a href="${pageContext.request.contextPath}/user/home" class="text-secondary text-decoration-none small">
            <i class="fas fa-arrow-left"></i> Back to Collections
        </a>
    </div>

    <div class="row justify-content-center">
        
        <c:if test="${empty videos}">
            <p class="text-center text-muted">There are no videos in this collection.</p>
        </c:if>

        <c:forEach items="${videos}" var="v">
            <div class="col-md-3 col-sm-6"> <a href="#" class="card-link" onclick="alert('Xem video: ${v.title}')"> <div class="product-card">
                        <div class="image-container">
                            <c:if test="${not empty v.poster}">
                                <c:set var="posterPath" value="${fn:replace(v.poster, '\\\\', '/')}" />
                                <c:url value="/image?fname=${posterPath}" var="imgUrl"/>
                                <img src="${imgUrl}" class="product-image" alt="${v.title}" 
                                     onerror="this.src='https://via.placeholder.com/300x400?text=No+Image'">
                            </c:if>
                            <c:if test="${empty v.poster}">
                                <img src="https://via.placeholder.com/300x400?text=No+Image" class="product-image">
                            </c:if>
                        </div>

                        <h5 class="product-title">${v.title}</h5>
                    </div>
                </a>
                
            </div>
        </c:forEach>
    </div>
</div>