<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h2>대여하기</h2>
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
					<a href="${contextPath }/book/takeList">도서대여 현황</a>
				</li>
				<li class="list-group-item">
					<a href="${contextPath }/book/#">도서대여 신청하기</a>
				</li>
			</ul>
		</div>
		<div class="col-9">
			<div class="my-3">
				<form class="form-inline searchForm">
					<select name="type" class="form-control mr-2 cate">
						<option>선택해주세요</option>
						<option value="BN" ${cri.type == 'BN' ? 'selected':''}>책제목</option>
						<option value="AT" ${cri.type == 'AT' ? 'selected':''}>저자</option>
						<option value="PS" ${cri.type == 'PS' ? 'selected':''}>출판사</option>			
					</select>
					<div class="form-group mr-2">
						<input type="search" class="form-control" name="keyword" value="${cri.keyword}">
					</div>
					<div class="form-group mr-2">
						<button class="btn btn-primary">검색</button>
					</div>
					<div class="form-group mr-2">
						<a href="${contextPath}/book/takeList"  class="btn btn-info">새로고침</a>
					</div>
				</form>		
			</div>
			<div>
				<table class="table">
					<tr>
						<th>책번호</th>
						<th>분류</th>
						<th>제목</th>
						<th>저자</th>
						<th>출판사</th>
						<th>대여여부</th>
					</tr>
					<c:forEach items="${takeList }" var="t">
					<tr>
						<td>${t.bookNo }</td>
						<td>${t.cate_id }</td>
						<td>${t.bookName }</td>
						<td>${t.author }</td>
						<td>${t.publisher }</td>
						<td>
							<a href="${t.bookName }" class="btn btn-info thisTitle" data-toggle="modal" data-target="#addTake">${t.take }</a> 
							<input type="hidden" class="returnDate" value="${t.returnDate }">
							<input type="hidden" class="takePrice" value="${t.takePrice }">	
							<input type="hidden" class="bookNo" value="${t.bookNo }">						
						</td>
					</tr>
					</c:forEach>
				</table>	
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
<!-- 대여누르면 나오는 모달 창 -->
<div class="modal" id="addTake">
	<div class="modal-dialog">
		<form action="${contextPath}/book" method="post">
			<div class="modal-content">
				
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">대여 신청하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<ul class="list">
							<h4>--대여시 알아야할 부분--</h4>
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
				
							<tr class="bookName">
								<td class="a"></td>
								<td></td>
								<td></td>
								
							</tr>
							<tr>
								<td colspan="3">위 책을 대여하시겠습니까?</td>			 
							</tr>
						</table>
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					
					<button class="btn btn-primary">대여신청하기</button>
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

	//페이징처리
	$('.pagination a').on('click',function(e){
		e.preventDefault();
		let pageForm = $('<form>');
		pageForm.empty();
		
		pageForm.attr('method','get')
			.attr('action',`${contextPath}/hope/requestList`)
			.append(getInputHiddenTag('page',$(this).attr('href')))
		if(typeValue !=null && keywordValue != null){
			pageForm.append(getInputHiddenTag('type',typeValue))
				.append(getInputHiddenTag('keyword',keywordValue))
		}
		pageForm.appendTo('body')
			.submit();

	});	//페이징처리
	
	
	
	$('.thisTitle').on('click',function(){

		let bookName = $(this).attr('href');
		let takePrice = $('.takePrice').val();
		let returnDate = $('.returnDate').val();
		console.log(bookName);
		console.log(takePrice);
		console.log(returnDate);
		$('.bookName').find('td .a').append(bookName)
					.next('td').append(returnDate)
					.next('td').append(takePrice)
					.submit();
		
	})
		
		
	
})
</script>