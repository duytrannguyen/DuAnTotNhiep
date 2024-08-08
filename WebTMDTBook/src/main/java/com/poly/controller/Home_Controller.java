package com.poly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
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
	private SessionService sessionService;

	@Autowired
	private ProductService productService;

	@Autowired
	private InvoiceService invoiceService;
	@Autowired
	private AuthenticationManager authenticationManager;

	@Autowired
	private UserService userServiceImpl;

	@RequestMapping("/login")
	public String Login() {
		return "login/logintest";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute LoginDTO loginDTO, Model model, HttpSession session) {
	    // Call userServiceImpl.login to check login information
	    boolean result = userServiceImpl.login(loginDTO);

	    if (result) {
	        // Retrieve user information from the database
	        User user = userServiceImpl.getUserByUsername(loginDTO.getUsername());

	        if (user != null) {
	            // Check the user's status
	            switch (user.getStatusId().getStatusId()) {
	                case 1: // Active
	                    // Store user object in session
	                    session.setAttribute("user", user);
	                    model.addAttribute("successMessage", "Đăng nhập thành công! Chào mừng bạn, " + user.getFullName() + ".");
	                    
	                    // Redirect to the appropriate page based on the user role
	                    if (user.getRoleId().getRoleId() == 1) {
	                        // Redirect to admin page if the user is admin
	                        return "redirect:/admin/index";
	                    } else {
	                        // Redirect to home page for regular users
	                        return "redirect:/home/index";
	                    }
	                case 2: // Inactive
	                    model.addAttribute("errorMessage", "Tài khoản của bạn không hoạt động.");
	                    break;
	                case 3: // Pending
	                    model.addAttribute("errorMessage", "Tài khoản của bạn đang chờ xử lý.");
	                    break;
	                case 4: // Suspended
	                    model.addAttribute("errorMessage", "Tài khoản của bạn đã bị tạm đình chỉ.");
	                    break;
	                case 5: // Banned
	                    model.addAttribute("errorMessage", "Tài khoản của bạn đã bị cấm vĩnh viễn.");
	                    break;
	                default:
	                    model.addAttribute("errorMessage", "Trạng thái tài khoản không xác định.");
	                    break;
	            }
	        } else {
	            // User not found (should not occur if login is successful)
	            model.addAttribute("errorMessage", "Người dùng không được tìm thấy.");
	        }
	    } else {
	        // Invalid login information
	        model.addAttribute("errorMessage", "Thông tin đăng nhập không hợp lệ.");
	    }

	    // Return to the login page with an error message if login fails
	    return "/login/logintest";
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
