<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% String ctxPath=request.getContextPath(); %>

<jsp:include page="../header.jsp"/>   
<style type="text/css">

#content-container {
	width: 70%;
	margin-left: auto;
	margin-right: auto;
	height: 600px;
}

#adminMenu{
	width: 60%;
	margin-left:auto;
	margin-right: auto;
	margin-top: 250px;
}


.menuIcon {
	width: 100px;
	margin-left:auto;
	margin-right: auto;
	margin-bottom: 10px;
	/* border: solid 1px blue; */
}

.menuIcon:hover tbody > tr > a.menuname{
	font-weight: bold;
}

.thead-padding{
	padding-left:90px;
	padding-right:80px;
}

.tbody-text-align, .menuIcon{
	text-align: center;
}

a.menuname{
	text-decoration: none;
	color: #737373;
}



td.menu-head:hover a.menuname{
	font-weight: bold;
}

span{
	padding-left: 20px;
}


</style>    
    
<div id="content-container">
	<table id="adminMenu">
		<tbody>
			<tr>
				<td class="thead-padding menu-head">
				<a href="<%=ctxPath%>/admin/memberList.to"><img class="menuIcon " src="<%=ctxPath%>/images/usermanagement.png"/></a>
				<span><a class="menuname" href="<%=ctxPath%>/admin/memberList.to">회원관리</a></span>
				</td>
				<td class="thead-padding menu-head">
				<a href="<%=ctxPath%>/admin/productManagement.to"><img class="menuIcon" src="<%=ctxPath%>/images/productmanagement.png"/></a>
				<span><a class="menuname" href="<%=ctxPath%>/admin/productManagement.to">상품관리</a></span>
				</td>
				<td class="thead-padding menu-head">
				<a href="#"><img class="menuIcon" src="<%=ctxPath%>/images/ordermanagement.png"/></a>
				<span><a class="menuname" href="#">주문관리</a></span>
				</td>
			</tr>
		</tbody>
	</table>

</div>
    
 
    
    
    
    
    
<jsp:include page="../footer.jsp"/>