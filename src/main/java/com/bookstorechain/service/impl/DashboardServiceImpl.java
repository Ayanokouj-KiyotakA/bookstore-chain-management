package com.bookstorechain.service.impl;

import com.bookstorechain.repository.*;
import com.bookstorechain.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DashboardServiceImpl implements DashboardService {

    private final StoreRepository storeRepository;
    private final BookRepository bookRepository;
    private final BookCopyRepository bookCopyRepository;
    private final BuybackRequestRepository buybackRequestRepository;
    private final StockTransferRepository stockTransferRepository;

    @Override
    @Transactional(readOnly = true)
    public Map<String, Long> getDashboardStatistics() {
        Map<String, Long> stats = new HashMap<>();
        stats.put("totalStores", storeRepository.count());
        stats.put("totalBooks", bookRepository.count());
        stats.put("totalBookCopies", bookCopyRepository.count());
        stats.put("totalBuybacks", buybackRequestRepository.count());
        stats.put("totalTransfers", stockTransferRepository.count());
        return stats;
    }
}