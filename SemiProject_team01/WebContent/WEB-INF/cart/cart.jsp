<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="../header.jsp"/>


<link rel="stylesheet" href="<%=ctxPath%>/css/Ohdayoon.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
	table.wishlist_table, table.cart_table, table.price_table{
		width:100%;
		border-top: solid 1px #CCD1D1;
		border-bottom: solid 1px #CCD1D1;
		vertical-align: middle;
	}

	th{
		text-align: center;
		height: 40px;
	}
	tr{
		border-bottom: solid 1px #CCD1D1;
		vertical-align: middle;
		text-align: center;
	}
	
	
	tr.cartprice{
		text-align: center;
		vertical-align: middle;
		height: 70px;
	}
</style>
  
<script type="text/javascript">
$(document).ready(function(){
	
	// 옵션변경 창 숨기기
	$("div.optionModify").hide();
	
	// 위시리스트 옵션선택 창 숨기기
	$("div#wishlistlayer").hide();
	
	// 클릭한 옵션변경창 보이기
	$("a#option_change").click(function(){
		var $target = $(event.target);
		$target.next().show();
	});
	
	// 장바구니 수량 변경하기
	$("input#prod_qty").spinner({
		min:1,
		max:100,
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
	
	// 제품의 재고량보다 많으면 경고창 뜨게함
	$("a#update_qty").click(function(){
		
		var qty = $("input#prod_qty").val();
		
		// qty가 재고수보다 많으면 alert 뜨게 해야한다.
	});
	
	
	// 위시리스트 옵션선택 창 외부영역에서 클릭시 창 닫힘
	$(document).mouseup(function (e) {

		var container = $("div#wishlistlayer");
		
		if (!container.is(e.target) && container.has(e.target).length === 0){
		
		container.css("display","none");
		
		}	
		
	});

	$("input#submit").click(function(){
		var frm = document.myFrm;
		frm.action="cart.to";
		frm.method="POST";
		frm.submit();
	});
	
}); // end of $(document).ready(function(){})-------


function option_change(pro_code,pro_name,pro_detail_code,pro_imagefilename,pro_price,pro_quantity){
	var option_layer =  $('#option_modify_layer_0'+pro_detail_code);
	
	$('.optionModify').hide();
	option_layer.show();
	
}

function update_qty(){
	
	
}

function moveOrderCart(){
$("div#wishlistlayer").show();
	
}

</script>


<div class="container" style="z-index: -1">
	<div class="contents" >
		
			<div class="title" >
				<h2>장바구니</h2>
			</div>
		
			<div class="information">
				<div class="decription">
					<div class="member">
						<p>${loginuser.name}님은 [${loginuser.level}] 등급입니다.</p>
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
                                    <a href="#none" class="close" onclick="$('div.optionModify').hide();"><img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기"/></a>
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
                                     <a href="#none" class="close" onclick="$('div.optionModify').hide();"><img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기"/></a>
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
							<a id="prod_order" class="btn_option" onclick="moveOrderCart();" >주문하기</a><br>
					    	<a id="prodtowish" class="btn_option" onclick="moveOrderCart();" >장바구니담기</a><br>
					    	<a id="proddelete" class="btn_option" >삭제</a>
								
					    </td>
					</tr>
					
					
				</tbody>
				
			</table>

	</div>


		<!-- 레이어 팝업 만들기  -->
		<div id="wishlistlayer" class="addoption ec-base-layer3" style="position: absolute !important;"> 
			<div class="header">
	     		<h3  style="color: #fff !important; text-align: left;">옵션변경</h3>
			</div>
				<iframe frameborder="0"style="width: 100%; height: 365px; " src="<%= request.getContextPath()%>/cart/addmyprod.to"></iframe>    
			<a href="#none" class="close" onclick="$('div#wishlistlayer').hide();"><img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기"/></a>
		
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
		<!-- 레이어 팝업 만들기  -->	


		<div class="useInfo"><h3 >이용안내</h3>
			<div class="inner" >
			        <h4 style="font-size: 11pt; padding-left: 12px; ">장바구니 이용안내</h4>
			        <ol>
			<li class="item1">ㆍ해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다.</li>
			            <li class="item2">ㆍ해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.</li>
			            <li class="item3">ㆍ선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
			            <li class="item4">ㆍ[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
			            <li class="item5">ㆍ장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
			            <li class="item6">ㆍ파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</li>
			        </ol>
			<h4 style="font-size: 11pt; padding-left: 12px;">무이자할부 이용안내</h4>
			        <ol>
			<li class="item1">ㆍ상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.</li>
			            <li class="item2">ㆍ[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
			            <li class="item3">ㆍ단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
			            <li class="item4">ㆍ무이자할부 상품은 장바구니에서 별도 무이자할부 상품 영역에 표시되어, 무이자할부 상품 기준으로 배송비가 표시됩니다.<br/>&nbsp;&nbsp;&nbsp;실제 배송비는 함께 주문하는 상품에 따라 적용되오니 주문서 하단의 배송비 정보를 참고해주시기 바랍니다.</li>
			        </ol>
			</div>
		</div>

</div>

	

<jsp:include page="../footer.jsp"/>