<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="../header.jsp"/>

<link rel="stylesheet" href="<%=ctxPath%>/css/Ohdayoon.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  
<script type="text/javascript">
$(document).ready(function(){
	
	$('.optionModify').hide();
	$("#wishlistlayer").hide();
	$("a#option_change").click(function(){
		var $target = $(event.target);
		$target.next().show();
	});
	
	// 장바구니 수량 변경하기
	$("input#prod_qty").spinner({
		min:1,
		max:20,
		step:1
	});
	
	// 장바구니 비우기 
	$("a#deleteCart").click(function(){
		var deleteOk = confirm("장바구니를 비우시겠습니까?");
		if(deleteOk==true){
			// 확인버튼을 누른다면 
			location.href="";
		}
		else{
			// 비우기 취소
			return;
		}
	});
	
	$("a#update_qty").click(function(){
		
		var qty = $("input#prod_qty").val();
		
		// qty가 재고수보다 많으면 alert 뜨게 해야한다.
	})
	
	
});
function option_change(pro_code,pro_name,pro_detail_code,pro_imagefilename,pro_price,pro_quantity){
	var option_layer = $('#option_modify_layer_0'+pro_detail_code);
	
	$('.optionModify').hide();
	option_layer.show();
	
}
function update_qty(){
	
	
}

function moveOrderCart(){
	$("#wishlistlayer").show();
	
}

</script>


