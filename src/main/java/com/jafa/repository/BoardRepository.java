package com.jafa.repository;

import java.util.List;

import com.jafa.domain.BoardVO;
import com.jafa.domain.Criteria;

public interface BoardRepository {

	//글쓰기 
	void insertBoard(BoardVO vo);

	//글목록
	List<BoardVO> list(Criteria criteria);
	int getTotalCount(Criteria criteria);

	//글상세보기
	BoardVO detail(Long bno);
	//글 삭제
	void remove(Long bno);
	//수정
	void modify(BoardVO vo);
	void modifyOnlyContent(BoardVO vo);	
	
}
