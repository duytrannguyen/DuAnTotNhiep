package com.poly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.model.Category;
import com.poly.model.Product;
import com.poly.repository.CategoryRepository;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("admin")
public class Admin_CategoryController {

	CategoryRepository categoryRepository;

	@Autowired
	public Admin_CategoryController(CategoryRepository categoryRepository) {
		this.categoryRepository = categoryRepository;
	}

	@GetMapping("/Category")
	public String showCategories(Model model, HttpServletRequest req) {
		List<Category> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);
		req.setAttribute("view", "/views/admin/QuanLyTheLoai/index.jsp");
		return "indexAdmin";
	}

	@PostMapping("/Category/create")
	public String addCategory(@ModelAttribute Category category) {
		categoryRepository.save(category);
		return "redirect:/admin/Category";
	}
	@GetMapping("/Category/edit/{categoryId}")
	public String edit(Model model,HttpServletRequest req, @PathVariable("categoryId") Integer id) {
		Category item = categoryRepository.findById(id).get();
		model.addAttribute("category", item);
		List<Category> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);
		req.setAttribute("view", "/views/admin/QuanLyTheLoai/index.jsp");
		return "indexAdmin";
	}
	@RequestMapping("/Category/update/{categoryId}")
	public String update(Model model,HttpServletRequest req, @PathVariable("categoryId") Integer id, @RequestParam("categoryName") String categoryName) {
		Category category = categoryRepository.findById(id).get();
		category.setCategoryName(categoryName);
		categoryRepository.save(category);
		return "redirect:/admin/Category";
	}
	@RequestMapping("/Category/delete/{categoryId}")
	public String create(@PathVariable("categoryId") Integer id) {
		categoryRepository.deleteById(id);
		return "redirect:/admin/Category";
	}
	@PostMapping("/Category/reset")
	public String restProducts(HttpServletRequest req, Model model) {
		List<Category> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);
		req.setAttribute("view", "/views/admin/QuanLyTheLoai/index.jsp");
		return "indexAdmin";
	}
}
