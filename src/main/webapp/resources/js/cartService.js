let cartService = {
	
	// 장바구니 상품 목록
	list : function(memberId) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/cart/list`,
			data : {memberId : memberId},
			
			success : function(cartList) {
				cartListRender(cartList);
			},
			
			error : function() {
				alert('실패')	;			
			}
		}); 
	},
	
	// 빼기
	minus : function(cartVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/cart/modifyCount`,
			data : cartVO,
			success : function(cartVO) {
				cartService.list(cartVO.memberId);
			},
			
			error : function() {
				alert('실패')		
			}
		});
	},
	
	// 더하기
	plus : function(cartVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/cart/modifyCount`,
			data : cartVO,
			
			success : function(result) {
				cartService.list(cartVO.memberId);
			},
			error : function() {
				alert('실패')		
			}
		});
	},
	
	// 장바구니 담기
	add : function(cartVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/cart/add`,
			data : cartVO,
			
			success : function(result) {
				alert(result)	
				$('#myModal').modal('show');
			},
			error : function() {
				alert('실패')		
			}
		});
	},
	
	// 삭제
	remove : function(cartVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/cart/remove`,
			data : cartVO,
			
			success : function(result) {
				alert(result)
				cartService.list(cartVO.memberId);
			},
			error : function() {
				alert('실패')		
			}
		});
	},
	
};

function cartListRender(cartList) {
	let output = '';
	for(let c of cartList) {
		output +=
		`<tr>
			<input type="hidden" name="cartId" value="${c.cartId}">
			<input type="hidden" name="bookNo" value="${c.bookNo}">
			<input type="hidden" name="price" value="${c.bookVO.price}">
			<td>${c.bookNo}</td>
			<td><img src="${contextPath}/fileDownload?path=book/${c.bookVO.cate_id}/${c.bookVO.subCate_id}/&no=${c.bookNo}&imageFileName=${c.bookVO.bookImage}" width="40px" height="40px"></td>
			<td>[${c.bookVO.cate_id}/${c.bookVO.subCate_id}] <a href="${contextPath}/book/detail?bookNo=${c.bookNo}">${c.bookVO.bookName}</a></td>
			<td>${c.bookVO.price}</td>
			<td>
				<div class="calc">
					<button type="button" class="decrease_amount">-</button>
					<input type="number" name="amount" value="${c.amount}" readonly="readonly" style = "width: 50px">
					<button type="button" class="increase_amount">+</button>
				</div>
			</td>
			<td>
				<div class="result">
					<input type="hidden" name="totalPrice" value="${c.bookVO.price * c.amount}">
					${c.bookVO.price * c.amount}
				</div>
			</td>
			<td>
				<button type="button" class="btn btn-secondary delCart">삭제</button>
			</td>
		</tr>`
	}
	$('.cartList tbody').html(output);
	
	let memberId = $('input[name="memberId"]').val();
	let cartIdObj = $('input[name="cartId"]');
	let bookNoObj = $('input[name="bookNo"]');
	
	let priceObj = $('input[name="price"]');
	let amountObj = $('input[name="amount"]');
	let totalPrice = $('input[name="totalPrice"]');
	let sum = $('input[name="sum"]');
	
	// 합계
	let i = 0;
	$(totalPrice).each(function(index, item) {
		let value = $(item).val();
		i += parseInt(value);
	});
	sum.val(i);
	$('.sum span').html(sum.val());
	
	// -버튼
	$('.decrease_amount').on('click', function(){
		let cartId = $(this).closest('tr').find(cartIdObj).val();
		let amountVal = $(this).closest('tr').find(amountObj).val();
		let amount = parseInt(amountVal);
		
		if (amount > 1) {
			amount--;
		}
		
		let cartVO = {
			memberId : memberId,
			cartId : cartId,
			amount : amount
		}		
		cartService.minus(cartVO);
	});
	
	// +버튼
	$('.increase_amount').on('click', function(){
		let cartId = $(this).closest('tr').find(cartIdObj).val();
		let amountVal = $(this).closest('tr').find(amountObj).val();
		let amount = parseInt(amountVal);
		
		amount++;
		
		let cartVO = {
			memberId : memberId,
			cartId : cartId,
			amount : amount
		}		
		cartService.plus(cartVO);
	});
	
	// 삭제버튼
	$('.delCart').on('click', function(){
		let cartId = $(this).closest('tr').find(cartIdObj).val();
		
		let cartVO = {
			memberId : memberId,
			cartId : cartId,
		}	
		cartService.remove(cartVO);
	});
	
}

$(function() {
	
	// 회원아이디 값
	let memberId = $('input[name="memberId"]').val();
	
	// 회원 아이디로 장바구니 조회
	cartService.list(memberId);
	
	// 주문 버튼 클릭 이벤트
	$('.orderBtn').on('click', function(){
		alert('결제 페이지로 이동')
	})
});