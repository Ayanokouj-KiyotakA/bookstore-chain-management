<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa Chi nhánh</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5" style="max-width: 600px;">
    <div class="card shadow-sm border-0 p-4">
        <h4 class="fw-bold mb-3">Chỉnh sửa thông tin Chi nhánh</h4>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger py-2 small">${errorMessage}</div>
        </c:if>

        <form:form action="/admin/stores/${storeId}/edit" method="post" modelAttribute="storeForm">
            <div class="mb-3">
                <label class="form-label">Tên chi nhánh</label>
                <form:input path="name" cssClass="form-control" />
                <form:errors path="name" cssClass="text-danger small" />
            </div>
            <div class="mb-3">
                <label class="form-label">Địa chỉ</label>
                <form:input path="address" cssClass="form-control" />
                <form:errors path="address" cssClass="text-danger small" />
            </div>
            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <form:input path="phone" cssClass="form-control" />
                <form:errors path="phone" cssClass="text-danger small" />
            </div>
            <div class="d-flex justify-content-end gap-2">
                <a href="/admin/stores" class="btn btn-secondary">Quay lại</a>
                <button type="submit" class="btn btn-primary">Cập nhật</button>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>