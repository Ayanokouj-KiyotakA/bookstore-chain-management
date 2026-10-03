<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản lý Kho bản sách - Bookstore Chain</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">
	<div class="container py-4">
		<div class="d-flex justify-content-between align-items-center mb-3">
			<div>
				<h2 class="fw-bold">Quản lý Kho Sách Cụ Thể (BookCopy)</h2>
				<a href="/admin/dashboard" class="text-decoration-none small">←
					Về Dashboard</a>
			</div>
			<a href="/admin/book-copies/new" class="btn btn-primary">+ Nhập
				bản sách mới vào kho</a>
		</div>

		<c:if test="${not empty successMessage}">
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				${successMessage}
				<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			</div>
		</c:if>

		<!-- Bộ lọc tìm kiếm -->
		<form action="/admin/book-copies" method="get" class="row g-2 mb-3">
			<div class="col-md-3">
				<select name="storeId" class="form-select">
					<option value="">-- Tất cả chi nhánh --</option>
					<c:forEach var="store" items="${stores}">
						<option value="${store.id}"
							${selectedStoreId == store.id ? 'selected' : ''}>${store.name}</option>
					</c:forEach>
				</select>
			</div>
			<div class="col-md-3">
				<select name="status" class="form-select">
					<option value="">-- Tất cả trạng thái --</option>
					<c:forEach var="st" items="${statuses}">
						<option value="${st}" ${selectedStatus == st ? 'selected' : ''}>${st}</option>
					</c:forEach>
				</select>
			</div>
			<div class="col-md-4">
				<input type="text" name="keyword" value="${keyword}"
					class="form-control"
					placeholder="Tìm theo mã bản sách hoặc tên sách...">
			</div>
			<div class="col-md-2">
				<button type="submit" class="btn btn-dark w-100">Lọc dữ
					liệu</button>
			</div>
		</form>

		<div class="card shadow-sm border-0">
			<div class="card-body p-0">
				<table class="table table-hover align-middle mb-0">
					<thead class="table-light">
						<tr>
							<th class="ps-3">Mã Bản Sách</th>
							<th>Tên Đầu Sách</th>
							<th>Chi Nhánh Quản Lý</th>
							<th>Tình Trạng</th>
							<th>Giá Bán</th>
							<th>Trạng Thái</th>
							<th class="text-end pe-3">Hành Động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="copy" items="${bookCopyPage.content}">
							<tr>
								<td class="ps-3 fw-bold text-secondary">${copy.copyCode}</td>
								<td>
									<div class="fw-semibold text-primary">${copy.bookTitle}</div> <small
									class="text-muted">Tác giả: ${copy.bookAuthor}</small>
								</td>
								<td>${copy.storeName}</td>
								<td><span class="badge bg-info text-dark">${copy.bookCondition}</span>
								</td>
								<td class="fw-semibold text-success"><fmt:formatNumber
										value="${copy.price}" pattern="#,###" /> đ</td>
								<td><span
									class="badge ${copy.status == 'AVAILABLE' ? 'bg-success' : (copy.status == 'SOLD' ? 'bg-secondary' : 'bg-warning text-dark')}">
										${copy.status} </span></td>
								<td class="text-end pe-3"><a
									href="/admin/book-copies/${copy.id}/edit"
									class="btn btn-sm btn-outline-secondary">Sửa</a></td>
							</tr>
						</c:forEach>
						<c:if test="${empty bookCopyPage.content}">
							<tr>
								<td colspan="7" class="text-center py-4 text-muted">Không
									tìm thấy bản sách nào trong kho.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<!-- Phân trang -->
		<c:if test="${bookCopyPage.totalPages > 1}">
			<nav class="mt-3">
				<ul class="pagination justify-content-center">
					<c:forEach begin="0" end="${bookCopyPage.totalPages - 1}" var="i">
						<li class="page-item ${bookCopyPage.number == i ? 'active' : ''}">
							<a class="page-link"
							href="/admin/book-copies?page=${i}&storeId=${selectedStoreId != null ? selectedStoreId : ''}&status=${selectedStatus != null ? selectedStatus : ''}&keyword=${keyword != null ? keyword : ''}">${i + 1}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</c:if>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>