<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/adminMenu.jsp"%>

<style>
.categoryList ul {
	text-align: center;
	padding-left: 0;
	list-style: none;
}

.categoryList ul li {
	border: solid 1px;
	width: 400px;
	min-height: 150px;
	margin: 20px;
	float: left;
}
</style>

<!-- Content -->
<div class="container">
	<div class="jumbotron mb-2">
		<h1>도서 관리</h1>
	</div>

	<!-- 등록버튼 -->
	<!-- 
	<button type="button" class="btn btn-primary addBook my-2" data-toggle="modal" data-target="#addBookForm">도서 등록</button>
	 -->
	<button type="button" class="btn btn-primary addBook my-2">도서 등록</button>

	<!-- Board1 -->
	<div class="row mb-2">
		<table class="table">
			<tr>
				<th colspan="3" class="bg-dark text-white"><h3>여기에 뭐하지</h3></th>
			</tr>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>흠흠</th>
			</tr>
			<tr>
				<td>1</td>
				<td>asdaa</td>
				<td>asdaa</td>
			</tr>
			<tr>
				<td>2</td>
				<td>asdxzz</td>
				<td>asdxzz</td>
			</tr>
		</table>
	</div>

	<!-- Board2 -->
	<div class="row mb-2">
		<table class="table">
			<tr>
				<th colspan="3" class="bg-dark text-white"><h3>여기에 뭐하지</h3></th>
			</tr>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>흠흠</th>
			</tr>
			<tr>
				<td>1</td>
				<td>asdaa</td>
				<td>asdaa</td>
			</tr>
			<tr>
				<td>2</td>
				<td>asdxzz</td>
				<td>asdxzz</td>
			</tr>
		</table>
	</div>


	<!-- 카테고리 -->
	<div class="row container categoryList">
		<ul class="categoryList">
			<c:forEach items="${cateList}" var="c">
				<!-- 여기부터 -->
				<li>
					<div style="border-bottom: solid 1px">
						<a class="nav-link" href="${contextPath}/book/list/${c.cate_id}">${c.cate_name} (${c.cate_id})</a>
					</div>

					<div>
						<c:forEach items="${subCate}" var="s">
							<c:if test="${s.cate_id == c.cate_id}">
								<a href="${contextPath}/book/list/${c.cate_id}/${s.subCate_id}">${s.subCate_name} (${s.subCate_id})</a>
								<span class="badge badge-primary badge-pill">${s.count}</span>
								<br>
							</c:if>
						</c:forEach>
					</div>

				</li>
				<!-- 여기까지 -->
			</c:forEach>
		</ul>
	</div>

</div>

<!-- 도서 등록 폼 -->
<div class="modal" id="addBookForm">
	<div class="modal-dialog modal-xl">
		<div class="modal-content container" style="padding: 0;">

			<!-- Modal Header -->
			<div class="modal-header bg-primary text-white">
				<h4 class="modal-title">도서 등록</h4>
				<button type="button" class="close" data-dismiss="modal">닫기</button>
				<button class="btn btn-info addbookLiBtn">폼추가</button>
				<button class="btn btn-danger delbookLiBtn">폼삭제</button>
			</div>

			<!-- Modal body -->
			<div id=" modalBody" class="row modal-body">
				<form class="registerBookForm">
					<ul class="list-group" style="width: 1100px;">
						<li class="list-group-item">
							<div class="row">
								<div class="col-4" style="border: solid 1px;">
									<div id="ImgArea" class="preview"></div>
								</div>
								<div class="col-8">
									<table class="table">
										<!-- 이미지 -->
										<tr>
											<th>이미지</th>
											<td colspan="3">
												<input id="attachFile[0]" type="file" class="form-control attachFile" name="attachFile">
											</td>
										</tr>
										<!-- 책제목 -->
										<tr>
											<th>책 제목</th>
											<td colspan="3">
												<input id="bookName" type="text" class="form-control bookName" name="bookList[0].bookName">
											</td>
										</tr>
										<!-- 저자 -->
										<tr>
											<th>저자</th>
											<td colspan="3">
												<input id="author" type="text" class="form-control author" name="bookList[0].author">
											</td>
										</tr>
										<!-- 출판사 -->
										<tr>
											<th>출판사</th>
											<td colspan="3">
												<input id="publisher" type="text" class="form-control publisher" name="bookList[0].publisher">
											</td>
										</tr>
										<!-- 카테고리 -->
										<tr>
											<th>대분류</th>
											<td>
												<select id="cate1" name="bookList[0].cate_id" class="form-control cate_id">
													<option value="none"">===선택===</option>
													<c:forEach items="${cateList}" var="c">
														<option value="${c.cate_id}">${c.cate_name}</option>
													</c:forEach>
												</select>
											</td>
											<th>소분류</th>
											<td>
												<select id="cate2" name="bookList[0].subCate_id" class="form-control subCate_id">
													<option id="none">===선택===</option>
													<c:forEach items="${subCateList}" var="s">
														<option class="${s.cate_id}" value="${s.subCate_id}" style="display: none;">${s.subCate_name}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<!-- 가격 -->
										<tr>
											<th>가격</th>
											<td colspan="3">
												<input type="text" class="form-control price" name="bookList[0].price" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
											</td>
										</tr>
									</table>								
								</div>
							</div>

						</li>
					</ul>
				</form>
			</div>


			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary registerBookBtn">등록하기</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
			</div>

		</div>
		<!-- modal-content -->
		</form>
	</div>
</div>

<%@include file="../layout/footer.jsp"%>

<script>
	$(function() {
		
		

		/*
		let cnoSet = new Set(); 
		$('.cno_ckbox').on('change', function () {
			let cno = $(this).val();
			let isChecked = $(this).prop('checked')
			if(isChecked){
				console.log(cno + "번 체크");
				cnoSet.add(cno);
			} else {
				console.log(cno + "번 체크 해제");
				cnoSet.delete(cno);
			}
			console.log(cnoSet);
		})
		 */

		/*
		$('.delBtn').on('click', function () {
			if(cnoSet.size<=0){
				alert('삭제할 게시물을 선택하세요');
				return; 
			}
			
			
			let delForm = $('<form/>')
			// 변환 : Set -> 배열 -> 문자열 
			let cnoListStr = Array.from(cnoSet).join();
			alert(cnoListStr);
			delForm.attr('method','post')
				.attr('action','${contextPath}/contact/delSelectedContact?cnoList='+cnoListStr)
				.appendTo('body')
				.submit();
		})
		 */
	});
</script>