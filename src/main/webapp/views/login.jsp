<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Nhập</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
    body {
        background-color: #f0f2f5; /* Màu nền */
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh; /* form ở giữa màn hình */
        margin: 0;
    }
    .login-container {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px; /* Giới hạn chiều rộng của form */
    }
    .login-container h2 {
        font-size: 1.5rem;
        font-weight: 500;
        margin-bottom: 30px;
        color: #333;
    }
    .input-group-text {
        background-color: #e9ecef; /* Màu nền cho icon */
        border-right: none;
        border-radius: 0.25rem 0 0 0.25rem; /* Bo tròn góc trái */
    }
    .form-control {
        border-left: none;
        border-radius: 0 0.25rem 0.25rem 0; /* Bo tròn góc phải */
    }
    .form-control:focus {
        box-shadow: none;
        border-color: #86b7fe; /* Màu viền khi focus */
    }
    .btn-primary {
        background-color: #007bff; /* Màu nút chính */
        border-color: #007bff;
        padding: 10px 0; /* Tăng chiều cao nút */
        font-size: 1.1rem;
    }
    .btn-primary:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }
    .form-check {
        margin-bottom: 15px;
    }
    .form-check-input {
        margin-top: 0.25em; /* Căn chỉnh checkbox với text */
    }
    .form-links {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: -10px; /* Đẩy lên gần checkbox */
        margin-bottom: 20px; /* Khoảng cách với nút login */
    }
    .form-links a {
        font-size: 0.9em;
        color: #007bff;
        text-decoration: none;
    }
    .form-links a:hover {
        text-decoration: underline;
    }
    .register-text {
        text-align: center;
        margin-top: 30px;
        font-size: 0.95em;
        color: #6c757d;
    }
    .register-text a {
        color: #007bff;
        text-decoration: none;
        font-weight: 500;
    }
    .register-text a:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>

	<div class="login-container">
		<form action="login" method="post">
			<h2 class="text-center">Sign In</h2>
			
			<c:if test="${not empty alert}">
				<div class="alert alert-danger text-center" role="alert">
					${alert}
				</div>
			</c:if>
			
			<div class="mb-3">
				<div class="input-group">
					<span class="input-group-text"><i class="fa fa-user"></i></span>
					<input type="text" placeholder="Username" name="username" id="usernameInput"
						class="form-control" value="${param.username}"> </div>
			</div>
			
			<div class="mb-3">
				<div class="input-group">
					<span class="input-group-text"><i class="fa fa-lock"></i></span>
					<input type="password" placeholder="Password" name="password" id="passwordInput"
						class="form-control">
				</div>
			</div>
			
			<div class="form-links">
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
					<label class="form-check-label" for="rememberMe">
						Remember me
					</label>
				</div>
				<a href="forgot-password">Forgot password?</a>
			</div>
			
			<button type="submit" name="submit" class="btn btn-primary w-100">Sign In</button>
		</form>

        <p class="register-text">
            Don't Have An Account? <a href="register">Sign Up</a>
        </p>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

</body>
</html>