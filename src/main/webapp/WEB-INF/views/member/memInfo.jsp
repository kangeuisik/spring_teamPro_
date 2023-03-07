<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../layout/header.jsp" %>
    <%@include file="../layout/adminMenu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div class="jumbotron">
		<h2>회원관리</h2>
	</div>
	<div class="contatiner">
		<table class="table">
			<tr>
				<th>프로필</th>			
				<th>회원번호</th>
				<th>아이디</th>
				<th>이메일</th>
				<th>이름</th>
				<th>성별</th>	
			</tr>
			<c:forEach items="${memberInfo }" var="m">
			<tr>
				<td>${m.profile }</td>
				<td>${m.mno }</td>
				<td>${m.id }</td>
				<td>${m.email }</td>
				<td>${m.name }</td>
				<td>${m.gender }</td>
			</tr>
			</c:forEach>	
		</table>
		
	</div>
</div>
</body>
</html>
<%@include file="../layout/footer.jsp" %>