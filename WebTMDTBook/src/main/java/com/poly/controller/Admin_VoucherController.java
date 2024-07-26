package com.poly.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.poly.model.Discount;
import com.poly.model.DiscountType;
import com.poly.repository.DiscountRepositopy;
//import com.poly.model.Voucher;
import com.poly.repository.DiscountTypeTRepository;
//import com.poly.repository.VoucherRepository;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;

@Controller
@RequestMapping("admin/voucher")
public class Admin_VoucherController {
//	@Autowired
//	VoucherRepository voucherRepository;
	@Autowired
	DiscountRepositopy discountRepositopy;

	@Autowired
	DiscountTypeTRepository discountTypeRepository;
	@Autowired
	ServletContext context;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	@GetMapping("/list")
	public String listVoucher(HttpServletRequest req, HttpServletResponse resp, Model model,
	        @RequestParam(name = "key", required = false, defaultValue = "") String key,
	        @RequestParam(name = "pageNo", required = false, defaultValue = "0") int pageNo,
	        @RequestParam(name = "discountTypeId", required = false) Integer discountTypeId) {
	    List<DiscountType> discountTypes = discountTypeRepository.findAll();
	    model.addAttribute("discountTypes", discountTypes);

	    // Sử dụng Pageable để lấy danh sách voucher
	    int pageSize = 10; // Tăng kích thước trang lên 10
	    Sort sort = Sort.by(Direction.DESC, "discountId");
	    Pageable pageable = PageRequest.of(pageNo, pageSize, sort);

	    Page<Discount> page;
	    if (StringUtils.isNotBlank(key)) {
	        page = discountRepositopy.findByDiscountCode(key, pageable);
	    } else if (discountTypeId != null) {
	        page = discountRepositopy.findByDiscountTypeId(discountTypeId, pageable);
	    } else {
	        page = discountRepositopy.findAll(pageable);
	    }

	    List<Discount> vouchers = page.getContent();
	    if (vouchers.isEmpty()) {
	        model.addAttribute("noVouchersFound", true);
	    } else {
	        model.addAttribute("vouchers", vouchers);
	    }

	    // Thêm thông tin về phân trang
	    model.addAttribute("pageNo", pageNo);
	    model.addAttribute("totalPages", page.getTotalPages());
	    model.addAttribute("key", key);

	    req.setAttribute("view", "/views/admin/QuanLyVoucher/Voucher/Voucher.jsp");
	    return "indexAdmin";
	}

	@GetMapping("/add")
	public String addProduct(@ModelAttribute("vc") Discount vc, Model model, HttpServletRequest req,
			HttpServletResponse resp) {
		List<DiscountType> discountType = discountTypeRepository.findAll();
		model.addAttribute("discountType", discountType);
		
		String chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		Random random = new Random();
		StringBuilder verificationCode = new StringBuilder();
		for (int i = 0; i < 10; i++) {
		    int index = random.nextInt(chars.length());
		    verificationCode.append(chars.charAt(index));
		}
		String result = verificationCode.toString();
		model.addAttribute("verificationCode", result);
		
		req.setAttribute("view", "/views/admin/QuanLyVoucher/Voucher/addVoucher.jsp");
		return "indexAdmin";
	}

	// thêm
	@PostMapping("/create")
	public String createVoucher(@Valid @ModelAttribute("vc") Discount vc, BindingResult errors, Model model,
			HttpServletRequest req, @RequestParam("discountType") Integer discountTypeId) {
		List<DiscountType> discountType = discountTypeRepository.findAll();
		model.addAttribute("discountType", discountType);
		// Kiểm tra lỗi của đối tượng Voucher
		if (errors.hasErrors()) {
			req.setAttribute("view", "/views/admin/QuanLyVoucher/Voucher/addVoucher.jsp");
			return "indexAdmin";
		}
		// Kiểm tra ngày bắt đầu không được trước ngày hiện tại
		Date currentDate = new Date(); // Ngày hiện tại
		if (vc.getStartDate().before(currentDate)) {
			errors.rejectValue("startDate", "error.startDate", "Ngày bắt đầu phải sau ngày hiện tại.");
			req.setAttribute("view", "/views/admin/QuanLyVoucher/Voucher/addVoucher.jsp");
			return "indexAdmin"; // Trả về trang form để hiển thị lỗi
		}
		// Validate startDate và endDate
		if (!vc.isValid()) {
			errors.rejectValue("endDate", "error.endDate", "Ngày kết thúc phải sau ngày bắt đầu");
			req.setAttribute("view", "/views/admin/QuanLyVoucher/Voucher/addVoucher.jsp");
			return "indexAdmin"; // Trả về trang form để hiển thị lỗi
		}
		// Xử lý logic khi không có lỗi
		DiscountType discountTypes = discountTypeRepository.findById(discountTypeId).get();
		vc.setDiscountType(discountTypes);
		discountRepositopy.saveAndFlush(vc);
		return "redirect:/admin/voucher/list";
	}

