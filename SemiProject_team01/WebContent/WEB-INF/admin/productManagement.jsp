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
	font-weight: bold;
}

#prodManagementMenu{
	width: 60%;
	margin-left:auto;
	margin-right: auto;
	margin-top: 100px;
	margin-bottom: 100px;
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
	padding-left:100px;
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

input#back{
	display: block;
	width: 110px;
 	heiht: 50px;
 	background-color: #fff;
 	color: #000;
 	border: solid 1px #000;
 	font-size: 15pt;
	padding: 5px 0px;
	margin-left: auto;
	margin-right: auto;
 }

#content-box{
	margin-top: 100px;
	width: 80%;
	margin-left: auto;
	margin-right: auto;
	border: solid 2px #e6e6e6;
	border-radius: 5px 10px;
	padding-top: 60px;
	padding-bottom: 80px;
}


</style>






<div id="content-container">
	<div id="content-box">
	<div class=" itemtitle">상품관리</div>


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

	<div id="btn">
		<input id="back" type="button" value="뒤로" onclick="location.href='<%=ctxPath%>/admin/home.to'" />
	</div>
	</div>
	
</div>





<jsp:include page="../footer.jsp"/>