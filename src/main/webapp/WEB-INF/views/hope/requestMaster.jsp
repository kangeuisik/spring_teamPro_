<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h1 class="title">신청처리(관리자)</h1>
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
			<div class="d-flex">
				<button data-toggle="collapse" data-target="#demo" class="btn btn-info mb-3 mr-3">신청관리</button>
				<button data-toggle="collapse" data-target="#demoA" class="btn btn-info mb-3">대여관리</button>
			</div>
			<div id="demo" class="collapse mt-5">
				- 신청 거절시 사유 필히 작성
				<form  action="${contextPath }/hope/requestResult" method="post">
					<table class="table">
						<tr>
							<th>신청번호</th>
							<th>책제목</th>
							<th>저자</th>
							<th>출판사</th>
							<th>신청인</th>
							<th colspan="2">승인/거절</th>
							<th>*비고</th>
						</tr>
						<c:forEach items="${ requestMaster}" var="r">
						<tr class="etcTd">
							<td>${r.rno }</td>
							<td>${r.nbookName }</td>
							<td>${r.nbookWriter }</td>
							<td>${r.npublisher }</td>
							<td>${r.mid }</td>
							<td> 
			 					<input type="checkbox" name="goResult_ck" class="form-control resultGo_ckbox" value="${r.rno }">
							</td>
							<td>
			 					<input type="checkbox" name="noResult_ck" class="form-control resultNo_ckbox" value="${r.rno }">
			 				</td>
			 				<!-- 
							<td>
								<input type="text" name="etc" class="etc" >
							</td>
							-->
						</tr>
						</c:forEach>
					</table>
					<button class="btn btn-info mb-3">결과전송</button>
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
			
			<!-- ===========================대여관리============================= -->	
			<div id="demoA" class="collapse mt-5">
				<form  action="${contextPath }#" method="post">
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
						${takeList }
						<c:forEach items="${ takeList}" var="t">
						<tr>
							<td>${t.bookNo }</td>
							<td>${t.bookName }</td>
							<td>${t.author }</td>
							<td>${t.publisher }</td>
							<td>${t.takePrice }</td>
							<td>${t.takeDate }</td>
							<td>${t.returnDate }</td>
							<td>${t.take }</td>
							<td>대여신청아이디</td>
						</tr>
						</c:forEach>
					</table>
					<button class="btn btn-info mb-3">결과전송</button>
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
	
	let GoResultSet = new Set(); 
	let NoResultSet = new Set();
	
	//승인
	$('.resultGo_ckbox').on('change',function(){ //셀렉 이벤트
		let goResult = $(this).val(); //위 클래스의 밸류값.
		let checkOn	= $(this).prop('checked'); //
		let etc = $(this).closest('td').next('td').next('td');
			if(checkOn){//승인을 체크하면
				GoResultSet.add(goResult+'체크');
				etc.remove(); //승인을 체크하면 비고란을 쓸수 없게
				$(this).closest('tr').find('.resultNo_ckbox') //두항목 모두 체크하지 못하게 막아놓기 하나만 체크할수있게
					.prop("checked",false).prop("disable",false);
			}else{// 다시 체크해제 했다면	
				GoResultSet.delete(goResult);
			 }
		console.log(GoResultSet);
	})//resultGo
	
	//거절
	$('.resultNo_ckbox').on('change',function(){
		let noResult = $(this).val(); //위 클래스의 밸류값.
		let checkOn	= $(this).prop('checked'); //
		let etc = $(this).closest('td').next('td');
			if(checkOn){
				NoResultSet.add(noResult+'체크');
				etc.remove();
				$(this).closest('tr').append("<td><input type='text' name='etc' class='etc' ></td>")
				$(this).closest('tr').find('.resultGo_ckbox')
					.prop("checked",false).prop("disable",false);
			}else{//체크해제 한다면
				NoResultSet.delete(noResult);
				etc.remove();
			}
		console.log(NoResultSet);
	})//resultNo

	
		
	
})
</script>
