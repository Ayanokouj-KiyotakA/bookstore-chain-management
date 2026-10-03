package com.bookstorechain.repository;

import com.bookstorechain.entity.BookCopy;
import com.bookstorechain.enums.CopyStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BookCopyRepository extends JpaRepository<BookCopy, Long> {

    boolean existsByCopyCode(String copyCode);

    @Query("SELECT bc FROM BookCopy bc WHERE " +
           "(:storeId IS NULL OR bc.store.id = :storeId) AND " +
           "(:status IS NULL OR bc.status = :status) AND " +
           "(:keyword IS NULL OR LOWER(bc.copyCode) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(bc.book.title) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    Page<BookCopy> searchBookCopies(@Param("storeId") Long storeId,
                                    @Param("status") CopyStatus status,
                                    @Param("keyword") String keyword,
                                    Pageable pageable);
}