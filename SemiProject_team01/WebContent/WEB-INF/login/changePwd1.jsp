<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />

<script type="text/javascript">
    
	$(function(){
		
	});// end of $(function() ------------------------------------------------------------
	
	
</script> 


<div id="changePwdContainer">
	<form name="changePwdFrm" id="changePwdFrm">
		<div>
		    <h4>회원님의 소중한 개인정보보호와 안전한 서비스 이용을 위해 주기적으로 비밀번호를 변경해주시기 바랍니다.</h4>
		</div>
		<div>
			<label for="currentPwd">현재 비밀번호</label><br>	
	  	   	<input type="text" name="currentPwd" id="currentPwd" class="loginWidth" placeholder="현재 비밀번호"/>
	  	   	<label for="newPwd">변경 비밀번호</label><br>
		    <input type="password" name="newPwd" id="newPwd" class="loginWidth" placeholder="변경 비밀번호"/>	
		    <label for="newPwd">변경 비밀번호 확인</label><br>
		    <input type="password" name="newPwd" id="newPwd" class="loginWidth" placeholder="변경 비밀번호 확인"/><br>	
		 </div>
		 <div>  	      	 	      	 	
	  	   <button type="button" id="sendCode" class="btn btn-secondary loginWidth" onclick="" >비밀번호 변경하기</button>
	  	   <button type="button" id="sendCode" class="btn btn-secondary loginWidth" onclick="" >다음에 변경하기</button> 
	   </div> 	
	</form>        	   
</div>   
 
<jsp:include page="../footer.jsp" />