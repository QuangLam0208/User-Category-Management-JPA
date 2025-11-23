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

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-primary">Category Management</h2>
        
        <c:if test="${sessionScope.account.roleid == 3 || sessionScope.account.roleid == 2}">
            <a href="${pageContext.request.contextPath}${rolePrefix}/category/add" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Category
            </a>
        </c:if>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
             <c:set var="listToRender" value="${cateList}" scope="request"/>
             <jsp:include page="/views/admin/fragments/cate-table.jsp" />
        </div>
    </div>
</div>