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
<table id="memberTbl" class="table table-bordered" style="width: 90%; margin-top: 20px;">
        <thead>
           <tr>
              <th>아이디</th>
              <th>회원명</th>
              <th>이메일</th>
              <th>성별</th>
           </tr>
        </thead>
        <tbody>
					  <c:forEach var="fvo" items="${requestScope.faqlist}" >
					  <span></span>
						<tr class = "memberInfo">
							<td class="userid">${fvo.faqNo}</td>
							<td>${fvo.faqtitle}</td>
							<td>${fvo.faqcontent}</td>
							<td>${fvo.fk_fcNo}</td>
						</tr>
					</c:forEach>
        </tbody>
	</table>
</body>
</html>