<div id="cartcontainer">
	<div id="contents">
		
			<div class="title" >
				<h2>장바구니</h2>
			</div>
		
			<div class="information">
				<div class="decription">
					<div class="member">
						<p>오다윤님은 [] 등급입니다.</p>
						<a href="">적립금:</a>
					</div>
				</div>
			</div>
		
			<div>
				<h3>일반상품(상품수)</h3>
			</div>
			
			<table class="cart_table">
				<colgroup>
					<col style="width: 27px">
					<col style="width: 92px">
					<col style="width: auto">
					<col style="width: 105px">
					<col style="width: 105px">
					<col style="width: 105px">
					<col style="width: 95px">
					<col style="width: 100px">
					<col style="width: 120px">									
				</colgroup>
				<thead>
					<tr>
						<th scope="col">
							<input type="checkbox" id="prodAllcheck" />
						</th>
					    <th scope="col">이미지</th>
					    <th scope="col">상품정보</th>
					    <th scope="col">판매가</th>
					    <th scope="col">수량</th>
					    <th scope="col">적립금</th>
					    <th scope="col">배송비</th>
					    <th scope="col">합계</th>
					    <th scope="col">선택</th>
				    </tr>
				</thead>
				
				<tbody>
					<c:forEach items="${cartlist}" var="cart">
							
								<tr class="xans-record-">
									<td scope="col"><input type="checkbox" id="basket_chk_id_0"
										name="product_check" value="${cart.cart_pro_detail_code}" onclick="ChangeTotalPrice()" /></td>
									<td scope="col" class="thumb">
									<a href="">
										<img src=""/>
									</a></td>
									<td scope="col" class="product" style="text-align: left;">
									<ul class="xans-element- xans-order xans-order-optionall option" style="margin-top: 15px;">
										<li>
											<a href="/product/detail.html?product_no=28871&cate_no=82">
												<strong class="name">${cart.pro_name}토트백</strong>	
											</a>
										</li>
										<li class="xans-record-" value="">[옵션: ${cart.cart_pro_color }]<br />
										
										<a onclick="option_change(${cart.cart_pro_code},'${cart.pro_name}',${cart.cart_pro_detail_code},
												'${cart.pro_imagefilename}',${cart.cart_pro_price},${cart.cart_pro_quantity})"
										id="option_change" class="btn_option" style="width: 80px; margin-top: 3px;">옵션변경</a>
							
					<!-- 옵션변경 레이어 -->
				 			<div class="optionModify ec-base-layer2" id="option_modify_layer_0${cart.cart_pro_detail_code}" style="position: absolute !important;">
                                    <div class="header">
                                        <h3  style="color: white !important;">옵션변경</h3>
                                    </div>
                                    <div class="content">
                                        <ul class="prdInfo">
											<li>${cart.pro_name }</li>
                                        </ul>
									<div class="prdModify">
                                            <h4>상품옵션</h4>
                                            <ul class="xans-element- xans-order xans-order-optionlist"><li class="xans-record-">
											<span>색상</span>
 											<select   id="product_option_id1" class="ProductOption0" name="${cart.cart_pro_detail_code}color">
 											<option value="null">- [필수] 옵션을 선택해 주세요 -</option>
 											<c:if test="${cart.color_list != null}">
 											<c:forEach items="${cart.color_list}" var="color">
 											<option value="${color}">${color}</option>
 											</c:forEach>
 											</c:if>
											</select>
											</li>
										</ul>
									</div>
                                    </div>
                                    <div class="ec-base-button">
                                        <a href="#none" class="btn_small" onclick="optionsChange('추가',${cart.cart_pro_code},${cart.cart_pro_detail_code},${cart.cart_pro_price},${cart.cart_pro_quantity})" >
                                       		추가</a>
                                        <a href="#none" class="btn_small" onclick="optionsChange('변경',${cart.cart_pro_code},${cart.cart_pro_detail_code},${cart.cart_pro_price},${cart.cart_pro_quantity})">
                                        	변경</a>
                                    </div>
                                    <a href="#none" class="close" onclick="$('.optionModify').hide();"><img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기"/></a>
									</div>
					<!-- 옵션변경 레이어 -->
																
										
										
													 
											</li>
										</ul></td>
									<td scope="col" class="price">
										<div class="">
											<strong><fmt:formatNumber value="${cart.cart_pro_price}" type="number"/> 원</strong>
										</div>
									</td>
									<td scope="col" >
  										<input id="prod_qty" name="value" style="width: 25px; height: 20px;"/>
  										<a id="update_qty" class="btn_option" style="width:50px;" >변경</a>
									</td>
									<td scope="col" class="mileage">-</td>
									<td scope="col">
										<span>2,500원</span>
											
											<%-- 100,000원 이상일 때 배송비 무료 (조건 따로 줄것)--%>
									
									</td>
									<td scope="col" class="total">
										<strong><fmt:formatNumber value="${cart.cart_pro_price * cart.cart_pro_quantity}" type="number" /> 원</strong>
									</td>
									<td scope="col" class="button">
											<a id="prod_order" class="btn_option">주문하기</a><br>
									    	<a id="prodtowish" class="btn_option">위시리스트담기</a><br>
									    	<a id="proddelete" class="btn_option" style="margin-bottom: 5px;">삭제</a>
									
									</td>
								</tr>
								</c:forEach>
							</tbody>
				
				
			</table>
			<a id="deleteCart" class="btn_option" style="width: 120px;">장바구니 비우기</a>
			<div class="displaynone">
			
			</div>
			<table class="price_table" style="border: solid 1px #CCD1D1;">
				<colgroup>
					<col style="width:20%; ">
					<col style="width:20%; ">
					<col style="width:auto; ">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">총 상품금액</th>
						<th scope="col">총 배송비</th>
						<th scope="col">총 주문금액</th>
					</tr>
				</thead>
				<tbody>
					<tr class="cartprice">
						<td scope="col" style="border-right: solid 1px #CCD1D1;">66,000원</td>
						<td scope="col" style="border-right: solid 1px #CCD1D1;">2,500원</td>
						<td scope="col">68,500원</td>
					</tr>
				</tbody>	
			</table>
			
			<div style="margin: 30px 0px;">
				<a id="allorder" class="btnLarge">전체상품주문 </a>
				<a id="seperateorder" class="btnLarge">선택상품주문 </a>
				<span class="btn_right"><a  id="shoppingcon" class="btnLarge" href="<%= request.getContextPath()%>/home.to">쇼핑계속하기 </a></span>
			</div>
		
			<div class="title">
				<h2>위시리스트</h2>
			</div>
		
		<table class="wishlist_table">
				<colgroup>
					<col style="width: 92px">
					<col style="width: auto">
					<col style="width: 105px">
					<col style="width: 105px">
					<col style="width: 95px">
					<col style="width: 105px">
					<col style="width: 120px">									
				</colgroup>
				<thead>
					<tr>
					    <th scope="col">이미지</th>
					    <th scope="col">상품정보</th>
					    <th scope="col">판매가</th>
					    <th scope="col">적립금</th>
					    <th scope="col">배송비</th>
					    <th scope="col">합계</th>
					    <th scope="col">선택</th>
				    </tr>
				</thead>
				
				<tbody>
					<tr>
						<td scope="col" class="thumb">
									<a href="">
										<img src=""/>
									</a></td>
									<td scope="col" class="product" style="text-align: left;">
									<ul class="xans-element- xans-order xans-order-optionall option"  style="margin-top: 15px;">
										<li>
											<a href="/product/detail.html?product_no=28871&cate_no=82">
												<strong class="name">${cart.pro_name}토트백</strong>	
											</a>
										</li>
										<li class="xans-record-" value=""><br />
										
										<a onclick="option_change(${cart.cart_pro_code},'${cart.pro_name}',${cart.cart_pro_detail_code},
												'${cart.pro_imagefilename}',${cart.cart_pro_price},${cart.cart_pro_quantity})"
										id="option_change" class="btn_option" style="width: 80px; margin-top: 3px;">옵션변경</a>
													
													
					<!-- 옵션변경 레이어 -->
				 			<div class="optionModify ec-base-layer2" id="option_modify_layer_0${cart.cart_pro_detail_code}" style="position: absolute !important;">
                                    <div class="header" >
                                        <h3  style="color: white !important;">옵션변경</h3>
                                    </div>
                                    <div class="content">
                                        <ul class="prdInfo">
											<li>${cart.pro_name }</li>
                                        </ul>
									<div class="prdModify">
                                            <h4>상품옵션</h4>
                                            <ul class="xans-element- xans-order xans-order-optionlist"><li class="xans-record-">
											<span>색상</span>
 											<select   id="product_option_id1" class="ProductOption0" name="${cart.cart_pro_detail_code}color">
 											<option value="null">- [필수] 옵션을 선택해 주세요 -</option>
 											<c:if test="${cart.color_list != null}">
 											<c:forEach items="${cart.color_list}" var="color">
 											<option value="${color}">${color}</option>
 											</c:forEach>
 											</c:if>
											</select>
											</li>
										</ul>
									</div>
                                    </div>
                                    <div class="ec-base-button">
                                        <a href="#none" class="btn_small" onclick="optionsChange('추가',${cart.cart_pro_code},${cart.cart_pro_detail_code},${cart.cart_pro_price},${cart.cart_pro_quantity})">
                                       		추가</a>
                                        <a href="#none" class="btn_small" onclick="optionsChange('변경',${cart.cart_pro_code},${cart.cart_pro_detail_code},${cart.cart_pro_price},${cart.cart_pro_quantity})">
                                        	변경</a>
                                    </div>
                                    <a href="#none" class="close" onclick="$('.optionModify').hide();"><img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기"/></a>
									</div>
					<!-- 옵션변경 레이어 -->
																	 
											</li>
										</ul></td>
									<td scope="col" class="price">
										<div class="">
											<strong><fmt:formatNumber value="${cart.cart_pro_price}" type="number"/> 원</strong>
										</div>
									</td>
									<td scope="col" class="mileage">-</td>
									<td scope="col">
										<span>2,500원</span>
									</td>
									<td scope="col" class="total">
										<strong><fmt:formatNumber value="${cart.cart_pro_price * cart.cart_pro_quantity}" type="number" /> 원</strong>
									</td>
				    	<td scope="col" class="button">
							<a id="prod_order" class="btn_option" onclick="moveOrderCart()" >주문하기</a><br>
					    	<a id="prodtowish" class="btn_option" onclick="moveOrderCart()" >장바구니담기</a><br>
					    	<a id="proddelete" class="btn_option" >삭제</a>
								
					    </td>
					</tr>
					
					
				</tbody>
				
			</table>

	</div>


		<!-- 레이어 팝업 만들기  -->
		<div id="wishlistlayer" class="addoption ec-base-layer2" > 
			<div class="header">
	     		<h3  style="color: #fff !important; text-align: left;">옵션변경</h3>
			</div>
				<iframe style="border: solid 1px red; width: 100%; height: 365px;" src="<%= request.getContextPath()%>/cart/addmyprod.to"></iframe>    
			<a href="#none" class="close" onclick="$('#wishlistlayer').hide();"><img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기"/></a>
		
		<div class="base-bottom">
		<span class="totalprice" style="font-size: 12pt;">총상품금액(수량):</span>&nbsp;<span style="font-size: 18pt;">원</span>
		<div class="bottom_base" style="margin-top:10px;">
	    <a href="#none" class=" btn_order" onclick="optionsChange('바로구매하기',${cart.cart_pro_code},${cart.cart_pro_detail_code},${cart.cart_pro_price},${cart.cart_pro_quantity})">
		바로구매하기</a>
		<a href="#none" class="btn_movecart" onclick="optionsChange('변경',${cart.cart_pro_code},${cart.cart_pro_detail_code},${cart.cart_pro_price},${cart.cart_pro_quantity})">
	    	장바구니담기</a>
	    	</div>
    	</div>
		</div>


</div>

	

		



<jsp:include page="../footer.jsp"/>