	@GetMapping("/edit/{discountId}")
	public String editVoucher(HttpServletRequest req, @ModelAttribute("vc") Discount vc, Model model,
			@PathVariable("discountId") Integer discountId) {
		Discount voucher = discountRepositopy.findById(discountId)
				.orElseThrow(() -> new IllegalArgumentException("Không tìm thấy voucher"));
		List<DiscountType> discountTypes = discountTypeRepository.findAll();
		model.addAttribute("discountTypes", discountTypes);
		model.addAttribute("voucher", voucher);
		req.setAttribute("view", "/views/admin/QuanLyVoucher/Voucher/editVoucher.jsp");
		return "indexAdmin";
	}

	@PostMapping("/update/{discountId}")
	public String updateVoucher(@Valid @ModelAttribute("vc") Discount vc, BindingResult errors, Model model,
			HttpServletRequest req, @RequestParam("discountId") Integer discountId,
			@RequestParam("discountType") Integer discountTypeId, RedirectAttributes redirectAttributes) {
		DiscountType discountType = discountTypeRepository.findById(discountTypeId)
				.orElseThrow(() -> new IllegalArgumentException("Không tìm thấy loại voucher"));
		vc.setDiscountType(discountType);
		if (errors.hasErrors()) {
			redirectAttributes.addFlashAttribute("voucher", vc);
			Discount voucher = discountRepositopy.findById(discountId)
					.orElseThrow(() -> new IllegalArgumentException("Không tìm thấy voucher"));
			List<DiscountType> discountTypes = discountTypeRepository.findAll();
			model.addAttribute("discountTypes", discountTypes);
			model.addAttribute("voucher", voucher);
			model.addAttribute("voucher", vc);
			req.setAttribute("view", "/views/admin/QuanLyVoucher/Voucher/editVoucher.jsp");
			return "indexAdmin";
		}
		// Kiểm tra ngày bắt đầu không được trước ngày hiện tại
		Date currentDate = new Date(); // Ngày hiện tại
		if (vc.getStartDate().before(currentDate)) {
			errors.rejectValue("startDate", "error.startDate", "Ngày bắt đầu phải sau ngày hiện tại.");
			req.setAttribute("view", "/views/admin/QuanLyVoucher/Voucher/editVoucher.jsp");
			return "indexAdmin";
		}
		// Validate startDate và endDate
		if (!vc.isValid()) {
			errors.rejectValue("endDate", "error.endDate", "Ngày kết thúc phải sau ngày bắt đầu");
			req.setAttribute("view", "/views/admin/QuanLyVoucher/Voucher/editVoucher.jsp");
			return "indexAdmin";
		}
		discountRepositopy.saveAndFlush(vc);
		return "redirect:/admin/voucher/list";
	}

//xoá
	@GetMapping("/remove/{discountId}")
	public String removeVoucher(@PathVariable("discountId") Integer discountId, RedirectAttributes redirectAttributes) {
	    Optional<Discount> voucher = discountRepositopy.findById(discountId);
	    if (voucher.isPresent()) {
	        try {
	        	discountRepositopy.delete(voucher.get());
	            redirectAttributes.addFlashAttribute("message", "Xoá Thành Công");
	            redirectAttributes.addFlashAttribute("deleteSuccess", true);
	        } catch (Exception e) {
	            redirectAttributes.addFlashAttribute("message", "Xoá Thất Bại: Voucher này đang được sử dụng và không thể xoá.");
	            redirectAttributes.addFlashAttribute("deleteSuccess", false);
	        }
	    } else {
	        redirectAttributes.addFlashAttribute("message", "Xoá Thất Bại: Không tìm thấy voucher.");
	        redirectAttributes.addFlashAttribute("deleteSuccess", false);
	    }
	    return "redirect:/admin/voucher/list";
	}



}
