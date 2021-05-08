<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<% String ctxPath = request.getContextPath(); %>   
<%@ page import="java.util.Date , java.text.SimpleDateFormat" %>
<%
	// *** 현재시각을 알아오기 *** //
	Date now = new Date(); // 현재시각 
		
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd"); 
		String today=sdformat.format(now);		
		//또는
		String currentTime = String.format("%tF",now);
%>
<jsp:include page="../header.jsp"/>
<!DOCTYPE html>
<html>
<head>

  <title>::: REVIEW :::</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<%=ctxPath%>/css/hanseoyeon.css"/>

<!-- Google Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

<!-- 제이쿼리 -->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <link rel="stylesheet" href="/resources/demos/style.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>



<script type="text/javascript">

	$( function() {
		
		$('ul.tabs li').click(function(){				//선택자를 통해 tabs 메뉴를 클릭 이벤트를 지정해줍니다.
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('current');		//선택 되있던 탭의 current css를 제거하고 
			$('.tab-content').removeClass('current');		

			$(this).addClass('current');				//선택된 탭에 current class를 삽입해줍니다.
			$("#" + tab_id).addClass('current');
		})
		
		if("${fn:trim(requestScope.searchWord)}" != "") {
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}

		
		if("${requestScope.sizePerPage}" != "") {
			$("select#sizePerPage").val("${requestScope.sizePerPage}");
		}
		
		
		
		// 특정 회원을 클릭하면 그 회원의 상세정보를 보여주도록 한다.
		$("tr.memberInfo").click(function(){
			// console.log($(this).html());
			var userid = $(this).children(".userid").text();
			// alert(userid);  
			location.href="<%= ctxPath%>/member/memberOneDetail.up?userid="+userid+"&goBackURL=${requestScope.goBackURL}";   
		});
		
	});// end of $(document).ready(function(){})--------------------------
	
	

</script>


<%-- 주문 내역 조회 탭 --%>

<div class="container">

		<h2>REVIEW</h2>
		<div class="container">
<!-- 탭 메뉴 상단 시작 -->
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">작성가능한 리뷰</li>
		<li class="tab-link" data-tab="tab-2">내가 작성한 리뷰</li>
	</ul>
<!-- 탭 메뉴 상단 끝 -->

<!-- 탭1 메뉴 내용 시작 -->
	<div id="tab-1" class="tab-content current">
    
    <table id="reviewTbl" class="table table-bordered" style="width: 100%; margin-top: 20px;">
        <thead>
        	<tr>
        		<th style="width:20%;">이미지</th>
        		<th>상품정보 및 옵션</th>
        		<th style="width:15%;">리뷰작성</th>
        	</tr>
        </thead>
        
        <tbody>
       	 	<c:if test="${pdrvListNo eq 0}">
				<tr><td colspan="3">현재 작성 가능한 리뷰가 없습니다.</td></tr>
			</c:if>
        	<c:forEach var="rv" items="${requestScope.reviewList}">
        	    <tr class="orderInfo">
        			<td><img src="<%=ctxPath%>/images/${rv.pimage1}"/></td>
        			<td>${rv.pname}<br>${rv.optionname}</td>
        			<td><input type="button" value="리뷰쓰기"></td>
        	    </tr>
        	</c:forEach>
        </tbody>
    </table>    

    <div>
    	${requestScope.pageBar}
    </div>
	</div>
<!-- 탭1 메뉴 내용 끝 -->
	
	<!-- 탭2 메뉴 내용 시작 -->
	<div id="tab-2" class="tab-content">
	    <table id="reviewTbl" class="table table-bordered" style="width: 100%; margin-top: 20px;">
        <thead>
        <tr><th colspan="4" style="border:none;">${pdrvListNo}개의 리뷰를 작성하였습니다</th></tr>	
        	<tr>
        		<th style="width:20%;">이미지</th>
        		<th>상품정보 및 옵션</th>
        		<th>별점</th>
        		<th style="width:15%;">리뷰 작성날짜</th>
        	</tr>
        </thead>
        
        <tbody>		
						
        	<c:forEach var="pdrv" items="${requestScope.pdrvList}">        	
        	    <tr class="orderInfo">
        			<td><img src="<%=ctxPath%>/images/${pdrv.pimage1}"/></td>
        			<td>${pdrv.pname}</td>
        			<td><input type="button" value="후기쓰기"></td>
        	    </tr>
        	</c:forEach>
        </tbody>
    </table>    
  	</div> <!-- 탭2 메뉴 내용 끝 -->
	
<!-- 탭 메뉴 내용 끝 -->

</div>
</div>



<jsp:include page="../footer.jsp"/> 