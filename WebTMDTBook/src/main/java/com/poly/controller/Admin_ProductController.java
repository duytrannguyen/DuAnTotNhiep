package com.poly.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.poly.model.Category;
import com.poly.model.Image;
import com.poly.model.Product;
import com.poly.repository.CategoryRepository;
import com.poly.repository.ImageRepository;
import com.poly.repository.ProductRepository;
import com.poly.repository.UserRepository;
import com.poly.service.CategoryService;
import com.poly.service.ImageService;
import com.poly.service.ProductService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("admin/products")
public class Admin_ProductController {
	@Autowired
	ProductRepository productsRepository;
	@Autowired
	CategoryRepository categoryRepository;
	@Autowired
	ProductService productService;

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

	@GetMapping("/list")
	public String listProducts(Model model, HttpServletRequest req,
			@RequestParam(name = "pageNo", defaultValue = "0") int page,
			@RequestParam(name = "size", defaultValue = "10") int size) { // Ví dụ size là 10
		// Sắp xếp theo ID giảm dần
		Pageable pageable = PageRequest.of(page, size, Sort.by("productId").descending());

		Page<Product> productPage = productsRepository.findAll(pageable);

		model.addAttribute("pageProd", productPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", productPage.getTotalPages());

		List<Category> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);

		req.setAttribute("view", "/views/admin/QuanLySanPham/Products.jsp");
		return "indexAdmin";
	}

	@GetMapping("/form")
	public String formProducts(Model model, HttpServletRequest req) {

		List<Category> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);

