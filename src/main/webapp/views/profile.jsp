<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:choose>
    <c:when test="${sessionScope.account.roleid == 3}">
        <c:set var="rolePrefix" value="/admin"/>
    </c:when>
    <c:when test="${sessionScope.account.roleid == 2}">
        <c:set var="rolePrefix" value="/manager"/>
    </c:when>
    <c:otherwise>
        <c:set var="rolePrefix" value=""/>
    </c:otherwise>
</c:choose>

<div class="row justify-content-center mt-4">
    <div class="col-md-8">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Personal Information</h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}${rolePrefix}/profile" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-4 text-center mb-3">
                            
                            <c:if test="${not empty sessionScope.account.images}">
							    <c:set var="imagePath" value="${fn:replace(sessionScope.account.images, '\\\\', '/')}" />
							    <c:url value="/image?fname=${imagePath}" var="imgUrl"></c:url>
							
							    <img src="${imgUrl}" 
							         class="img-thumbnail rounded-circle shadow-sm" 
							         style="width: 150px; height: 150px; object-fit: cover;" 
							         alt="Avatar"
							         onerror="this.src='https://via.placeholder.com/150'">
							</c:if>
                            
                            <c:if test="${empty sessionScope.account.images}">
                                <img src="https://via.placeholder.com/150" 
                                     class="img-thumbnail rounded-circle shadow-sm" alt="Default Avatar">
                            </c:if>
                            
                            <div class="mt-3">
                                <label for="images" class="form-label fw-bold text-primary">Change Avatar</label>
                                <input type="file" class="form-control" name="images" id="images" accept="image/*">
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Username</label>
                                <input type="text" class="form-control bg-light" value="${sessionScope.account.username}" disabled>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Email</label>
                                <input type="email" class="form-control bg-light" value="${sessionScope.account.email}" disabled>
                            </div>

                            <div class="mb-3">
                                <label for="fullname" class="form-label fw-bold">Fullname</label>
                                <input type="text" class="form-control" name="fullname" id="fullname" 
                                       value="${sessionScope.account.fullname}" required>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label fw-bold">Phone</label>
                                <input type="text" class="form-control" name="phone" id="phone" 
                                       value="${sessionScope.account.phone}">
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-4">
                                <c:choose>
                                    <c:when test="${rolePrefix == ''}">
                                        <a href="${pageContext.request.contextPath}/user/home" class="text-decoration-none text-secondary">
                                            <i class="fas fa-arrow-left"></i> Back to Home
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}${rolePrefix}/home" class="text-decoration-none text-secondary">
                                            <i class="fas fa-arrow-left"></i> Back to Dashboard
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                                <button type="submit" class="btn btn-primary px-4">
                                    <i class="fas fa-save me-1"></i> Update Profile
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>