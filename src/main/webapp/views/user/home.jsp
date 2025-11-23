<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    .gallery-card {
        position: relative;
        overflow: hidden;
        border-radius: 0; 
        cursor: pointer;
        transition: all 0.3s ease;
        margin-bottom: 24px;
    }

    .gallery-image {
        width: 100%;
        height: 400px; 
        object-fit: cover;
        transition: transform 0.5s ease;
        filter: brightness(0.8);
    }

    /* Hiệu ứng zoom khi rê chuột */
    .gallery-card:hover .gallery-image {
        transform: scale(1.1);
        filter: brightness(1);
    }

    .gallery-overlay {
        position: absolute;
        bottom: 30px; 
        left: 0;
        right: 0;
        text-align: center;
        z-index: 2;
    }

    .gallery-title {
        color: white;
        font-family: 'Times New Roman', serif; 
        font-size: 1.8rem;
        text-shadow: 1px 1px 4px rgba(0,0,0,0.6);
        margin: 0;
    }
</style>

<div class="container mt-5">
    <h2 class="text-center mb-5" style="font-family: 'Times New Roman', serif;">Explore the Collection</h2>

    <div class="row">
        <c:forEach items="${cateList}" var="cate">
            <div class="col-md-4 col-sm-6">
                <a href="${pageContext.request.contextPath}/user/video?categoryId=${cate.id}" class="text-decoration-none">
                    <div class="gallery-card shadow-sm">
                        <c:if test="${not empty cate.images}">
                            <c:set var="imagePath" value="${fn:replace(cate.images, '\\\\', '/')}" />
                            <c:url value="/image?fname=${imagePath}" var="imgUrl"></c:url>
                            
                            <img src="${imgUrl}" class="gallery-image" alt="${cate.name}" 
                                 onerror="this.src='https://via.placeholder.com/400x600?text=No+Image'">
                        </c:if>
                        
                        <div class="gallery-overlay">
                            <h3 class="gallery-title">${cate.name}</h3>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>