<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<%=ctxPath%>/css/Ohdayoon.css"/>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<style type="text/css">

	body{
		overflow: hidden;
		margin: 0px;
		padding: 0px;
		border:0px;
	}
	div.choicecontent{
	    overflow: auto;
    overflow-x: hidden;
    max-height: 359px;
    padding: 20px 25px 14px;
    }
    
    .choicecontent .name{
    padding: 0px 0px 20px 0px;
    font-size: 12pt;
    border-bottom: 1px dotted #000;
    margin: 0px;
    }
    
    .prodNormal{
    margin: 20px 0 0;
    min-height: 82px;
    position: relative;
    padding: 0 0 0 100px;
    }
    
    .imgarea{
    position: absolute;
    left: 0;
    top: 0;
    width: 80px;
    height: 80px;
    min-height: 82px;
    }
    
    table.prodchoice{
    width: 100%;
    border-spacing: 0;
    border-collapse: collapse;    
    color: #353535;
    clear: both;
    text-align: left;
    padding-top: 20px;
    }
</style>
 
 <script type="text/javascript">
	
	 $(document).ready(function(){
		
		 
		 $("select[name=chicecolor]").change(function(){
			  console.log($(this).val()); //value값 가져오기
			  console.log($("select[chicecolor] option:selected").text()); //text값 가져오기
			  
			  
			});
		 
	 });
</script>

<div class="choicecontent">
     <h2 class="name">상품명</h2>
									
	<div class="prodNormal">
		<div class="imgarea">
			<img src=""/>
		</div>
		<table class="prodchoice" style="border: 0px;">
			<colgroup>
				<col width="120px;">
				<col width="auto;">
			</colgroup>
			
			<tr style="border: 0px;">
				<th >color</th>
				<td>
					<span class="btn_small"></span>
					<select id="choiceoption" name="chicecolor">
						<option value=""></option>
						<option value="1">블랙</option>
						<option value="2">브라운</option>
						<option value="3">브라운</option>
					</select>
					<p id="requireOption"></p>
					<%-- select   id="product_option_id1" class="ProductOption0" name="${cart.cart_pro_detail_code}color">
 						<option value="null">- [필수] 옵션을 선택해 주세요 -</option>
 						<c:if test="${cart.color_list != null}">
 						<c:forEach items="${cart.color_list}" var="color">
 						<option value="${color}">${color}</option>
 						</c:forEach>
 						</c:if>
					</select>
					--%>
				</td>
			</tr>
		</table>
		</div>
		<p style="font-size: 9pt;">위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</p>
	
	<div style="height: 400px; border: solid 0px gray;"></div>
			
	</div>	
	
	


