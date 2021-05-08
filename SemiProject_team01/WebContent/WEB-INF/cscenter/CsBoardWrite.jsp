<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="../css/yh_css/boardTable.css">
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
div.mb-3 > input#boardpwd, input#fk_userid  {
	display:inline-block;
	width:25%;
}
div.mb-3 > select#fk_bigcateno, select#fk_smallcateno {
	width: 30%;
}
</style>
<script>

	$(document).ready(function() {
		$("span.error").hide();
		
		<%-- 사용자가 어떤 카테고리에서 글쓰기 버튼을 눌렀는지. 그에 따라 미리 select의 값을 입력해준다. --%>
		if(${requestScope.fk_bigcateno eq '0'}) { <%-- 사용자가 전체보기에서 글쓰기 버튼을 클릭했을 때 기본으로 '상품문의'가 선택되도록 한다. --%>
			$("select#fk_bigcateno").val("1");
		}else {
			$("select#fk_bigcateno").val("${requestScope.fk_bigcateno}");
		}
		
		<%-- select 값이 변경되었을 때 그에 맞는 소분류카테고리를 읽어오기 위한 이벤트 --%>
		$("select#fk_bigcateno").bind("change", function(){
			//var choice = $(this).val();
			//alert(choice);
			var html = "";
			$.ajax({
				   url:"/SemiProject_team01/cscenter/getSmallCategory.to",
				   type:"GET",
				   data:{"fk_bigcateno" : $(this).val()},
			   	   dataType:"json",
			   	   success:function(json) {
			   		   var html = "";
			   		$.each(json, function(index, item){
			   			if(item.smallcatename == "없음") {
			   				$("select#fk_smallcateno").css("display", "none");
			   			}else {
			   				html += "<option value='"+item.smallcateno+"'>"+item.smallcatename+"</option>";
			   				$("select#fk_smallcateno").css("display", "inline-block");
			   			}
			   		});
			   		
			   		$("select#fk_smallcateno").html(html);
			   	   }, error: function(request, status, error){
					      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				   }
			});
			
			
			
		});
		
		<%-- 비밀번호 정규화 숫자6자리 --%>
		$("input#boardpwd").bind("blur", function() {
			var regExp = /^\d{6}$/i;
			var bool = regExp.test( $(this).val() );
			if( !bool ) {
				$("span.error").show();
				$(this).val("");
				$(this).focus();
			} else {
				$("span.error").hide();
			}
				
		});
		
		<%-- 취소버튼 시 이전 페이지로 이동 --%>
		$("button#btnList").click(function() {
			location.href="javascript:history.back()";
		});
		
		
		
	});
	
	function goRegister() {
		
		<%-- 사용자에게 보여지는 값은 사용자의 이름이지만 DB에 저장하기 위해선 userid가 입력되어야하기 때문에
				 input의 값을 변경해준다. --%>
		$("input#fk_userid").val("${sessionScope.loginuser.userid}");
		
		var frm = document.boardForm;
        frm.action = "<%= request.getContextPath()%>/cscenter/boardRegister.to";      // submit 한 경우이니까... 경로이동시 action을 사용한다.
        frm.method = "post";
        frm.submit();
	}
</script>
<div class="container container_b">

<br><br><h2 align="center">문의 게시판</h2><br><br><br>
<span></span>
			<form name="boardForm" role="form" enctype="multipart/form-data">
				<div class="mb-3">
					<label for="title">카테고리&nbsp;&nbsp;</label>
					<select class="w3-select w3-border selectBig" id="fk_bigcateno" name="fk_bigcateno">
						<option value="1">상품문의</option>
						<option value="2">배송전변경/취소</option>
						<option value="3">배송/교환/반품</option>
						<option value="4">입금확인/입금자변경</option>
					</select>&nbsp;
					<c:if test="${requestScope.fk_bigcateno == '1' || requestScope.fk_bigcateno == '4'}">
						<select class='w3-select w3-border' id='fk_smallcateno' name='fk_smallcateno' style="display:none;">
							<c:forEach var="list" items="${requestScope.boardList}" varStatus="status">
								<option value="${list.cbscvo.smallcateno}">${list.cbscvo.smallcatename}</option>
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${requestScope.fk_bigcateno == '2' || requestScope.fk_bigcateno == '3'}">
						<select class='w3-select w3-border' id='fk_smallcateno' name='fk_smallcateno' style="display:inline-block;">
							<c:forEach var="list" items="${requestScope.boardList}" varStatus="status">
								<option value="${list.cbscvo.smallcateno}">${list.cbscvo.smallcatename}</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
				<div class="mb-3">
					<label for="title">제목</label>
					<input type="text" class="form-control" name="boardtitle" id="boardtitle" placeholder="제목을 입력해 주세요">
				</div>
				<div class="mb-3">
					<label for="reg_id">작성자</label>&nbsp;&nbsp;
					<input type="text" class="form-control" name="fk_userid" id="fk_userid" value = "${sessionScope.loginuser.name}" readonly>
					<label for="reg_id">&nbsp;&nbsp;&nbsp;비밀번호( 숫자 6자 )</label>&nbsp;&nbsp;
					<input type="password" class="form-control" name="boardpwd" id="boardpwd">&nbsp;&nbsp;
					<span style="color:red;"class="error">비밀번호를 입력하세요</span>
				</div>
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="10" name="boardcontent" id="boardcontent" 
					placeholder="1. 주문자명 :&#13;&#10;2. 주문번호/상품명 :&#13;&#10;3. 요청 및 문의사항 :" ></textarea>
				</div>
				<div class="mb-3">
					<label for="reg_id" style="padding-right:15px;">파일</label>
					<input type="file" name="boardfile" id="boardfile">
				</div>
				<br>
			</form>
			<div align="center">
				<button type="button" class="btn btn-outline-secondary " id="btnSave" onclick="goRegister();">등록</button>
				<button type="button" class="btn btn-outline-secondary" id="btnList" >취소</button>
			</div>
</div>
<br><br><br><br>
<jsp:include page="../footer.jsp"/>