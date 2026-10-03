package com.bookstorechain.controller.web;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

        // Nếu đã đăng nhập thì chuyển hướng thẳng vào dashboard
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth instanceof AnonymousAuthenticationToken)) {
            return "redirect:/admin/dashboard";
        }

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
}