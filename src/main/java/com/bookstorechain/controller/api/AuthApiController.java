package com.bookstorechain.controller.api;

import com.bookstorechain.entity.User;
import com.bookstorechain.enums.Role;
import com.bookstorechain.repository.UserRepository;
import com.bookstorechain.security.JwtUtil;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthApiController {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    public AuthApiController(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtUtil jwtUtil) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping("/register")
    public User register(@RequestBody Map<String, String> body) {
        User user = new User();
        user.setEmail(body.get("email"));
        user.setPassword(passwordEncoder.encode(body.get("password")));
        user.setFullName(body.get("fullName"));
        user.setRole(Role.CUSTOMER);
        return userRepository.save(user);
    }

    @PostMapping("/login")
    public Map<String, String> login(@RequestBody Map<String, String> body) {
        User user = userRepository.findByEmail(body.get("email"))
                .orElseThrow(() -> new RuntimeException("Sai email hoac mat khau"));

        if (!passwordEncoder.matches(body.get("password"), user.getPassword())) {
            throw new RuntimeException("Sai email hoac mat khau");
        }

        String token = jwtUtil.generateToken(user.getEmail(), user.getRole().name());
        return Map.of("token", token);
    }
}
