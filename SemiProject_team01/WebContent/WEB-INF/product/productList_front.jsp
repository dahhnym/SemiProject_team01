<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="<%=ctxPath%>/css/kimdanim.css" />

<style>


nav#sortby-nav {
	text-align: right;
	margin-top: 0;
}

nav#sortby-nav > ul > li {
	font-size: 20px;
	font-weight: bold;
	display: inline;
}

a.pagebar-style {
	text-decoration: none;
	color: black;
}

	
</style>

<script type="text/javascript">



<%-- 제품 이미지 클릭시 제품 상세 페이지 이동--%>
function goProdDetail(imgs) {
	window.location.href = "<%= ctxPath %>/Info.to?pnum=${requestScope.pvo.pnum}";
}

</script>

<div id="content-container" class="content-width">
		<%-- <div class="hr-sect itemtitle">제품 목록</div>

	   <div>
	      <div id="displayProd"></div>
	   
	      <div style="margin: 20px 0;">
	        <span id="totalProdCount">${requestScope.totalHITCount}</span>
	         <span id="countProd">0</span>
	      </div>
	   </div> --%>
	
   	<c:if test="${not empty requestScope.productList}">
       <c:forEach begin="1" end="1" var="pvo" items="${requestScope.productList}">
         <div style="margin: 20px 0; font-size: 13pt;" >${pvo.categvo.cname}</div>
      </c:forEach>
      
      <div id="proddiv">
      <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
		<div class='prodInfo' style="position: relative; bottom: 0;">
		   <ul style='list-style-type: none; position: absolute'> 
		        <li style='padding-bottom: 5px;'><a href="<%=ctxPath%>/Info.to?pnum=${pvo.pnum}"><img style="width: 100%; height: 280px;" src="/SemiProject_team01/images/${pvo.pimage1}"/></a></li> 
				<c:choose>
				<c:when test="${pvo.spvo.snum eq 1}">
		        	<li class="infoliststyle"><img src="<%=ctxPath%>/images/new.png"/></li>
		        </c:when>
				<c:when test="${pvo.spvo.snum eq 2}">
		        	<li class="infoliststyle"><img src="<%=ctxPath%>/images/best.png"/></li>
		        </c:when>
				<c:otherwise>
		        	<li class="infoliststyle"><img src="<%=ctxPath%>/images/sale.png"/></li>
		        </c:otherwise>
		        </c:choose>
		        <li class="infoliststyle">${pvo.pname}</li> 
		        <li class="infoliststyle"><span style="color: #ccc; text-decoration: line-through;"><fmt:formatNumber value="${pvo.price}" pattern="#,###" /> 원</span></li> 
		        <li class="infoliststyle"><span style="color: black; font-weight: bold;"><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span></li> 
		    </ul>
	   </div>
		<c:if test="${status.count%4 == 0}">
           <br>
           </c:if>
        </c:forEach>
        </div>
        <div id="pagebar-div">${requestScope.pageBar}</div>
       </c:if>
       
       <c:if test="${empty requestScope.productList}">
       	<span>현재 상품진열 준비중입니다..</span>
       </c:if>
	
	
</div>	

<jsp:include page="../footer.jsp" />
