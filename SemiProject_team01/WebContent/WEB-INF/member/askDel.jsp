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
      <span id="viewInfo" class="subhead" onclick="location.href='<%=ctxPath%>/member/personalInfo.to'">내 정보보기</span>
      <span id="delAccount" class="subhead" onclick="location.href='<%=ctxPath%>/member/personalDel.to'">회원탈퇴</span>
   </div><br>
   <div id="personalInfoContains">
		<h4 style="font-weight: bold;">정말로 탈퇴하시겠습니까?</h4>
		<h5 style="margin-bottom: 50px;">회원탈퇴시 삭제된 정보는 복구할 수 없으며, 탈퇴후 재가입시 동일ID는 사용불가 합니다.</h5>
		<span style="display:block; height: 50px;">
			<button type="button" class="btn btn-secondary" id="btnPersionInfo" >탈퇴하기</button>
			<button type="button" class="btn btn-secondary" id="btnPersionInfo" onclick="location.href='<%=ctxPath%>/member/personalInfo.to'" >취소</button>
		</span>
		<br>
		<span class="confirm" id="currentPwd"></span>
   </div>
</div>


<jsp:include page="../footer.jsp"/>