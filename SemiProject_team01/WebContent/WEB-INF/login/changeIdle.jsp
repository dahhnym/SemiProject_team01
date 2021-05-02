<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />

<script type="text/javascript">
    
	$(function(){
		
	});// end of $(function() ------------------------------------------------------------
	
	
</script> 


<div id="changeIdleContainer">
	<form name="changeIdleFrm" id="changeIdleFrm">
		<div>
		    <h2>계정이 휴면상태입니다.</h2>
		</div>
		<div>
			<span>1년간 로그인 이력이 없어 휴면 전환된 계정을 해제하여 다시 사용하실 수 있습니다.</span><br><br>
			<h4>휴면 계정 해제</h4>
			<span>휴면 상태를 해제하시면 다시 정상적으로 사용이 가능합니다.</span><br>
			<span>휴면 상태를 해제 후에는 다시 로그인이 필요 합니다.</span><br>
		 </div>		
		 <input type="password" name="password" id="password" class="loginWidth" placeholder="비밀번호 확인"/> 	      	 	      	 	
	  	 <button type="button" id="changeIdle" class="btn btn-secondary" onclick="" >휴면상태 해제</button>	
	</form>        	   
</div>   
 
<jsp:include page="../footer.jsp" />