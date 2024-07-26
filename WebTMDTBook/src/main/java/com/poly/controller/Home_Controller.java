package com.poly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.dto.LoginDTO;
import com.poly.dto.RegisterDTO;
import com.poly.model.Product;
import com.poly.model.User;
import com.poly.service.InvoiceService;
import com.poly.service.ProductService;
import com.poly.service.SessionService;
import com.poly.service.UserService;
import com.poly.service.lmpl.UserServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("home")
public class Home_Controller {

	@Autowired
	private UserService userService;
	@Autowired
	UserServiceImpl userServiceImpl;
	@Autowired
	private SessionService sessionService;

	@Autowired
	private ProductService productService;

	@Autowired
	private InvoiceService invoiceService;

	@GetMapping("/login")
	public String Login() {
		return "login/logintest";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute LoginDTO loginDTO, Model model, HttpSession session) {
	    // Call userServiceImpl.login to check login credentials
	    boolean result = userServiceImpl.login(loginDTO);

	    if (result) {
	        // Retrieve user details from the database or wherever user information is stored
	        User user = userServiceImpl.getUserByUsername(loginDTO.getUsername());

	        if (user != null) {
	            // Store user object in session
	            session.setAttribute("user", user);

	            if (user.getRoleId().getRoleId() == 1) {
	                // Redirect to admin page if user is admin
	                return "redirect:/admin/products/list";
	            } else {
	                // Redirect to home page for non-admin users
	                return "redirect:/home/index";
	            }
	        } else {
	            // User not found (this scenario should ideally not happen if login was successful)
	            model.addAttribute("mess", "User not found");
	            return "/login/logintest";
	        }
	    } else {
	        // Invalid credentials
	        model.addAttribute("mess", "Invalid credentials");
	        return "/login/logintest";
	    }
	}
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home/index";
	}

	@RequestMapping("/dangky")
	public String register() {
		return "login/registertest";
	}

	@PostMapping("/dangky")
	public String register(@ModelAttribute RegisterDTO registerDTO, Model model) {
		boolean result = userService.register(registerDTO);
		if (result) {
			model.addAttribute("mess", "Account created successfully");
		} else {
			model.addAttribute("mess", "Username already exists");
		}
		return "login/registertest";
	}

	@RequestMapping("/login/quenmk")
	public String forgotPassword() {
		return "login/forgotPassword";
	}

	@RequestMapping("/login/quenmk/hoantat")
	public String finishForgotPassword() {
		return "login/finishForgotPassword";
	}

	@RequestMapping("/login/doimk")
	public String changePassword() {
		return "users/changePassword";
	}

	@GetMapping("/report")
	public String listProducts(Model model) {
		int totalCustomers = userService.getTotalUsers();
		int totalProducts = productService.getTotalProducts();
//        Double totalAmount = invoiceService.getTotalAmount();
//        Long totalDeliveredOrders = invoiceService.getTotalDeliveredOrders();

		List<Product> products = productService.getAllProducts();
		model.addAttribute("products", products);

		model.addAttribute("totalCustomers", totalCustomers);
		model.addAttribute("totalProducts", totalProducts);
//        model.addAttribute("totalAmount", totalAmount);
//        model.addAttribute("totalDeliveredOrders", totalDeliveredOrders);

		return "admin/BaoCaoThongKe/Report";
	}
}
