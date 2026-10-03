package com.bookstorechain.controller.web;

import com.bookstorechain.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/dashboard")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole('ADMIN', 'MANAGER', 'STAFF')")
public class DashboardController {

    private final DashboardService dashboardService;

    @GetMapping
    public String showDashboard(Model model) {
        model.addAttribute("stats", dashboardService.getDashboardStatistics());
        return "admin/dashboard";
    }
}