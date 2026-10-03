<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hệ thống Quản lý Chuỗi Cửa hàng Sách Cũ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark text-white sidebar collapse min-vh-100 p-3">
            <div class="position-sticky">
                <h4 class="text-center py-3 fw-bold text-warning">BOOKSTORE CHAIN</h4>
                <hr class="text-secondary">
                <ul class="nav flex-column gap-2">
                    <li class="nav-item">
                        <a href="/admin/dashboard" class="nav-link text-white active bg-primary rounded">
                            <i class="fa-solid fa-house me-2"></i> Tổng quan Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="/admin/stores" class="nav-link text-white">
                            <i class="fa-solid fa-store me-2"></i> Quản lý Chi Nhánh
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="/admin/books" class="nav-link text-white">
                            <i class="fa-solid fa-book me-2"></i> Quản lý Đầu Sách
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="/admin/book-copies" class="nav-link text-white">
                            <i class="fa-solid fa-boxes-stacked me-2"></i> Quản lý Kho Bản Sách
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="/admin/buybacks" class="nav-link text-white">
                            <i class="fa-solid fa-hand-holding-dollar me-2"></i> Duyệt Thu Mua Sách
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="/admin/transfers" class="nav-link text-white">
                            <i class="fa-solid fa-truck-ramp-box me-2"></i> Chuyển Kho Chi Nhánh
                        </a>
                    </li>
                </ul>
                <hr class="text-secondary mt-5">
                <form action="/logout" method="post" class="mt-3">
                    <button type="submit" class="btn btn-outline-danger w-100">
                        <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                    </button>
                </form>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2 fw-bold">Bảng Điều Hướng Quản Trị</h1>
                <span class="text-muted">Xin chào, Quản trị viên hệ thống</span>
            </div>

            <!-- Thống kê dạng Thẻ (Cards) -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm bg-primary text-white p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1">Tổng Số Chi Nhánh</h6>
                                <h2 class="fw-bold mb-0">${stats.totalStores}</h2>
                            </div>
                            <i class="fa-solid fa-store fa-2x opacity-50"></i>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border-0 shadow-sm bg-success text-white p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1">Danh Mục Đầu Sách</h6>
                                <h2 class="fw-bold mb-0">${stats.totalBooks}</h2>
                            </div>
                            <i class="fa-solid fa-book fa-2x opacity-50"></i>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border-0 shadow-sm bg-warning text-dark p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1">Tổng Bản Sách Trong Kho</h6>
                                <h2 class="fw-bold mb-0">${stats.totalBookCopies}</h2>
                            </div>
                            <i class="fa-solid fa-boxes-stacked fa-2x opacity-50"></i>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card border-0 shadow-sm bg-info text-white p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1">Yêu Cầu Thu Mua Sách Cũ</h6>
                                <h2 class="fw-bold mb-0">${stats.totalBuybacks}</h2>
                            </div>
                            <i class="fa-solid fa-hand-holding-dollar fa-2x opacity-50"></i>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card border-0 shadow-sm bg-secondary text-white p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1">Phiếu Chuyển Kho</h6>
                                <h2 class="fw-bold mb-0">${stats.totalTransfers}</h2>
                            </div>
                            <i class="fa-solid fa-truck-ramp-box fa-2x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Khu vực hướng dẫn nhanh -->
            <div class="card border-0 shadow-sm p-4 bg-white">
                <h4 class="fw-bold mb-3">Chào mừng bạn đến với hệ thống Bookstore Chain Management</h4>
                <p class="text-muted">Hệ thống hỗ trợ quản lý toàn diện các hoạt động vận hành chuỗi cửa hàng sách cũ:</p>
                <ul>
                    <li>Quản lý thông tin chi nhánh, phân quyền nhân sự.</li>
                    <li>Quản lý danh mục đầu sách chung và tải ảnh bìa trực tuyến qua Cloudinary.</li>
                    <li>Quản lý kho chi tiết theo từng mã bản sách (`BookCopy`) vật lý.</li>
                    <li>Xử lý và định giá các yêu cầu thu mua sách cũ từ khách hàng gửi đến.</li>
                    <li>Điều phối luân chuyển kho hàng linh hoạt giữa các chi nhánh trong hệ thống chuỗi.</li>
                </ul>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>