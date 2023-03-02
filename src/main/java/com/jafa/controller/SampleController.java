package com.jafa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.jafa.domain.Criteria;
import com.jafa.domain.Pagination;
import com.jafa.domain.Bookshop.BookVO;
import com.jafa.repository.BookRepository;

@RestController
@RequestMapping("/sample")
public class SampleController {
	
	@Autowired
	private BookRepository bookRepository;
	
	@PostMapping("/take")
	public String requestTake(@RequestBody BookVO bookVO) {
		System.out.println("오나? :"+ bookVO);
		bookRepository.requestTake(bookVO.getBookName());
		return "success"; 
	}
	
	
	@PostMapping("/list") // @GetMapping에 @RequestBody붙이니까 안됨
	public Map<String, Object> list(@RequestBody Criteria criteria) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<BookVO> bookList = bookRepository.selectByCategory(criteria);
		Pagination pagination = new Pagination(criteria, bookRepository.getTotalCount(criteria));
		map.put("bookList", bookList);
		map.put("p", pagination);
		return map; 
	}
	
//	@PostMapping("/list") // @GetMapping에 @RequestBody붙이니까 안됨
//	public List<BookVO> list(@RequestBody Criteria criteria) {
//		System.out.println("크리테리아 : "+criteria);
//		List<BookVO> bookList = bookRepository.selectByCategory(criteria);
//		return bookList; 
//	}
}