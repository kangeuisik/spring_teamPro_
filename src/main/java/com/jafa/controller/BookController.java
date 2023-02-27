package com.jafa.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jafa.domain.Criteria;
import com.jafa.domain.Pagination;
import com.jafa.repository.BookRepository;
import com.jafa.repository.CategoryRepository;

@Controller
@RequestMapping("/book")
public class BookController {
	
	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	BookRepository bookRepository;

	// 도서 홈
	@GetMapping("/home")
	public String home() {
		application.setAttribute("cateList", categoryRepository.getCateList());
		application.setAttribute("subCateList", categoryRepository.getSubCateList());
		return "book/home";
	}
	
	// 게시물(책) 목록
	// @PathVariable(required = false) 
	// required속성 false로 지정하면 : 값이 없을 때 null로 받음
	@GetMapping(value = { "/list/{cate_id}", "/list/{cate_id}/{subCate_id}" })
	public String list(@ModelAttribute("cri") Criteria criteria,
			@PathVariable(required = false) String cate_id,
			@PathVariable(required = false) String subCate_id) {
		criteria.setCate_id(cate_id);
		criteria.setSubCate_id(subCate_id);
//		model.addAttribute("bookList", bookRepository.selectByCategory(criteria)).addAttribute("p",
//				new Pagination(criteria, bookRepository.getTotalCount(criteria)));
		return "book/list";
	}
	
	//글상세보기
	@GetMapping("/detail")
	public String detail(Model model, int bookNo) {
		model.addAttribute("detail",bookRepository.findByBookNo(bookNo));
		return "book/detail";
	}
	
	//====================================대여=============================================//
	
	@GetMapping("/takeList")
	public String takeList(@ModelAttribute("cri") Criteria criteria,
			Model model) {
		model.addAttribute("takeList", bookRepository.getTakeList(criteria))
		.addAttribute("p", new Pagination(criteria, bookRepository.getTotalCount(criteria)));
		return "book/takeList"; 
		
	}
}
