<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<script src="${contextPath }/resources/js/takeMaster.js">
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h1 class="title">대여처리(관리자)</h1>
	</div>
	<div class="row">
		<div class="col-3">
			<ul class="list-group">
				<li class="list-group-item">
					<a href="${contextPath}/hope/requestList">비치희망도서 신청현황</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/hope/requestForm">비치희망도서 신청하기</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/hope/requestMaster">도서신청/대여관리(관리자용)</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/book/takeList">도서대여 현황 및 신청</a>
				</li>
			</ul>
		</div>
		<div class="col-9">
			<div>
				<a href="${contextPath }/book/takeMaster" class="btn btn-info mb-3 mr-3">대여관리</a>
				<a href="${contextPath }/hope/requestMaster" class="btn btn-info mb-3 mr-3">신청관리</a>
			</div>
			<div>
				<form  action="${contextPath }/book/takeResult" method="post">
					<table class="table">
						<tr>
							<th>책번호</th>
							<th>책제목</th>
							<th>저자</th>
							<th>출판사</th>
							<th>대여료</th>
							<th>대여신청일</th>
							<th>반납예정일</th>
							<th>상태</th>
							<th>대여인</th>
						</tr>
						<c:forEach items="${ takeMaster}" var="t">
						<tr>
							<td>${t.bookNo }</td>
							<td>${t.bookName }</td>
							<td>${t.author }</td>
							<td>${t.publisher }</td>
							<td>${t.takePrice }</td>
							<td>${t.takeDate }</td>
							<td>${t.returnDate }</td>
							<td>대여신청아이디</td>
							<td>
								<a href="${t.bookName }" class="btn btn-info takeResult" data-toggle="modal" data-target="#result">${t.take }</a>
								<input type="hidden" class="returnDate" value="${t.returnDate }">
								<input type="hidden" class="takePrice" value="${t.takePrice }">	
								<input type="hidden" name="bookNo" value="${t.bookNo }">
							</td>
						</tr>
						</c:forEach>
					</table>
				</form>
				<ul class="pagination">
					<c:if test="${p.prev}">
						<li class="page-item">
							<a class="page-link" href="${p.startPage-1}">이전</a>
						</li>
					</c:if>
					<c:forEach begin="${p.startPage }" end="${p.endPage}" var="pageNum">
						<li class="page-item ${cri.page == pageNum ? 'active':''}">
							<a class="page-link" href="${pageNum}">${pageNum}</a>
						</li>		
					</c:forEach>
					<c:if test="${p.next}">
						<li class="page-item">
							<a class="page-link" href="${p.endPage+1 }">다음</a>
						</li>		
					</c:if>
				</ul>
			</div>	
		</div>
	</div>	
</div>
<!-- 신청대기 누르면 나오는 모달창(관리자) -->
<div class="modal" id="result">
	<div class="modal-dialog">
		<form>
			<div class="modal-content">
				
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">대여</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<ul class="list">
							<h4>대여 책 정보</h4>
						</ul>
						<ul>
							<li>기본 대여기간은 7일</li>
							<li>대여금액은 기본대여기간을 기준으로 1000원</li>
							<li>반납기한 초과시 3일초과시 과금 1000원추가 부과</li>
							<li>최초 책 대여시 대여료 납부</li>
						</ul>
						<table class="table">
							<tr>
								<th>책제목</th>
								<th>반납일시</th>
								<th>대여료</th>
							</tr>
							<tr class="bookName"></tr>
							<tr>
								<td colspan="3">
									거절시 사유 : <input type="text" name="reason" class="reason form-control">
								</td>
							</tr>
							<tr>
								<td colspan="3">위 책을 대여승인하시겠습니까?</td>			 
							</tr>
						</table>
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					
					<button type="button" class="btn btn-primary modal yesResult">승인</button>
					<button type="button" class="btn btn-warning modal noResult">거절</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				</div>
				
			</div>
			<!-- modal-content -->
		</form>
	</div>
</div>


</body>
</html>
<%@ include file="../layout/footer.jsp" %>
<script>
$(function(){
	let typeValue = getSearchParam('type');
	let keywordValue = getSearchParam('keyword');

	//신청페이징처리
	$('.pagination a').on('click',function(e){
		e.preventDefault();
		let pageForm = $('<form>');
		pageForm.empty();
		
		pageForm.attr('method','get')
			.attr('action',`${contextPath}/book/takeMaster`)
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
	
	// 대여 신청 모달창 띄우는거
	$('.takeResult').on('click',function(e){
		e.preventDefault();
		let bookName = $(this).attr('href'); // 이름 가져오고
		
		// td태그 만드는 거
		let content = '<td>'+bookName+'</td>';
		content += '<td>'+returnDate+'</td>';
		content += '<td>'+takePrice+'</td>';
		console.log(content);
		$('.bookName').html(content) // tr안에 추가
					.submit();
		// 신청하기 버튼			
		$('.takeRequest').on('click',function(){
			let bookVO = {
				bookName : bookName, 
				takePrice : takePrice		
			}
			console.log(bookVO);
			takeService.requestTake(bookVO);
			
		})
		//신청시 모달 내부에서 승인값 컨드롤러로 보내기	
		$('.yesResult').on('click',function(){
			let bookN ={
				bookName : bookName,
				takePrice : takePrice	
			};
			takeResultService.yesResult(bookN);
		})
		//신청시 모달 내부에서 거절값 컨드롤러로 보내기
		//거절은 사유도 포함해서 보내기
		$('.noResult').on('click',function(){
			let reason = $('.reason').val();
			let bookR ={
				bookName : bookName,
				reason : reason	
			};
			takeResultService.noResult(bookR);
		})
	});

	
});
</script>
