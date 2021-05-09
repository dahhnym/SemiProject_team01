<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="../css/yh_css/boardTable.css">
<link rel="stylesheet" href="../css/yh_css/tabs.css">
<style>
	tr.boardlist:hover{
		background-color:#D5D5D5;
		cursor:pointer;
	}
	span {
	font-size: 17pt;
}

span {
	color: #555;
}
a:hover {
	color: #999;
}
</style>
<script type="text/javascript">


	$(function() {
		
		if(self.name!='reload'){
		      self.name='reload'
		      self.location.reload();
		   } else self.name="";
		
		$("tr.boardlist").click(function() {
			if(${empty sessionScope.loginuser}) {
	    		  alert("문의글을 보시려면 먼저 로그인 하셔야 합니다.");
	    		  return false;
	    	  } else {
	    			location.href="csBoardViewPwd.to?boardno="+$(this).find("#boardno").html();
		  			//console.log($(this).find("#boardno").html());
		  			return true;
	    	  }
			
		});
		
		$("a#write").click(function(){
			if(${empty sessionScope.loginuser}) {
	    		  alert("문의글을 작성하시려면 먼저 로그인 하셔야 합니다.");
	    		  return false;
	    	  } else {
	    		  return true;
	    	  }
		});
	});
</script>

<div class="container_b containers">
<br><br><br>
<h1 align="center" style="font-weight:bold;">고객센터</h1><br>
<h2 align="center"><a class="menu_cs" href="<%=request.getContextPath()%>/cscenter/csHome.to">
<c:if test="${empty requestScope.fk_bigcateno}">
전체보기
</c:if>
<c:if test="${not empty requestScope.fk_bigcateno}">
${requestScope.bigcatename}
</c:if>

</a></h2><br> 
<div>
<c:if test="${not empty requestScope.BoardList}">
<table class="table">
    <thead class="thead-light">
      <tr>
        <th>No</th>
        <th>분류</th>
        <th style="display:none">글번호</th>
        <th colspan="2" >제목</th>
        <th>작성자</th>
        <th>작성일자</th>
      </tr>
    </thead>
    <tbody>
       <c:forEach var="bvo" items="${BoardList}" varStatus="status">
        <tr class="boardlist">
	        <td>${status.count}</td>
	        <td>${bvo.cbscvo.cbbcvo.bigcatename}</td>
	        <td id="boardno" style="display:none">${bvo.boardno}</td>
	        <td colspan="2">${bvo.boardtitle}</td>
	        <td>${bvo.mvo.name}</td>
	        <td>${bvo.boardregistdate}</td>
      	</tr>
        </c:forEach>
        </tbody>
</table>
</c:if>
       <c:if test="${empty requestScope.BoardList}">
       	<h2 align="center" >등록된 글이 없습니다.</h2>
       </c:if>
  <a href="<%= request.getContextPath()%>/cscenter/csBoardWrite.to?fk_bigcateno=${requestScope.fk_bigcateno}" id="write" class="btn btn-secondary">글쓰기</a>
  <br>  
  <div class="div_a" align="center">
	  ${pageBar}	  
  </div>
</div>
</div>


<jsp:include page="../footer.jsp"/>