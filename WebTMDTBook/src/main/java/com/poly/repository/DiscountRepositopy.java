package com.poly.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.poly.model.Discount;

public interface DiscountRepositopy extends JpaRepository<Discount, Integer> {
	@Query("SELECT v FROM Discount v WHERE v.discountType.discountTypeId = :discountTypeId")
	Page<Discount> findByDiscountTypeId(@Param("discountTypeId") int discountTypeId,Pageable pageable);

	@Query("SELECT p FROM Discount p WHERE p.discountCode like %:discountCode%")
    Page<Discount> findByDiscountCode(@Param("discountCode") String discountCode, Pageable pageable);
}
