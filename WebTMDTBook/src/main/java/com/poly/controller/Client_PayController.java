package com.poly.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.poly.model.Address;
import com.poly.model.CartItem;
import com.poly.model.Discount;
import com.poly.model.Invoice;
import com.poly.model.InvoiceItem;
import com.poly.model.OrderStatus;
import com.poly.model.PaymentMethod;
import com.poly.model.Product;
import com.poly.model.Shipping;
import com.poly.model.ShoppingCart;
import com.poly.model.User;
import com.poly.repository.CartItemRepository;
import com.poly.repository.InvoiceItemRepository;
import com.poly.repository.InvoiceRepository;
import com.poly.repository.ProductRepository;
import com.poly.repository.ShoppingCartRepository;
import com.poly.repository.UserRepository;
import com.poly.service.CartService;
import com.poly.service.DiscountService;
import com.poly.service.SessionService;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class Client_PayController {
	@Autowired
	UserRepository userRepository;
	@Autowired
	CartItemRepository cartItemRepository;
	@Autowired
	ShoppingCartRepository shoppingCartRepository;
	@Autowired
	InvoiceItemRepository invoiceItemRepository;
	@Autowired
	InvoiceRepository invoiceRepository;
	@Autowired
	ProductRepository productRepository;
	@Autowired
	SessionService sessionService;
	@Autowired
	JavaMailSender sender;
	
	@Autowired
    CartService cartService; // Dịch vụ giỏ hàng
	@Autowired
    DiscountService discountService;
	
	@RequestMapping("/products/details/cart/pay")
	public String pay(@RequestParam("cartItemIds") String cartItemIds, Model model) {
	    // Lấy thông tin người dùng từ session
	    User user = (User) sessionService.get("user");
	    if (user == null) {
	        return "redirect:/home/login"; // Chuyển hướng đến trang đăng nhập nếu không có người dùng trong session
	    }
	    
	    // Lấy giỏ hàng hiện tại của người dùng
	    ShoppingCart shoppingCart = shoppingCartRepository.findCurrentCartByUser(user);
	    if (shoppingCart == null) {
	        return "giohangtrong"; // Chuyển hướng đến trang thông báo giỏ hàng trống nếu không tìm thấy giỏ hàng
	    }
	    
	    // Tính tổng giá trị giỏ hàng dựa trên cartItemIds
	    double total = 0;
	    List<CartItem> cartItems = new ArrayList<>();
	    String[] idStrings = cartItemIds.split(",");
	    for (String id : idStrings) {
	        try {
	            int cartItemId = Integer.parseInt(id);
	            Optional<CartItem> cartItemOptional = cartItemRepository.findById(cartItemId);
	            if (cartItemOptional.isPresent()) {
	                CartItem cartItem = cartItemOptional.get();
	                total += cartItem.getQuantity() * cartItem.getProductId().getPrice();
	                cartItems.add(cartItem);
	            } else {
	                // Handle case where cart item with given id is not found
	                // You may redirect to an error page or handle it as per your application's logic
	                return "errorpage"; 
	            }
	        } catch (NumberFormatException e) {
	            // Handle invalid cart item id (should not occur if input is validated properly)
	            return "errorpage";
	        }
	    }
	    
	    //User user = userRepository.findById(userId);
	    Hibernate.initialize(user.getAddresses());

	    Address defaultAddress = user.getAddresses().stream()
	                                 .filter(Address::isStatus)
	                                 .findFirst()
	                                 .orElse(null);
	    model.addAttribute("address", defaultAddress);
	    // Lưu thông tin vào model
	    model.addAttribute("total", total);
	   // model.addAttribute("address", defaultAddress);
	    model.addAttribute("user", user);
	    model.addAttribute("cartItems", cartItems);
	    
	    // Lưu cart_id vào session
	    sessionService.set("cartId", shoppingCart.getCartId());
	    // Lưu danh sách sản phẩm vào session
	    sessionService.set("cartItems", cartItems);
	    
	    return "client/Pay"; // Trả về view Pay để người dùng thanh toán
	}

	@GetMapping("/products/details/cart/paynow")
	public String paynow(@RequestParam("productId") Integer productId,
	                     Model model,
	                     HttpSession session) {
	    // Lấy thông tin người dùng hiện tại từ session
	    User user = (User) session.getAttribute("user");
	    if (user == null) {
	        return "redirect:/home/login"; // Chuyển hướng đến trang đăng nhập nếu người dùng chưa đăng nhập
	    }

	    // Tìm giỏ hàng hiện tại của người dùng
	    ShoppingCart shoppingCart = shoppingCartRepository.findByUser(user);
	    if (shoppingCart == null) {
	        // Nếu không tìm thấy giỏ hàng, tạo mới một giỏ hàng
	        shoppingCart = new ShoppingCart();
	        shoppingCart.setUser(user);
	        shoppingCartRepository.save(shoppingCart);
	    }

	    // Tìm sản phẩm dựa trên productId
	    Product product = productRepository.findById(productId).orElse(null);
	    if (product == null) {
	        // Xử lý trường hợp không tìm thấy sản phẩm
	        return "error"; // Có thể chuyển hướng đến trang lỗi
	    }

	    // Tạo một CartItem mới cho sản phẩm
	    CartItem cartItem = new CartItem();
	    cartItem.setShoppingCart(shoppingCart);
	    cartItem.setProductId(product);
	    cartItem.setQuantity(1); // Thiết lập số lượng mặc định (có thể điều chỉnh tùy theo yêu cầu)
	    cartItemRepository.save(cartItem);

	    // Lấy lại danh sách CartItem từ shoppingCart
	    List<CartItem> cartItems = cartItemRepository.findByShoppingCart(shoppingCart);

	    // Tính toán tổng tiền
	    double total = 0;
	    for (CartItem item : cartItems) {
	        total += item.getProductId().getPrice() * item.getQuantity();
	    }

	    // Lưu cartId và cartItems vào session
	    session.setAttribute("cartId", shoppingCart.getCartId());
	    session.setAttribute("cartItems", cartItems);

	    // Thêm các thuộc tính cần thiết vào model cho trang thanh toán
	    model.addAttribute("user", user);
	    model.addAttribute("cartItems", cartItems);
	    model.addAttribute("total", total);

	    Address defaultAddress = user.getAddresses().stream()
                .filter(Address::isStatus)
                .findFirst()
                .orElse(null);
if (defaultAddress != null) {
System.out.println("Default Address: " + defaultAddress);
} else {
System.out.println("Default Address is null");
}
model.addAttribute("address", defaultAddress);



	    // Tạo đối tượng invoice và thêm vào model
	    Invoice invoice = new Invoice();
	    model.addAttribute("invoice", invoice);

	    // Chuyển hướng đến trang thanh toán
	    return "client/Pay";
	}


	@PostMapping("/products/details/cart/pay")
	public String pay(@ModelAttribute("invoice") Invoice invoice, 
	                  @RequestParam("status_id") int status_id,
	                  @RequestParam("payment_method_id") int payment_method_id,
	                  @RequestParam("payment_status") String payment_status,
	                  @RequestParam("shipping_id") int shipping_id,
	                  @RequestParam("totalAmount") double totalAmount,
	                  HttpSession session,
	                  Model model) {
	    // Lấy thông tin người dùng từ session
	    User user = (User) session.getAttribute("user");
	    if (user == null) {
	        return "redirect:/error"; // Chuyển hướng đến trang lỗi nếu không tìm thấy người dùng
	    }
	    
	    // Tạo và thiết lập các đối tượng liên quan
	    Shipping shipping = new Shipping();
	    shipping.setShipping_id(shipping_id); // Đảm bảo rằng shipping_id là giá trị hợp lệ

	    OrderStatus orderStatus = new OrderStatus();
	    orderStatus.setStatusId(status_id);
	    PaymentMethod paymentMethod = new PaymentMethod();
	    paymentMethod.setPaymentMethodId(payment_method_id); // Sử dụng id từ radio button
	    
	    // Cập nhật thông tin hóa đơn
	    invoice.setStatus(orderStatus);
	    invoice.setPaymentMethod(paymentMethod);
	    invoice.setShipping(shipping);
	    invoice.setPaymentDate(new Date());
	    invoice.setPaymentStatus(payment_status);
	    invoice.setUser(user); // Sửa thành user
	    invoice.setTotalAmount(totalAmount);
	    
	    // Lưu hóa đơn vào cơ sở dữ liệu
	    invoiceRepository.saveAndFlush(invoice);
	    
	    // Chuyển đổi các mục giỏ hàng thành các mục hóa đơn
	    List<CartItem> cartItems = sessionService.get("cartItems");
	    if (cartItems != null && !cartItems.isEmpty()) { // Kiểm tra xem cartItems có null hoặc rỗng không
	        for (CartItem cartItem : cartItems) {
	            InvoiceItem invoiceItem = new InvoiceItem();
	            invoiceItem.setInvoice(invoice);
	            Product product = cartItem.getProductId();
	            if (product != null) {
	                invoiceItem.setProduct(product);
	                invoiceItem.setPrice(product.getPrice()); // Gán giá từ product
	            } else {
	                // Xử lý khi product là null (nếu cần thiết)
	                continue; // Bỏ qua và chuyển sang mục tiếp theo
	            }
	            invoiceItem.setQuantity(cartItem.getQuantity()); // Số lượng từ cartItem
	            // Lưu InvoiceItem vào cơ sở dữ liệu
	            invoiceItemRepository.saveAndFlush(invoiceItem);
	            // Xóa CartItem sau khi đã chuyển thành InvoiceItem
	            cartItemRepository.delete(cartItem);
	        }
	    }
	    
	    // Cập nhật session
	    sessionService.set("invoice", invoice);
	    sessionService.remove("cartItems");
	    
	    // Gửi email xác nhận đơn hàng
	    try {
	        MimeMessage mimeMessage = sender.createMimeMessage();
	        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
	        mimeMessageHelper.setFrom("lyt8073@gmail.com");
	        mimeMessageHelper.setTo(user.getEmail());
	        mimeMessageHelper.setSubject("Xác nhận đơn hàng #" + invoice.getInvoiceId());

	        String addresses = user.getAddresses().stream()
	                               .map(Address::toString)
	                               .collect(Collectors.joining(", "));

	        String htmlContent = "<!DOCTYPE html>"
	                + "<html lang='en'>"
	                + "<head>"
	                + "<meta charset='UTF-8'>"
	                + "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
	                + "<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet' integrity='sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH' crossorigin='anonymous'>"
	                + "<title>Order Confirmation</title>"
	                + "<style type='text/css'>"
	                + "body { font-family: Arial, sans-serif; }"
	                + ".container { margin-top: 50px; }"
	                + ".card { padding: 20px; }"
	                + ".card-header { background-color: #007bff; color: white; }"
	                + ".card-body { margin-top: 20px; }"
	                + ".text-center { text-align: center; }"
	                + ".fw-bold { font-weight: bold; }"
	                + ".text-primary { color: #007bff; }"
	                + "</style>"
	                + "</head>"
	                + "<body>"
	                + "<div class='container'>"
	                + "<div class='card'>"
	                + "<div class='card-header'>"
	                + "<h4>Order Confirmation</h4>"
	                + "</div>"
	                + "<div class='card-body'>"
	                + "<h5 class='text-center fw-bold text-primary'>Cảm Ơn Bạn Đã Đặt Hàng Tại QLBook</h5>"
	                + "<div class='card'>"
	                + "<p>Chào " + user.getFullName() + ",</p>"
	                + "<span>QLBook đã nhận được yêu cầu đặt hàng của bạn và đang xử lý.</span>"
	                + "</div><br>"
	                + "<div class='card'>"
	                + "<b>Đơn Hàng Được Giao đến</b> <br>"
	                + "<div class='row'>"
	                + "<div class='col-md-4'>"
	                + "Tên: " + user.getFullName() + "<br>"
	                + "Địa Chỉ: " + addresses + "<br>"
	                + "Điện Thoại: " + user.getPhone() + "<br>"
	                + "Email: " + user.getEmail() + "<br>"
	                + "</div>"
	                + "</div>"
	                + "</div><br>"
	                + "<div class='card'>"
	                + "<div class='row'>"
	                + "<div class='col-md-5'>"
	                + "<p>Thành Tiền:</p>"
	                + "<p>Phí Vận Chuyển:</p>"
	                + "<p>Giảm Giá:</p>"
	                + "<p>Tổng Cộng:</p>"
	                + "</div>"
	                + "<div class='col-md-3'>"
	                + "<p>VNĐ</p>"
	                + "<p>VNĐ</p>"
	                + "<p>VNĐ</p>"
	                + "<p>VNĐ</p>"
	                + "</div>"
	                + "<div class='col-md-3'>"
	                + "<p>" + invoice.getTotalAmount() + "</p>"
	                + "<p>" + shipping.getCOD() + "</p>"
	                + "<p>" + invoice.getDiscount() + "</p>"
	                + "<p>" + (invoice.getTotalAmount() + shipping.getCOD() - 0 ) + " VNĐ</p>"
	                + "</div>"
	                + "</div>"
	                + "</div>"
	                + "<p>Cảm ơn bạn đã mua hàng!</p>"
	                + "<p>Thông tin đơn hàng đã được gửi vào email này.</p>"
	                + "<p>Trân trọng,<br />Đội ngũ hỗ trợ của chúng tôi</p>"
	                + "<p>*Vui lòng không trả lời email này!*</p>"
	                + "</div>"
	                + "</div>"
	                + "</div>"
	                + "</body>"
	                + "</html>";

	        mimeMessageHelper.setText(htmlContent, true);
	        sender.send(mimeMessage);
	        System.out.println("Email đã được gửi đi thành công.");
	    } catch (Exception e) {
	        System.out.println("Đã xảy ra lỗi khi gửi email: " + e.getMessage());
	        e.printStackTrace();
	        // Bạn có thể thêm logic xử lý lỗi ở đây nếu cần
	    }
	    
	    return "redirect:/products/details/cart/pay/success";
	}


	@RequestMapping("/products/details/cart/pay/success") 
	public String orderView(Model model) {
		Invoice invoice = (Invoice) sessionService.get("invoice");
        if (invoice == null) {
            return "redirect:/error"; // Chuyển hướng đến trang lỗi nếu không tìm thấy hóa đơn
        }
        model.addAttribute("orderId", invoice.getInvoiceId());
        model.addAttribute("totalAmount", invoice.getTotalAmount());
        model.addAttribute("paymentMethod", invoice.getPaymentMethod().getPaymentMethodName());
        model.addAttribute("orderTime", invoice.getPaymentDate());
        return "client/PaySuccess";
	}

	@PostMapping("/apply-discount")
	public ResponseEntity<Map<String, Object>> applyDiscount(@RequestBody Map<String, String> payload) {
	    String discountCode = payload.get("discountCode");
	    Map<String, Object> response = new HashMap<>();
	    try {
	        double discountAmount = discountService.getDiscountAmount(discountCode);

	        // Áp dụng giảm giá và tính toán tổng tiền
	        double currentTotal = cartService.getCurrentTotal(); // Lấy tổng tiền hiện tại từ giỏ hàng
	        double newTotal = currentTotal - discountAmount + 32000; // Tổng tiền sau khi áp dụng giảm giá và cộng phí vận chuyển
	        cartService.applyDiscount(discountAmount); // Áp dụng giảm giá

	        response.put("success", true);
	        response.put("discountAmount", discountAmount);
	        response.put("total", newTotal); // Trả về tổng tiền sau khi áp dụng giảm giá
	    } catch (IllegalArgumentException e) {
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "Có lỗi xảy ra, vui lòng thử lại sau.");
	    }
	    return ResponseEntity.ok(response);
	}



	@PostMapping("/remove-discount")
	public ResponseEntity<Map<String, Object>> removeDiscount() {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        double currentTotal = cartService.getCurrentTotal();
	        double shippingCost = 32000; // Phí vận chuyển

	        // Cập nhật tổng tiền sau khi gỡ bỏ giảm giá
	        double newTotal = currentTotal + shippingCost;
	        cartService.removeDiscount(); // Xóa giảm giá trong dịch vụ giỏ hàng

	        response.put("success", true);
	        response.put("newTotal", newTotal); // Trả về tổng tiền sau khi gỡ bỏ giảm giá
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "Có lỗi xảy ra, vui lòng thử lại sau.");
	    }
	    return ResponseEntity.ok(response);
	}


	private double calculateTotalWithDiscount(double total, double discountAmount) {
	    return total - discountAmount;
	}

}





