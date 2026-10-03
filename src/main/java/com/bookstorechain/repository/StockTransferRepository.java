package com.bookstorechain.repository;

import com.bookstorechain.entity.StockTransfer;
import com.bookstorechain.enums.TransferStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface StockTransferRepository extends JpaRepository<StockTransfer, Long> {

    @Query("SELECT st FROM StockTransfer st WHERE " +
           "(:storeId IS NULL OR st.senderStore.id = :storeId OR st.receiverStore.id = :storeId) AND " +
           "(:status IS NULL OR st.status = :status)")
    Page<StockTransfer> searchTransfers(@Param("storeId") Long storeId,
                                        @Param("status") TransferStatus status,
                                        Pageable pageable);
}