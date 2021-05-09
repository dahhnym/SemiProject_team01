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
		
		if(self.name!='reload'){
		      self.name='reload'
		      self.location.reload();
		   } else self.name="";
		
		$("span.error").hide();
		
		<%-- 비밀번호 작성 후 입력창에서 마우스가 벗어나면 정규화에 맞게 값을 입력했는지 확인해줌 --%>
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
				
		}); //$("input#boardpwd").bind("blur", function() {} ---------------------
		
		$("button#btncheck").bind("click", function() {
			
			if(${sessionScope.loginuser.userid eq 'admin'}) {
				var frm = document.pwdForm;
	   			//console.log("확인용 => " + Frm.boardno.value);
	   			frm.action ="<%=request.getContextPath()%>/cscenter/boardDetailView.to";
	   			frm.method="post";
	   			frm.submit();
			} else {
				$.ajax({
				   url:"/SemiProject_team01/cscenter/boardViewCheckUser.to",
				   type:"post",
				   data:{"boardpwd" : $("input#boardpwd").val(), "boardno" : "${requestScope.boardno}" },
			   	   dataType:"json",
			   	   success:function(json) { <%-- 사용자가 입력한 비밀번호와 DB에 저장된 비밀번호가 일치한지 확인 --%>
			   		   if(json.n == 1) {
			   			var frm = document.pwdForm;
			   			//console.log("확인용 => " + Frm.boardno.value);
			   			frm.action ="<%=request.getContextPath()%>/cscenter/boardDetailView.to";
			   			frm.method="post";
			   			frm.submit();
			   		   } else {
			   			   alert("비밀번호가 일치하지 않습니다.");
			   			   location.href="javascript:location.reload(true)";
			   		   }
			   	   },error: function(request, status, error){
				      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				   }
			   	   
			   });// end of ajax--------------------
			}// end of else

		});//$("button#btncheck").bind("click", function() {}---------------------
	});

</script>
<br><br><br>
<h1 align="center" style="font-weight:bold;">고객센터</h1><br><br>
<h2 align="center">문의 게시판</h2><br> <br> 
<form name="pwdForm">
	<div align="center"><br>
		<label for="reg_id" style="padding-bottom: 3px;">비밀번호( 숫자 6자 )</label><br>
		<span style="color:red;"class="error">비밀번호를 입력하세요</span><br><br>
		<input type="password" class="form-control" name="boardpwd" id="boardpwd" style="text-align: center;"/>&nbsp;&nbsp;
	</div>
	<br>
	<div  align="center">
	<button type="button" class="btn btn-outline-secondary " id="btncheck">확인</button>
	</div>
	<input type="hidden" name="boardno" value="${requestScope.boardno}"/>
</form>
<jsp:include page="../footer.jsp"/>