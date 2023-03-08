package com.jafa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jafa.domain.Criteria;
import com.jafa.repository.BoardRepository;

@Controller
@RequestMapping("/")
public class MainController {

	@Autowired
	BoardRepository boardRepository;
	
	//메인페이지
	@GetMapping("/main")
	public String main(Model model) {
		//글 미리보기 , 각 게시판의 최신글 3개의 항목 불러오는 코드
		model.addAttribute("threeNotice",boardRepository.mainNotice());
		model.addAttribute("threeReview", boardRepository.mainReview());
		model.addAttribute("threeEtc", boardRepository.mainEtc());
		return "/main/main";
	}
	//테스트 코드
	@GetMapping("/test")
	public String test() {
		return"main/test";
	}


}
