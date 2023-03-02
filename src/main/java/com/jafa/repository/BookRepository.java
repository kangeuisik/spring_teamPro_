package com.jafa.repository;

import java.util.List;
import java.util.Map;

import com.jafa.domain.Criteria;
import com.jafa.domain.Bookshop.BookVO;

public interface BookRepository {

	// 게시물(책) 목록
	List<BookVO> selectByCategory(Criteria criteria);

	// 총 게시물(책) 수
	int getTotalCount(Criteria criteria);

	// 게시물(책) 상세
	BookVO findByBookNo(int bookNo);

	List<Map<String, Integer>> getCount();
//--------------------------대여-------------------//
	//대여현황 목록
	List<BookVO> getTakeList(Criteria criteria);
	//신청받으면 take컬럼 업데이트 시키기
	void requestTake(String bookName);
	//대여신청받은목록(신청대기자만 관리자페이지에서 테이블로 표기)
	List<BookVO> takeWaitList(Criteria criteria);

}
