<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${copyId != null ? 'Cập nhật Bản Sách' : 'Thêm Bản Sách Vào Kho'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4" style="max-width: 700px;">
    <div class="card shadow-sm border-0 p-4">
        <h3 class="fw-bold mb-3">${copyId != null ? 'Cập nhật Bản Sách' : 'Nhập Bản Sách Mới Vào Kho'}</h3>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger py-2 small">${errorMessage}</div>
        </c:if>

        <form:form action="${copyId != null ? '/admin/book-copies/'.concat(copyId).concat('/edit') : '/admin/book-copies/new'}" 
                   method="post" 
                   modelAttribute="copyForm">
            
            <div class="mb-3">
                <label class="form-label">Mã định danh bản sách (Copy Code) (*)</label>
                <form:input path="copyCode" cssClass="form-control" placeholder="VD: BC-HN01-0001" />
                <form:errors path="copyCode" cssClass="text-danger small" />
            </div>

            <div class="mb-3">
                <label class="form-label">Chọn Đầu Sách (*)</label>
                <form:select path="bookId" cssClass="form-select">
                    <form:option value="">-- Chọn đầu sách chung --</form:option>
                    <c:forEach var="book" items="${books}">
                        <form:option value="${book.id}">${book.title} - Tác giả: ${book.author}</form:option>
                    </c:forEach>
                </form:select>
                <form:errors path="bookId" cssClass="text-danger small" />
            </div>

            <div class="mb-3">
                <label class="form-label">Chi Nhánh Lưu Kho (*)</label>
                <form:select path="storeId" cssClass="form-select">
                    <form:option value="">-- Chọn chi nhánh tiếp nhận --</form:option>
                    <c:forEach var="store" items="${stores}">
                        <form:option value="${store.id}">${store.name}</form:option>
                    </c:forEach>
                </form:select>
                <form:errors path="storeId" cssClass="text-danger small" />
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Tình trạng sách (*)</label>
                    <form:select path="bookCondition" cssClass="form-select">
                        <form:option value="">-- Chọn tình trạng --</form:option>
                        <c:forEach var="cond" items="${conditions}">
                            <form:option value="${cond}">${cond}</form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="bookCondition" cssClass="text-danger small" />
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Giá bán thực tế (VNĐ) (*)</label>
                    <form:input path="price" type="number" step="1000" cssClass="form-control" placeholder="VD: 50000" />
                    <form:errors path="price" cssClass="text-danger small" />
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Ghi chú tình trạng</label>
                <form:textarea path="note" rows="3" cssClass="form-control" placeholder="VD: Sách cũ nguyên vẹn, góc hơi quăn nhẹ..." />
            </div>

            <div class="d-flex justify-content-end gap-2">
                <a href="/admin/book-copies" class="btn btn-secondary">Quay lại</a>
                <button type="submit" class="btn btn-primary">${copyId != null ? 'Cập nhật' : 'Xác nhận nhập kho'}</button>
            </div>
        </form:form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>