		req.setAttribute("view", "/views/admin/QuanLySanPham/add.jsp");
		return "indexAdmin";
	}

	@PostMapping("/create")
	public String createProduct(Model model, HttpServletRequest req, @RequestParam("img") MultipartFile photo,
			@RequestParam("productName") String productName, @RequestParam("price") String priceStr,
			@RequestParam("publishingYear") String publishingYearStr, @RequestParam("weight") String weight,
			@RequestParam("size") String size, @RequestParam("numberOfPages") String numberOfPagesStr,
			@RequestParam("language") String language, @RequestParam("author") String author,
			@RequestParam("description") String description, @RequestParam("manufacturer") String manufacturer,
			@RequestParam("postingDate") String postingDateStr,
			@RequestParam(value = "quantity", required = false, defaultValue = "0") String quantityStr,
			@RequestParam("categoryId") String categoryIdStr) {

		List<String> errors = new ArrayList<>();

		// Validate productName
		if (productName == null || productName.trim().isEmpty()) {
			errors.add("Tên sản phẩm là bắt buộc.");
		}

		// Validate price
		float price = 0;
		try {
			price = Float.parseFloat(priceStr);
			if (price <= 0) {
				errors.add("Giá phải lớn hơn 0.");
			}
		} catch (NumberFormatException e) {
			errors.add("Định dạng giá không hợp lệ.");
		}

		// Validate publishingYear
		int publishingYear = 0;
		try {
			publishingYear = Integer.parseInt(publishingYearStr);
			if (publishingYear <= 0) {
				errors.add("Năm xuất bản phải là số nguyên dương.");
			}
		} catch (NumberFormatException e) {
			errors.add("Định dạng năm xuất bản không hợp lệ.");
		}

		// Validate numberOfPages
		int numberOfPages = 0;
		try {
			numberOfPages = Integer.parseInt(numberOfPagesStr);
			if (numberOfPages <= 0) {
				errors.add("Số trang phải là số nguyên dương.");
			}
		} catch (NumberFormatException e) {
			errors.add("Định dạng số trang không hợp lệ.");
		}

		// Validate categoryId
		int categoryId = 0;
		try {
			categoryId = Integer.parseInt(categoryIdStr);
		} catch (NumberFormatException e) {
			errors.add("Định dạng mã danh mục không hợp lệ.");
		}

		// Validate postingDate
		Date postingDate = null;
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			postingDate = dateFormat.parse(postingDateStr);
		} catch (ParseException e) {
			errors.add("Định dạng ngày đăng bán không hợp lệ.");
		}

		// Validate quantity
		int quantity = 0;
		try {
			quantity = Integer.parseInt(quantityStr);
			if (quantity < 0) {
				errors.add("Số lượng không được âm.");
			}
		} catch (NumberFormatException e) {
			errors.add("Định dạng số lượng không hợp lệ.");
		}

		// Check if product with the same name already exists
		if (productService.existsByProductName(productName)) {
			errors.add("Sản phẩm với tên đã tồn tại trong hệ thống.");
		}

		// Check for errors
		if (!errors.isEmpty()) {
			// Load categories for the form
			List<Category> categories = categoryRepository.findAll();
			model.addAttribute("categories", categories);
			model.addAttribute("errorMessages", errors);
			req.setAttribute("view", "/views/admin/QuanLySanPham/add.jsp");
			return "indexAdmin";
		}

		try {
			// Tìm đối tượng Category theo mã danh mục
			Category category = categoryService.findByCategoryCode(categoryId);

			// Tạo đối tượng Product mới
			Product product = new Product();
			product.setProductName(productName);
			product.setPrice(price);
			product.setPublishingYear(publishingYear);
			product.setWeight(weight);
			product.setSize(size);
			product.setNumberOfPages(numberOfPagesStr);
			product.setLanguage(language);
			product.setAuthor(author);
			product.setDescription(description);
			product.setManufacturer(manufacturer);
			product.setPostingDate(postingDate);
			product.setQuantity(quantity);
			product.setCategory(category);

			if (!photo.isEmpty()) {
				String fileName = photo.getOriginalFilename();
				String realPath = context.getRealPath("/Image_SP/" + fileName);
				Path path = Path.of(realPath);
				if (!Files.exists(path)) {
					try {
						Files.createDirectories(path);
					} catch (IOException e) {
						errors.add("Tạo thư mục để tải lên hình ảnh thất bại.");
						model.addAttribute("errorMessages", errors);
						req.setAttribute("view", "/views/admin/QuanLySanPham/add.jsp");
						return "indexAdmin";
					}
				}

				File file = new File(realPath);

				try {
					photo.transferTo(file);
				} catch (IllegalStateException | IOException e) {
					errors.add("Tải lên hình ảnh thất bại.");
					model.addAttribute("errorMessages", errors);
					req.setAttribute("view", "/views/admin/QuanLySanPham/add.jsp");
					return "indexAdmin";
				}

				// Tạo đối tượng Image mới và lưu thông tin ảnh vào cơ sở dữ liệu
				Image image = new Image();
				image.setImageName(fileName);
				imageService.saveImage(image);
				// Liên kết đối tượng Image với Product trước khi lưu Product
				product.setImageId(image);
			}

			// Lưu sản phẩm vào cơ sở dữ liệu
			productService.saveProduct(product);

		} catch (Exception e) {
			errors.add("Đã xảy ra lỗi: " + e.getMessage());
			// Load categories for the form
			List<Category> categories = categoryRepository.findAll();
			model.addAttribute("categories", categories);
			model.addAttribute("errorMessages", errors);
			req.setAttribute("view", "/views/admin/QuanLySanPham/add.jsp");
			return "indexAdmin";
		}

		model.addAttribute("successMessage", "Tạo sản phẩm thành công!");
		return "redirect:/admin/products/list";
	}

	@GetMapping("/edit/{productId}")
	public String edit(HttpServletRequest req, Model model, @PathVariable(name = "productId") Integer id) {
		Product item = productsRepository.findById(id).get();
		model.addAttribute("itemProd", item);
		List<Category> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);
