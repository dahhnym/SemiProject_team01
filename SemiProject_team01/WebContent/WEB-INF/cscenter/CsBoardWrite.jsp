<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<div class="container container_b">

<br><br><h2 align="center">문의 게시판</h2><br><br><br>

			<form name="form" id="form" role="form" method="post" action="${pageContext.request.contextPath}/board/saveBoard">


				<div class="mb-3">
					<label for="title">카테고리</label>
					<select class="w3-select w3-border" name="option">
						<option value="1">상품문의</option>
						<option value="2">배송전변경/취소</option>
						<option value="3">배송/교환/반품</option>
						<option value="4">입금확인/입금자변경</option>
					</select>
				</div>
				<div class="mb-3">
					<label for="title">제목</label>
					<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
				</div>
				<div class="mb-3">
					<label for="reg_id">작성자</label>
					<input type="text" class="form-control" name="reg_id" id="reg_id" placeholder="이름을 입력해 주세요">
				</div>
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="10" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
				</div>
				<div class="mb-3">
					<label for="reg_id" style="padding-right:15px;">파일</label>
					<input type="file" name="file" id="file">
				</div>
				<div class="mb-3">
					<label for="reg_id">비밀번호</label>
					<input type="password" class="form-control" name="passwd" id="passwd">
				</div>
				<br><br><br>
			</form>
			<div align="center">
				<button type="button" class="btn btn-sm btn-primary" id="btnSave">등록</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList">취소</button>
			</div>
</div>
<br><br><br><br>
<jsp:include page="../footer.jsp"/>