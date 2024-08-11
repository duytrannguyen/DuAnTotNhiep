package com.poly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.model.Category;
import com.poly.model.Product;
import com.poly.model.ProductStatus;
import com.poly.repository.CategoryRepository;
import com.poly.repository.ImageRepository;
import com.poly.repository.ProductRepository;
import com.poly.repository.ProductStatusRepository;
import com.poly.repository.UserRepository;
import com.poly.service.CategoryService;
import com.poly.service.ImageService;
import com.poly.service.InvoiceService;
import com.poly.service.ProductService;
import com.poly.service.ProductStatusService;
import com.poly.service.UserService;

import jakarta.servlet.ServletContext;
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
	@Autowired
	ProductRepository productsRepository;
	@Autowired
	CategoryRepository categoryRepository;

	@Autowired
	CategoryService categoryService;

	@Autowired
	ImageService imageService;

	@Autowired
	ServletContext context;
	@Autowired
	UserRepository userRepository;
	@Autowired
	ImageRepository imageRepository;
	@Autowired
	ProductStatusRepository productStatusRepository;
	@Autowired
	private ProductStatusService productStatusService; // Thêm dòng này vào controller

//	@GetMapping("/index")
//	public String homeAdmin() {
//		return "redirect:/admin/report";
//	}

//	@GetMapping("/index")
//	public String listProducts(Model model, HttpServletRequest req) {
//		int totalCustomers = userService.getTotalUsers();
//		int totalProducts = userService.getTotalProducts();
//		Double totalAmount = invoiceService.getTotalAmount();
//		Long totalOrders = invoiceService.getTotalOrders();
//		List<Product> products = productService.getAllProducts();
//		model.addAttribute("products", products);
//
//		model.addAttribute("totalCustomers", totalCustomers);
//		model.addAttribute("totalProducts", totalProducts);
//		model.addAttribute("totalAmount", totalAmount);
//		model.addAttribute("totalOrders", totalOrders);
//		req.setAttribute("view", "/admin/QuanLySanPham/Products.html");
//		return "indexAdmin";
//
//	}
	@GetMapping("/index")
	public String listProducts(Model model, HttpServletRequest req,
			@RequestParam(name = "pageNo", defaultValue = "0") int page,
			@RequestParam(name = "size", defaultValue = "10") int size) {
		// Sắp xếp theo ID giảm dần
		Pageable pageable = PageRequest.of(page, size, Sort.by("productId").descending());

		Page<Product> productPage = productsRepository.findAll(pageable);

		// Thêm thông tin sản phẩm vào model
		model.addAttribute("pageProd", productPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", productPage.getTotalPages());

		// Lấy danh sách thể loại
		List<Category> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);

		// Lấy danh sách trạng thái sản phẩm
		List<ProductStatus> productStatus = productStatusRepository.findAll();
		model.addAttribute("productStatus", productStatus);

		// Thiết lập view
		req.setAttribute("view", "/admin/QuanLySanPham/Products.html");
		return "indexAdmin";
	}
}