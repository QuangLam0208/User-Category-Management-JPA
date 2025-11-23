<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
    <c:when test="${sessionScope.account.roleid == 3}">
        <c:set var="rolePrefix" value="/admin" scope="request"/>
    </c:when>
    <c:when test="${sessionScope.account.roleid == 2}">
        <c:set var="rolePrefix" value="/manager" scope="request"/>
    </c:when>
    <c:otherwise>
        <c:set var="rolePrefix" value="/user" scope="request"/>
    </c:otherwise>
</c:choose>

<div class="container mt-5" style="max-width: 600px;">
    <div class="card shadow-sm">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">Add New Category</h4>
        </div>
        <div class="card-body">
            <form role="form" action="${pageContext.request.contextPath}${rolePrefix}/category/add" method="post" enctype="multipart/form-data">
                
                <div class="mb-3">
                    <label for="name" class="form-label">Category name:</label> 
                    <input class="form-control" placeholder="Enter a category name" name="name" id="name" required />
                </div>

                <div class="mb-3">
                    <label for="icon" class="form-label">Image:</label> 
                    <input type="file" name="icon" id="icon" class="form-control" required />
                </div>

                <div class="d-flex justify-content-between">
                    <a href="${pageContext.request.contextPath}${rolePrefix}/category" class="btn btn-secondary">
                        Cancel
                    </a>
                    <button type="submit" class="btn btn-success">Add</button>
                </div>
            </form>
        </div>
    </div>
</div>