<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- ============추가함=========== -->
<c:set var="cateList" value="${applicationScope.cateList}"/>
<c:set var="subCateList" value="${applicationScope.subCateList}"/>
<!-- =========================== -->

<!-- 관리자 메뉴 -->
<div class="adminMenu">
	<div>
		<h3>admin menu</h3>
	</div>
	<ul class="nav flex-column">
		<li class="nav-item">
			<a class="nav-link" href="${contextPath}/admin/book">도서관리</a>
		</li>
	</ul>
	<ul class="nav flex-column">
		<li class="nav-item">
			<a class="nav-link" href="#">회원관리</a>
		</li>
	</ul>
	<ul class="nav flex-column">
		<li class="nav-item">
			<a class="nav-link" href="${contextPath}/admin/category">카테고리관리</a>
		</li>
	</ul>
</div>