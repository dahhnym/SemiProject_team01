<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>   
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="<%=ctxPath%>/css/hanseoyeon.css"/>

<title>:::주문 상세 내역:::</title>

<script type="text/javascript">

</script>

<div class="container">

	<h2>주문 상세 내역</h2>
	<br><br>
		
	
	<div class="left">
		<div style=" font-weight:bold; font-size:13pt;">주문정보</div>
		<hr>
		<table>
			<tr>
				<th width="120px;">주문번호</th>
				<td><a href="" style="text-decoration: underline; color: blue;">1234567</a></td>
			</tr>
			<tr>
				<th>주문일자</th>
				<td>yyyy-mm-dd&nbsp;hh:mm:ss</td>
			</tr>
			<tr>
				<th>주문자</th>
				<td>주문자이름</td>
			</tr>
			<tr>
				<th>주문처리상태</th>
				<td>배송중&nbsp;</td>
				<td>대한통운(송장번호 : 
					<a style=" text-decoration: underline; color: blue;"
					href=" https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=388773705275">
					388773705275</a>)</td>
			</tr>
		</table>
		
		<table class=orderInfo>
			<tr>
				<th>주문번호</th>
				<td><a>1234567</a></td>
			</tr>
			<tr>
				<th>주문일자</th>
				<td>yyyy-mm-dd&nbsp;hh:mm:ss</td>
			</tr>
			<tr>
				<th>주문자</th>
				<td>주문자이름</td>
			</tr>
			<tr>
				<th>주문처리상태</th>
				<td>배송중&nbsp;</td>
				<td>대한통운(송장번호 : 
					<a style=" text-decoration: underline; color: blue;"
					href=" https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=388773705275">
					388773705275</a>)</td>
			</tr>
		</table>
	</div>
	





















</div>

<jsp:include page="../footer.jsp"/> 