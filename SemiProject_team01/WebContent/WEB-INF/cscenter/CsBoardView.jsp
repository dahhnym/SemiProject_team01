<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="../css/yh_css/boardTable.css">
<style>
	tr.boardlist:hover{
		background-color:#D5D5D5;
		cursor:pointer;
	}
</style>
<script type="text/javascript">
	$(function() {
		
		
		$("tr.boardlist").click(function() {
			location.href="csBoardViewPwd.to?boardno="+$(this).find("#boardno").html();
			//console.log($(this).find("#boardno").html());
		});
		
		$("a#write").click(function(){
			if(${empty sessionScope.loginuser}) {
	    		  alert("제품사용 후기를 작성하시려면 먼저 로그인 하셔야 합니다.");
	    		  return false;
	    	  } else {
	    		  return true;
	    	  }
		});
	});
</script>

<div class="container_b containers">
<br><br><br>
<h1 align="center" style="font-weight:bold;">고객센터</h1><br><br>
<h2 align="center">문의 게시판</h2><br> 
<div>
<c:if test="${not empty requestScope.BoardList}">
<table class="table">
    <thead class="thead-light">
      <tr>
        <th>No</th>
        <th>분류</th>
        <th>글번호</th>
        <th colspan="2">제목</th>
        <th>작성자</th>
        <th>작성일자</th>
      </tr>
    </thead>
    <tbody>
       <c:forEach var="bvo" items="${BoardList}" varStatus="status">
        <tr class="boardlist">
	        <td>${status.count}</td>
	        <td>${bvo.cbscvo.cbbcvo.bigcatename}</td>
	        <td id="boardno">${bvo.boardno}</td>
	        <td colspan="2">${bvo.boardtitle}</td>
	        <td>${bvo.fk_userid}</td>
	        <td>${bvo.boardregistdate}</td>
      	</tr>
        </c:forEach>
        </tbody>
</table>
</c:if>
       <c:if test="${empty requestScope.BoardList}">
       	<h2>등록된 글이 없습니다.</h2>
       </c:if>
  <a href="<%= request.getContextPath()%>/cscenter/csBoardWrite.to" id="write" class="btn btn-secondary">글쓰기</a>
  <br>  
  <div class="div_a" align="center">
	  ${pageBar}	  
  </div>
</div>
</div>


<jsp:include page="../footer.jsp"/>