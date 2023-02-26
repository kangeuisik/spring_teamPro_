package com.jafa.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int page; // 현재페이지
	private int perPageNum; //한페이지에 표시할 게시물 수
	
	private String cate_id; // 카테 아이디
	private String subCate_id; // 서브카테 아이디
	private String tid;
	private String type;
	private String keyword;
	
	
	public Criteria() {
		this(1,10);
	}
	

	public Criteria(int page, int perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
	}
	//#{maxRow}
	public int getMaxRow() {
		return this.page*this.perPageNum; 
	}
	//#{minRow}
	public int getMinRow() {
		return (this.page-1)*this.perPageNum;
	}
}
