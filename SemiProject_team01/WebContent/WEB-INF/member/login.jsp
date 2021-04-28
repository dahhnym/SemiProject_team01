<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />

<style type="text/css">	
	
</style>

<script type="text/javascript">
	
</script> 


<div id="loginContainer">
   <form name="registerFrm">
   	   <div id="loginSide">
   	   	   <input type="text" name="userid" id="userid" placeholder="아이디"/>
		   <input type="text" name="pwd" id="pwd"  placeholder="비밀번호"/>			      	 	      	 	
   	   </div>
   	   <div id="loginBanner">
   	   		
   	   </div>
	</form>
</div>   
 
<jsp:include page="../footer.jsp" />