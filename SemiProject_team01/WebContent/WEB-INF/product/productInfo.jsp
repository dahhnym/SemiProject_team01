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
			<br><br><br>
			<span id="sale">10%<span id="normalprice">10000원</span></span><span id="price">9000원</span>
			<br><br><br><br><br><br>
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
			<br><br><br><br><br><br>
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
		
		<div>
			
		</div>
		
		
		
	</div>
	
	






<jsp:include page="../footer.jsp" />