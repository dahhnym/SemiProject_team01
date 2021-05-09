<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath=request.getContextPath(); %>
<jsp:include page="../header.jsp"/>


<link rel="stylesheet" href="<%=ctxPath%>/css/Ohdayoon.css"/>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<style type="text/css">

	.contents  h2{
	  width: 90%;
	  margin: 0 auto;
      border-bottom: solid 1px #707070;
      padding-bottom: 20px;
   }

	.info{
		margin-top: 100px;
	}
	.container #table{
		display: table; 
		width: 90%; 
		vertical-align:middle; 
		margin-left: 60px;
		
	}
	
	.container #table .row{
		display: table-row; 
		height: 100px; 
		/* vertical-align:middle; */
	}
	
	.container #table .cell{
	
	display: table-cell; 
	padding-left: 50px; 
	border-bottom: 1px solid #000; 
	vertical-align:middle;
	font-size: 18pt;
	font-weight: bolder;
	overflow: hidden;
	}
	

	
	.container #table .col1{
		width: 35%; 
		
	}
	
	.container #table .col2{
		width: 15%; 
		border-right:1px solid #000;
	}
	
	.container #table .col3{
		width: 35%; 
	}
	
	.container #table .col4{
		width: 15%; 
	}
	
	.container #table .cell img{
	margin-right: 30px;
	width: 50px;
	height:50px;

	}
	

</style>
<script>
	$(function(){
		if(self.name!='reload'){
			self.name='reload'
			self.location.reload();
		} else self.name="";
	});
</script>

<div class="container">
   <div class="contents">
      <h2>
	      <span style="font-weight: bold;"><c:out value="${sessionScope.loginuser.userid}"/></span> 님의 계정&nbsp;&nbsp;
	      <span style="color: #00ace6; font-weight: bold;">
	      <c:choose>
		      <c:when test="${sessionScope.loginuser.level eq 1}">Silver</c:when>
			  <c:when test="${sessionScope.loginuser.level eq 2}">Gold</c:when>
			  <c:when test="${sessionScope.loginuser.level eq 3}">Platinum</c:when>
	      </c:choose>
	      </span>
      </h2>
   </div>
   
  	<div class="info">
      <div id="table">
         <div class="row">
            <a class="cell col1" ><span>포인트</span></a>
            <span class="cell col2" style="color: #00ace6; text-align: right; padding-right: 50px;">
            	<span style="color: #00ace6; font-weight: bold;"><c:out value="${sessionScope.loginuser.point}"/>&nbsp;P</span>
            </span>
            <a class="cell col3" href="<%= request.getContextPath() %>/member/personalInfo.to"  >회원정보</a>
            <span class="cell col4"> <img src="<%=request.getContextPath()%>/images/human.png" /></span>
         </div>
         <div class="row">
            <a class="cell col1" href="<%= request.getContextPath() %>/cart/cart.to" ><span>위시리스트/장바구니</span></a>
            <span class="cell col2"> <img src="<%=request.getContextPath()%>/images/cart.png" /></span>
            <a class="cell col3" href="<%= request.getContextPath() %>/orderList.to" ><span>주문/배송조회</span></a>
            <span class="cell col4"> <img src="<%=request.getContextPath()%>/images/form.png"/></span>
         </div>
      
         <div class="row" >
            <a class="cell col1" href="<%= request.getContextPath() %>/member/memberCsBoardView.to" style="border-bottom: 0px;"><span>Q&#38;A</span></a>
            <span class="cell col2" style="border-bottom: 0px;"> <img src="<%=request.getContextPath()%>/images/speechbubble.png" /></span>
            <a class="cell col3" href="<%= request.getContextPath() %>/reviewList.to"  style="border-bottom: 0px;"><span>REVIEW</span></a>
            <span class="cell col4" style="border-bottom: 0px;"> <img  src="<%=request.getContextPath()%>/images/review.png" /></span>
         </div>

      </div>
  </div>
  
</div>




<jsp:include page="../footer.jsp"/>