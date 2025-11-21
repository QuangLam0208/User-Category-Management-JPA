<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title><sitemesh:write property="title">Admin Dashboard</sitemesh:write></title> 

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        /* CSS cho các thẻ Dashboard (Card) */
        .dashboard-card {
            transition: all 0.3s;
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            overflow: hidden; /* Để bo góc mượt hơn */
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
            cursor: pointer;
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        /* Màu nền Gradient cho đẹp (nếu muốn dùng thêm) */
        .bg-gradient-primary {
            background: linear-gradient(45deg, #4e73df, #224abe);
        }
        .text-white-opacity {
            color: rgba(255, 255, 255, 0.8);
        }
        
        /* Tinh chỉnh Footer luôn nằm dưới cùng */
        .wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .content-wrapper {
            flex: 1;
        }
    </style>
    
    <sitemesh:write property="head"/> 
</head>
<body>

    <div class="wrapper">
        <jsp:include page="/common/admin/header.jsp"></jsp:include>
    
        <div class="container content-wrapper pt-4 pb-4">
            <sitemesh:write property="body"/>
        </div>
    
        <jsp:include page="/common/admin/footer.jsp"></jsp:include>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>