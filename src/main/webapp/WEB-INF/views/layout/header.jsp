<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js" integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="${contextPath }/resources/css/style.css">
<script src="${contextPath}/resources/js/main.js"></script>
<script src="${contextPath}/resources/js/bookMenu.js"></script>
<script src="${contextPath}/resources/js/adminService.js"></script>
<script>
	const contextPath = "${contextPath}"
</script>
<style type="text/css">
.footer img{ 
	width: 100%;
	margin: auto;
    display: block;}
</style>


</head>
<body>
 <div class="container">
	<div class=" row mt-2">
	  <div class="container col-3 ">
	  	<a>------</a>
	  </div>
	  <div class="TopLogo col-6">
	  	<a href="${contextPath }/main">
	  		<img style="margin: auto; display: block;" alt="" src="${contextPath }/resources/images/상단로고.png">
	  	</a>
	  </div>
	  <div class=" col-3 ">
	 	 <h5>
	 	 	<a href="#" class="badge badge-light">로그인하기</a>
	 	 	<a href="#" class="badge badge-light">회원가입하기</a>
	 	 </h5>
	  	
	  </div>
	</div>
</div>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-light navbar-dark banner">
	  <a class="navbar-brand text-body" href="${contextPath }/main">
	 	<img alt="" src="${contextPath }/resources/images/도서로고.png">
	 	</a>
	  <!-- 메뉴얼 -->    
	  	<li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle topMenu text-body" href="#" id="navbardrop" data-toggle="dropdown">
	       공지 및 문의(게시판류)
	      </a>
	      <div class="dropdown-menu ">
	      	<a class="dropdown-item" href="${contextPath }/board/list">전체</a>
	        <a class="dropdown-item" href="${contextPath }/board/list/notice">공지</a>
	        <a class="dropdown-item" href="${contextPath }/board/list/question">문의(배송,환불등등)</a>
	        <a class="dropdown-item" href="${contextPath }/board/list/etc">기타게시판</a>
	        <a class="dropdown-item" href="${contextPath }/board/list/review">도서리뷰게시판</a>
	      </div>
	    </li>
	<!-- 메뉴얼 -->
	    <li class="nav-item dropdown" >
	      <a class="nav-link dropdown-toggle topMenu text-body" href="#" id="navbardrop" data-toggle="dropdown">
	        도서쇼핑
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="${contextPath }/book/home">도서쇼핑홈</a>
	        <a class="dropdown-item" href="#">쇼핑--2</a>
	        <a class="dropdown-item" href="#">쇼핑--3</a>
	      </div>
	    </li>
	<!-- 메뉴얼 -->    
	  	<li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle topMenu text-body" href="#" id="navbardrop" data-toggle="dropdown">
	        대여 및 신청란
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="${contextPath }/hope/requestMaster">대여/도서신청 관리</a>
	        <a class="dropdown-item" href="${contextPath }/hope/requestList">비치 희망도서 신청현황</a>
	        <a class="dropdown-item" href="${contextPath }/hope/requestForm">비치 희망도서 신청하기</a>
	        <a class="dropdown-item" href="#">도서 대여하기</a>
	        <a class="dropdown-item" href="#">도서 대여 신청하기</a>
	        

	      </div>
	    </li>
	<!-- 메뉴얼 -->
	    <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle topMenu text-body" href="#" id="navbardrop" data-toggle="dropdown">
	        관리자페이지
	      </a>
	      <div class="dropdown-menu ">
	        <a class="dropdown-item" href="#">회원정보관리</a> <!-- 글쓰기 -->
	        <a class="dropdown-item" href="#">---2</a>
	        <a class="dropdown-item" href="#">---3</a>
	      </div>
		</li>
	</nav>	
</div>