<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${bookId != null ? 'Cập nhật Sách' : 'Thêm Sách Mới'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4" style="max-width: 700px;">
    <div class="card shadow-sm border-0 p-4">
        <h3 class="fw-bold mb-3">${bookId != null ? 'Cập nhật Sách' : 'Thêm Sách Mới'}</h3>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger py-2 small">${errorMessage}</div>
        </c:if>

        <form:form action="${bookId != null ? '/admin/books/'.concat(bookId).concat('/edit') : '/admin/books/new'}" 
                   method="post" 
                   modelAttribute="bookForm" 
                   enctype="multipart/form-data">
            
            <div class="mb-3">
                <label class="form-label">Tên sách (*)</label>
                <form:input path="title" cssClass="form-control" />
                <form:errors path="title" cssClass="text-danger small" />
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Tác giả (*)</label>
                    <form:input path="author" cssClass="form-control" />
                    <form:errors path="author" cssClass="text-danger small" />
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Thể loại</label>
                    <form:input path="category" cssClass="form-control" placeholder="Tiểu thuyết, Kỹ năng,..." />
                    <form:errors path="category" cssClass="text-danger small" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Nhà xuất bản</label>
                    <form:input path="publisher" cssClass="form-control" />
                </div>
                <div class="col-md-3 mb-3">
                    <label class="form-label">Năm XB</label>
                    <form:input path="publicationYear" type="number" cssClass="form-control" />
                    <form:errors path="publicationYear" cssClass="text-danger small" />
                </div>
                <div class="col-md-3 mb-3">
                    <label class="form-label">Giá bìa (VNĐ)</label>
                    <form:input path="coverPrice" type="number" step="1000" cssClass="form-control" />
                    <form:errors path="coverPrice" cssClass="text-danger small" />
                </div>
            </div>

            <!-- Trường chọn tải ảnh bìa lên Cloudinary -->
            <div class="mb-3">
                <label class="form-label">Ảnh bìa sách</label>
                <input type="file" name="imageFile" class="form-control" accept="image/*" />
                <c:if test="${not empty bookForm.coverImage}">
                    <div class="mt-2">
                        <small class="text-muted d-block mb-1">Ảnh bìa hiện tại:</small>
                        <img src="${bookForm.coverImage}" alt="Ảnh bìa" class="rounded border shadow-sm" style="max-height: 120px;" />
                        <form:hidden path="coverImage" />
                    </div>
                </c:if>
            </div>

            <div class="mb-3">
                <label class="form-label">Mô tả tóm tắt</label>
                <form:textarea path="description" rows="4" cssClass="form-control" />
            </div>

            <div class="d-flex justify-content-end gap-2">
                <a href="/admin/books" class="btn btn-secondary">Hủy bỏ</a>
                <button type="submit" class="btn btn-primary">Lưu thông tin</button>
            </div>
        </form:form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>