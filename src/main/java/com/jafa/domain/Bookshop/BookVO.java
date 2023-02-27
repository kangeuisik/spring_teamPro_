package com.jafa.domain.Bookshop;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BookVO {
    
    private int bookNo; // 책 번호
	private String cate_id; // 카테
	private String subCate_id; // 서브카테
	private String bookName; // 책 제목
	private String author; // 저자
	private String publisher; // 출판사
	private String bookImage; // 이미지
	private int price; // 가격
	private Date regDate; // 등록일
	
	private String take; //대여
	private int takePrice; //대여금액
	private Date takeDate; //대여일자
	private Date returnDate; //반납일자
}
