<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- ============추가함=========== -->
<c:set var="cateList" value="${applicationScope.cateList}"/>
<c:set var="subCateList" value="${applicationScope.subCateList}"/>
<!-- =========================== -->

<!-- 도서 메뉴 -->
<div class="bookMenu">
	<div>
		<h3>book menu</h3>
	</div>
	<ul class="nav flex-column">
		<li class="nav-item">
			<a class="nav-link" href="book/home">도서 홈</a>
		</li>
	</ul>
	<c:forEach items="${cateList}" var="c">
		<ul class="nav flex-column">
			<li class="nav-item dropdown dropright">
				<a class="nav-link" href="book/list" cateId="${c.cate_id}">${c.cate_name}</a>
				<div class="dropdown-menu">
					<c:forEach items="${subCateList}" var="s">
						<c:if test="${c.cate_id eq s.cate_id}">
							<a class="dropdown-item" href="book/list" cateId="${c.cate_id}" subCateId="${s.subCate_id}">${s.subCate_name}</a>
						</c:if>
					</c:forEach>
				</div>
			</li>
		</ul>
	</c:forEach>
</div>