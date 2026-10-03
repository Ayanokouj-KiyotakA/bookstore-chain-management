package com.bookstorechain.config;

import com.bookstorechain.entity.Store;

import com.bookstorechain.entity.User;
import com.bookstorechain.enums.Role;
import com.bookstorechain.repository.StoreRepository;
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
    private final StoreRepository storeRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        Store defaultStore = initDefaultStore();
        initDefaultAdmin();
        initDefaultStaff(defaultStore);
    }

    private Store initDefaultStore() {
        return storeRepository.findByName("Chi Nhánh Trung Tâm - Hà Nội")
                .orElseGet(() -> {
                    Store store = Store.builder()
                            .name("Chi Nhánh Trung Tâm - Hà Nội")
                            .address("Số 123 Đường Cầu Giấy, Quận Cầu Giấy, Hà Nội")
                            .phone("02412345678")
                            .isActive(true)
                            .build();
                    Store saved = storeRepository.save(store);
                    log.info(">>> Đã khởi tạo STORE mặc định: {}", saved.getName());
                    return saved;
                });
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

    private void initDefaultStaff(Store store) {
        if (!userRepository.existsByUsername("staff")) {
            User staff = User.builder()
                    .username("staff")
                    .password(passwordEncoder.encode("staff123"))
                    .fullName("Nhân Viên Chi Nhánh")
                    .email("staff@bookstorechain.com")
                    .phone("0907654321")
                    .role(Role.STAFF)
                    .store(store)
                    .isActive(true)
                    .build();

            userRepository.save(staff);
            log.info(">>> Đã khởi tạo tài khoản STAFF mặc định thuộc Store: {}", store.getName());
        }
    }
}