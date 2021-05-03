<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트여</title>
</head>
<body>
<table class="table table-hover table-expandable table-striped">
    <thead>
      <tr>
        <th>NO</th>
        <th>분류</th>
        <th>제목</th>
      </tr>
    </thead>
    <tbody>
		  <c:forEach var="fvo" items="${requestScope.faqlist}" >
			<tr>
				<td>${fvo.faqNo}</td>
				<td>${fvo.fcname}</td>
				<td>${fvo.faqtitle}</td>
			</tr>
			<tr>
				<td colspan="4">${fvo.faqcontent}</td>
			</tr>
		</c:forEach>
        </tbody>
     </table>
</body>
</html>