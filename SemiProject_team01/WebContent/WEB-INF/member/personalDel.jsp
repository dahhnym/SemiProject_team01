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
		
		$(document).on("click","button#btnPersionDel",function(){
			var pwd = $("input#pwd").val().trim();
			
			if(pwd==""){
				$("span#password").show();
				$("span#password").html("현재 비밀번호를 입력해주세요.");
				bool=false;
				return;
			} else if(pwd!="${sessionScope.loginuser.pwd}"){
				$("span#password").show();
				$("span#password").html("현재 비밀번호와 다릅니다. 다시 입력해주세요.");
				bool=false;
				return;
			} else {
				$("span#password").hide();
				bool=true;
			}
			
			if(bool) {
				var frm = document.personalDelFrm;
				frm.action="askDel.to";
				frm.method="POST";
				frm.submit();
			}
			
		});
	});
</script>

<div class="personalDelContainer">
   <div class="contents">
      <h2>
	      <span style="font-weight: bold;"><c:out value="${sessionScope.loginuser.userid}"/></span> 님의 계정정보&nbsp;&nbsp;
      </h2>
   </div>
   <div id="personalDelMenu">
      <span id="viewInfo2" class="subhead" onclick="location.href='<%=ctxPath%>/member/personalInfo.to'">내 정보보기</span>
      <span id="delAccount2" class="subhead" onclick="location.href='<%=ctxPath%>/member/personalDel.to'">회원탈퇴</span>
   </div><br>
   <div id="personalDelContains">
	   <form name="personalDelFrm">
	   		<h4 style="font-weight: bold;">회원탈퇴</h4>
	   		<h5 style="margin-bottom: 50px;">회원탈퇴를 위해 비밀번호를 입력해주세요.</h5>
	   		<span style="display:block; height: 50px;">
		   		<input type="password" name="pwd" id="pwd" style="margin: 0 30px 0 40%; vertical-align: middle;" placeholder=" 비밀번호"/>
		   		<button type="button" class="btn btn-secondary" id="btnPersionDel" >조회하기</button>
	   		</span>
	   		<span class="confirm" id="password" style="margin-left: 40%;" ></span>
	   </form>
   </div>
</div>


<jsp:include page="../footer.jsp"/>