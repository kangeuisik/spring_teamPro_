package com.jafa.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pagination {
	private Criteria criteria;
	
	private int startPage; // 시작페이지 버튼 번호
	private int endPage; //마지막 페이지 버튼 번호
	private int tempEndPage; //실제 마지막 페이지 버튼 번호
	private int displayPageNum; //화면에 보여질 페이지 버튼 수
	
	private boolean prev; //이전페이지 버튼 활성화 여부 
	private boolean next; //다음페이지 버튼 활성화 여부
	
	
	//페이징 처리
	public Pagination(Criteria criteria, int totalCount) {
		this.criteria = criteria;
		this.displayPageNum = 10;

		endPage = (int) Math.ceil(criteria.getPage()/(double)displayPageNum)*displayPageNum;
		//EX) 현재페이지 5
		//마지막 페이지 = 현재페이지(5)에서 화면에보여질 페이지 버튼수(10)를 나눈 값을 올림하여
		// (0.5->1) * 화면에 보여질 페이지 버튼수(10) => 10
		//ex) 현재페이지 24
		// 현재페이지(24)에서 화면에 보여질 페이지 버튼수(10)를 나눈값을 올림하여
		//
		startPage = endPage - displayPageNum + 1;
		tempEndPage = (int) Math.ceil((double)totalCount/criteria.getPerPageNum());
		
		prev = startPage != 1; 
		next = endPage < tempEndPage;
		
		if(endPage>tempEndPage) endPage = tempEndPage;
	}
}
