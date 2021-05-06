<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="../header.jsp"/>


<style type="text/css">

#content-container{
	width: 70%;
	margin-left: auto;
	margin-right: auto;
	padding-left: 50px;
	padding-right: 50px;
}

#frm-container{
	display: inline-block;
	float: right;
}

#productTbl{
	margin-top: 65px;
}

#thead {
	background-color: #1a1a1a;
	color: white;
	font-weight: lighter;
	text-align: center;
	font-size: 10pt;
}

th.first{width: 80px;}
th.second{width: 105px;}
th.third{ width:100px;}
th.fourth{width:570px;}
th.fifth{width:93px;}
th.sixth{width:93px;}
th.seventh{width:70px;}
th.eighth{width:70px;}


#pageBar{
	display: block;
	width: 10%;
	margin-left: auto;
	margin-right: auto;
	
}

#pageBar > a{
	text-decoration: none;
	color: #1a1a1a;
	font-size: 14pt;
}

input#back{
	margin-top: 20px;
	display: block;
	width: 110px;
 	heiht: 50px;
 	background-color: #fff;
 	color: #000;
 	border: solid 1px #000;
 	font-size: 15pt;
	padding: 5px 0px;
	float: right;
 }


</style>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("select#sizePerPage").bind("change", function(){
			goSearch();
		});
		
		if("${requestScope.sizePerPage}" != "") {
			$("select#sizePerPage").val("${requestScope.sizePerPage}");
		}
		
		
	});

	// Function declaration
	function goSearch() {
		var frm = document.productFrm;
		frm.action = "productList.to";
		frm.method = "GET";
		frm.submit();
	}

</script>







<div id="content-container">
<h4 style="margin-top: 50px; margin-bottom: 20px;">::: 상품 목록 :::</h4>

<!-- 높은가격순, 낮은가격순, 판매량순 등 카테고리 추가예정 -->
 <div id="frm-container">
	<form name="productFrm">
		<select id="searchType" name="searchType">
			<option value="pname">제품명</option>
			<option value="pcompany">제조사</option>
			<option value="cname">카테고리</option>
		</select>
		<input type="text" id="searchWord" name="searchWord" />
		
		<%-- form 태그내에서 전송해야할 input 태그가 만약에 1개 밖에 없을 경우에는 유효성검사가 있더라도 
		         유효성 검사를 거치지 않고 막바로 submit()을 하는 경우가 발생한다.
		         이것을 막아주는 방법은 input 태그를 하나 더 만들어 주면 된다. 
		         그래서 아래와 같이 style="display: none;" 해서 1개 더 만든 것이다. 
		 --%>
		<input type="text" style="display: none;"> <%-- 조심할 것은 type="hidden" 이 아니다. --%>
		<button type="button" onclick="goSearch();" style="margin-right: 30px;">검색</button>
		
		<select id="sizePerPage" name="sizePerPage">
			<option value="10">10개씩 보기</option>
			<option value="20">20개씩 보기</option>
			<option value="30">30개씩 보기</option>
		</select>
		
    </form>
</div>

    <table id="productTbl" class="table table-bordered">
        <thead id="thead">
        	<tr>
        		<th class="first">제품번호</th>
        		<th class="second">카테고리</th>
        		<th class="third">제품스펙</th>
        		<th class="fourth">제품명</th>
        		<th class="fifth">정가</th>
        		<th class="sixth">판매가</th>
        		<th class="seventh">수량</th>
        		<th class="eighth">판매량</th>
        	</tr>
        </thead>
        
        <tbody>
        	<c:forEach var="pvo" items="${requestScope.productList}">
        	    <tr class="prodInfo">
        			<td>${pvo.pnum}</td>
        			<td>${pvo.categvo.cname}</td>
        			<td>${pvo.spvo.sname}</td>
        			<td>${pvo.pname}</td>
        			<td>${pvo.price}</td>
        			<td>${pvo.saleprice}</td>
        			<td><span class="stock">${pvo.pqty}</span><!-- (입고량 - 판매량) 계산해서 넣을것 --></td>
        			<td>${pvo.saleqty}</td>
        	    </tr>
        	</c:forEach>
        </tbody>
    </table>    

    <div id="pageBar">
    	${requestScope.pageBar}
    </div>
    
    
	<input id="back" type="button" value="뒤로" onclick="location.href='<%=ctxPath%>/admin/home.to'" />
	
    
</div>





<jsp:include page="../footer.jsp"/>