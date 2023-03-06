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
	
	@GetMapping("/main")
	public String main(Model model) {
		model.addAttribute("threeNotice",boardRepository.mainNotice());
		model.addAttribute("threeReview", boardRepository.mainReview());
		model.addAttribute("threeEtc", boardRepository.mainEtc());
		return "/main/main";
	}
	
	@GetMapping("/test")
	public String test() {
		return"main/test";
	}


}
