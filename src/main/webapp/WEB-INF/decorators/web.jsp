<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><sitemesh:write property="title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <sitemesh:write property="head"/>
</head>
<body>
    <jsp:include page="/common/web/header.jsp"></jsp:include> 

    <div class="container">
        <sitemesh:write property="body"/>
    </div>

    <jsp:include page="/common/web/footer.jsp"></jsp:include>
</body>
</html>