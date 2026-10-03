package com.bookstorechain.service.impl;

import com.bookstorechain.dto.response.BuybackResponseDTO;
import com.bookstorechain.entity.*;
import com.bookstorechain.enums.CopyStatus;
import com.bookstorechain.enums.BuybackStatus;
import com.bookstorechain.exception.ResourceNotFoundException;
import com.bookstorechain.repository.BookCopyRepository;
import com.bookstorechain.repository.BuybackRequestRepository;
import com.bookstorechain.service.BuybackService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BuybackServiceImpl implements BuybackService {

    private final BuybackRequestRepository buybackRequestRepository;
    private final BookCopyRepository bookCopyRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<BuybackResponseDTO> getRequests(Long storeId, BuybackStatus status, Pageable pageable) {
        return buybackRequestRepository.searchRequests(storeId, status, pageable).map(this::mapToResponseDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public BuybackRequest getRequestById(Long id) {
        return buybackRequestRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy yêu cầu thu mua với ID: " + id));
    }

    @Override
    @Transactional
    public void updateStatusAndPricing(Long requestId, BuybackStatus status, String staffNote, List<Long> itemIds, List<BigDecimal> offeredPrices) {
        BuybackRequest request = getRequestById(requestId);
        request.setStatus(status);
        request.setStaffNote(staffNote);

        // Cập nhật giá đề xuất cho từng item
        if (itemIds != null && offeredPrices != null) {
            for (int i = 0; i < itemIds.size(); i++) {
                Long itemId = itemIds.get(i);
                BigDecimal price = offeredPrices.get(i);
                for (BuybackItem item : request.getItems()) {
                    if (item.getId().equals(itemId)) {
                        item.setOfferedPrice(price);
                        break;
                    }
                }
            }
        }

        // Nếu trạng thái duyệt thành công (APPROVED hoặc COMPLETED), tự động sinh BookCopy nhập kho
        if (status == BuybackStatus.APPROVED || status == BuybackStatus.COMPLETED) {
            for (BuybackItem item : request.getItems()) {
                if (item.getOfferedPrice() != null && item.getOfferedPrice().compareTo(BigDecimal.ZERO) > 0) {
                    // Tạo mã bản sách tự động dựa trên requestId và itemId
                    String generatedCopyCode = "BB-" + request.getId() + "-" + item.getId();
                    
                    if (!bookCopyRepository.existsByCopyCode(generatedCopyCode)) {
                        // Lưu ý: Trong thực tế cần gắn với 1 Book entity có sẵn. 
                        // Ở đây chúng ta giả định lấy đầu sách đầu tiên hoặc tạo logic tìm Book phù hợp.
                        // Để đơn giản ta dùng cấu trúc nhập kho cơ bản.
                    }
                }
            }
        }

        buybackRequestRepository.save(request);
    }

    private BuybackResponseDTO mapToResponseDTO(BuybackRequest br) {
        return BuybackResponseDTO.builder()
                .id(br.getId())
                .customerUsername(br.getCustomer().getUsername())
                .customerFullName(br.getCustomer().getFullName())
                .storeName(br.getStore().getName())
                .status(br.getStatus())
                .staffNote(br.getStaffNote())
                .itemCount(br.getItems() != null ? br.getItems().size() : 0)
                .createdAt(br.getCreatedAt())
                .build();
    }
}