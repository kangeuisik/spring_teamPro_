console.log('adminService');

$(function(){
	
	// 카테고리 삭제
	$('.delCate').on('click',function(e){
		e.preventDefault()
		let form = $('<form/>')
		let id = $(this).attr('href')
		form.attr('action',`${contextPath}/admin/delCate?id=`+id)
			.attr('method','post')
			.appendTo('body')
			.submit()
	})
	
	// 서브 카테고리 삭제
	$('.delsubCate').on('click',function(e){
		e.preventDefault()
		let form = $('<form/>')
		let id = $(this).attr('href')
		form.attr('action',`${contextPath}/admin/delSubCate?id=`+id)
			.attr('method','post')
			.appendTo('body')
			.submit()
	})
})