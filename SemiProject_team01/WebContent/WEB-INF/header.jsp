<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>::: ladies and gents :::</title>
<!-- common.css -->
<link rel="stylesheet" href="<%=ctxPath%>/css/common.css"/>



<!-- Google Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

<!-- Bootstrap 4 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">




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
	  <a href="<%=ctxPath%>/cscenter/csHome.to">고객센터</a>
	  <a href="<%=ctxPath%>/cart/cart.to">장바구니</a>
	  <a href="javascript:void(0)">마이페이지</a>
	  <a href="javascript:void(0)">로그인</a>
	  <a href="<%=ctxPath%>/member/memberRegister.to">회원가입</a>
  </div>
</div>

<div class="header">
	<a href="<%=ctxPath%>/home.to"><img style="margin-top: 5px;"src="<%=ctxPath%>/images/logo.jpg"/></a>
</div>

<div id="navbar">
	<div id="bottom-nav-container" class="content-width">
			  <a href="<%=ctxPath%>/List.to">Best상품</a>
			  <a href="<%=ctxPath%>/List.to">Sale상품</a>
			  <a href="<%=ctxPath%>/List.to">토트백</a>
			  <a href="<%=ctxPath%>/List.to">숄더백</a>
			  <a href="<%=ctxPath%>/List.to">백백</a>
			  <a href="<%=ctxPath%>/List.to">클러치백</a>
			  <a href="<%=ctxPath%>/List.to">악세사리</a>
	</div>
</div>