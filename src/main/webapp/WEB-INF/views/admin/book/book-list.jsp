<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đầu sách - Bookstore Chain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="fw-bold">Danh mục Đầu sách</h2>
            <a href="/admin/dashboard" class="text-decoration-none small">← Về Dashboard</a>
        </div>
        <a href="/admin/books/new" class="btn btn-primary">+ Thêm đầu sách mới</a>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Thanh tìm kiếm -->
    <form action="/admin/books" method="get" class="row g-2 mb-3">
        <div class="col-auto flex-grow-1">
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo tên sách, tác giả hoặc thể loại...">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-dark">Tìm kiếm</button>
            <c:if test="${not empty keyword}">
                <a href="/admin/books" class="btn btn-outline-secondary">Xóa lọc</a>
            </c:if>
        </div>
    </form>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3">ID</th>
                        <th>Tên Sách</th>
                        <th>Tác Giả</th>
                        <th>Thể Loại</th>
                        <th>Giá Bìa</th>
                        <th>Trạng Thái</th>
                        <th class="text-end pe-3">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${bookPage.content}">
                        <tr>
                            <td class="ps-3 fw-bold">${book.id}</td>
                            <td>
                                <div class="fw-semibold text-primary">${book.title}</div>
                                <small class="text-muted">${book.publisher} (${book.publicationYear})</small>
                            </td>
                            <td>${book.author}</td>
                            <td><span class="badge bg-info text-dark">${book.category}</span></td>
                            <td>
                                <fmt:formatNumber value="${book.coverPrice}" pattern="#,###" /> đ
                            </td>
                            <td>
                                <span class="badge ${book.active ? 'bg-success' : 'bg-secondary'}">
                                    ${book.active ? 'Hoạt động' : 'Tạm dừng'}
                                </span>
                            </td>
                            <td class="text-end pe-3">
                                <a href="/admin/books/${book.id}/edit" class="btn btn-sm btn-outline-secondary me-1">Sửa</a>
                                <form action="/admin/books/${book.id}/toggle-status" method="post" class="d-inline">
                                    <button type="submit" class="btn btn-sm ${book.active ? 'btn-outline-danger' : 'btn-outline-success'}">
                                        ${book.active ? 'Khóa' : 'Mở'}
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bookPage.content}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">Không tìm thấy sách phù hợp.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Phân trang -->
    <c:if test="${bookPage.totalPages > 1}">
        <nav class="mt-3">
            <ul class="pagination justify-content-center">
                <c:forEach begin="0" end="${bookPage.totalPages - 1}" var="i">
                    <li class="page-item ${bookPage.number == i ? 'active' : ''}">
                        <a class="page-link" href="/admin/books?page=${i}&keyword=${keyword != null ? keyword : ''}">${i + 1}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>