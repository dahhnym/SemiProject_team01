<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="../header.jsp" />




<style>
	div#info {
		width: 1300px;
		margin-left: 300px;
		margin-right: auto;
		/*border: solid 1px red;*/
	}
	
	nav#info-list {
		text-align: left;
		margin-top: 0;
		/*border: solid 1px blue;*/
	}

	nav#info-list > ul > li {
		font-size: 20px;
		font-weight: bold;
		display: inline;
	}
	
	div#imagebox{
		float:left;
		height: 1000px;
		width: 650px;
		margin-left: 0px;
		margin-right: auto;
		border: solid 1px gray; 
		
	}
	
	div#myCarousel {
		height: 700px;
		width: 600px;
		margin-top: 50px;
		margin-left: auto;
		margin-right: auto;
	}
	
	div#order{
		float:left;
		position:relative;
		height: 1000px;
		width: 648px;
		margin-left: auto;
		margin-right: 0px;
		border: solid 1px gray; 
		border-left-style: none;
		padding: 50px;
	}
	
	span#itemname {
		font-size: 40px;
		font-weight: bold;
		/*border: solid 1px red;*/
	}
	
	span#sale {
		font-size: 45px;
		font-weight: bold;
		color: red;
		/*border: solid 1px red;*/
	}
	
	span#normalprice {
		font-size: 20px;
		font-weight: bold;
		color: gray;
		text-decoration: line-through;
		text-align:right;
		margin-left: 280px;
		margin-bottom: 40px;
		/*border: solid 1px red;*/
		
	}
	
	span#price {
		font-size: 30px;
		font-weight: bold;
		color: black;
		text-decoration: none;
		float: right;
		margin-left: 0px;
		margin-top: 20px;
	}
	
	 fieldset {
      border: 0;
    }
    label {
      display: block;
      margin: 30px 0 0 0;
    }
    .overflow {
      height: 200px;
    }
    
    select#option1 {
    	width: 80%;
    	height: 10%;
    	margin-left: 50px;
		margin-right: auto;
		font-size: 30px;
		/*border: solid 1px red;*/
    }
    
    option#choption{
    	font-size: 30px;
    	
    }
    div#basket {
    	width: 250px;
    	height: 80px;
    	float: left;
    	/*border: solid 1px red;*/
    }
    
    div#wish {
    	width: 250px;
    	height: 80px;
    	float: right;
    	/*border: solid 1px red;*/
    }
    
    div#buynow{
    	width: 500px;
    	height: 80px;
    	/*border: solid 1px red;*/
    	margin-left: 80px;
    }
    
    .btn-primary {
    	width: 250px;
    	height: 80px;
    	
    }
    
    .btn-success {
    	float: right;
    	width: 550px;
    	height: 80px;
    	
    }
    
    span#texttest {
    	font-size: 30px;
    }
    
   	div#bestproductdiv{
    	padding-top: 1050px;
    	/*border: solid 1px red;*/
    }
    
    span#tbltextname {
    	font-size: 15px;
    }
    
    span#tblbestprice {
    	font-size: 15px;
    	font-weight: bold;
    }
    
    li#tabli {
    	width: 324px;
    	font-size: 20px;
    	text-align: center;
    }
    
    td.qasort {
    	width: 100px;
    	border: solid 1px red;
    	text-align: center;
    }
    
    span.qasorttext{
    	font-size: 20px;
    }
    
    

	
