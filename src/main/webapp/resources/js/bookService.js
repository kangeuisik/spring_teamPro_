console.log('bookService');

let bookService = {
	
	// 목록
	list : function(criteria) {
		
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/list`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(criteria),
			
			success : function(map) {
				let p = map.p;
				bookListRender(map);
				paginationRender(p); // Pagination [criteria(page=1, perPageNum=10)]
			},
			error : function() {
				alert('목록 조회 실패');			
			}
		}); // ajax end
	}
	
};

// 북 리스트 렌더링
function bookListRender(map) {
	let output = ``;
	for(let b of map.bookList) {
		output +=`
		<tr>
			<td>${b.bookNo}</td>`;
			if(b.bookImage == '' || b.bookImage == null) {
				output +=
				`<td>이미지X</td>`;
			} else {
				output +=
				`<td><img src="${contextPath}/bookImgDisplay?category=${b.cate_id}/${b.subCate_id}&no=${b.bookNo}&imageFileName=${b.bookImage}" width="40px" height="40px"></td>`;
			}
		output +=`
			<td>${b.cate_id} / ${b.subCate_id}</td>
			<td><a id="${b.bookNo}" href="${contextPath}/book/detail?bookNo=${b.bookNo}">${b.bookName}</a></td>
			<td>${b.author}</td>
			<td>${b.publisher}</td>
			<td>${b.price}</td>
			<td>${b.regDate}</td>
		</tr>`;
	}
	$('.bookList tbody').html(output);
	
	/*
	// 제목 클릭하면 상세 페이지로 이동
	$('.bookList a').on('click', function(e){
		e.preventDefault();
		let bookNodata = $(this).attr('id');
		
		let form = $('<form>');
		form.attr('method','post')
			.attr('action',`${contextPath}/book/detail?bookNo=`+bookNodata)
			.appendTo('body')
			.submit();
	})
	*/
	
}

// 페이지네이션 렌더링
function paginationRender(p) {
	let output =`
		<ul class="pagination bookPagination">`;
		if(p.prev) {
			output +=
			`<li class="page-item">
				<a class="page-link" href="${p.startPage-1}">이전</a>
			</li>`;
		}
		for(let pageNum=p.startPage; pageNum<=p.endPage; pageNum++) {
			output +=
			`<li class="page-item ${p.criteria.page == pageNum ? 'active':''}">
				<a class="page-link" href="${pageNum}">${pageNum}</a>
			</li>`;
		}
		if(p.next) {
			output +=
			`<li class="page-item">
				<a class="page-link" href="${p.endPage+1 }">다음</a>
			</li>`;
		}
	output +=`</ul>`;
	$('#bookPagination').html(output);
	
	// 페이지이동
	$('.bookPagination a').on('click',function(e){
		e.preventDefault();
		let typeValue = $('select[name="type"]').val(); // 셀렉트태그에서 선택된 값
		let keywordValue = $('input[name="keyword"]').val(); // input[name="keyword"]태그 값
		
		// 검색한 내용, 카테고리 유지한 채로 페이지 이동 할 때 필요한거
		let criteria = {
			page : $(this).attr('href'), // 클릭한 페이지 번호
			cate_id : p.criteria.cate_id,
			subCate_id : p.criteria.subCate_id,
			type : typeValue,
			keyword : keywordValue
		}
		bookService.list(criteria); // 해당 페이지 리스트 새로 불러옴
	});
	 
}


$(function() {
	
	// 처음 리스트 불러 올 때 필요한거 -> 뭔가 중복되는게 많은데 줄이는 방법 없나??
	let cate_id = $('#cate option:selected').val(); // 셀렉트태그에서 선택된 값
	let subCate_id = $('#subCate option:selected').val();  // 셀렉트태그에서 선택된 값
	let typeValue = $('select[name="type"]').val(); // // 셀렉트태그에서 선택된 값
	let keywordValue = $('input[name="keyword"]').val(); // input[name="keyword"]태그 값

	let criteria = {
		cate_id : cate_id,
		subCate_id : subCate_id,
		type : typeValue, // 검색 할 때 필요한거
		keyword : keywordValue // 검색 할 때 필요한거
	}
	bookService.list(criteria);
	
	// 검색
	$('.searchBookForm button').on('click',function(){
		/* 카테고리 바꾸고 검색 했을 때*/
		let cate_id = $('#cate option:selected').val(); // // 셀렉트태그에서 선택된 값
		let subCate_id = $('#subCate option:selected').val(); // 셀렉트태그에서 선택된 값
		
		let searchForm = $('.searchBookForm');
		if(cate_id != '' && subCate_id != '') { // 대분류, 소분류 둘 다 선택
			searchForm.attr('action',`${contextPath}/book/list/${cate_id}/${subCate_id}`)
		} else { // 대분류만 선택
			searchForm.attr('action',`${contextPath}/book/list/${cate_id}`)
		}
		searchForm.appendTo('body')
			.submit();
	});
	
	// 목록버튼 클릭 이벤트
	$('.toBookList').on('click', function(){
		alert('목록버튼 클릭');
		/*
		let bookDetailForm = $('#bookDetailForm'); // ${contextPath}/book/list/${cate_id}/${subCate_id}
		bookDetailForm.attr('method','post')
			.attr('action',`${contextPath}/book/list`)
			.appendTo('body')
			.submit();
		*/
	})
	
});