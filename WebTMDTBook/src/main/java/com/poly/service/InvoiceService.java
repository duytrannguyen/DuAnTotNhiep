package com.poly.service;

import java.util.List;

import com.poly.model.Invoice;

public interface InvoiceService {

	List<Invoice> getAllInvoices();

	// Khang
	List<Invoice> searchInvoices(String searchQuery);

	Long getTotalOrders();

	Double getTotalAmount();

	// Khang
	Invoice findByInvoice(Integer invoiceId);

	// Khang
	List<Invoice> findByStatusName(String statusName);

	// Khang
	void save(Invoice invoice);
}
