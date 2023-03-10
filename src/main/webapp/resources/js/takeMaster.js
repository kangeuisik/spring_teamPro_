let takeResultService={

	//승인
	yesResult : function(bookN){
		$.ajax({
			type : 'post',
			url : `${contextPath}/book/yesUpdate`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(bookN),
			success : function(yesTest) {
				$('.modal').hide();
				alert('승인처리 되었습니다.')
			},
			error : function() {
				alert('실패');			
			}
		});
	},
	//거절 및 사유
	noResult : function(bookR){
		$.ajax({
			type : 'post',
			url : `${contextPath}/book/noUpdate`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(bookR),
			success : function(noTest) {
				$('.modal').hide();
				alert('거절처리 되었습니다.')
			},
			error : function() {
				alert('실패');			
			}
		});
	}

};