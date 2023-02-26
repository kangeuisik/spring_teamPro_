<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp" %>
<%@include file="../layout/bookMenu.jsp" %>
<script src="${contextPath}/resources/js/bookService.js"></script>

<div class="container">
	<div class="jumbotron title">
		<h1>도서 목록</h1>
		<input type="hidden" name="cate_id" value="${cri.cate_id}">
		<input type="hidden" name="subCate_id" value="${cri.subCate_id}">
		카테 : ${cri.cate_id}<br>
		서브 카테 : ${cri.subCate_id}<br>
		타입 : ${cri.type}<br>
		키워드 : ${cri.keyword}<br>
		
	</div>
	
	<!-- 검색기능 -->
	<div>
		<form class="form-inline searchForm">
			<select id="cate" class="form-control mr-2">
				<option value="">====전체=====</option>
				<c:forEach items="${cateList}" var="c">
					<option value="${c.cate_id}" ${cri.cate_id == c.cate_id ? 'selected':'' }>${c.cate_name}</option>
				</c:forEach>			
			</select>
			<select id="subCate" class="form-control mr-2">
				<option value="">====전체=====</option>
				<c:forEach items="${subCateList}" var="s">
					<option value="${s.subCate_id}" ${cri.subCate_id == s.subCate_id ? 'selected':'' }>${s.subCate_name}</option>
				</c:forEach>			
			</select>
			<select id="type" class="form-control mr-2">
				<option value="B" ${cri.type == 'B' ? 'selected':''}>책제목</option>
				<option value="A" ${cri.type == 'A' ? 'selected':''}>저자</option>
				<option value="P" ${cri.type == 'P' ? 'selected':''}>출판사</option>			
			</select>
			<div class="form-group mr-2">
				<input type="search" name="keyword" class="form-control" value="${cri.keyword}">
			</div>
			<div class="form-group mr-2">
				<button type="button" class="btn btn-primary">검색</button>
			</div>
		</form>
	</div>
	
	<!-- 북리스트 : ${bookList}<br> -->
	<div class="bookList">
		<table class="table">
			<thead>
				<tr>
					<th>책 번호</th>
					<th>이미지</th>
					<th>카테고리</th>
					<th>책 제목</th>
					<th>저자</th>
					<th>출판사</th>
					<th>가격</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	
	<!-- 페이징처리 -->
	<div id="pagination"></div>
	
	
</div>

<%@include file="../layout/footer.jsp" %>