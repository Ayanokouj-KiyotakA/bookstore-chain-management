<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng nhập - Bookstore Chain</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f4f6f9;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100vh;
}

.card-login {
	width: 100%;
	max-width: 420px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
	<div class="card card-login p-4 bg-white">
		<div class="text-center mb-4">
			<h4 class="fw-bold text-primary">BOOKSTORE CHAIN</h4>
			<p class="text-muted small">Hệ thống quản lý chuỗi sách cũ</p>
		</div>

		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger py-2 small">${errorMessage}</div>
		</c:if>
		<c:if test="${not empty successMessage}">
			<div class="alert alert-success py-2 small">${successMessage}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/perform-login"
			method="post">
			<div class="mb-3">
				<label for="username" class="form-label">Tên đăng nhập</label> <input
					type="text" class="form-control" id="username" name="username"
					required autofocus placeholder="admin hoặc staff">
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">Mật khẩu</label> <input
					type="password" class="form-control" id="password" name="password"
					required placeholder="••••••••">
			</div>
			<button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">Đăng
				nhập</button>
		</form>
	</div>
</body>
</html>