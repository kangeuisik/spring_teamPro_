<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<title>memUpdateForm</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
  	$(document).ready(function(){
  		if(${!empty msgType}){
   			$("#messageType").attr("class", "modal-content panel-warning");    
  			$("#myMessage").modal("show");
  		}
  	});
  	
  	function passwordCheck(){
    	var password1=$("#password1").val();
    	var password2=$("#password2").val();
    	if(password1 != password2){
    		$("#passMessage").html("비밀번호가 서로 일치하지 않습니다.");
    	}else{
    		$("#passMessage").html("");
    		$("#pwd").val(password1);
    	}   	
    }
  	
  	function goUpdate() {
		var age=$("#age").val();
		if(age == null || age == "" || age == 0){
			alert("나이를 입력하세요");
			return false;
		}
		document.frm.submit();	// 전송
	}
  </script>
</head>
<body>
	<div class="container">
		<jsp:include page="../layout/header.jsp" />
		<h2>Update</h2>
		<div class="panel panel-default">
			<div class="panel-heading">회원정보 수정</div>
			<div class="panel-body">
				<form name="frm" action="${contextPath}/update.do" method="post">
					<input type="hidden" id="id" name="id" value="${mvo.id}" /> <input
						type="hidden" id="pwd" name="pwd" value="" />
					<table class="table table-bordered"
						style="text-align: center; border: 1px solid; #dddddd;">
						<tr>
							<td style="width: 110px; vertical-align: middle;">아이디</td>
							<td>${mvo.id}</td>
						</tr>
						<tr>
							<td style="width: 110px; vertical-align: middle;">비밀번호</td>
							<td colspan="2"><input id="password1" name="password1"
								onkeyup="passwordCheck()" class="form-control" type="password"
								maxlength="20" placeholder="비밀번호를 입력하세요." /></td>
						</tr>
						<tr>
							<td style="width: 110px; vertical-align: middle;">비밀번호 확인</td>
							<td colspan="2"><input id="password2" name="password2"
								onkeyup="passwordCheck()" class="form-control" type="password"
								maxlength="20" placeholder="비밀번호를 확인하세요." /></td>
						</tr>
						<tr>
							<td style="width: 110px; vertical-align: middle;">이름</td>
							<td colspan="2"><input id="name" name="name"
								class="form-control" type="text" maxlength="20"
								placeholder="이름을 입력하세요." value="${mvo.name}" /></td>
						</tr>
						<tr>
							<td style="width: 110px; vertical-align: middle;">나이</td>
							<td colspan="2"><input id="age" name="age"
								class="form-control" type="number" maxlength="20"
								placeholder="나이를 입력하세요." value="${mvo.age}" /></td>
						</tr>
						<tr>
							<td style="width: 110px; vertical-align: middle;">성별</td>
							<td colspan="2">
								<div class="form-group"
									style="text-align: center; margin: 0 auto;">
									<div class="btn-group" data-toggle="buttons">
										<label
											class="btn btn-primary <c:if test="${mvo.gender eq '남자'}"> active </c:if>">
											<input type="radio" id="gender" name="gender"
											autocomplete="off" value="남자"
											<c:if test="${mvo.gender eq '남자'}"> checked</c:if> /> 남자
										</label> <label
											class="btn btn-primary <c:if test="${mvo.gender eq '여자'}"> active </c:if>">
											<input type="radio" id="gender" name="gender"
											autocomplete="off" value="여자"
											<c:if test="${mvo.gender eq '여자'}"> checked</c:if> /> 여자
										</label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td style="width: 110px; vertical-align: middle;">이메일</td>
							<td colspan="2"><input id="email" name="email"
								class="form-control" type="text" maxlength="20"
								placeholder="이메일을 입력하세요." value="${mvo.email}" /></td>
						</tr>
						<tr>
							<td colspan="3" style="text-align: left;"><span
								id="passMessage" style="color: red"></span><input type="button"
								class="btn btn-primary btn-sm pull-right" value="수정"
								onclick="goUpdate()" /></td>
						</tr>
					</table>
				</form>
			</div>

			<!-- 실패 메세지를 출력(modal) -->
			<div id="myMessage" class="modal fade" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div id="messageType" class="modal-content panel-info">
						<div class="modal-header panel-heading">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">${msgType}</h4>
						</div>
						<div class="modal-body">
							<p>${msg}</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

			<div class="panel-footer"></div>
		</div>
	</div>

</body>
</html>