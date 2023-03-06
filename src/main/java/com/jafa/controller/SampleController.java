package com.jafa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jafa.domain.CartVO;
import com.jafa.domain.Criteria;
import com.jafa.domain.Pagination;
import com.jafa.domain.Bookshop.BookCategory;
import com.jafa.domain.Bookshop.BookSubCategory;
import com.jafa.domain.Bookshop.BookVO;
import com.jafa.repository.BookRepository;
import com.jafa.repository.CartRepository;
import com.jafa.repository.CategoryRepository;

@RestController
@RequestMapping("/sample")
public class SampleController {
	
	@Autowired
	private BookRepository bookRepository;
	
	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private CartRepository cartRepository;
	
	// 도서목록
	@PostMapping("/list") // @GetMapping에 @RequestBody붙이니까 안됨
	public Map<String, Object> list(@RequestBody Criteria criteria) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<BookVO> bookList = bookRepository.selectByCategory(criteria);
		Pagination pagination = new Pagination(criteria, bookRepository.getTotalCount(criteria));
		map.put("bookList", bookList);
		map.put("p", pagination);
		map.put("cri", criteria);
		return map; 
	}
	
	// 도서 상세페이지
	@GetMapping("/detail")
	public Map<String, Object> detail(int bookNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		BookVO detail = bookRepository.findByBookNo(bookNo);
		List<BookCategory> cateList = categoryRepository.getCateList();
		List<BookSubCategory> subCateList = categoryRepository.getSubCateList();
		map.put("detail", detail);
		map.put("cateList", cateList);
		map.put("subCateList", subCateList);
		return map;
	}
	
	// 장바구니 상품 목록
	@PostMapping("/cartList")
	public Map<String, Object> cartList(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CartVO> cartList = cartRepository.findById(id);
		map.put("cartList", cartList);
		return map; 
	}

}