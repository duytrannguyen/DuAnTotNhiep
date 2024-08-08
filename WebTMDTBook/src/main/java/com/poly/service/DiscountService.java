package com.poly.service;

import java.util.Date;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.model.Discount;
import com.poly.repository.DiscountRepositopy;

//@Service
//public class DiscountService {
//
//    @Autowired
//    private DiscountRepositopy discountRepository;
//
//    public Double getDiscountAmount(String discountCode) {
//        Optional<Discount> discountOpt = discountRepository.findByDiscountCode(discountCode);
//
//        if (discountOpt.isPresent()) {
//            Discount discount = discountOpt.get();
//            
//            if (discount.isValid()) {
//                return discount.getDiscountValue();
//            } else {
//                return (double) 0;
//            }
//        } else {
//            return (double) 0;
//        }
//    }
// // Phương thức lấy mã khuyến mãi dựa trên mã khuyến mãi
//    public Discount getDiscountByCode(String discountCode) {
//        return discountRepository.findByDiscountCode(discountCode)
//                .orElseThrow(() -> new IllegalArgumentException("Mã khuyến mãi không hợp lệ."));
//    }
//    
//}
@Service
public class DiscountService {

    @Autowired
    private DiscountRepositopy discountRepository;

    // Lấy giá trị giảm giá dựa trên mã khuyến mãi
    public double getDiscountAmount(String discountCode) {
        Discount discount = discountRepository.findByDiscountCode(discountCode)
                .orElseThrow(() -> new IllegalArgumentException("Mã khuyến mãi không hợp lệ."));

        // Kiểm tra trạng thái của mã khuyến mãi
        if (discount.getStatusId() != 1) {
            throw new IllegalArgumentException("Mã khuyến mãi này không khả dụng!");
        }

        // Kiểm tra ngày bắt đầu và ngày kết thúc
        Date currentDate = new Date();
        if (currentDate.before(discount.getStartDate()) || currentDate.after(discount.getEndDate())) {
            throw new IllegalArgumentException("Mã khuyến mãi này đã hết hạn hoặc chưa được phát hành!");
        }

        // Kiểm tra số lượng còn lại
        if (discount.getQuantity() <= 0) {
            throw new IllegalArgumentException("Mã khuyến mãi này đã được sử dụng hết!");
        }

        // Trả về giá trị giảm giá
        return discount.getDiscountValue();
    }

    // Các phương thức khác của DiscountService
}
