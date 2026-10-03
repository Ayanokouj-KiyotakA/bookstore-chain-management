<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Yêu Cầu Thu Mua #${buybackRequest.id}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4" style="max-width: 900px;">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="fw-bold">Chi Tiết Đơn Thu Mua #${buybackRequest.id}</h2>
        <a href="/admin/buybacks" class="btn btn-outline-secondary btn-sm">← Quay lại danh sách</a>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border-0 mb-4 p-4">
        <div class="row mb-3">
            <div class="col-md-6">
                <p class="mb-1 text-muted">Khách hàng gửi:</p>
                <h5 class="fw-semibold">${buybackRequest.customer.fullName} (${buybackRequest.customer.email})</h5>
            </div>
            <div class="col-md-6">
                <p class="mb-1 text-muted">Chi nhánh tiếp nhận:</p>
                <h5 class="fw-semibold">${buybackRequest.store.name}</h5>
            </div>
        </div>

        <form action="/admin/buybacks/${buybackRequest.id}/update" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold">Trạng thái đơn thu mua:</label>
                <select name="status" class="form-select w-50">
                    <c:forEach var="st" items="${statuses}">
                        <option value="${st}" ${buybackRequest.status == st ? 'selected' : ''}>${st}</option>
                    </c:forEach>
                </select>
            </div>

            <h5 class="fw-bold mt-4 mb-3">Danh sách sách khách gửi bán:</h5>
            <div class="table-responsive mb-3">
                <table class="table align-middle table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Tựa Sách</th>
                            <th>Tác Giả</th>
                            <th>Tình Trạng Đánh Giá</th>
                            <th style="width: 200px;">Giá Đề Xuất Mua Lại (VNĐ)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${buybackRequest.items}">
                            <tr>
                                <input type="hidden" name="itemIds" value="${item.id}" />
                                <td class="fw-semibold">${item.bookTitle}</td>
                                <td>${item.bookAuthor}</td>
                                <td><span class="badge bg-info text-dark">${item.proposedCondition}</span></td>
                                <td>
                                    <input type="number" step="1000" name="offeredPrices" value="${item.offeredPrice}" class="form-control" placeholder="Nhập giá tiền..." />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Ghi chú của nhân viên kiểm tra:</label>
                <textarea name="staffNote" rows="3" class="form-control" placeholder="Nhập ghi chú tình trạng sách thực tế...">${buybackRequest.staffNote}</textarea>
            </div>

            <div class="text-end">
                <button type="submit" class="btn btn-primary px-4">Lưu thay đổi & Cập nhật định giá</button>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>