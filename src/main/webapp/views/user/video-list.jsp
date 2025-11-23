<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    /* ... Copy đoạn style từ home.jsp qua đây hoặc để chung file .css ... */
    .gallery-card { position: relative; overflow: hidden; cursor: pointer; margin-bottom: 24px; }
    .gallery-image { width: 100%; height: 300px; object-fit: cover; transition: transform 0.5s; filter: brightness(0.9); }
    .gallery-card:hover .gallery-image { transform: scale(1.1); filter: brightness(1); }
    .gallery-overlay { position: absolute; bottom: 20px; width: 100%; text-align: center; z-index: 2; }
    .gallery-title { color: white; font-family: 'Times New Roman', serif; font-size: 1.5rem; text-shadow: 1px 1px 3px rgba(0,0,0,0.8); }
    .play-icon {
        position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
        font-size: 3rem; color: rgba(255,255,255,0.8); opacity: 0; transition: opacity 0.3s;
    }
    .gallery-card:hover .play-icon { opacity: 1; }
</style>

<div class="container mt-5">
    <div class="mb-4 text-center">
        <h2 style="font-family: 'Times New Roman', serif;">
            <span class="text-primary">${category.name}</span>
        </h2>
        <a href="${pageContext.request.contextPath}/user/home" class="btn btn-outline-secondary btn-sm mt-2">
            <i class="fas fa-arrow-left"></i> Back
        </a>
    </div>

    <div class="row">
        <c:if test="${empty videos}">
            <p class="text-center text-muted">There are no videos in this category yet.</p>
        </c:if>

        <c:forEach items="${videos}" var="v">
            <div class="col-md-4 col-sm-6">
                <a href="#" onclick="playUserVideo('${v.title}', '${v.poster}', '${v.id}')">
                    <div class="gallery-card shadow">
                        <c:if test="${not empty v.poster}">
                            <c:set var="posterPath" value="${fn:replace(v.poster, '\\\\', '/')}" />
                            <c:url value="/image?fname=${posterPath}" var="imgUrl"/>
                            <img src="${imgUrl}" class="gallery-image" alt="${v.title}" onerror="this.src='https://via.placeholder.com/400x300'">
                        </c:if>
                        
                        <i class="fas fa-play-circle play-icon"></i>

                        <div class="gallery-overlay">
                            <h4 class="gallery-title">${v.title}</h4>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>