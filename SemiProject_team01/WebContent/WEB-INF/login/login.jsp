<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="../css/login.css"/>

<script type="text/javascript">
 	var bool = false;
 	var saveid = localStorage.getItem('saveid');
 	var loginuser = "${sessionScope.loginuser}"
 	
	$(function(){
		$("div#confirm").html("");
		
		if(saveid != null) {
			$("input#login_userid").val(saveid);
			$("input:checkbox[id=saveid]").prop("checked", true);
		}
		
		if(loginuser == null) {
			$("input#login_userid").val(saveid);
			$("input:checkbox[id=saveid]").prop("checked", true);
		}
		
		if("${failed}" == "failed") {
			$("div#confirm").show();
			$("div#confirm").addClass("eventspace");
			$("div#confirm").html("<span id='loginConfirm' class='loginConfirm'>아이디와 비밀번호가 일치하지 않습니다.</span><br>");
		}
		
		$("button#goLogin").click(function(){
			goCheck();
			
			if(bool){
				if( $("input:checkbox[id=saveid]").prop("checked") ) {
					localStorage.setItem('saveid', $("input#login_userid").val());
				}
				else {
					localStorage.removeItem('saveid');
				}
				
				var frm = document.registerFrm;
				frm.action="login.to";
				frm.method="POST";
				frm.submit();
			}			
		});
		
	});// end of $(function() ------------------------------------------------------------
	
			
	function goCheck(){
		$("div#confirm").html("");
		
		// 아이디 공백 체크
		var userid = $("input#login_userid").val();
		if(userid==""){
			$("div#confirm").show();
			$("div#confirm").addClass("eventspace");
			$("div#confirm").html("<span id='loginConfirm' class='loginConfirm'>아이디를 입력해주세요.</span><br>");
			bool=false;
			return;
		} else {
			$("div#confirm").hide();
			$("div#confirm").removeClass("eventspace");
			bool=true;
		}
		
		// 비밀번호 공백 체크
		var pwd = $("input#login_pwd").val();
		if(pwd==""){
			$("div#confirm").show();
			$("div#confirm").addClass("eventspace");
			$("div#confirm").append("<span id='loginConfirm' class='loginConfirm'>비밀번호를 입력해주세요.</span><br>");
			bool=false;
		} else {
			$("div#confirm").hide();
			$("div#confirm").removeClass("eventspace");
			bool=true;
		}
		
	}// end of function goCheck() --------------------------------------------------------
	
</script> 


<div id="loginContainer">
   <div id="loginSide">
   		<form name="registerFrm" id="registerFrm">
   		   <h2>로그인</h2>
		   <br>
   	   	   <input type="text" name="login_userid" id="login_userid" class="login" placeholder="아이디"/><br>
		   <input type="password" name="login_pwd" id="login_pwd" class="login" placeholder="비밀번호"/><br>	
		   <input type="checkbox" name="saveid" id="saveid"/>
		   <label for="saveid" class="login" id="saveid">&nbsp;아이디 저장하기</label><br>
		   <div id="confirm"></div>	   
		      	 	      	 	
   	       <button type="button" id="goLogin" class="btn btn-secondary loginWidth login" >로그인</button><br>
		   <a href="<%=ctxPath%>/member/memberRegister.to" class="addedMenu" style="margin-right:25px;">회원가입하기</a>   	   
		   <a href="<%=ctxPath%>/login/idFind.to" class="addedMenu">아이디 찾기</a>
		   <span class="addedMenu" >/</span>
		   <a href="<%=ctxPath%>/login/pwdFind.to" class="addedMenu">비밀번호 찾기</a>   	
		</form>        	   
   </div>
   <div id="loginBanner">
	  	<img src="../images/pic01.jpg" id="loginBanner"/>
   </div>  	
</div>   
 
<jsp:include page="../footer.jsp" />