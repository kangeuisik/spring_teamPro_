<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../layout/header.jsp" %>
<div class="container">
	<div class="container topMenu mt-3 mb-3 ">
	  <div class="card">
	  <h2>이미지 파일</h2>
	    <div class="card-body">
	      <h4 class="card-title">Card title</h4>
	      <p class="card-text">Some example text. Some example text.</p>
	      <a href="#" class="#">제 목</a>
	      <a href="#" class="#">공지, 베스트셀러추천, 회원들이가장많이 찾아본글
	      	기타 관리자가 지정한글</a>
	    </div>
	  </div>
	</div>
	<div class="row">
		<div class="col-8 d-flex justify-content-between mb-3">
			<div class="d-inline-flex p-3 bg-light text-dark">
				<a href="${contextPath }/board/list" class="contatiner text-center">
					<img src="${contextPath }/resources/images/전체게시판.png" class="rounded-circle" alt="" width="100" height="80"><br>
					전체게시판
				</a> 
			</div>
			<div class="d-inline-flex p-3 bg-light text-dark">
				<a href="${contextPath }/board/list" class="contatiner text-center">
					<img src="${contextPath }/resources/images/도서신청.png" class="rounded-circle" alt="" width="100" height="80"><br>
					도서신청하기
				</a> 
			</div>
			<div class="d-inline-flex p-3 bg-light text-dark">
				<a href="#" class="contatiner text-center">
					<img src="${contextPath }/resources/images/회원가입 바로가기.png" class="rounded-circle" alt="" width="100" height="80"><br>
					회원가입하기
				</a> 
			</div>
			<div class="d-inline-flex p-3 bg-light text-dark">
				<a href="#" class="contatiner text-center">
					<img src="${contextPath }/resources/images/도서쇼핑하기.png" class="rounded-circle" alt="" width="100" height="80"><br>
					도서쇼핑
				</a> 
			</div>
		</div>	<!-- col-8 end-->
		<div class="col-4"  >
			<div class="container" >
				  <ul class="nav nav-tabs" role="tablist">
				    <li class="nav-item">
				      <a class="nav-link active" data-toggle="tab" href="#home">공지사항</a>
				    </li>
				    <li class="nav-item">
				      <a class="nav-link" data-toggle="tab" href="#menu1">도서리뷰</a>
				    </li>
				    <li class="nav-item">
				      <a class="nav-link" data-toggle="tab" href="#menu2">기타게시판</a>
				    </li>
				  </ul>
			</div> 
			<div class="tab-content">
			    <div id="home" class="container tab-pane active"><br>
			      <table class="table">
			      	<tr>
			      		<td>
			      		<a href="#">공지게시글제목</a>
			      		</td>
			      		<td>작성자</td>
			      	</tr>
			      </table>
			    </div>
			    <div id="menu1" class="container tab-pane fade"><br>
			      <table class="table">
			      	<tr>
			      		<td>
			      		<a href="#">도서리뷰글제목</a>
			      		</td>
			      		<td>작성자</td>
			      	</tr>
			      </table>		    </div>
			    <div id="menu2" class="container tab-pane fade"><br>
			      <table class="table">
			      	<tr>
			      		<td>
			      		<a href="#">기타게시글제목</a>
			      		</td>
			      		<td>작성자</td>
			      	</tr>
			      </table>
			    </div>
			</div>
		</div> <!-- col-4 end-->	
	</div><!-- row end -->
	<div class="row">
		<div class="col-8">
			<table>
				<tr>
					<th>sdfadsafdsafsdafdsfadsafdasfasdfasdf</th>
				</tr>
			</table>
		</div><!-- col-8 end-->
		<div class="col-4">
		
		</div><!-- col-4 end-->
	</div><!-- row end -->


</div>
<%@include file="../layout/footer.jsp" %>