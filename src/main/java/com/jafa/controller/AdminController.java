package com.jafa.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jafa.domain.Bookshop.CategoryDTO;
import com.jafa.repository.CategoryRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private ServletContext application;
	
	// 관리자 홈
	@GetMapping("/home")
	public String home() {
		return "/admin/home";
	}
	
	//글쓰기 폼 이동
	@GetMapping("/book")
	public String book() {
		return "admin/book";
	}
	
	// 카테고리 관리 페이지
	@GetMapping("/category")
	public String category() {
		application.setAttribute("cateList", categoryRepository.getCateList());
		application.setAttribute("subCateList", categoryRepository.getSubCateList());
		return "/admin/category";
	}
	
	// 카테고리 추가
	@PostMapping("/addCate")
	public String addCate(CategoryDTO dto) {
		categoryRepository.saveCate(dto);
		return "redirect:/admin/category";
	}
	
	// 서브카테고리 추가
	@PostMapping("/addSubCate") // org.apache.ibatis.binding.BindingException
	public String addSubCate(CategoryDTO dto) {
		System.out.println("dto : "+dto);
		categoryRepository.saveSubCate(dto);
		return "redirect:/admin/category";
	}
	
	// 카테고리 삭제
	@PostMapping("/delCate")
	public String delCate(String id) {
		categoryRepository.delCate(id);
		return "redirect:/admin/category";
	}
	
	// 서브 카테고리 삭제
	@PostMapping("/delSubCate")
	public String delSubCate(String id) {
		categoryRepository.delSubCate(id);
		return "redirect:/admin/category";
	}
	
}
