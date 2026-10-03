package com.bookstorechain.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @GetMapping("/login")
    public String showLoginPage(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout,
            Model model) {

        if (error != null) {
            model.addAttribute(
                    "errorMessage",
                    "Tên đăng nhập hoặc mật khẩu không chính xác!"
            );
        }

        if (logout != null) {
            model.addAttribute(
                    "successMessage",
                    "Bạn đã đăng xuất thành công!"
            );
        }

        return "auth/login";
    }

    @GetMapping("/admin/dashboard")
    public String showAdminDashboard() {
        return "admin/dashboard";
    }
}