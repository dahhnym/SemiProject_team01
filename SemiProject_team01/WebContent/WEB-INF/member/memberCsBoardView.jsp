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
</style>
<script type="text/javascript">
	$(function() {
		
		$("tr.boardlist").click(function() {
			location.href="csBoardViewPwd.to?boardno="+$(this).find("#boardno").html();
			//console.log($(this).find("#boardno").html());
		});
		
	});
</script>

<div class="container_b containers">
<br><br><br>
<h2 style="font-weight: bold; text-align:center;"><c:out value="${sessionScope.loginuser.userid}"/> 님의 문의내역</h2>
<br><br>
<div>
<c:if test="${not empty requestScope.BoardList}">
<table class="table">
    <thead class="thead-light">
      <tr>
        <th>No</th>
        <th>분류</th>
        <th style="display:none">글번호</th>
        <th colspan="2" style="width: 300px;">제목</th>
        <th>작성일자</th>
      </tr>
    </thead>
    <tbody>
       <c:forEach var="bvo" items="${BoardList}" varStatus="status">
        <tr class="boardlist">
	        <td>${status.count}</td>
	        <td>${bvo.cbscvo.cbbcvo.bigcatename}</td>
	        <td id="boardno" style="display:none">${bvo.boardno}</td>
	        <td colspan="2" style="width: 300px;">${bvo.boardtitle}</td>
	        <td>${bvo.boardregistdate}</td>
      	</tr>
        </c:forEach>
        </tbody>
</table>
</c:if>
       <c:if test="${empty requestScope.BoardList}">
       	<h2>등록된 글이 없습니다.</h2>
       </c:if>
  <a href="<%= request.getContextPath()%>/cscenter/csBoardWrite.to?fk_bigcateno=${requestScope.fk_bigcateno}" id="write" class="btn btn-secondary">글쓰기</a>
  <br>  
  <div class="div_a" align="center">
	  ${pageBar}	  
  </div>
</div>
</div>


<jsp:include page="../footer.jsp"/>