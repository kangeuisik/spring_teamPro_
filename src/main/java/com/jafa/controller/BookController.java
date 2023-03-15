package com.jafa.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jafa.domain.Criteria;
import com.jafa.domain.Pagination;
import com.jafa.domain.Bookshop.BookVO;
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
	private BookRepository bookRepository;

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
	@GetMapping(value = {"/list", "/list/{cate_id}", "/list/{cate_id}/{subCate_id}" })
	public String list(@ModelAttribute("cri") Criteria criteria,
			@PathVariable(required = false) String cate_id,
			@PathVariable(required = false) String subCate_id) {
		criteria.setCate_id(cate_id);
		criteria.setSubCate_id(subCate_id);
		return "book/list";
	}
	// 장바구니 페이지로 이동
	@GetMapping("/cartPage")
	public String cartPage() {
		return "cart/cartPage";
	}
	
	//글상세보기 왜 post로 바꿨는지 -> get요청시 에러...int bookNo가 null??
	/* Request processing failed; nested exception is java.lang.IllegalStateException: Optional int parameter
	 * 'bookNo' is present but cannot be translated into a null 
	 * value due to being declared as a primitive type. 
	 * Consider declaring it as object wrapper for the corresponding primitive type. */
	@PostMapping("/detail")
	public String detail(@ModelAttribute("cri") Criteria criteria, Model model, int bookNo) {
		model.addAttribute("detail",bookRepository.findByBookNo(bookNo));
		return "book/detail";
	}
	
	//====================================대여=============================================//
	
	//대여현황
	@GetMapping("/takeList")
	public String takeList(@ModelAttribute("cri") Criteria criteria,
			Model model) {
		model.addAttribute("takeList", bookRepository.getTakeList(criteria))
		.addAttribute("p", new Pagination(criteria, bookRepository.getTotalCount(criteria)));
		return "book/takeList"; 
	}
	//대여 신청처리
	@PostMapping("/take")
	@ResponseBody //신청하면 신청대기로 take를 '신청확인중'으로 업데이트
	public ResponseEntity<String> requestTake(@RequestBody BookVO bookVO) {
		String bookName = bookVO.getBookName();
		bookRepository.requestTake(bookName);
		return new ResponseEntity<String>("test",HttpStatus.OK);
	}
	
	//대여신청 후 관리자 페이지
	@GetMapping("/takeMaster")
	public String takeMaster(@ModelAttribute("cri") Criteria criteria,
			Model model, String type,String keyword) {
		criteria.setType(type);
		criteria.setKeyword(keyword);
		model.addAttribute("takeMaster",bookRepository.takeMaster(criteria))
		.addAttribute("p", new Pagination(criteria, bookRepository.getTakeTotalCount(criteria)));
		return "book/takeMaster";
	}
	//'신청대기'->대여중으로 업데이트
	@PostMapping("/yesUpdate")
	@ResponseBody
	public ResponseEntity<String> resultYesUpdate(@RequestBody BookVO bookN) {
		String bookName = bookN.getBookName(); // 승인한 책이름
		bookRepository.yesUpdate(bookName); 
		return new ResponseEntity<String>("yesTest",HttpStatus.OK);			
	}		
	//'신청대기'->거절로 업데이트
	@PostMapping("/noUpdate")
	@ResponseBody
	public ResponseEntity<String> resultNoUpdate(@RequestBody BookVO bookR) {
		String bookName = bookR.getBookName(); //거절한 책이름
		String reason = bookR.getReason(); //사유
		bookRepository.noUpdate(bookName,reason);
		return new ResponseEntity<String>("noTest",HttpStatus.OK);
	}



}
