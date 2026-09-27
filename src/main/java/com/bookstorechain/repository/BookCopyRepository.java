package com.bookstorechain.repository;

import com.bookstorechain.entity.BookCopy;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookCopyRepository extends JpaRepository<BookCopy, Long> {
    List<BookCopy> findByStoreId(Long storeId);
}
