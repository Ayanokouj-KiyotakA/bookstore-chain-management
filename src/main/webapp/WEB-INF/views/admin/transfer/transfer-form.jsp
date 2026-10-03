<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Phiếu Chuyển Kho</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4" style="max-width: 800px;">
    <div class="card shadow-sm border-0 p-4">
        <h3 class="fw-bold mb-3">Tạo Lệnh Chuyển Kho Mới</h3>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger py-2 small">${errorMessage}</div>
        </c:if>

        <!-- Bước 1: Chọn chi nhánh gửi để load danh sách sách -->
        <div class="mb-3">
            <label class="form-label fw-bold">1. Chọn chi nhánh xuất kho (Gửi):</label>
            <select id="senderStoreSelect" class="form-select" onchange="location.href='/admin/transfers/new?senderStoreId=' + this.value;">
                <option value="">-- Chọn chi nhánh gửi --</option>
                <c:forEach var="store" items="${stores}">
                    <option value="${store.id}" ${selectedSenderId == store.id ? 'selected' : ''}>${store.name}</option>
                </c:forEach>
            </select>
        </div>

        <form:form action="/admin/transfers/new" method="post" modelAttribute="transferForm">
            <form:hidden path="senderStoreId" value="${selectedSenderId}" />

            <div class="mb-3">
                <label class="form-label fw-bold">2. Chọn chi nhánh nhận:</label>
                <form:select path="receiverStoreId" cssClass="form-select">
                    <form:option value="">-- Chọn chi nhánh nhận --</form:option>
                    <c:forEach var="store" items="${stores}">
                        <c:if test="${store.id != selectedSenderId}">
                            <form:option value="${store.id}">${store.name}</form:option>
                        </c:if>
                    </c:forEach>
                </form:select>
                <form:errors path="receiverStoreId" cssClass="text-danger small" />
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">3. Chọn các bản sách cần chuyển:</label>
                <div class="border rounded p-3 bg-white" style="max-height: 250px; overflow-y: auto;">
                    <c:choose>
                        <c:when test="${not empty availableCopies}">
                            <c:forEach var="copy" items="${availableCopies}">
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="bookCopyIds" value="${copy.id}" id="copy_${copy.id}">
                                    <label class="form-check-label" for="copy_${copy.id}">
                                        <strong>[${copy.copyCode}]</strong> ${copy.bookTitle} - Tình trạng: <span class="badge bg-info text-dark">${copy.bookCondition}</span>
                                    </label>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted small mb-0">Vui lòng chọn chi nhánh gửi ở trên để hiển thị danh sách sách có sẵn trong kho.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <form:errors path="bookCopyIds" cssClass="text-danger small" />
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Ghi chú vận chuyển:</label>
                <form:textarea path="note" rows="3" cssClass="form-control" placeholder="Nhập ghi chú hoặc lý do chuyển kho..." />
            </div>

            <div class="d-flex justify-content-end gap-2">
                <a href="/admin/transfers" class="btn btn-secondary">Quay lại</a>
                <button type="submit" class="btn btn-primary">Xác nhận tạo phiếu</button>
            </div>
        </form:form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>