<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<jsp:include page="../kimdanim/header.jsp"/>

<style type="text/css">


div#cartcontainer{
	margin: 200px auto;
}
div#contents{
	position: relative; 
	width:100%;
	margin: 0 auto;
}

div.information{
	display: table;
	padding: 10px 0;
	width:100%;
	table-layout: fixed;
	box-sizing: border-box;
	border: solid 1px #CCD1D1;
}

div.information .decription{
	display: table-cell;
	padding: 0 10px;
	width: auto;
	line-height: 1.5em;
	vertical-align: middle;
	text-align: center;

}

div.displaynone{
	margin: 40px 0px;
}
table{
	width:100%;
	border-top: solid 1px #CCD1D1;
	border-bottom: solid 1px #CCD1D1;
}

div.option_change{
	padding: 0px;
	background-color: #909497;
	width:450px;
}

div.option_layer{
	position: absolute;
	z-index: 100;
	border: solid 1px #909497;
	background-color: white;
	padding: 0px;
	}
div.option_header{
	background-color: #909497;
	padding: 0.3px 35px 0.3px 19px;
	margin-top:0px;
	color: white;
	height: 36px;
}
div.close{
	position: absolute;
	right:0;
	top:0;
	cursor: pointer;
	padding: 5px 20px;
}

h3{
margin:9px 3px;
font-size: 12pt;
}

span.btn_option{
	display: inline-block;
	border: solid 1px #CCD1D1;
	cursor: pointer;
	margin-top: 10px;
	padding: 0px 7px;
	font-size: 10pt;
	width: 107px;
	text-align: center;
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

a.btnLarge{
	display: inline-block;
	width: 160px;
	height: 50px;
	border-radius: 0px;
	font-weight: bold;
	cursor: pointer;
	text-align: center;
	padding: 14px 14px;
	text-decoration: none;
	opacity: 1;
}

a#allorder{
	background-color: black;
	color:white;
	border: solid 1px black;
	margin: 0px 10px 0px 600px;
}

a#seperateorder{
	background-color: #E5E8E8 ;
	color:black;
	border: solid 1px #CCD1D1 ;
}

a#shoppingcon{
	background-color: white ;
	color:black;
	border: solid 1px #CCD1D1 ;
	
}

span.btn_right{
	float: right;
}

span.small_btn{
	height: 30px;
	padding-top: 5px;
	margin-bottom: 10px;
}

div.title{
	margin: 35px 0px;
}
</style>

<script type="text/javascript">

$(document).ready(function(){
	
	$("div.option_change").hide();
	
	$("span#one_optionchange").click(function(){
		var $target = $(event.target);
		$target.next().show();
	});
	
	$("div.close").click(function(){
		$("div.option_change").hide();
	})
	
	
	// 장바구니 비우기 
	$("span#deleteCart").click(function(){
		var deleteOk = confirm("장바구니를 비우시겠습니까?");

		if(deleteOk==true){
			// 확인버튼을 누른다면 
			location.href="";
		}
		else{
			// 비우기 취소
			alert("삭제를 취소하였습니다.");
		}
	});
	
	
});

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
						<p>적립금:</p>
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
					<tr>
						<td scope="col"><input type="checkbox" id="oneProdCheck"/> </td>
						<td scope="col">이미지</td>
					    <td scope="col" style="text-align: left;">상품정보<br>
					    	<span id="one_optionchange" class="btn_option" style="width: 70px;">옵션변경</span>
					    	<div class="option_change option_layer" style="display: block;">
					    		<div class="option_header"><h3>옵션변경</h3></div>
					    		
					    		<div class="close"><img alt="x" src="images/btn_close.gif"></div>
					    		<div class="optionChange_contents">상품 이미지</div>
					    		
					    		<div class="optionChange_footer">
									<span class="btn_option small_btn" style="width: 70px; margin-left:150px">추가</span>
									<span class="btn_option small_btn" style="width: 70px;">변경</span>
								</div>
					    	</div>
					    </td>
					    <td scope="col">판매가</td>
					    <td scope="col">
					    	<input type="text" id="prod_cnt" maxlength="2">
					    	<span id="prod_count" class="btn_option" style="width: 50px;">변경</span><br>
					    </td>
					    <td scope="col">적립금</td>
					    <td scope="col">배송비</td>
					    <td scope="col">합계</td>
					    <td scope="col">
					    	<span id="prod_order" class="btn_option">주문하기</span><br>
					    	<span id="prodtowish" class="btn_option">위시리스트담기</span><br>
					    	<span id="proddelete" class="btn_option" style="margin-bottom: 5px;">삭제</span>
					    </td>
					</tr>
				</tbody>
				
			</table>
			<span id="deleteCart" class="btn_option" style="width: 120px;">장바구니 비우기</span>
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
						<td scope="col">이미지</td>
					    <td scope="col" style="text-align: left;">상품정보<br>
					    	<span id="one_optionchange" class="btn_option" style="width: 70px;">옵션변경</span>
					    	<div class="option_change option_layer" style="display: block;">
					    		<div class="option_header"><h3>옵션변경</h3></div>
					    		
					    		<div class="close"><img alt="x" src="images/btn_close.gif" ></div>
					    		<div class="optionChange_contents">상품 이미지</div>
					    		<div class="optionChange_footer">
									<span class="btn_option small_btn" style="width: 70px; margin-left: 180px;">변경</span>
								</div>
					    	</div>
					    </td>
					    <td scope="col">판매가</td>
					    <td scope="col">적립금</td>
					    <td scope="col">배송비</td>
					    <td scope="col">합계</td>
					    <td scope="col">
					    	<span id="prod_order" class="btn_option">주문하기</span><br>
					    	<span id="prodtowish" class="btn_option">위시리스트담기</span><br>
					    	<span id="proddelete" class="btn_option" style="margin-bottom: 5px;">삭제</span>
					    </td>
					</tr>
					
					
				</tbody>
				
			</table>
		
		
		</div>

</div>	




<jsp:include page="../kimdanim/footer.jsp"/>