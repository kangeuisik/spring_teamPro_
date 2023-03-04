console.log('adminService');

$(function(){
	
	// 도서등록 모달창 띄우기
	$('.addBook').on('click', function(){
		//$('.registerBookForm li').not('li:eq(0)').remove(); // 첫번째 li 제외하고 다 지우기
		//LiNumber = 1; // LiNumber 1로 초기화
		//$('#addBookForm form').find('input').val('');
		//$('#addBookForm form').find('.preview').html('');
		$('#addBookForm').modal('show');
	});
	
	// 대분류(#cate1)먼저 선택해야만 -> 소분류(#cate2) 보여지게 하는 거
	$('select[name="bookList[0].cate_id"]').on('change', function(){
		$('select[name="bookList[0].subCate_id"]').find('option').hide(); // 바꿀때 마다 #subCate 옵션 전체 숨김
		let selectedValue = $('select[name="bookList[0].cate_id"] option:selected').val(); // 선택된 값을 selectedValue 변수에 저장
		
		// 소분류 옵션에서 선택된 대분류 포함되어 있는거 찾아서...
		$('select[name="bookList[0].subCate_id"]').find('option[class='+selectedValue+']').each(function(index, item) {
			$(item).toggle(); // 보여주기
		});
		$('select[name="bookList[0].subCate_id"] option:eq(0)').prop("selected", true); // 이전에 선택된거를 맨 첫번째 옵션으로 초기화
	});
	
	// 이미지 파일만 업로드
	$('input[id="attachFile[0]"').on('change', function() {
		if (this.files[0]) {
			let reader = new FileReader(); // 파일읽기 객체
			reader.onload = function(e) { // 파일을 읽으면 이벤트 발생
				let value = e.target.result;
				if (value.startsWith("data:image/")) { // 이미지 파일인 경우
					let imgTag = `<img src="${value}" alt="다운로드 이미지" width="300px" height="350px">`;
					$('input[id="attachFile[0]"').closest('li').find('.preview').html(imgTag);
				} else { // 이미지 파일이 아닌경우
					alert('이미지 파일만 등록하세요');
					$('input[id="attachFile[0]"').val('');
					$('input[id="attachFile[0]"').closest('li').find('.preview').html('');
				}
			}
			reader.readAsDataURL(this.files[0]); // 파일 읽기 메소드 호출
		}
	});
	
	
/* ===========================================폼추가 ================================================================================ */	
	// 폼추가 버튼
	let LiNumber = 1; // 처음 인덱스 값
	$('.addbookLiBtn').on('click', function() {
		if (LiNumber >= 5) {
			alert('더 이상 추가할 수 없음');
			return;
		}
		let bookLi = $('.registerBookForm li').eq(0).clone(); // .clone(true)
		bookLi.find('input').val(''); // input태그 모든값 삭제
		bookLi.find('.preview').html(''); // 미리보기 삭제
		//bookLi.find('.cate_id option:eq(0)').prop("selected", true); // 카테고리 초기화
		
		// input 선택
		let bookImg = bookLi.find('.attachFile'); 
		let bookName = bookLi.find('.bookName'); 
		let author  = bookLi.find('.author'); 
		let publisher = bookLi.find('.publisher'); 
		let cate = bookLi.find('.cate_id'); 
		let subCate = bookLi.find('.subCate_id'); 
		let price = bookLi.find('.price'); 
		
		// name속성 변경
		let I = bookImg.attr("id").replace('0', LiNumber); 
		let B = bookName.attr("name").replace('0', LiNumber); 
		let A = author.attr("name").replace('0', LiNumber); 
		let H = publisher.attr("name").replace('0', LiNumber); 
		let C = cate.attr("name").replace('0', LiNumber); 
		let S = subCate.attr("name").replace('0', LiNumber); 
		let P = price.attr("name").replace('0', LiNumber); 
		
		// 변경한 name속성 설정
		bookImg.attr("id", I); 
		bookName.attr("name", B); 
		author.attr("name", A); 
		publisher.attr("name", H); 
		cate.attr("name", C); 
		subCate.attr("name", S); 
		price.attr("name", P); 
		$('.registerBookForm ul').append(bookLi); // ul태그에 추가
		
		$('.cate_id').on('change', function(){
			let selectedVal = $(this).val(); // 선택된 값
			
			$(this).closest('tr').find('.subCate_id option').each(function(index, item) {
				if($(item).attr('class')==selectedVal){
					$(item).show();		
				} else {
					$(item).hide();
				}
			});
			$(this).closest('tr').find('.subCate_id option').eq(0).prop("selected", true);
			
		});
		
		// 이미지 첨부 할 때 이벤트
		$('input[id="attachFile['+LiNumber+']"]').on('change', function() { // ``로 하니깐 모달닫힘...
			let obj = $(this);
			if (this.files[0]) {
				let reader = new FileReader(); // 파일읽기 객체
				reader.onload = function(e) { // 파일을 읽으면 이벤트 발생
					//hello();
					let value = e.target.result;
					if (value.startsWith("data:image/")) { // 이미지 파일인 경우
						let imgTag = `<img src="${value}" alt="다운로드 이미지" width="300px" height="350px">`;
						obj.closest('li').find('.preview').html(imgTag); // $(this)안되네...
					} else { // 이미지가 아닌경우
						alert('이미지 파일만 등록하세요');
						obj.val('');
						obj.closest('li').find('.preview').html('');
					}
				}
				reader.readAsDataURL(this.files[0]); // 파일 읽기 메소드 호출
			}
		});
		
		LiNumber++; // 인덱스번호 증가
	});
		
	
/* ===================================================================================================================================== */	
	
	// 폼삭제 버튼
	$('.delbookLiBtn').on('click', function() {
		if (LiNumber <= 1) { // 폼이 하나만 있을 때 삭제할 수 없음
			alert('마지막 폼은 삭제할 수 없습니다.');
			return;
		}
		$('.registerBookForm li').eq(LiNumber - 1).remove(); // 마지막폼 삭제
		LiNumber--; // 인덱스 번호 감소
	})
	
	// 도서등록버튼 클릭 이벤트
	$('.registerBookBtn').on('click',function(e){
		e.preventDefault();
		$('.registerBookForm').attr('action',`${contextPath}/admin/registerBook`)
			.attr('method','post')
			.attr('enctype', 'multipart/form-data')
			.appendTo('body')
			.submit();
	});
	
	// 도서상품 삭제버튼
	$('.delBookBtn').on('click', function() {
		let bookNodata = $('input[name="bookNo"]').val(); // 도서상품 번호
		$('#bookDetailForm').attr('method','post')
			.attr('action',`${contextPath}/admin/removeBook?bookNo=`+bookNodata).appendTo('body').submit();
	});
	
	// 카테고리 삭제
	$('.delCate').on('click',function(e){
		e.preventDefault();
		let form = $('<form/>')
		let id = $(this).attr('href')
		form.attr('action',`${contextPath}/admin/delCate?id=`+id).attr('method','post').appendTo('body').submit()
	})
	// 서브 카테고리 삭제
	$('.delsubCate').on('click',function(e){
		e.preventDefault();
		let form = $('<form/>')
		let id = $(this).attr('href')
		form.attr('action',`${contextPath}/admin/delSubCate?id=`+id).attr('method','post').appendTo('body').submit()
	})
	
})

function hello() {
	alert('hello~!');
}
