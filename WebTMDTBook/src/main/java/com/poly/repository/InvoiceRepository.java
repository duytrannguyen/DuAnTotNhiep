package com.poly.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.poly.model.Invoice;

@Repository
public interface InvoiceRepository extends JpaRepository<Invoice, Integer> {

	@Query("SELECT SUM(i.totalAmount) FROM Invoice i")
	Double findTotalAmount();

//	@Query("SELECT COUNT(i) FROM Invoice i JOIN i.status s WHERE s.statusName = :statusName")
//	Long countByStatusStatusName(@Param("statusName") String statusName);

//	List<Invoice> findByInvoiceIdOrCartUserFullNameContaining(Integer invoiceId, String fullName);

	@Query("SELECT COUNT(i) FROM Invoice i")
	Long countTotalOrders();

	//Khang
//	@Query("SELECT i FROM Invoice i " + "JOIN FETCH i.cart c " + "JOIN FETCH c.user u " + "JOIN FETCH i.status s "
//			+ "JOIN FETCH i.paymentMethod pm")
//	List<Invoice> findAllInvoicesWithDetails();

	//Khang
	List<Invoice> findByStatusStatusName(String statusName);

	//Khang
	Page<Invoice> findAll(Pageable pageable);

	//Khang
	Page<Invoice> findByStatusStatusName(@Param("statusName") String statusName, Pageable pageable);

}
