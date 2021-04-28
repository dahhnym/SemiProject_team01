<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- common.css -->
<link rel="stylesheet" href="../css/common.css"/>

<!-- Google Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

<!-- Bootstrap 4 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	window.onscroll = function() {myFunction()};

	var navbarfixed = document.getElementById("navbar-fixed");
	var navbar = document.getElementById("navbar");

	var sticky = navbar.offsetTop;

	console.log(sticky);

	function myFunction() {
	  if (window.pageYOffset >= sticky) {
	    navbar.classList.add("sticky");
	  } else {
	    navbar.classList.remove("sticky");
	  }
	}
	
});


</script>

</head>
<body>

<div id="navbar-fixed">
  <div id="top-nav-container" class="content-width">
	  <a href="javascript:void(0)">고객센터</a>
	  <a href="javascript:void(0)">장바구니</a>
	  <a href="javascript:void(0)">마이페이지</a>
	  <a href="javascript:void(0)">로그인</a>
	  <a href="javascript:void(0)">회원가입</a>
  </div>
</div>

<div class="header">
	<img style="margin-top: 5px;"src="<%=ctxPath%>/images/logo.jpg"/>
</div>

<div id="navbar">
	<div id="bottom-nav-container" class="content-width">
		<div id="bottom-nav-first" >
		  <a href="javascript:void(0)">Best상품</a>
		  <a href="javascript:void(0)">Sale상품</a>
		</div>  
		<div id="bottom-nav-second">
		  <a href="javascript:void(0)">토트백</a>
		  <a href="javascript:void(0)">숄더백</a>
		  <a href="javascript:void(0)">백백</a>
		  <a href="javascript:void(0)">클러치백</a>
		  <a href="javascript:void(0)">악세사리</a>
		</div>
	</div>
</div>