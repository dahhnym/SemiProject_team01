<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath=request.getContextPath(); %>

<link rel="stylesheet" href="<%=ctxPath%>/css/member.css"/>
<jsp:include page="../header.jsp"/>


<div class="delAccountContainer" style="margin: 100px 0 0 30%;">
	<h4 style="font-weight: bold;">회원탈퇴가 완료되었습니다.</h4>
	<h5 style="margin: 10px 0 50px 0;">더 나은 제품과 서비스로 다시 만나뵐 수 있기를 바랍니다.</h5>
</div>


<jsp:include page="../footer.jsp"/>