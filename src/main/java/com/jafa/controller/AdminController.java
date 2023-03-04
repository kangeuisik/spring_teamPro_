package com.jafa.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.Bookshop.BookDTO;
import com.jafa.domain.Bookshop.BookVO;
import com.jafa.domain.Bookshop.CategoryDTO;
import com.jafa.repository.BookRepository;
import com.jafa.repository.CategoryRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private static final String REPO_PATH = "c:/file01_spring/";
	private static final String bookServicePathName = "book/";
	
	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private BookRepository bookRepository;
	
	@Autowired
	private ServletContext application;
	
	// 관리자 홈
	@GetMapping("/home")
	public String home() {
		application.setAttribute("cateList", categoryRepository.getCateList());
		application.setAttribute("subCateList", categoryRepository.getSubCateList());
		return "/admin/home";
	}
	//도서관리페이지로 이동
	@GetMapping("/book")
	public String book() {
		List<Map<String,Integer>> list = bookRepository.getCount();
		application.setAttribute("subCate", list);
		return "admin/book";
	}
	
	// 여러개 등록
		@PostMapping("/registerBook")
		public String registerBook(BookDTO dto, @RequestParam("attachFile") List<MultipartFile> multipartFile, RedirectAttributes rttr) {
			/*
			List<BookVO> bookList = dto.getBookList();
			for (BookVO b : bookList) {
				System.out.println("book : "+ b);
			}
			*/
			List<BookVO> bookList = dto.getBookList();
			if (!multipartFile.isEmpty()) { // 첨부파일이 있을 때
				int count = 0;
				for (MultipartFile f : multipartFile) {
					String fileName = f.getOriginalFilename(); // 데이터베이스에 저장될 이미지 파일 이름
					System.out.println("이미지파일 이름: "+ fileName);
					bookList.get(count).setBookImage(fileName); // vo.setBookImage(fileName);
					count++;
				}
				System.out.println(bookList);
				bookRepository.addBook(bookList);
				/*
				// 경로: c:/file01_spring/book/cate_id/subCate_id/bookNo/이미지파일
				File uploadPath = new File(REPO_PATH + bookServicePathName + vo.getCate_id() + "/" + vo.getSubCate_id() + "/" + vo.getBookNo());
				if (!uploadPath.exists()) { // 디렉토리 존재하지 않으면
					uploadPath.mkdirs(); // 디렉토리 생성
				}
				File uploadFile = new File(uploadPath, fileName); // 업로드
				try {
					multipartFile.transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				} else { // 첨부파일이 없는 경우
					bookRepository.addBook(bookList);
				}
				 */
			}
			return "redirect:/admin/book";
		}

		/*
		// 하나만 등록
		@PostMapping("/registerBook")
		public String registerBook(BookVO vo, @RequestParam("attachFile") MultipartFile multipartFile,
				RedirectAttributes rttr) {

			if (!multipartFile.isEmpty()) { // 첨부파일이 있을 때
					String fileName = multipartFile.getOriginalFilename(); // 데이터베이스에 저장될 이미지 파일 이름
					vo.setBookImage(fileName);
					bookRepository.insertBook(vo);

					// 경로: c:/file01_spring/book/cate_id/subCate_id/bookNo/이미지파일
					File uploadPath = new File(REPO_PATH + bookServicePathName + vo.getCate_id() + "/" + vo.getSubCate_id() + "/" + vo.getBookNo());
					
					if (!uploadPath.exists()) { // 디렉토리 존재하지 않으면
						uploadPath.mkdirs(); // 디렉토리 생성
					}
					
					File uploadFile = new File(uploadPath, fileName); // 업로드
					try {
						multipartFile.transferTo(uploadFile);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
			} else { // 첨부파일이 없는 경우
				bookRepository.insertBook(vo);
			}
			return "redirect:/admin/book";
		}
		*/
		// 도서상품 삭제
		@PostMapping("/removeBook")
		public String removeBook(int bookNo) {
			BookVO vo = bookRepository.findByBookNo(bookNo); // 게시물정보조회 
			String category = vo.getCate_id()+"/"+vo.getSubCate_id();
			
			if(vo.getBookImage()!=null) {
				// 파일 삭제 
				File file = new File(REPO_PATH + bookServicePathName + category + "/" + bookNo, vo.getBookImage());
				File folder = new File(REPO_PATH + bookServicePathName + category + "/" + bookNo);
				file.delete(); // 파일삭제
				folder.delete(); // 폴더삭제ㅁ
			}
			
			bookRepository.deleteBook(bookNo); 
			return "redirect:/book/list/"+category;
		}
	
	// 카테고리 관리 페이지
	@GetMapping("/category")
	public String category() {
		application.setAttribute("cateList", categoryRepository.getCateList());
		application.setAttribute("subCateList", categoryRepository.getSubCateList());
		return "/admin/category";
	}
	
	// 카테고리 추가
	@PostMapping("/addCate")
	public String addCate(CategoryDTO dto) {
		categoryRepository.saveCate(dto);
		return "redirect:/admin/category";
	}
	
	// 서브카테고리 추가
	@PostMapping("/addSubCate") // org.apache.ibatis.binding.BindingException
	public String addSubCate(CategoryDTO dto) {
		System.out.println("dto : "+dto);
		categoryRepository.saveSubCate(dto);
		return "redirect:/admin/category";
	}
	
	// 카테고리 삭제
	@PostMapping("/delCate")
	public String delCate(String id) {
		categoryRepository.delCate(id);
		return "redirect:/admin/category";
	}
	
	// 서브 카테고리 삭제
	@PostMapping("/delSubCate")
	public String delSubCate(String id) {
		categoryRepository.delSubCate(id);
		return "redirect:/admin/category";
	}
	
}
