<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/adminMenu.jsp"%>

<div class="container">
	<div class="jumbotron title">
		<h1>도서 관리</h1>
	</div>
	<!-- 리스트 -->
	<div>
		<c:forEach items="${cateList}" var="c">
			<div class="card mb-2">
				<div class="card-header">
					<a class="nav-link" href="${contextPath}/book/list/${c.cate_id}">${c.cate_name} (${c.cate_id})</a>
				</div>
			<div class="card-body">
				<c:forEach items="${subCate}" var="s">
					<c:if test="${s.cate_id == c.cate_id}">
						<a href="${contextPath}/book/list/${c.cate_id}/${s.subCate_id}">${s.subCate_name} (${s.subCate_id})</a>
						<span class="badge badge-primary badge-pill">${s.count}</span><br>
					</c:if>
				</c:forEach>
			</div>
			</div>
		</c:forEach>
	</div>
</div>

<%@include file="../layout/footer.jsp"%>