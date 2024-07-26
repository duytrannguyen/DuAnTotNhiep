package com.poly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.poly.model.Invoice;
import com.poly.model.OrderStatus;
import com.poly.model.PaymentMethod;
import com.poly.repository.InvoiceRepository;
import com.poly.service.InvoiceService;
import com.poly.service.PaymentMethodService;
import com.poly.service.StatusService;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;

@Controller
@RequestMapping("admin/payment")
public class Admin_PaymentController {

	@Autowired
	ServletContext context;

	@Autowired
	private InvoiceService invoiceService;

	@Autowired
	private StatusService statusService;

	@Autowired
	private PaymentMethodService paymentMethodService;

	@Autowired
	private InvoiceRepository invoiceRepository;

	@GetMapping("/index")
	public String homeAdmin() {
		return "redirect:/admin/payment";
	}

	@GetMapping("/list")
	public String listInvoices(HttpServletRequest req, HttpServletResponse resp, Model model,
			@RequestParam(name = "key", required = false, defaultValue = "") String key,
			@RequestParam(name = "pageNo", required = false, defaultValue = "0") int pageNo) {

		int pageSize = 10;
		Sort sort = Sort.by(Sort.Direction.DESC, "invoiceId");
		Pageable pageable = PageRequest.of(pageNo, pageSize, sort);

		Page<Invoice> page;
		if (StringUtils.isNotBlank(key)) {
			page = invoiceRepository.findByStatusStatusName(key, pageable);
		} else {
			page = invoiceRepository.findAll(pageable);
		}

		List<OrderStatus> statuses = statusService.findAll();
		List<PaymentMethod> paymentMethods = paymentMethodService.findAll();

		List<Invoice> invoices = page.getContent();
		model.addAttribute("invoices", invoices);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("key", key);
		model.addAttribute("statuses", statuses);
		model.addAttribute("paymentMethods", paymentMethods);
		req.setAttribute("view", "/views/admin/QuanLyHoaDon/Payment/Payment.jsp");
		return "indexAdmin";
	}

	@GetMapping("/edit/{invoiceId}")
	public String edit(HttpServletRequest req, Model model, @PathVariable(name = "invoiceId") Integer id) {
		Invoice invoice = invoiceService.findById(id);
		if (invoice == null) {
			throw new IllegalArgumentException("Không tìm thấy hóa đơn");
		}
		List<OrderStatus> statuses = statusService.findAll();
		List<PaymentMethod> paymentMethods = paymentMethodService.findAll();

		model.addAttribute("invoice", invoice);
		model.addAttribute("statuses", statuses);
		model.addAttribute("paymentMethods", paymentMethods);
		req.setAttribute("view", "/views/admin/QuanLyHoaDon/Payment/editPayment.jsp");
		return "indexAdmin";
	}

	@PostMapping("/update/{invoiceId}")
	public String updateInvoice(@Valid @ModelAttribute("invoice") Invoice invoice, BindingResult errors,
			@PathVariable("invoiceId") Integer invoiceId, @RequestParam("paymentStatus") Integer statusId,
			@RequestParam("paymentMethod") Integer paymentMethodId, Model model, HttpServletRequest req,
			RedirectAttributes redirectAttributes) {
		if (errors.hasErrors()) {
			req.setAttribute("view","/views/admin/QuanLyHoaDon/Payment/editPayment.jsp");
			return "indexAdmin";
		}
		OrderStatus orderStatus = statusService.findById(statusId)
				.orElseThrow(() -> new IllegalArgumentException("Không tìm thấy trạng thái thanh toán"));
		invoice.setStatus(orderStatus);

		PaymentMethod paymentMethod = paymentMethodService.findById(paymentMethodId)
				.orElseThrow(() -> new IllegalArgumentException("Không tìm thấy phương thức thanh toán"));
		invoice.setPaymentMethod(paymentMethod);
		invoiceService.save(invoice);
		return "redirect:/admin/payment/list";
	}

}
