//ajax
let takeService ={
	requestTake : function(bookVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/book/take`, 
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(bookVO),
			success : function(test) {
				alert("책 "+bookVO.bookName+"신청이 완료되었습니다. 대여료는 "
				+ bookVO.takePrice + "입니다. 책 수령시 납부 부탁드립니다.")
				$('.modal').hide();
			},
			error : function() {
				alert('실패')	
			}
		})	
	}
};
$(function(){
	let typeValue = getSearchParam('type');
	let keywordValue = getSearchParam('keyword');

	//페이징처리
	$('.pagination a').on('click',function(e){
		e.preventDefault();
		let pageForm = $('<form>');
		pageForm.empty();
		
		pageForm.attr('method','get')
			.attr('action',`${contextPath}/book/takeList`)
			.append(getInputHiddenTag('page',$(this).attr('href')))
		if(typeValue !=null && keywordValue != null){
			pageForm.append(getInputHiddenTag('type',typeValue))
				.append(getInputHiddenTag('keyword',keywordValue))
		}
		pageForm.appendTo('body')
			.submit();
	});	//페이징처리
	
	
	let takePrice = $('.takePrice').val();
	let returnDate = $('.returnDate').val();
	
	// 대여 신청 모달 화면
	$('.thisTitle').on('click',function(e){
		e.preventDefault();
		let bookName = $(this).attr('href'); // 이름 가져오고
		// td태그 삽입
		let content = '<td>'+bookName+'</td>';
			content += '<td>'+returnDate+'</td>';
			content += '<td>'+takePrice+'</td>';
		$('.bookName').html(content) // tr내부에 삽입
					.submit();
		// 신청하기 버튼 이벤트			
		$('.takeRequest').on('click',function(){
			let bookVO = {
				bookName : bookName, 
				takePrice : takePrice		
			}
			takeService.requestTake(bookVO);
		})
	})
	$('.thisTitle').on('click',function(){
		let take = $(this).attr('id');
		let reason = $(this).attr('title');
		let howDay = $(this).attr('target');
		let reject = '<td>'+reason+'</td>';
		let returnDate = '<td>반납예정일 : '+howDay+'</td>';
		if(take=='대여가능'){
			$('#addTake').show();
		}else if(take=='신청대기'){
			$('#wait').show();
		}else if(take=='거절'){
			$('#reject').show();
			$('.rejectReason').html(reject) // 거절사유추가
					.submit();	
		}else if(take=='대여중'){
			$('#ing').show();
			$('.howDay').html(returnDate) // 반납예정일 명시
					.submit();
		}
	})
	
	// Modal 닫기
	$('.close, .modal_close').click(function(){
		$('.modal').hide();
	})
});