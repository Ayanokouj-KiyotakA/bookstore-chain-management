<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Yêu Cầu Thu Mua - Bookstore Chain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="fw-bold">Quản lý Yêu Cầu Thu Mua Sách Cũ</h2>
            <a href="/admin/dashboard" class="text-decoration-none small">← Về Dashboard</a>
        </div>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Bộ lọc -->
    <form action="/admin/buybacks" method="get" class="row g-2 mb-3">
        <div class="col-md-4">
            <select name="storeId" class="form-select">
                <option value="">-- Tất cả chi nhánh tiếp nhận --</option>
                <c:forEach var="store" items="${stores}">
                    <option value="${store.id}" ${selectedStoreId == store.id ? 'selected' : ''}>${store.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4">
            <select name="status" class="form-select">
                <option value="">-- Tất cả trạng thái đơn --</option>
                <c:forEach var="st" items="${statuses}">
                    <option value="${st}" ${selectedStatus == st ? 'selected' : ''}>${st}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-dark w-100">Lọc dữ liệu</button>
        </div>
    </form>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3">Mã Yêu Cầu</th>
                        <th>Khách Hàng</th>
                        <th>Chi Nhánh Xử Lý</th>
                        <th>Số Lượng Sách</th>
                        <th>Trạng Thái</th>
                        <th>Ngày Gửi</th>
                        <th class="text-end pe-3">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="req" items="${requestPage.content}">
                        <tr>
                            <td class="ps-3 fw-bold">#${req.id}</td>
                            <td>
                                <div class="fw-semibold">${req.customerFullName}</div>
                                <small class="text-muted">(${req.customerUsername})</small>
                            </td>
                            <td>${req.storeName}</td>
                            <td><span class="badge bg-secondary">${req.itemCount} cuốn</span></td>
                            <td>
                                <span class="badge ${req.status == 'PENDING' ? 'bg-warning text-dark' : (req.status == 'APPROVED' ? 'bg-success' : 'bg-danger')}">
                                    ${req.status}
                                </span>
                            </td>
                            <td>${req.createdAt}</td>
                            <td class="text-end pe-3">
                                <a href="/admin/buybacks/${req.id}" class="btn btn-sm btn-outline-primary">Xem & Định Giá</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty requestPage.content}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">Chưa có yêu cầu thu mua nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>