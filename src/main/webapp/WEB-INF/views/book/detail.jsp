<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/bookMenu.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:formatDate var="regDate" pattern = "yyyy-MM-dd" value="${detail.regDate}"/>
<script src="${contextPath}/resources/js/bookService.js"></script>

<style>
#ImgArea {
	border: 1px solid black;
}
</style>

<div class="container">
	<!-- Title -->
	<div class="jumbotron title">
		<h1>상세 페이지</h1>
		<input type="hidden" name="cate_id" value="${cri.cate_id}"> <input type="hidden" name="subCate_id" value="${cri.subCate_id}">
		크리 : ${cri}
		크리테리아 : ${criteria}
	</div>
	
	<!-- Content -->
	<form id="bookDetailForm">
	<!-- 회원아이디 -->
	<input type="hidden" name="memberId" value="kim"> <!-- value="${auth.id}" -->
		<div class="row">
			<!-- BookImage -->
			<div id="ImgArea" class="col-6">
				<img src="${contextPath}/bookImgDisplay?category=${detail.cate_id}/${detail.subCate_id}&no=${detail.bookNo}&imageFileName=${detail.bookImage}">
			</div>
			<div class="col-6">
				<!-- BookInfo -->
				<table class="table">
					<thead>
						<tr>
							<th>책 제목</th>
							<td colspan="3">${detail.bookName}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>저자</th>
							<td>${detail.author}</td>
							<th>출판사</th>
							<td>${detail.publisher}</td>
						</tr>
						<tr>
							<th>카테고리</th>
							<td colspan="3">
								<input type="hidden" name="cate_id" value="${detail.cate_id}">
								<input type="hidden" name="subCate_id" value="${detail.subCate_id}">
								${detail.cate_id} / ${detail.subCate_id}
								</td>
						</tr>
						<tr>
							<th>책번호</th>
							<td>
								<input type="hidden" name="bookNo" value="${detail.bookNo}">
								${detail.bookNo}
							</td>
							<th>등록일</th>
							<td>${regDate}</td>
						</tr>
						<tr>
							<th>가격</th>
							<td colspan="3">
								<input type="hidden" name="price" value="${detail.price}">
								${detail.price}
							</td>
						</tr>
					</tbody>
				</table>
				
				<!-- Calculator -->
				<div>
					<div class="row">
						<div class="col-6">
							<b>수량</b><br>
							<button type="button" class="minus">-</button>
							<input type="number" name="amount" value="1" readonly="readonly">
							<button type="button" class="plus">+</button>
						</div>
						<div class="col-6">
							<b>총 금액</b><br>
							<input type="number" name="total" value="${detail.price}" readonly="readonly">
							<b>원</b>
						</div>
					</div>
				</div>
	
				<!-- Button -->
				<div>
					<div>
						<div class="row">
							<button type="button" class="btn btn-danger my-2 buy">바로구매</button>
						</div>
						<div class="row">
							<button type="button" class="btn btn-primary addCart">장바구니담기</button>
						</div>
					</div>
					<div>
						<div>
							<button type="button" class="btn btn-info toBookList">목록</button>
							<button type="button" class="btn btn-success modifyBookBtn">수정</button>
							<button type="button" class="btn btn-secondary delBookBtn">삭제</button>
						</div>
						<div class="modifyMod">
							<button type="button" class="btn btn-primary modify">수정완료</button>
							<button type="button" class="btn btn-danger cancel">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 모달창 -->
<div class="modal" id="myModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- Modal body -->
			<div class="modal-body">
				<a class="nav-link" href="${contextPath}/cart/cartPage">장바구니 페이지로 가기</a>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<%@include file="../layout/footer.jsp"%>