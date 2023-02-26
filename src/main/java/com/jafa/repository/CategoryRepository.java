package com.jafa.repository;

import java.util.List;

import com.jafa.domain.Bookshop.BookCategory;
import com.jafa.domain.Bookshop.BookSubCategory;
import com.jafa.domain.Bookshop.CategoryDTO;

public interface CategoryRepository {

	// 카테고리 목록 불러오기
	List<BookCategory> getCateList();
	// 서브 카테고리 목록 불러오기
	List<BookSubCategory> getSubCateList();
	
	// 카테고리 추가
	void saveCate(CategoryDTO dto);
	// 서브 카테고리 추가
	void saveSubCate(CategoryDTO dto);
	
	// 카테고리 삭제
	void delCate(String id);
	// 서브 카테고리 삭제
	void delSubCate(String id);
	
	

}
