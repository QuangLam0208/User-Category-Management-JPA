<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4>Personal Information</h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="profile" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-4 text-center mb-3">
                            <c:if test="${not empty sessionScope.account.images}">
							    <c:set var="imagePath" value="${fn:replace(sessionScope.account.images, '\\\\', '/')}" />
							    
							    <c:url value="/image?fname=${imagePath}" var="imgUrl"></c:url>
							
							    <img src="${imgUrl}" 
							         class="img-thumbnail rounded-circle" 
							         style="width: 150px; height: 150px; object-fit: cover;" 
							         alt="Avatar"
							         onerror="this.src='https://via.placeholder.com/150'">
							</c:if>
                            
                            <c:if test="${empty sessionScope.account.images}">
                                <img src="https://via.placeholder.com/150" 
                                     class="img-thumbnail rounded-circle" alt="Default Avatar">
                            </c:if>
                            
                            <div class="mt-3">
                                <label for="images" class="form-label">Change Avatar</label>
                                <input type="file" class="form-control" name="images" id="images" accept="image/*">
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" value="${sessionScope.account.username}" disabled>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" value="${sessionScope.account.email}" disabled>
                            </div>

                            <div class="mb-3">
                                <label for="fullname" class="form-label">Fullname</label>
                                <input type="text" class="form-control" name="fullname" id="fullname" 
                                       value="${sessionScope.account.fullname}" required>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="text" class="form-control" name="phone" id="phone" 
                                       value="${sessionScope.account.phone}">
                            </div>

                            <button type="submit" class="btn btn-primary">Update Profile</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>