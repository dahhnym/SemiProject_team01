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
				<td>1234567</td>
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
				<td>배송중&nbsp;
					 <span style="font-size:10pt;">대한통운(송장번호 : 
					<a style=" text-decoration: underline; color: blue;"
					href=" https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=388773705275">
					388773705275</a>)</span></td>
			</tr>
		</table>
		<br><br>
		<div style=" font-weight:bold; font-size:13pt;">결제정보</div>
		<hr>
		<table>
			<tr>
				<th width="120px;">총 주문금액</th>
				<td><a>30,000원</a></td>
			</tr>
			<tr>
				<th>총 결제금액</th>
				<td>30,000원</td>
			</tr>
			<tr>
				<th>결제수단</th>
				<td>무통장입금&nbsp; <span style="font-size:10pt;">계좌번호: 신한은행 <span style="font-weight: bold;">110-1234-5678</span>&nbsp;(김민지)</span></td>
			</tr>
		</table>
		<br><br>
		<div style=" font-weight:bold; font-size:13pt;">주문 상품 정보</div>
	
		<br>
		<table id="prodInfo">
			<thead align="center">
				<tr id="prodInfo">
					<th>이미지</th>
					<th width="30%">상품정보</th>
					<th>수량</th>
					<th>판매가</th>
					<th>적립포인트</th>
					<th>배송비</th>
					<th>주문처리상태</th>
					<th>취소/교환/반품</th>
				</tr>
			</thead>
			<tbody align="center">
				<tr id="prodInfo">
					<td><a href="">이미지 연결</a></td>
					<td align="left"><a href="">[상품정보]링크걸기</a><br>[옵션:컬러]</td>
					<td>1</td>
					<td>30,000원</td>
					<td>150p</td>
					<td>[무료]</td>
					<td>입금전</td>
					<td>취소</td>
				</tr>
			</tbody>
				<tr>
					<td id="sumtbl" colspan="8">상품구매금액 원 + 배송비 원 - 쿠폰적용(쿠폰이름 원) = 합계 : <span id="sum">원</span></td>				
				</tr>
			</tbody>
		</table>	 
		<br><br>
		<div style=" font-weight:bold; font-size:13pt;">배송지정보</div>
		<hr>
		<table>
			<tr>
				<th width="120px;">받으시는 분</th>
				<td>받는사람 이름</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>12345</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>주소+참고항목+상세주소</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>010-1234-5678</td>
			</tr>
			<tr>
				<th>배송메세지</th>
				<td>메세지 중 하나</td>
			</tr>
		</table>
	</div>
	
	<br><br>
	<input type="button" value="주문목록보기" onclick="location.href='<%=ctxPath%>/orderList.to'" style="background-color: #737373; border:none;color:white; width:150px;height:40px;"/>



















</div>

<jsp:include page="../footer.jsp"/> 