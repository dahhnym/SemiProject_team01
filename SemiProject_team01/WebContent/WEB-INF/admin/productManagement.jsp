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

.hr-sect {
   display: flex;
   flex-basis: 100%;
   align-items: center;
   margin: 100px 0px 50px 0px;
 }
 .hr-sect::before,
 .hr-sect::after {
   content: "";
   flex-grow: 1;
   background: rgba(0, 0, 0, 0.35);
   height: 1px;
   font-size: 0px;
   line-height: 0px;
   margin: 0px 150px 0px 150px;
 }

.itemtitle {
	font-size: 25px;
	text-align: center;
	margin-top: 150px;
	font-weight: bold;
}

#prodManagementMenu{
	width: 60%;
	margin-left:auto;
	margin-right: auto;
	margin-top: 100px;
	/* border: solid 1px blue; */
}


.menuIcon {
	width: 90px;
	margin-left:auto;
	margin-right: auto;
	margin-bottom: 10px;
}

.menuIcon:hover tbody > tr > a.menuname{
	font-weight: bold;
}

.thead-padding{
	padding-left:130px;
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
	padding-left: 15px;
}



</style>






<div id="content-container">
	<div class="hr-sect itemtitle">상품관리</div>


	<table id="prodManagementMenu">
		<tbody>
			<tr>
				<td class="thead-padding menu-head">
				<a href="<%=ctxPath%>/admin/productList.to"><img class="menuIcon " src="<%=ctxPath%>/images/prodList.png"/></a><br>
				<span><a class="menuname" href="<%=ctxPath%>/admin/productList.to">상품목록</a></span>
				</td>
				<td class="thead-padding menu-head">
				<a href="<%=ctxPath%>/admin/productRegister.to"><img class="menuIcon" src="<%=ctxPath%>/images/prodRegister.png"/></a><br>
				<span><a class="menuname" href="<%=ctxPath%>/admin/productRegister.to">상품등록</a></span>
				</td>
			</tr>
		</tbody>
	</table>

</div>





















<jsp:include page="../footer.jsp"/>