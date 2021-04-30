<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="../header.jsp"/>

<link rel="stylesheet" href="<%=ctxPath%>/css/Ohdayoon.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">

</style>


<script type="text/javascript">

	$(document).ready(function(){
		
	}); // end of $(document).ready(function(){})----------

</script>

<div class="container">

	<div class="contents" style="text-align: center;">       
	   <span style="font-size: 20pt; font-weight: bold;">제품등록</span>   
	
	<br/>

	<%-- !!!!! ==== 중요 ==== !!!!! --%>
	<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
     enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>
	<form name="prodInputFrm"
		  action="<%= request.getContextPath() %>/shop/admin/productRegister.to"
		  method="post"	
		  enctype="multipart/form-data">
		  
		  <table id="tblProdInput" style="width: 80%">
		  	<tbody>
		  		<tr>
		  			 <td width="25%"  class="prodInputName" style="padding-top: 10px;">카테고리</td>
		  			 <td width="75$"  align="left" style="padding-top: 10px;">
		  				<select name="fk_cnum" class="infoData"> <%-- name이 있어야만 값을 보내줄 수 있다. --%>
		  					<option value="">:::선택하세요:::</option>
		  					<c:forEach var="map" items="${requestScope.categoryList}">
		  						<option value="${map.cnum}">${map.cname}</option>
		  					</c:forEach>
		  				</select>
		  				<span class="error">필수입력</span>
		  			 </td>
		  		</tr>
		  		<tr>
				      <td width="25%" class="prodInputName">제품명</td>
				      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
				         <input type="text" style="width: 300px;" name="pname" class="box infoData" />
				         <span class="error">필수입력</span>
				      </td>
				</tr>
			    <tr>
				      <td width="25%" class="prodInputName">제조사</td>
				      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
				         <input type="text" style="width: 300px;" name="pcompany" class="box infoData" />
				         <span class="error">필수입력</span>
				      </td>
			    </tr>
			    <tr>
				      <td width="25%" class="prodInputName">제품이미지</td>
				      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
				         <input type="file" name="pimage1" class="infoData" /><span class="error">필수입력</span>
				         <input type="file" name="pimage2" class="infoData" /><span class="error">필수입력</span>
				      </td>
			    </tr>

			    <tr>
				      <td width="25%" class="prodInputName">제품정가</td>
				      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
				         <input type="text" style="width: 100px;" name="price" class="box infoData" /> 원
				         <span class="error">필수입력</span>
				      </td>
			    </tr>
			    <tr>
				      <td width="25%" class="prodInputName">제품판매가</td>
				      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
				         <input type="text" style="width: 100px;" name="saleprice" class="box infoData" /> 원
				         <span class="error">필수입력</span>
				      </td>
			    </tr>
			    <tr>
				      <td width="25%" class="prodInputName">제품스펙</td>
				      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
				         <select name="fk_snum" class="infoData">
				            <option>:::선택하세요:::</option>
				            <c:forEach var="spvo" items="${requestScope.specList}">
				            	<option value="${spvo.snum}">${spvo.sname}</option>
				            </c:forEach>
				         </select>
				         <span class="error">필수입력</span>
				      </td>
			    </tr>
			    <tr>
				      <td width="25%" class="prodInputName">제품설명</td>
				      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
				         <textarea name="pcontent" rows="5" cols="60"></textarea>
				      </td>
			    </tr>
			    <tr>
				      <td width="25%" class="prodInputName" style="padding-bottom: 10px;">제품포인트</td>
				      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden; padding-bottom: 10px;">
				         <input type="text" style="width: 100px;" name="point" class="box infoData" /> POINT
				         <span class="error">필수입력</span>
				      </td>
			    </tr>
		  		
		  		<%-- ==== 첨부파일 타입 추가하기 ==== --%>
			    <tr>
			          <td width="25%" class="prodInputName" style="padding-bottom: 10px;">추가이미지파일(선택)</td>
			          <td>
			             <label for="spinnerImgQty">파일수 : </label>
			          <input id="spinnerImgQty" value="0" style="width: 30px; height: 20px;">
			             <div id="divfileattach"></div>
			              
			             <input type="hidden" name="attachCount" id="attachCount" />
			              
			          </td>
			    </tr>

				<%-- ==== 제품 옵션  추가하기 ==== --%>
 				<tr width="25%" class="prodInputName" style="padding-bottom: 10px;">
				  	<td>
				  		제품옵션
				  	</td>
				   	<td> 
				   	
				   		<label for="spinnerImgQty">옵션수 : </label>
			          		<input id="spinnerImgQty" value="0" style="width: 30px; height: 20px;">
			             <div id="divfileattach"></div>
			              
			             <input type="hidden" name="attachCount" id="attachCount" />
			              </td>
			    </tr>
				<tr style="height: 70px;">
				      <td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
				          <input type="button" value="제품등록" id="btnRegister" style="width: 80px;" /> 
				          &nbsp;
				          <input type="reset" value="취소"  style="width: 80px;" />   
				      </td>
			   </tr>
			   
			  
		  	</tbody>
		  	
		  </table>
		  
		  
	</form>


</div>



</div>













<jsp:include page="../footer.jsp"/>
