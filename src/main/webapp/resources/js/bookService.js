console.log('bookService');

let bookService = {
	
	// 목록
	list : function(criteria) {
		console.log('크리 카테 : '+criteria.cate_id);
		console.log('크리 서브카테 : '+criteria.subCate_id);
		console.log('크리 타입 : '+criteria.type);
		console.log('크리 키워드 : '+criteria.keyword);
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/list`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(criteria),
			
			success : function(map) {
				/*
				console.log("page : "+map.p.criteria.page);
				console.log("perPageNum : "+map.p.criteria.perPageNum);
				console.log("cate_id : "+map.p.criteria.cate_id);
				console.log("subCate_id : "+map.p.criteria.subCate_id);
				console.log("startPage : "+map.p.startPage);
				console.log("endPage : "+map.p.endPage);
				console.log("tempEndPage : "+map.p.tempEndPage);
				console.log("displayPageNum : "+map.p.displayPageNum);
				console.log("prev : " + map.p.prev);
				console.log("next : "+ map.p.next);
				*/
				// alert(map.bookList);
				let bookList = map.bookList;
				let p = map.p;
				bookListRender(bookList);
				paginationRender(p);
				
			},
			error : function() {
				alert('목록 조회 실패');			
			}
		}); // ajax end
	}
	
};

function bookListRender(bookList) {
	let output = ``;
	for(let b of bookList) {
		output +=
		`<tr>
			<td>${b.bookNo}</td>
			<td>이미지</td>
			<td>${b.cate_id} / ${b.subCate_id}</td>
			<td><a href="${contextPath}/book/detail?bookNo=${b.bookNo}">${b.bookName}</a></td>
			<td>${b.author}</td>
			<td>${b.publisher}</td>
			<td>${b.price}</td>
			<td>${b.regDate}</td>
		</tr>`
	}
	$('.bookList tbody').html(output);
	
	
	
}

function paginationRender(p) {
	let output =`<ul class="pagination">`;
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
	$('#pagination').html(output);
	
	// 페이지이동
		$('.pagination a').on('click',function(e){
		e.preventDefault();
		let typeValue = $('select[name="type"]').val(); // id가 type인 셀렉트태그 선택된 값 가져오기
		let keywordValue = $('input[name="keyword"]').val(); // name속성이 keyword인 input태그 값 가져오기
				
		let criteria = {
			page : $(this).attr('href'),
			cate_id : p.criteria.cate_id,
			subCate_id : p.criteria.subCate_id,
			type : typeValue,
			keyword : keywordValue
		}
		
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/list`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(criteria),
			
			success : function(map) {
				let bookList = map.bookList;
				let p = map.p;
				bookListRender(bookList);
				paginationRender(p);
			},
			error : function() {
				alert('목록 조회 실패');			
			}
		}); // ajax end
	});
	 
}


$(function() {

	let cate_id = $('#cate option:selected').val(); // id가 cate인 셀렉트태그 선택된 값 가져오기
	let subCate_id = $('#subCate option:selected').val(); // id가 subCate인 셀렉트태그 선택된 값 가져오기
	let typeValue = $('select[name="type"]').val(); // id가 type인 셀렉트태그 선택된 값 가져오기
	let keywordValue = $('input[name="keyword"]').val(); // name속성이 keyword인 input태그 값 가져오기

	let criteria = {
		cate_id : cate_id,
		subCate_id : subCate_id,
		type : typeValue,
		keyword : keywordValue
	}
	
	bookService.list(criteria);
	
	// 검색
	$('.searchForm button').on('click',function(){
		let searchForm = $('.searchForm');
		if(cate_id != '' && subCate_id != '') { // 둘다 선택
			searchForm.attr('action',`${contextPath}/book/list/${cate_id}/${subCate_id}`)
		}
		else { // 하나만 선택
			searchForm.attr('action',`${contextPath}/book/list/${cate_id}`)
		}
		searchForm.appendTo('body')
			.submit();
	});
	
});