//		System.out.println(id);
		req.setAttribute("view", "/views/admin/QuanLySanPham/edit.jsp");
		return "indexAdmin";
	}

	@PostMapping("/update/{productId}")
	public String updateProduct(Model model, @PathVariable(name = "productId") Integer productId,
			@RequestParam("productName") String productName, @RequestParam("price") float price,
			@RequestParam("publishingYear") int publishingYear, @RequestParam("weight") String weight,
			@RequestParam("size") String size, @RequestParam("numberOfPages") String numberOfPages,
			@RequestParam("language") String language, @RequestParam("author") String author,
			@RequestParam("description") String description, @RequestParam("manufacturer") String manufacturer,
			@RequestParam("postingDate") String postingDateStr,
			@RequestParam(value = "quantity", required = false, defaultValue = "0") int quantity,
			@RequestParam("category.categoryId") int categoryId,
			@RequestPart(value = "img", required = false) MultipartFile photo, HttpServletRequest request) {

		try {
			// Parse postingDateStr to Date
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date postingDate = dateFormat.parse(postingDateStr);

			// Find Category by categoryId
			Category category = categoryService.findByCategoryCode(categoryId);

			// Find Product by productId
			Product product = productService.findByProductId(productId);
			if (product == null) {
				// Handle case where product is not found, e.g., redirect or error message
				return "redirect:/admin/products/list?error=ProductNotFound";
			}

			// Update product attributes
			product.setProductName(productName);
			product.setPrice(price);
			product.setPublishingYear(publishingYear);
			product.setWeight(weight);
			product.setSize(size);
			product.setNumberOfPages(numberOfPages);
			product.setLanguage(language);
			product.setAuthor(author);
			product.setDescription(description);
			product.setManufacturer(manufacturer);
			product.setPostingDate(postingDate);
			product.setQuantity(quantity);
			product.setCategory(category); // Set the category for the product

			// Handle image upload if provided
			if (photo != null && !photo.isEmpty()) {
				try {
					// Save image to server directory
					String fileName = StringUtils.cleanPath(photo.getOriginalFilename());
					String uploadDir = "/Image_SP/";
					String realPath = request.getServletContext().getRealPath(uploadDir);
					Path path = Paths.get(realPath);
					if (Files.notExists(path)) {
						Files.createDirectories(path);
					}

					// Save image file
					Path filePath = Paths.get(realPath, fileName);
					Files.copy(photo.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

					// Create new Image object and save image details to database
					Image image = new Image();
					image.setImageName(fileName);
					imageService.saveImage(image);

					// Link Image object to Product before saving Product
					product.setImageId(image);
				} catch (IOException | RuntimeException e) {
					e.printStackTrace();
					// Handle file upload error, e.g., show error message or redirect to error page
					model.addAttribute("errorMessage", "Lỗi khi tải lên hình ảnh.");
					return "redirect:/admin/products/list?error=UploadError";
				}
			}

			// Save updated product to database
			productService.saveProduct(product);

			// Add success message
			model.addAttribute("successMessage", "Cập nhật sản phẩm thành công!");

		} catch (ParseException e) {
			e.printStackTrace();
			// Handle date parsing error, e.g., show error message or redirect to error page
			model.addAttribute("errorMessage", "Lỗi định dạng ngày.");
			return "redirect:/admin/products/list?error=DateError";
		}

		// Set view attribute and return view name
		return "redirect:/admin/products/list";
	}

	@GetMapping("/delete/{productId}")
	public String delete(@PathVariable(name = "productId") Integer id, Model model,
			RedirectAttributes redirectAttributes) {
		// Fetch the product by id
		try {
			Product product = productsRepository.findById(id).orElse(null);
			if (product != null) {
				// Remove the image reference from the product
				Image image = product.getImageId();
				if (image != null) {
					product.setImageId(image);
					productsRepository.save(product); // Save changes to product
					// Delete the image if no other products reference it
					if (imageRepository.findProductsByImageId(image.getImageId()).isEmpty()) {
						imageRepository.delete(image);
					}
				}
				// Delete the product
				productsRepository.delete(product);

				redirectAttributes.addFlashAttribute("toastMessage", "Xóa sản phầm thành công!.");
			} else {
				// Add failure toast message
				redirectAttributes.addFlashAttribute("toastMessage", "Xóa sản phầm thất bại!.");
			}
		} catch (Exception e) {
			// TODO: handle exception
			redirectAttributes.addFlashAttribute("toastMessage", "Đã xảy ra lỗi trong quá trình xóa sản phẩm!.");

		}
		return "redirect:/admin/products/list";

	}

	@PostMapping("/reset")
	public String restProducts(HttpServletRequest req, Model model) {
		List<Product> products = productsRepository.findAll();
		model.addAttribute("pageProd", products);
		List<Category> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);
		req.setAttribute("view", "/views/admin/QuanLySanPham/add.jsp");
		return "indexAdmin";
	}

}
