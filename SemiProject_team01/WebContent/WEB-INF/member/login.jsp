<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="../css/member.css"/>

<script type="text/javascript">
//  var bannerImg;
    
	$(function(){
		
	});// end of $(function() ------------------------------------------------------------
	
	function func_login(){
		
	}
</script> 


<div id="loginContainer">
   <form name="registerFrm" id="registerFrm">
   	   <div id="loginSide">
   	   	   <input type="text" name="userid" id="login_userid" class="loginWidth" placeholder="아이디"/><br>
		   <input type="text" name="pwd" id="login_pwd" class="loginWidth" placeholder="비밀번호"/><br>		      	 	      	 	
   	       <button type="button" id="sendCode" class="btn btn-secondary loginWidth" onclick="func_login()" >로그인</button><br>
		   <a href="<%=ctxPath%>/member/memberRegister.to" class="addedMenu" style="margin-right:25px;">회원가입하기</a>   	   
		   <a href="<%=ctxPath%>/member/memberRegister.to" class="addedMenu">아이디 찾기</a>
		   <span class="addedMenu" >/</span>
		   <a href="<%=ctxPath%>/member/memberRegister.to" class="addedMenu">비밀번호 찾기</a>   	        	   
   	   </div>
   	 </form>	
     <div id="loginBanner">
	  	<img src="../images/pic01.jpg" id="loginBanner"/>
	 </div> 
</div>   
 
<jsp:include page="../footer.jsp" />