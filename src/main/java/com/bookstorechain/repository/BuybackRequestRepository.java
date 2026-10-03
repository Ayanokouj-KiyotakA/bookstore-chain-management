package com.bookstorechain.repository;

import com.bookstorechain.entity.BuybackRequest;
import com.bookstorechain.enums.BuybackStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BuybackRequestRepository extends JpaRepository<BuybackRequest, Long> {

    @Query("SELECT br FROM BuybackRequest br WHERE " +
           "(:storeId IS NULL OR br.store.id = :storeId) AND " +
           "(:status IS NULL OR br.status = :status)")
    Page<BuybackRequest> searchRequests(@Param("storeId") Long storeId,
                                                @Param("status") BuybackStatus status,
                                                Pageable pageable);
}