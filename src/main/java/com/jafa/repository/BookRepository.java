package com.jafa.repository;

import java.util.List;

import com.jafa.domain.Criteria;
import com.jafa.domain.Bookshop.BookVO;

public interface BookRepository {

	// 게시물(책) 목록
	List<BookVO> selectByCategory(Criteria criteria);

	// 총 게시물(책) 수
	int getTotalCount(Criteria criteria);

	// 게시물(책) 상세
	BookVO findByBookNo(int bookNo);


}
