<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="../css/login.css"/>

<script type="text/javascript">
	var bool = false;
    
	$(function(){
		
		$("button#changePwd").click(function(){
			goConfirm();
			$("input").blur(function(){
				goConfirm();
			});
			
			if(bool) {
				var frm = document.registerFrm;
				frm.action="memberRegister.to";
				frm.method="POST";
				frm.submit();
			}	
		});
		
		$("button#laterChangePwd").click(function(){
			location.href="<%=ctxPath%>/home.to";
		});

	});// end of $(function() ------------------------------------------------------------
	
			
	function goConfirm() {	// 비밀번호 변경을 누른 경우
		
	//	MemberVO mvo = (MemberVO)session.getAttribute("loginuser");
	//	var pwd = mvo.getPwd();
		var pwd = "${sessionScope.mvo.pwd}"
		
		// 현재 비밀번호 입력란 체크
		var currentPwd = $("input#currentPwd").val();
		if(currentPwd==""){
			$("span#currentPwd").show();
			$("span#currentPwd").html("비밀번호를 입력해주세요.");
			bool=false;
		} else if(currentPwd!=pwd){
				$("span#currentPwd").show();
				$("span#currentPwd").html("현재 비밀번호와 다릅니다. 다시 입력해주세요.");
				bool=false;
		} else {
			$("span#currentPwd").hide();
			bool=true;
		}
		
		// 변경 비밀번호란 체크
		var newPwd1 = $("input#newPwd1").val();
		if(newPwd1==""){
			$("span#newPwd1").show();
			$("span#newPwd1").html("변경할 비밀번호를 입력해주세요.");
			bool=false;
		} else {
			// 비밀번호 8-15자리, 영문자,숫자,특수기호 혼합 정규표현식
			var regExp= /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			var bool = regExp.test(newPwd1);
			if(!bool){
				$("span#newPwd1").html("비밀번호는 8-15자리의 영문자, 숫자, 특수기호를 혼합해야 합니다.");
				bool=false;
			} else {
				$("span#newPwd1").hide();
				bool=true;
			}
		}
		
		// 변경 비밀번호 확인란 체크
		var newPwd2 = $("input#newPwd2").val();
		if(newPwd2==""){
			$("span#newPwd2").show();
			$("span#newPwd2").html("변경 비밀번호 확인란를 입력해주세요.");
			bool=false;
		} else if(newPwd2!=newPwd1){
				$("span#newPwd2").show();
				$("span#newPwd2").html("변경 비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				bool=false;
		} else {
			$("span#newPwd2").hide();
			bool=true;
		}
		
			
	}// end of function goConfirm() ----------------------------------------------------------
	
</script> 


<div id="changePwdContainer">
	<form name="changePwdFrm" id="changePwdFrm">
		<div>
		    <h4 id="alert">회원님의 소중한 개인정보보호와 안전한 서비스 이용을 위해 <br> 주기적으로 비밀번호를 변경해주시기 바랍니다.</h4>
		</div>
		<div id="changePwd">
			<label for="currentPwd" id="letter" >현재 비밀번호</label>	
	  	   	<input type="password" name="currentPwd" id="currentPwd" class="loginWidth" placeholder="현재 비밀번호"/>
	  	   	<span id="currentPwd" class="confirm"></span><br>
	  	   	<label for="newPwd" id="letter">변경 비밀번호</label>
		    <input type="password" name="newPwd" id="newPwd1" class="loginWidth" placeholder="변경 비밀번호"/>
		    <span id="newPwd1" class="confirm"></span><br>
		    <label for="newPwd" id="letter">변경 비밀번호 확인</label>
		    <input type="password" name="newPwd2" id="newPwd2" class="loginWidth" placeholder="변경 비밀번호 확인"/> 
		    <span id="newPwd2" class="confirm"></span><br>   	 	      	 	
	  	    <button type="button" name="changePwd" id="changePwd" class="btn btn-primary loginWidth changePwd" >비밀번호 변경하기</button><br>
	  	    <button type="button" name="changePwd" class="btn btn-outline-secondary loginWidth changePwd" >다음에 변경하기</button> 
	   </div> 	
	</form>        	   
</div>   
 
<jsp:include page="../footer.jsp" />