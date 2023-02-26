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
public class BookCategory {

	private String cate_id; // 카테 아이디
	private String cate_name; // 카테 네임
}