</style>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script>
  $( function() {
    $( "#speed" ).selectmenu();
 
    $( "#files" ).selectmenu();
 
    $( "#number" )
      .selectmenu()
      .selectmenu( "menuWidget" )
        .addClass( "overflow" );
 
    $( "#salutation" ).selectmenu();
  } );
 </script>


	<div id="info">
		<nav id="info-list">
			<ul>
				<li>반복문 추가해서 들어온 순서대로 쓰일수 있도록함</li>	
			</ul>
		</nav>
		<div id="imagebox">
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
			  <!-- Indicators -->
			  <ol class="carousel-indicators">
			    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			    <li data-target="#myCarousel" data-slide-to="1"></li>
			    <li data-target="#myCarousel" data-slide-to="2"></li>
			  </ol>
			
			  <!-- Wrapper for slides -->
			  <div class="carousel-inner">
			    <div class="item active">
			      <img src="<%=ctxPath%>/images/pic01.jpg" style="width:100%; height:100%">
			    </div>
			
			    <div class="item">
			      <img src="<%=ctxPath%>/images/pic02.jpg" style="width:100%; height:100%">
			    </div> 
			
			    <div class="item">
			      <img src="<%=ctxPath%>/images/pic03.jpg" style="width:100%; height:100%">
			    </div>
			  </div>
			
			  <!-- Left and right controls -->
			  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
			    <span class="glyphicon glyphicon-chevron-left"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="right carousel-control" href="#myCarousel" data-slide="next">
			    <span class="glyphicon glyphicon-chevron-right"></span>
			    <span class="sr-only">Next</span>
			  </a>
			</div>
			
			
		</div>
		<div id="order">
			<span id="itemname">제품명</span>
			<br><br>
			<hr style="background:#fff; height:5px; color:#fff; display:block;">
			<br>
			<span id="sale">10%<span id="normalprice">10000원</span></span><span id="price">9000원</span>
			<br><br><br>
			<hr style="background:#fff; height:5px; color:#fff; display:block;">
			<br><br><br>
			<div class="demo">
 
				<form action="#">
				 
				  <fieldset>
				    <select name="옵션1" id="option1">
				      <option selected="selected" id="choption">옵션을 선택하세요</option>
				      <option id="choption">예시옵션1</option>
				      <option id="choption">예시옵션2</option>
				      <option id="choption">예시옵션3</option>
				      <option id="choption">예시옵션4</option>
				    </select>
				   </fieldset>
				  </form>
			</div>
			<br><br><br>
			<div class="demo">
 
				<form action="#">
				 
				  <fieldset>
				    <select name="옵션1" id="option1">
				      <option selected="selected" id="choption">옵션을 선택하세요</option>
				      <option id="choption">예시옵션1</option>
				      <option id="choption">예시옵션2</option>
				      <option id="choption">예시옵션3</option>
				      <option id="choption">예시옵션4</option>
				    </select>
				   </fieldset>
				  </form>
			</div>
			<br><br><br>
			<hr style="background:#fff; height:5px; color:#fff; display:block;">
			<br><br><br>
			<div id="button-container">
				<div class="container" id="basket">      
				  <button type="button" class="btn btn-primary"><span id="texttest">장바구니</span></button>
				</div>
				
				<div class="container" id="wish">      
				  <button type="button" class="btn btn-primary"><span id="texttest">위시리스트</span></button>
				</div>
			</div>
			<br><br><br><br><br>
			<div>
				<div class="container" id="buynow">     
				  <button type="button" class="btn btn-success"><span id="texttest">바로구매</span></button>
				</div>
			</div>
			
		</div>
		
		<div id="bestproductdiv">
			<table>
				<tr>
					<td><img src="<%=ctxPath%>/images/pic01.jpg" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="<%=ctxPath%>/images/pic02.jpg" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="<%=ctxPath%>/images/pic03.jpg" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="<%=ctxPath%>/images/pic01.jpg" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="<%=ctxPath%>/images/pic02.jpg" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="<%=ctxPath%>/images/pic03.jpg" style="width:130px; height:150px; margin-left:75px;"></image></td>
				</tr>
				<tr>
					<td style="padding-left: 100px;"><span id="tbltextname">상품명1</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">상품명2</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">상품명3</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">상품명4</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">상품명5</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">상품명6</span></td>
				</tr>
				<tr>
					<td style="padding-left: 100px;"><span id="tblbestprice">10000원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">11000원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">12000원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">13000원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">14000원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">15000원</span></td>
				</tr>
			</table>
		</div>
		
		<div>
			<br><br><br><br>
		  <ul class="nav nav-tabs">
		    <li class="active" id="tabli"><a data-toggle="tab" href="#home">상세정보</a></li>
		    <li id="tabli"><a data-toggle="tab" href="#menu1">리뷰</a></li>
		    <li id="tabli"><a data-toggle="tab" href="#menu2">Q&A</a></li>
		    <li id="tabli"><a data-toggle="tab" href="#menu3">반품/교환정보</a></li>
		  </ul>
		
		  <div class="tab-content">
		    <div id="home" class="tab-pane fade in active">
		      <img src="/images/pic01.jpg">
		    </div>
		    <div id="menu1" class="tab-pane fade">
		      <h3>Menu 1</h3>
		      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		    </div>
		    <div id="menu2" class="tab-pane fade">
		      <table>
		      	<tr>
		      		<td class="qasort"><span class="qasorttext">No</span></td>
		      		<td class="qasort"><span class="qasorttext">답변상태</span></td>
		      		<td class="qasort"><span class="qasorttext">제목</span></td>
		      		<td class="qasort"><span class="qasorttext">작성자</span></td>
		      		<td class="qasort"><span class="qasorttext">작성일</span></td>
		      	</tr>
		      
		      </table>
		    </div>
		    <div id="menu3" class="tab-pane fade">
		      <div class="well">
			      교환/반품 제한사항 
				ㆍ주문/제작 상품의 경우, 상품의 제작이 이미 진행된 경우
				ㆍ상품 포장을 개봉하여 사용 또는 설치 완료되어 상품의 가치가 훼손된 경우 (단, 내용 확인을 위한 포장 개봉의 경우는 예외)
				ㆍ고객의 사용, 시간경과, 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우
				ㆍ세트상품 일부 사용, 구성품을 분실하였거나 취급 부주의로 인한 파손/고장/오염으로 재판매 불가한 경우
				ㆍ모니터 해상도의 차이로 인해 색상이나 이미지가 실제와 달라, 고객이 단순 변심으로 교환/반품을 무료로 요청하는 경우
				ㆍ제조사의 사정 (신모델 출시 등) 및 부품 가격 변동 등에 의해 무료 교환/반품으로 요청하는 경우
		      </div>
		    </div>
		  </div>
		</div>
		
	</div>
	
	






<jsp:include page="../footer.jsp" />