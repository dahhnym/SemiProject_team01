<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>   
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="<%=ctxPath%>/css/hanseoyeon.css"/>

<title>:::주문 상세 내역:::</title>

<script type="text/javascript">

//alert(${orderInfo.payment});

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
				<td>${orderInfo.odrcode}</td>
			</tr>
			<tr>
				<th>주문일자</th>
				<td>${orderInfo.orderdate}</td>
			</tr>
			<tr>
				<th>주문자</th>
				<td>${orderInfo.odrname}</td>
			</tr>
			<tr>
				<th>주문처리상태</th>
				<td>${orderInfo.odrstatus}&nbsp;${orderInfo.odrprgrss}&nbsp;
				<!-- 배송조회 바로 가능한 링크 --> 
				<a style="color:blue; text-decoration: underline;" 					
				href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${orderInfo.invoicenum}">${orderInfo.invoicenum}</a>
				</td>				
			</tr>
		</table>
		<br><br>
		<div style=" font-weight:bold; font-size:13pt;">결제정보</div>
		<hr>
		<table>
			<tr>
				<th width="120px;">총 결제금액</th>
				<td><a><fmt:formatNumber value="${orderInfo.totalcost}" type="number" />원</a></td>
			</tr>
			<tr>
				<th>결제수단</th>
				<td>${orderInfo.payment}&nbsp;</td>
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
					<th>합계</th>
				</tr>
			</thead>
				<tbody align="center">				
				
					<!-- control단에서 받아온 orderList로 상품 리스트 보여주기  시작--> 				
					<c:forEach items="${requestScope.orderList}" var="odr" varStatus="status">
						<tr id="prodInfo">
							<td><a href="<%=ctxPath%>/Info.to?pnum=${odr.pvo.pnum}"><img class="pimage1" src="<%=ctxPath%>/images/${odr.pvo.pimage1}" width= "90px;" height="90px;"/></a></td>
							<td align="left"><a href="<%=ctxPath%>/Info.to?pnum=${odr.pvo.pnum}">${odr.pvo.pname}</a><br>[옵션: ${odr.optionname} ]</td>
							<td>${odr.odrqty}</td>
							<td><fmt:formatNumber value="${odr.pvo.saleprice}" type="number" />원</td>
							<td>
								<div id="pointbox">
								<c:if test="${sessionScope.loginuser.level == 1}">
									<fmt:formatNumber value="1" type="number"/>
								</c:if>
								<c:if test="${sessionScope.loginuser.level == 2}">
									<fmt:formatNumber value="3" type="number"/>P
								</c:if>
								<c:if test="${sessionScope.loginuser.level == 3}">
									<fmt:formatNumber value="5" type="number"/>P
								</c:if>
								% 적립
								</div>
								
								<c:if test="${sessionScope.loginuser.level == 1}">
									<fmt:formatNumber value="${odr.odrprice*0.01}" type="number"/>P
								</c:if>
								<c:if test="${sessionScope.loginuser.level == 2}">
									<fmt:formatNumber value="${odr.odrprice*0.03}" type="number"/>P
								</c:if>
								<c:if test="${sessionScope.loginuser.level == 3}">
									<fmt:formatNumber value="${odr.odrprice*0.05}" type="number"/>P
								</c:if>
							</td>
							<td><fmt:formatNumber value="${odr.odrprice}" type="number"/>원</td>
						</tr>
					</c:forEach>
					<!-- control단에서 받아온 orderList로 상품 리스트 보여주기  끝--> 					
			</tbody>
			
			
<!-- 상품합계금액 sum, 배송비 delivery, 총결제금액 totalsum 계산하기 --> 			
<c:set var="sum" value="0"/>
<c:forEach items="${requestScope.orderList}" var="odr">
	<c:set var="sum" value="${sum+odr.odrprice}"/>
</c:forEach>

<c:set var="delivery" value="0"/>
<c:if test="${(sum) < 50000}">
	<c:set var="delivery" value="2500"/>
</c:if>

<c:set var="totalsum" value="${sum+delivery}"/>
<!-- 상품합계금액 sum, 배송비 delivery, 총결제금액 totalsum 계산하기 --> 	
				<tr>
					<td id="sumtbl" colspan="8">상품구매금액 <fmt:formatNumber value="${sum}" type="number" />원 + 배송비&nbsp;					
						<fmt:formatNumber value="${delivery}" type="number" />원
					  - 포인트 0 P= 합계 : <span id="sum"><fmt:formatNumber value="${totalsum}" type="number" /> 원</span></td>				
				</tr>
			</tbody>
		</table>	 
		<br><br>
		<div style=" font-weight:bold; font-size:13pt;">배송지정보</div>
		<hr>
		<table>
			<tr>
				<th width="120px;">받으시는 분</th>
				<td>${orderInfo.deliname}</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>${orderInfo.delipostcode}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${orderInfo.deliaddress}&nbsp;${orderInfo.delidtaddress}&nbsp;${orderInfo.deliextddress}</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${orderInfo.delimobile}</td>
			</tr>
			<tr>
				<th>배송메세지</th>
				<td>${orderInfo.delimsg}</td>
			</tr>
		</table>
	</div>
	
	<br><br>
	<input type="button" value="주문목록보기" onclick="location.href='<%=ctxPath%>/orderList.to'" style="background-color: #737373; border:none;color:white; width:150px;height:40px;"/>



















</div>

<jsp:include page="../footer.jsp"/> 