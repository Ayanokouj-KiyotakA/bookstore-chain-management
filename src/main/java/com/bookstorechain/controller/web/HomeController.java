package com.bookstorechain.controller.web;

import com.bookstorechain.repository.BookRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private final BookRepository bookRepository;

    // Giữ nguyên constructor injection chuẩn Spring
    public HomeController(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        try {
            model.addAttribute("books", bookRepository.findAll());
        } catch (Exception e) {
            // Phòng ngừa trường hợp bảng book chưa có dữ liệu hoặc đang khởi tạo
        }
        return "index";
    }
}