package com.poly.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.poly.model.Product;
import com.poly.model.Seller; // Thêm import Seller nếu chưa có

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    @Query("SELECT COUNT(p) FROM Product p")
    int countTotalProducts();

    @Query("SELECT p.productName, i.quantity, os.statusName " +
           "FROM Product p " +
           "JOIN p.invoiceItems i " +
           "JOIN i.invoice iv " +
           "JOIN iv.status os " +
           "WHERE p.productName IS NOT NULL")
    List<Object[]> findProductNamesWithStatusAndQuantity();

    Optional<Product> findByProductId(Integer productId);

    boolean existsByProductName(String productName);

    // Lọc sản phẩm theo categoryId
    List<Product> findByCategoryCategoryId(int categoryId);

    // Tìm sản phẩm theo khoảng giá
    Page<Product> findByPriceBetween(double minPrice, double maxPrice, Pageable pageable);
    
    // Tìm sản phẩm theo tên chứa chuỗi
    Page<Product> findByProductNameContaining(String productName, Pageable pageable);
    
    @Query("SELECT p FROM Product p WHERE p.category.categoryId = :categoryId")
    Page<Product> findProductsByCategory(@Param("categoryId") Integer categoryId, Pageable pageable);

    // Tìm sản phẩm theo seller
    Page<Product> findBySeller(Seller seller, Pageable pageable); // Sử dụng đối tượng Seller
}
