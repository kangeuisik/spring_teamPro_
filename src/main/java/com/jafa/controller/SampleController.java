package com.jafa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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

	@PostMapping("/list") // @GetMapping에 @RequestBody붙이니까 안됨
	public Map<String, Object> list(@RequestBody Criteria criteria) {
		System.out.println("타입 : "+ criteria.getType());
		System.out.println("키워드 : "+ criteria.getKeyword());
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