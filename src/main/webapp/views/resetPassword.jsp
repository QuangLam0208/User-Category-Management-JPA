<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt Lại Mật Khẩu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body { background-color: #f8f9fa; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
    .login-container { background-color: #ffffff; padding: 35px; border-radius: 10px; box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08); width: 100%; max-width: 450px; border-top: 5px solid #28a745; }
    .login-container h2 { font-size: 1.7rem; font-weight: 500; margin-bottom: 30px; color: #333; }
    .input-group-text { background-color: #e9ecef; border: 1px solid #ced4da; border-right: none; color: #495057; }
    .form-control { border: 1px solid #ced4da; border-left: none; color: #495057; }
    .form-control:focus { border-color: #28a745; box-shadow: 0 0 0 0.25rem rgba(40, 167, 69, 0.25); }
    .btn-primary { background-color: #28a745; border-color: #28a745; padding: 10px 0; font-size: 1.1rem; font-weight: 600; color: #ffffff; }
    .btn-primary:hover { background-color: #218838; border-color: #1e7e34; }
    .alert-danger { color: #842029; background-color: #f8d7da; border-color: #f5c2c7; }
</style>
</head>
<body>
	<div class="login-container">
		<form action="reset-password" method="post"> 
			<h2 class="text-center">Reset Password</h2>
			
			<c:if test="${not empty alert}">
				<div class="alert alert-danger text-center" role="alert">
					${alert}
				</div>
			</c:if>
            
            <div class="mb-3">
				<div class="input-group">
					<span class="input-group-text"><i class="fa fa-lock"></i></span>
					<input type="password" placeholder="New Password" name="password" class="form-control" required>
				</div>
			</div>

            <div class="mb-3">
				<div class="input-group">
					<span class="input-group-text"><i class="fa fa-lock"></i></span>
					<input type="password" placeholder="Confirm Password" name="re_password" class="form-control" required>
				</div>
			</div>

            <button type="submit" name="submit" class="btn btn-primary w-100 mt-3">Reset Password</button>
		</form>
	</div>
</body>
</html>