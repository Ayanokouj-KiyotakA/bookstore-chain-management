<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Chuyển Kho - Bookstore Chain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="fw-bold">Quản lý Phiếu Chuyển Kho Giữa Các Chi Nhánh</h2>
            <a href="/admin/dashboard" class="text-decoration-none small">← Về Dashboard</a>
        </div>
        <a href="/admin/transfers/new" class="btn btn-primary">+ Tạo phiếu chuyển kho</a>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Bộ lọc -->
    <form action="/admin/transfers" method="get" class="row g-2 mb-3">
        <div class="col-md-4">
            <select name="storeId" class="form-select">
                <option value="">-- Tất cả chi nhánh (Gửi/Nhận) --</option>
                <c:forEach var="store" items="${stores}">
                    <option value="${store.id}" ${selectedStoreId == store.id ? 'selected' : ''}>${store.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4">
            <select name="status" class="form-select">
                <option value="">-- Tất cả trạng thái phiếu --</option>
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
                        <th class="ps-3">Mã Phiếu</th>
                        <th>Chi Nhánh Gửi</th>
                        <th>Chi Nhánh Nhận</th>
                        <th>Người Tạo</th>
                        <th>Số Lượng Sách</th>
                        <th>Trạng Thái</th>
                        <th class="text-end pe-3">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tr" items="${transferPage.content}">
                        <tr>
                            <td class="ps-3 fw-bold">#${tr.id}</td>
                            <td><span class="text-danger fw-semibold">${tr.senderStoreName}</span></td>
                            <td><span class="text-success fw-semibold">${tr.receiverStoreName}</span></td>
                            <td>${tr.creatorUsername}</td>
                            <td><span class="badge bg-secondary">${tr.itemCount} cuốn</span></td>
                            <td>
                                <span class="badge ${tr.status == 'PENDING' ? 'bg-warning text-dark' : (tr.status == 'IN_TRANSIT' ? 'bg-info text-dark' : (tr.status == 'COMPLETED' ? 'bg-success' : 'bg-secondary'))}">
                                    ${tr.status}
                                </span>
                            </td>
                            <td class="text-end pe-3">
                                <a href="/admin/transfers/${tr.id}" class="btn btn-sm btn-outline-primary">Chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty transferPage.content}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">Chưa có phiếu chuyển kho nào.</td>
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