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
		// Gọi userServiceImpl.login để kiểm tra thông tin đăng nhập
		boolean result = userServiceImpl.login(loginDTO);

		if (result) {
			// Lấy thông tin người dùng từ cơ sở dữ liệu
			User user = userServiceImpl.getUserByUsername(loginDTO.getUsername());

			if (user != null) {
				// Kiểm tra trạng thái của người dùng
				if (user.getStatusId().getStatusId() == 1) { // Hoạt động
					// Lưu đối tượng người dùng vào session
					session.setAttribute("user", user);

					if (user.getRoleId().getRoleId() == 1) {
						// Chuyển hướng đến trang quản trị nếu người dùng là admin
						model.addAttribute("successMessage",
								"Đăng nhập thành công! Chào mừng bạn, " + user.getFullName() + ".");
						return "redirect:/admin/index";
					} else {
						// Chuyển hướng đến trang chính cho người dùng không phải admin
						model.addAttribute("successMessage",
								"Đăng nhập thành công! Chào mừng bạn, " + user.getFullName() + ".");
						return "redirect:/home/index";
					}
				} else if (user.getStatusId().getStatusId() == 2) { // Không hoạt động
					model.addAttribute("errorMessage", "Tài khoản của bạn không hoạt động.");
					return "/login/logintest";
				} else if (user.getStatusId().getStatusId() == 3) { // Chờ xử lý
					model.addAttribute("errorMessage", "Tài khoản của bạn đang chờ xử lý.");
					return "/login/logintest";
				} else if (user.getStatusId().getStatusId() == 4) { // Tạm đình chỉ
					model.addAttribute("errorMessage", "Tài khoản của bạn đã bị tạm đình chỉ.");
					return "/login/logintest";
				} else if (user.getStatusId().getStatusId() == 5) { // Cấm vĩnh viễn
					model.addAttribute("errorMessage", "Tài khoản của bạn đã bị cấm vĩnh viễn.");
					return "/login/logintest";
				} else {
					// Trường hợp không xác định trạng thái
					model.addAttribute("errorMessage", "Trạng thái tài khoản không xác định.");
					return "/login/logintest";
				}
			} else {
				// Người dùng không được tìm thấy (trường hợp này lý tưởng không nên xảy ra nếu
				// đăng nhập thành công)
				model.addAttribute("errorMessage", "Người dùng không được tìm thấy.");
				return "/login/logintest";
			}
		} else {
			// Thông tin đăng nhập không hợp lệ
			model.addAttribute("errorMessage", "Thông tin đăng nhập không hợp lệ.");
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
