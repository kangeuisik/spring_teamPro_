package com.jafa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jafa.domain.CartVO;
import com.jafa.repository.CartRepository;

@Controller
@RequestMapping("/cart")
public class CartController {

	@Autowired
	CartRepository cartRepository;

	// 장바구니 페이지
	@GetMapping("/cartPage")
	public String cartPage() {
		return "cart/cartPage";
	}

	// 장바구니 담기
	@PostMapping("/addCart")
	public String addCart(CartVO vo) {
		cartRepository.addCart(vo);
		return "cart/cartPage";
	}

}
