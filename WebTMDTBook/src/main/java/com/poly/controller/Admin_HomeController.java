package com.poly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.model.Product;
import com.poly.service.InvoiceService;
import com.poly.service.ProductService;
import com.poly.service.UserService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class Admin_HomeController {

	@Autowired
	private UserService userService;

	@Autowired
	private ProductService productService;

	@Autowired
	private InvoiceService invoiceService;

//	@GetMapping("/index")
//	public String homeAdmin() {
//		return "redirect:/admin/report";
//	}

	@GetMapping("/index")
	public String listProducts(Model model, HttpServletRequest req) {
		int totalCustomers = userService.getTotalUsers();
		int totalProducts = userService.getTotalProducts();
		Double totalAmount = invoiceService.getTotalAmount();
		Long totalOrders = invoiceService.getTotalOrders();
		List<Product> products = productService.getAllProducts();
		model.addAttribute("products", products);

		model.addAttribute("totalCustomers", totalCustomers);
		model.addAttribute("totalProducts", totalProducts);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("totalOrders", totalOrders);
		req.setAttribute("view", "/views/admin/BaoCaoThongKe/Report.jsp");
		return "indexAdmin";

	}
}