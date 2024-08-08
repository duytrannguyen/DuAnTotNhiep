package com.poly.service.lmpl;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.model.Invoice;
import com.poly.repository.InvoiceRepository;
import com.poly.service.InvoiceService;

@Service
public class InvoiceServiceImpl implements InvoiceService {

	@Autowired
	private InvoiceRepository invoiceRepository;

//	@Override
//	public List<Invoice> getAllInvoices() {
//		return invoiceRepository.findAllInvoicesWithDetails();
//	}

	@Override
	public Double getTotalAmount() {
		return invoiceRepository.findTotalAmount();
	}

	@Override
	public Long getTotalOrders() {
		return invoiceRepository.countTotalOrders();
	}

//	@Override
//	public List<Invoice> searchInvoices(String searchQuery) {
//		Integer invoiceId = null;
//		try {
//			invoiceId = Integer.parseInt(searchQuery);
//		} catch (NumberFormatException e) {
//			// Do nothing, invoiceId will be null
//		}
//		return invoiceRepository.findByInvoiceIdOrCartUserFullNameContaining(invoiceId, searchQuery);
//	}

	//Khang
	@Override
	public Invoice findById(Integer id) {
		return invoiceRepository.findById(id).orElse(null);
	}

	//Khang
	@Override
	public List<Invoice> findByStatusName(String statusName) {
		return invoiceRepository.findByStatusStatusName(statusName);
	}

	//Khang
	@Override
	public void save(Invoice invoice) {
		invoiceRepository.save(invoice);
	}
	
	
	
//ly
	@Override
	public List<Invoice> searchInvoices(String searchQuery) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Invoice> getAllInvoices() {
		// TODO Auto-generated method stub
		return null;
	}
}
