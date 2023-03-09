<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- ============추가함=========== -->
<c:set var="cateList" value="${applicationScope.cateList}" /> <!--상위 대분류 언어,정보... -->
<c:set var="subCateList" value="${applicationScope.subCateList}" /> <!--일본어 영어 등등.. -->
<c:set var="cate" value="${applicationScope.cate}" />
<c:set var="subCate" value="${applicationScope.subCate}" />
<!-- =========================== -->

<!-- 관리자 메뉴 -->
<div class="adminMenu container">
	<div>
		<nav class="navbar navbar-expand-sm bg-light">
			<i class="fas fa-bars"></i>
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="${contextPath}/member/memInfo">회원정보관리</a>
				</li>
			</ul>
			<ul class="navbar-nav">
				<li class="nav-item active dropdown"><!-- 도서관리자에 커서올리면 -->
					<a class="nav-link" href="${contextPath}/admin/book">도서관리자</a>
					<div class="dropdown-menu"> <!-- IT, 언어, 예술...-->
					<!--  -->	<c:forEach items="${cateList}" var="c">
					${c.cate_id}
						<!-- 
						<div class="active dropdown dropright "> 
							<a class="dropdown-item" href="${contextPath}/book/list/${c.cate_id}">${c.cate_name}</a>
						</div> 
						-->
						</c:forEach>	
					</div>
				</li>
			</ul>
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="${contextPath}/admin/category">카테고리관리</a>
				</li>
			</ul>
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="${contextPath}/hope/requestMaster">도서대여/도서신청 관리</a>
				</li>
			</ul>
		</nav>
	</div>
</div> <!-- bookmenu end -->
<div class="adminMenu container">
	<div>
		<nav class="navbar navbar-expand-sm bg-light">
			<i class="fas fa-bars"></i>
			<c:forEach items="${cate}" var="c">
				<ul class="navbar-nav">
					<li class="nav-item dropdown dropright">
						<a class="nav-link" href="${contextPath}/book/list/${c.cate_id}">${c.cate_name}
						<span class="badge badge-primary badge-pill">${c.count}</span></a>
						<div class="dropdown-menu">
							<c:forEach items="${subCate}" var="s">
								<c:if test="${s.cate_id == c.cate_id}">
									<a href="${contextPath}/book/list/${c.cate_id}/${s.subCate_id}">${s.subCate_name}</a>
									<span class="badge badge-primary badge-pill">${s.count}</span>
									<br>
								</c:if>
							</c:forEach>
						</div>
					</li>
				</ul>
			</c:forEach>
		</nav>
	</div>
</div> <!-- bookmenu end -->

