<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Chi nhánh - Bookstore Chain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="fw-bold">Danh sách Chi nhánh</h2>
            <a href="/admin/dashboard" class="text-decoration-none small">← Về Dashboard</a>
        </div>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createStoreModal">
            + Thêm Chi nhánh mới
        </button>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3">ID</th>
                        <th>Tên Chi Nhánh</th>
                        <th>Địa Chỉ</th>
                        <th>Số Điện Thoại</th>
                        <th>Nhân Viên</th>
                        <th>Trạng Thái</th>
                        <th class="text-end pe-3">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="store" items="${stores}">
                        <tr>
                            <td class="ps-3 fw-bold">${store.id}</td>
                            <td class="fw-semibold text-primary">${store.name}</td>
                            <td>${store.address}</td>
                            <td>${store.phone}</td>
                            <td><span class="badge bg-secondary">${store.employeeCount} nhân sự</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${store.active}">
                                        <span class="badge bg-success">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Tạm dừng</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end pe-3">
                                <a href="/admin/stores/${store.id}/edit" class="btn btn-sm btn-outline-secondary me-1">Sửa</a>
                                <form action="/admin/stores/${store.id}/toggle-status" method="post" class="d-inline">
                                    <button type="submit" class="btn btn-sm ${store.active ? 'btn-outline-danger' : 'btn-outline-success'}">
                                        ${store.active ? 'Khóa' : 'Mở'}
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty stores}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">Chưa có chi nhánh nào được tạo.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal Thêm Chi Nhánh -->
<div class="modal fade ${openModal ? 'show d-block' : ''}" id="createStoreModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form:form action="/admin/stores" method="post" modelAttribute="storeForm">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Thêm Chi nhánh mới</h5>
                    <a href="/admin/stores" class="btn-close"></a>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Tên chi nhánh</label>
                        <form:input path="name" cssClass="form-control" placeholder="VD: Chi Nhánh Đống Đa" />
                        <form:errors path="name" cssClass="text-danger small" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <form:input path="address" cssClass="form-control" placeholder="VD: 45 Chùa Bộc, Hà Nội" />
                        <form:errors path="address" cssClass="text-danger small" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <form:input path="phone" cssClass="form-control" placeholder="VD: 0987654321" />
                        <form:errors path="phone" cssClass="text-danger small" />
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="/admin/stores" class="btn btn-secondary">Đóng</a>
                    <button type="submit" class="btn btn-primary">Lưu chi nhánh</button>
                </div>
            </form:form>
        </div>
    </div>
</div>
<c:if test="${openModal}">
    <div class="modal-backdrop fade show"></div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>