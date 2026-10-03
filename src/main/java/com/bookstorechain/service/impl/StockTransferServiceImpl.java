package com.bookstorechain.service.impl;

import com.bookstorechain.dto.request.StockTransferRequestDTO;
import com.bookstorechain.dto.response.StockTransferResponseDTO;
import com.bookstorechain.entity.*;
import com.bookstorechain.enums.CopyStatus;
import com.bookstorechain.enums.TransferStatus;
import com.bookstorechain.exception.ResourceNotFoundException;
import com.bookstorechain.repository.*;
import com.bookstorechain.service.StockTransferService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class StockTransferServiceImpl implements StockTransferService {

    private final StockTransferRepository stockTransferRepository;
    private final StoreRepository storeRepository;
    private final UserRepository userRepository;
    private final BookCopyRepository bookCopyRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<StockTransferResponseDTO> getTransfers(Long storeId, TransferStatus status, Pageable pageable) {
        return stockTransferRepository.searchTransfers(storeId, status, pageable).map(this::mapToResponseDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public StockTransfer getTransferById(Long id) {
        return stockTransferRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy phiếu chuyển kho với ID: " + id));
    }

    @Override
    @Transactional
    public void createTransfer(StockTransferRequestDTO requestDTO, String currentUsername) {
        if (requestDTO.getSenderStoreId().equals(requestDTO.getReceiverStoreId())) {
            throw new IllegalArgumentException("Chi nhánh gửi và chi nhánh nhận không được trùng nhau!");
        }

        Store senderStore = storeRepository.findById(requestDTO.getSenderStoreId())
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy chi nhánh gửi"));

        Store receiverStore = storeRepository.findById(requestDTO.getReceiverStoreId())
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy chi nhánh nhận"));

        User creator = userRepository.findByUsername(currentUsername)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy thông tin tài khoản thao tác"));

        StockTransfer transfer = StockTransfer.builder()
                .senderStore(senderStore)
                .receiverStore(receiverStore)
                .creator(creator)
                .status(TransferStatus.PENDING)
                .note(requestDTO.getNote())
                .build();

        for (Long copyId : requestDTO.getBookCopyIds()) {
            BookCopy bookCopy = bookCopyRepository.findById(copyId)
                    .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy bản sách ID: " + copyId));

            // Kiểm tra sách phải thuộc chi nhánh gửi và đang sẵn sàng
            if (!bookCopy.getStore().getId().equals(senderStore.getId())) {
                throw new IllegalArgumentException("Bản sách " + bookCopy.getCopyCode() + " không thuộc kho chi nhánh gửi!");
            }

            StockTransferItem item = StockTransferItem.builder()
                    .stockTransfer(transfer)
                    .bookCopy(bookCopy)
                    .build();
            transfer.getItems().add(item);
        }

        stockTransferRepository.save(transfer);
    }

    @Override
    @Transactional
    public void updateTransferStatus(Long id, TransferStatus newStatus) {
        StockTransfer transfer = getTransferById(id);
        TransferStatus currentStatus = transfer.getStatus();

        // Xử lý chuyển đổi trạng thái và cập nhật BookCopy tương ứng
        if (currentStatus == TransferStatus.COMPLETED || currentStatus == TransferStatus.CANCELLED) {
            throw new IllegalStateException("Không thể thay đổi trạng thái của phiếu đã hoàn tất hoặc đã hủy!");
        }

        if (newStatus == TransferStatus.IN_TRANSIT) {
            // Chuyển sang đang vận chuyển: Đổi trạng thái các BookCopy thành IN_TRANSIT
            for (StockTransferItem item : transfer.getItems()) {
                BookCopy bc = item.getBookCopy();
                bc.setStatus(CopyStatus.IN_TRANSIT);
                bookCopyRepository.save(bc);
            }
        } else if (newStatus == TransferStatus.COMPLETED) {
            // Hoàn tất: Cập nhật chi nhánh chủ sở hữu mới cho các BookCopy và trả về AVAILABLE
            for (StockTransferItem item : transfer.getItems()) {
                BookCopy bc = item.getBookCopy();
                bc.setStore(transfer.getReceiverStore());
                bc.setStatus(CopyStatus.AVAILABLE);
                bookCopyRepository.save(bc);
            }
        } else if (newStatus == TransferStatus.CANCELLED) {
            // Hủy phiếu: Trả lại trạng thái AVAILABLE cho sách ở chi nhánh cũ
            for (StockTransferItem item : transfer.getItems()) {
                BookCopy bc = item.getBookCopy();
                bc.setStatus(CopyStatus.AVAILABLE);
                bookCopyRepository.save(bc);
            }
        }

        transfer.setStatus(newStatus);
        stockTransferRepository.save(transfer);
    }

    private StockTransferResponseDTO mapToResponseDTO(StockTransfer st) {
        return StockTransferResponseDTO.builder()
                .id(st.getId())
                .senderStoreName(st.getSenderStore().getName())
                .receiverStoreName(st.getReceiverStore().getName())
                .creatorUsername(st.getCreator().getUsername())
                .status(st.getStatus())
                .note(st.getNote())
                .itemCount(st.getItems() != null ? st.getItems().size() : 0)
                .createdAt(st.getCreatedAt())
                .build();
    }
}