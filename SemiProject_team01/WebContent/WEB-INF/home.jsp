<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<title>::: ladies and gents:::</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<%=ctxPath%>/css/style.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

<header id="header" class="fixed-top header-scrolled">
	<div id="header-div">
		<nav id="header-top-nav">
			<ul>
				<li>회원가입</li>
				<li>로그인</li>
				<li>마이페이지</li>
				<li>장바구니</li>
				<li>고객센터</li>
			</ul>
			
		</nav>
		<a href="<%=ctxPath%>/home.to"><img id="logo" src="images/logo.jpg"/></a>
		<nav id="header-bottom-nav">
			<ul>
				<li>Best상품</li>
				<li>Sale상품</li>
				<li>토트백</li>
				<li>숄더백</li>
				<li>백팩</li>
				<li>클러치백</li>
				<li>악세사리</li>
			</ul>
		</nav>
	
	</div>
	
</header>
<div id="content-container">
	<div class="container">
	  <h2>Carousel Example</h2>  
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
	        <img src="<%=ctxPath%>/images/pic01.jpg" alt="pic01" style="width:100%;">
	      </div>
	
	      <div class="item">
	        <img src="<%=ctxPath%>/images/pic02.jpg" alt="pic02" style="width:100%;">
	      </div>
	    
	      <div class="item">
	        <img src="<%=ctxPath%>/images/pic03.jpg" alt="pic003" style="width:100%;">
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
	
	<p style="text-align: center; height: 500px; margin-top: 50px;">Best Seller</p>
	
	<p style="text-align: center; height: 500px;">New Arrival</p>
	
	<p style="text-align: center;">제품 목록 이미지 추가</p>
 </div>








<footer id="footer">
<hr style="margin-bottom: 15px;">
<div class="div-footer">
	<nav id="footer-nav">
		<ul>
			<li>회사소개</li><div class="divider"></div>
			<li>이용약관</li><div class="divider"></div>
			<li>개인정보처리방침</li><div class="divider"></div>
			<li>이용안내</li><div class="divider"></div>
			<li>제휴문의</li>
		</ul>
		<ul id="sns">
			<li><a href="https://facebook.com" target="_blank"><img class="snsicon" id="facebook" src="<%=ctxPath%>/images/facebook.png" /></a></li>
			<li><a href="https://instagram.com" target="_blank"><img class="snsicon" id="instagram" src="<%=ctxPath%>/images/instagram.png" /></a></li>
			<li><a href="https://twitter.com" target="_blank"><img class="snsicon" id="twitter" src="<%=ctxPath%>/images/twitter.png" /></a></li>
		</ul>
	</nav>
</div>
<hr style="margin-top: 15px; margin-bottom: 0">

<div class="container-fluid div-footer">
  <div class="row" style="height: 180px;">
    <div class="col-sm-4">
    	<div class="col-container">
	    	<p class="colname">고객센터</p>
	    	<p style="font-size: 25pt;">070-1234-5678</p>
	    	<p>평일 오전 10:00 ~ 오후 4:00 점심시간 오후 12:00 ~ 1:30 토/일/공휴일 휴무</p>
    	</div>
    </div>
     <div class="col-sm-4" style="padding-left: 100px;">
    	<p class="colname">Account Info</p>
    	<p>국민 김일조</p>
    	<p>654321-12-123456</p>
    	<select>
    		<option>인터넷뱅킹바로가기</option>
    		<option>국민은행</option>
    		<option>우리은행</option>
    		<option>기업은행</option>
    		<option>농협은행</option>
    		<option>산업은행</option>
    		<option>하나은행</option>
    		<option>부산은행</option>
    		<option>신한은행</option>
    	</select>
    </div>
    <div class="col-sm-4">
    	<p class="colname">Return/Exchange</p>
    	<p>서울특별시 강남구 oo대로 ooo oo빌딩 7층 ooo호</p>
    	<p>자세한 교환,반품절차 안내는 문의란 및 공지사항을 참고해주세요.</p>
    	
    </div>
  </div>
</div>
<hr style="margin: 0;">
<div class="bottom-footer" style="background-color: #f2f2f2; padding: 20px 0;">
	<div class="div-footer">
		<p>COMPANY : Ladies and gents&nbsp;&nbsp;&nbsp;OWNER: 김OO&nbsp;&nbsp;BUSINESS LICENSE : 000-00-00000 &nbsp;&nbsp;<span><button type="button" style="display: inline-block;">사업자정보조회</button></span></p>
		<p>ADDRESS: 12345 서울특별시 강남구 oo대로 ooo oo빌딩 7층 ooo호&nbsp;&nbsp;&nbsp;TEL : 000-0000-0000&nbsp;&nbsp;FAX: 0000-000-0000</p>
		<p>CPO: 최OO&nbsp;&nbsp;&nbsp;&nbsp;CONTACT US: abcd@gmail.com</p>
		<p>COPYRIGHT ⓒ Ladies and gents ALL RIGHTS RESERVED.</p>
	</div>

</div>
</footer>

</body>
</html>

