<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
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

#memberTbl{
	margin-top: 65px;
}

#thead {
	background-color: #1a1a1a;
	color: white;
	font-weight: lighter;
	text-align: center;
	font-size: 10pt;
}


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
 	display : inline-block; 
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
		
		if("${fn:trim(requestScope.searchWord)}" != ""){
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}
		
		$("select#sizePerPage").bind("change", function(){
			goSearch();
		});
		
		if("${requestScope.sizePerPage}" != "") {
			$("select#sizePerPage").val("${requestScope.sizePerPage}");
		}
		
		// 검색어에 엔터를 치면 검색이 되어지게 하기
		$("input#searchWord").keyup(function(event){
			if(event.keyCode == 13){
				goSearch();
			}
		});
		
	}); // end of $(document).ready(function() ------------------

	// Function declaration
	function goSearch() {
		var frm = document.memberFrm;
		frm.action = "memberList.to";
		frm.method = "GET";
		frm.submit();
	}

</script>







<div id="content-container">
<h4 style="margin-top: 50px; margin-bottom: 20px;">::: 회원 목록 :::</h4>

 <div id="frm-container">
	<form name="memberFrm">
		<select id="searchType" name="searchType">
			<option value="name">회원명</option>
			<option value="userid">아이디</option>
			<option value="email">이메일</option>
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

    <table id="memberTbl" class="table table-bordered">
        <thead id="thead">
        	<tr>
        		<th class="first">아이디</th>
        		<th class="second">회원명</th>
        		<th class="third">연락처</th>
        		<th class="fourth">회원등급</th>
        		<th class="fifth">휴면상태</th>
        		<th class="sixth">탈퇴유무</th>
        	</tr>
        </thead>
        
        <tbody>
        	<c:forEach var="mvo" items="${requestScope.memberList}">
        	    <tr class="memberInfo">
        			<td>${mvo.userid}</td>
        			<td>${mvo.name}</td>
        			<td>${mvo.mobile}</td>
        			<td>
						<c:choose>
							<c:when test="${mvo.level eq '1'}">실버</c:when>
							<c:when test="${mvo.level eq '2'}">골드</c:when>
							<c:otherwise>플래티넘</c:otherwise>
						</c:choose>        			
        			</td>
        			<td>
        				<c:if test="${mvo.idle eq '0'}"><span style="color: green;">활동중</span></c:if>
        				<c:if test="${mvo.idle eq '1'}"><span style="color: red;">휴면중</span></c:if>
        			</td>
        			<td>
        				<c:if test="${mvo.status eq '1'}"><span style="color: green;">가입중</span></c:if>
        				<c:if test="${mvo.status eq '0'}"><span style="color: gray;">탈퇴</span></c:if>
        			</td>
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