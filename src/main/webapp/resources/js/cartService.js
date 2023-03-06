let cartService = {
	
	// 장바구니 상품 목록
	list : function(memberId) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/sample/cartList?id=`+memberId,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(memberId),
			
			success : function(map) {
				cartListRender(map);
			},
			error : function() {
				alert('실패')	;			
			}
		}); 
	},
	
};

function cartListRender(map) {
	let output = '';
	for(let c of map.cartList) {
		output +=`
		<div>
			카트넘버 : ${c.cartNo}, 회원아이디 : ${c.cartNo}, 책번호 : ${c.cartNo}, 수량 : ${c.cartNo}<br>
		</div>`;
	}
	$('.cartList').html(output);
	
}

$(function() {
	
	// 회원 아이디로 장바구니 조회
	let memberId = $('input[name="memberId"]').val();
	cartService.list(memberId);

});