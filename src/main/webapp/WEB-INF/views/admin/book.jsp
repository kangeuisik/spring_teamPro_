<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/adminMenu.jsp"%>

<div class="container">
	<div class="jumbotron title">
		<h1>도서 관리</h1>
	</div>
	<div>
		<c:forEach items="${cateList}" var="c">
			<div class="card mb-2">
				<div class="card-header">
					<span class="float-left">${c.cate_name} (${c.cate_id})</span>
				</div>
				<div class="card-body">
					<c:forEach items="${subCateList}" var="s">
						<c:if test="${s.cate_id == c.cate_id}">
							<span class="float-left"> ${s.subCate_name} (${s.subCate_id}) </span><br>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<%@include file="../layout/footer.jsp"%>