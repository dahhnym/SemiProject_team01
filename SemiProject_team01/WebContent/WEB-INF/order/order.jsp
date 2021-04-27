<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    
<jsp:include page="../header.jsp"/>
<!DOCTYPE html>
<html>
<head>

<title>:::Order:::</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<%=ctxPath%>/hanseoyeon.css"/>

<!-- Google Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

</head>




<div class="container">

	<h2>Order</h2>

	<div id="left">
	주문 상품 정보
	</div>
	<br>
	<table id="prodInfo">
		<thead align="center">
			<tr>
				<th><input type="checkbox" id="prod" /></th>
				<th>이미지</th>
				<th width="30%">상품정보</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>주문처리상태</th>
				<th>교환/환불</th>
			</tr>
		</thead>
		
		<tbody align="center">
			<tr>
				<td>2021-04-17<br><a=href="">[주문번호링크]</a></td>
				<td>이미지 연결</td>
				<td align="left">[상품정보]링크걸기<br>[옵션:컬러]</td>
				<td>1</td>
				<td>30,000원</td>
				<td>입금전</td>
				<td>교환</td>
			</tr>
		</tbody>
	</table>
  
	
	
	
</div>


<jsp:include page="../footer.jsp"/> 