<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<style>
form {
	margin:0 38%;
	border: dashed 3px gray;
	border-radius: 20px;
}
input#boardpwd {
	display:inline-block;
	width:50%;
}
</style>

<script>

	$(function() {
		$("span.error").hide();
		
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
	});
	
	function goBoardDetailView() {
		
		$.ajax({
			   url:"/SemiProject_team01/cscenter/boardViewCheckUser.to",
			   type:"post",
			   data:{"boardpwd" : $("input#boardpwd").val(), "boardno" : "${requestScope.boardno}" },
		   	   dataType:"json",
		   	   success:function(json) {
		   		   if(json.n == 1) {
		   				goBoardDetail();
		   		   } else {
		   			   alert("알 수 없는 에러 발생");
		   			   location.href="javascript:location.reload(true)";
		   		   }
		   	   },error: function(request, status, error){
			      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   }
		   	   
		   });// end of ajax--------------------
		
	}
	
	function goBoardDetail() {
		var frm = document.pwdForm;
		frm.action = "<%= request.getContextPath()%>/cscenter/boardDetailView.to";
        frm.method = "post";
        frm.submit();
	}

</script>
<br><br><br>
<h1 align="center" style="font-weight:bold;">고객센터</h1><br><br>
<h2 align="center">문의 게시판</h2><br> <br> 
<form class="pwdForm">
	<div align="center"><br>
		<label for="reg_id" style="padding-bottom: 3px;">비밀번호( 숫자 6자 )</label><br>
		<span style="color:red;"class="error">비밀번호를 입력하세요</span><br><br>
		<input type="password" class="form-control" name="boardpwd" id="boardpwd" style="text-align: center;">&nbsp;&nbsp;
	</div>
	<br>
	<div  align="center">
	<button type="button" class="btn btn-outline-secondary " id="btnSave" onclick="goBoardDetailView();">확인</button>
	</div>
</form>
<jsp:include page="../footer.jsp"/>