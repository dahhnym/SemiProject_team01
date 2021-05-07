<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath=request.getContextPath(); %>

<link rel="stylesheet" href="<%=ctxPath%>/css/member.css"/>
<jsp:include page="../header.jsp"/>
<style>
.contents  h2{
	  width: 90%;
	  margin: 0 auto;
      border-bottom: solid 1px #707070;
      padding-bottom: 20px;
 }
</style>

<script>
	$(function(){
		var bool = false;
		
		$("button#btnPersionInfo").click(function(){

		});
	
	});
</script>

<div class="personalInfoContainer">
   <div class="contents">
      <h2>
	      <span style="font-weight: bold;"><c:out value="${sessionScope.loginuser.userid}"/></span> 님의 계정정보&nbsp;&nbsp;
      </h2>
   </div>
   <div id="personalInfoMenu">
      <span id="viewInfo" class="subhead">내 정보보기</span>
      <span id="delAccount" class="subhead">회원탈퇴</span>
   </div><br>
   <div id="personalInfoContains">
	   <form name="surveyFrm">
	   		<h4 style="font-weight: bold;">회원정보 확인</h4>
	   		<h5 style="margin-bottom: 50px;">상세 회원정보 조회/수정을 위해 비밀번호를 입력해주세요.</h5>
	   		<span style="display:block; height: 50px;">
		   		<input type="passward" name="passward" style="margin: 0 30px 0 40%; vertical-align: middle;" placeholder=" 비밀번호"/>
		   		<button type="button" class="btn btn-secondary" id="btnPersionInfo" >조회하기</button>
	   		</span>
	   		<br>
	   		<span class="confirm" id="currentPwd"></span>
	   </form>
   </div>
</div>


<jsp:include page="../footer.jsp"/>