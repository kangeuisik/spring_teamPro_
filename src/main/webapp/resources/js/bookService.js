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
		//console.log("type : "+type);
		//console.log("keyword : "+keyword);
		
		
		
		let criteria = {
			page : $(this).attr('href'),
			cate_id : p.criteria.cate_id,
			subCate_id : p.criteria.subCate_id
			/*
			type : typeInput,
			keyword : keywordInput
			*/
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

	let cateValue = $('#cate option:selected').val(); // id가 cate인 셀렉트태그 선택된 값 가져오기
	let subCateValue = $('#subCate option:selected').val(); // id가 subCate인 셀렉트태그 선택된 값 가져오기
	//let typeValue = getSearchParam('type');
	//let keywordValue = getSearchParam('keyword');

	let criteria = {
		cate_id : cateValue,
		subCate_id : subCateValue
	}
	
	bookService.list(criteria);
	
	// 검색 
	$('.searchForm button').click(function(){
		alert('검색');
		/*
		let type = new URLSearchParams(location.search).get('type');
		let keyword = new URLSearchParams(location.search).get('keyword');
		
		let typeInput = $('<input/>',{
			type : 'hidden',
			name : 'type',
			value : type
		});
		let keywordInput = $('<input/>',{
			type : 'hidden',
			name : 'keyword',
			value : keyword
		});
		let criteria = {
			cate_id : cateValue,
			subCate_id : subCateValue,
			type : typeInput.value,
			keyword : keywordInput.value
		};
		console.log("카테 : "+criteria.cate_id);
		console.log("서브카테 : "+criteria.subCate_id);
		console.log("타입 : "+criteria.type);
		console.log("키워드 : "+criteria.keyword);
		*/
		
	})
	
	let detailForm = $('#detailForm');
	let memberId = $('input[name="memberId"]').val();
	let bookNoData = $('input[name="bookNo"]').val();
	let price = $('input[name="price"]').val(); // 가격
	let amount = $('input[name="amount"]'); // 수량
	let total = $('input[name="total"]'); // 합계금액
	
	let count = amount.val();
	// 감소
	$('.minus').on('click', function() {
		count--;
		if(count < 1) {
			count =1;
		}
		amount.val(count);
		total.val(price * count);
	});
	
	// 증가
	$('.plus').on('click',function(){
		count++;
		amount.val(count);
		total.val(price * count);
	});
	
	// 장바구니 담기 버튼
	$('.addCart').on('click', function() {
		let cartVO = {
			memberId : memberId,
			bookNo : bookNoData,
			amount : amount.val()
		}		
		cartService.add(cartVO);
	});
	
	
});