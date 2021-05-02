<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="../css/login.css"/>

<script type="text/javascript">		//*엔터키 정정사항
	var bool = false;
	
	$(function(){
		$("span.confirm").hide();
		
		$("button#changePwd").on("click","",function(){
			goConfirm();
			$("input").blur(function(){
				goConfirm();
			});
			
			if(bool) {
				var frm = document.registerFrm;
				frm.action="changePwd.to";
				frm.method="POST";
				frm.submit();
			}	
		});
		
		$("button#laterChangePwd").click(function(){
			goConfirm();
			
			if(bool) {
				$("input#userid").html("${sessionScope.loginuser.userid}");
				
				var frm = document.registerFrm;
				frm.action="home.to";
				frm.method="POST";
				frm.submit();
			}
		});

	});// end of $(function() ------------------------------------------------------------
	
			
	function goConfirm() {	// 비밀번호 변경을 누른 경우		
		
		// 현재 비밀번호 입력란 체크
		var currentPwd = $("input#currentPwd").val();
		if(currentPwd==""){
			$("div#currentPwd").show();
			$("div#currentPwd").html("비밀번호를 입력해주세요.");
			bool=false;
			return;
		} else if(currentPwd!="${sessionScope.loginuser.pwd}"){
				$("div#currentPwd").show();
				$("div#currentPwd").html("현재 비밀번호와 다릅니다. 다시 입력해주세요.");
				bool=false;
				return;
		} else {
			$("div#currentPwd").hide();
			bool=true;
		}
		
		// 변경 비밀번호란 체크
		var newPwd1 = $("input#newPwd1").val();
		if(newPwd1==""){
			$("div#newPwd1").show();
			$("div#newPwd1").html("변경할 비밀번호를 입력해주세요.");
			bool=false;
			return;
		} else {
			// 비밀번호 8-15자리, 영문자,숫자,특수기호 혼합 정규표현식
			var regExp= /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			var bool = regExp.test(newPwd1);
			if(!bool){
				$("div#newPwd1").show();
				$("div#newPwd1").html("비밀번호는 8-15자리의 영문자, 숫자, 특수기호를 혼합해야 합니다.");
				bool=false;
				return;
			} else {
				$("div#newPwd1").hide();
				bool=true;
			}
		}
		
		// 변경 비밀번호 확인란 체크
		var newPwd2 = $("input#newPwd2").val();
		if(newPwd2==""){
			$("div#newPwd2").show();
			$("div#newPwd2").html("변경 비밀번호 확인란를 입력해주세요.");
			bool=false;
		} else if(newPwd2!=newPwd1){
				$("div#newPwd2").show();
				$("div#newPwd2").html("변경 비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				bool=false;
		} else {
			$("div#newPwd2").hide();
			bool=true;
		}
		
			
	}// end of function goConfirm() ----------------------------------------------------------

</script> 


<div id="changePwdContainer">
	<form name="changePwdFrm" id="changePwdFrm">
		<div id="alert">회원님의 소중한 개인정보보호와 안전한 서비스 이용을 위해 주기적으로 <br> 비밀번호를 변경해주시기 바랍니다.</div>
		<div id="changePwd">
			<input type="hidden" name="userid" />
			<label for="currentPwd" id="letter" >현재 비밀번호</label>	
	  	   	<input type="password" name="currentPwd" id="currentPwd" class="loginWidth" placeholder="현재 비밀번호"/>
	  	   	<div id="currentPwd" class="confirm"></div><br>
	  	   	<label for="newPwd" id="letter">변경 비밀번호</label>
		    <input type="password" name="newPwd" id="newPwd1" class="loginWidth" placeholder="변경 비밀번호"/>
		    <div id="newPwd1" class="confirm"></div><br>
		    <label for="newPwd" id="letter">변경 비밀번호 확인</label>
		    <input type="password" name="newPwd2" id="newPwd2" class="loginWidth" placeholder="변경 비밀번호 확인"/> 
		    <div id="newPwd2" class="confirm"></div><br>	 	      	 	
	  	    <button type="button" name="changePwd" id="changePwd" class="btn btn-primary loginWidth changePwd" >비밀번호 변경하기</button><br>
	  	    <button type="button" name="changePwd" class="btn btn-outline-secondary loginWidth changePwd" >다음에 변경하기</button> 
	   </div> 	
	</form>        	   
</div>   
 
<jsp:include page="../footer.jsp" />