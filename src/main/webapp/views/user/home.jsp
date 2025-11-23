<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    .gallery-container {
        width: 96%;        
        max-width: none;   
        margin: 0 auto;    
        padding-top: 40px;
    }

    .gallery-card {
        position: relative;
        overflow: hidden;
        border-radius: 0; 
        cursor: pointer;
        width: 100%;
        
        aspect-ratio: 483 / 603; 
        
        background-color: #f0f0f0; 
        transition: all 0.5s ease;
    }

    .gallery-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
        transition: transform 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .gallery-card:hover .gallery-image {
        transform: scale(1.05);
    }

    .gallery-overlay {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        text-align: center;
        z-index: 2;
        padding-bottom: 30px; 
        
        /* Gradient đen mờ giúp chữ trắng nổi bật trên mọi nền ảnh */
        background: linear-gradient(to top, rgba(0,0,0,0.6) 0%, transparent 100%);
    }

    .gallery-title {
        color: white;
        font-family: 'Times New Roman', serif; 
        font-size: 2rem; 
        font-weight: 400;
        text-shadow: 0 2px 10px rgba(0,0,0,0.3);
        margin: 0;

        letter-spacing: 2px;       /* Giãn khoảng cách chữ */
    }
    
    /* Tiêu đề trang */
    .page-title {
        font-family: 'Times New Roman', serif;
        font-size: 2.2rem;
        color: #333;
        margin-bottom: 50px;
        font-weight: normal;
        letter-spacing: 1px;
    }
    
    @media (max-width: 768px) {
        .gallery-container { width: 100%; padding: 0 15px; }
        .gallery-title { font-size: 1.5rem; }
    }
</style>

<div class="gallery-container mb-5">
    
    <h2 class="text-center page-title">
        Five wonderful worlds, a dazzling experience
    </h2>

    <div class="row g-4 justify-content-center">
        <c:forEach items="${cateList}" var="cate">
            
            <div class="col-lg-4 col-md-6 col-12">
                <a href="${pageContext.request.contextPath}/user/video?categoryId=${cate.id}" class="text-decoration-none">
                    <div class="gallery-card shadow-sm">
                        <c:if test="${not empty cate.images}">
                            <c:set var="imagePath" value="${fn:replace(cate.images, '\\\\', '/')}" />
                            <c:url value="/image?fname=${imagePath}" var="imgUrl"></c:url>
                            
                            <img src="${imgUrl}" class="gallery-image" alt="${cate.name}" 
                                 onerror="this.src='https://via.placeholder.com/1080x1350?text=No+Image'">
                        </c:if>
                        <c:if test="${empty cate.images}">
                             <img src="https://via.placeholder.com/1080x1350?text=No+Image" class="gallery-image">
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