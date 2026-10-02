package com.bookstorechain.config;

import com.bookstorechain.entity.Role;
import com.bookstorechain.entity.User;
import com.bookstorechain.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
@Slf4j
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        initDefaultAdmin();
        initDefaultStaff();
    }

    private void initDefaultAdmin() {
        if (!userRepository.existsByUsername("admin")) {

            User admin = User.builder()
                    .username("admin")
                    .password(passwordEncoder.encode("admin123"))
                    .fullName("Quản Trị Viên Hệ Thống")
                    .email("admin@bookstorechain.com")
                    .phone("0901234567")
                    .role(Role.ADMIN)
                    .isActive(true)
                    .build();

            userRepository.save(admin);

            log.info(">>> Đã khởi tạo tài khoản ADMIN mặc định: admin / admin123");
        }
    }

    private void initDefaultStaff() {
        if (!userRepository.existsByUsername("staff")) {

            User staff = User.builder()
                    .username("staff")
                    .password(passwordEncoder.encode("staff123"))
                    .fullName("Nhân Viên Chi Nhánh")
                    .email("staff@bookstorechain.com")
                    .phone("0907654321")
                    .role(Role.STAFF)
                    .isActive(true)
                    .build();

            userRepository.save(staff);

            log.info(">>> Đã khởi tạo tài khoản STAFF mặc định: staff / staff123");
        }
    }
}