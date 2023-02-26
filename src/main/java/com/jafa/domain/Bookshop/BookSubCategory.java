package com.jafa.domain.Bookshop;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookSubCategory {
	
	private String cate_id; // 카테 아이디
	private String subCate_id; // 서브카테 아이디
	private String subCate_name; // 서브카테 네임

}
