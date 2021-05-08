<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>::: ladies and gents :::</title>
<!-- common.css -->
<link rel="stylesheet" href="<%=ctxPath%>/css/common_recover.css"/>



<!-- Google Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

<!-- Bootstrap 4 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Bootstrap 4 icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

<script type="text/javascript">

$(document).ready(function(){
	//드롭다운 하위메뉴 숨기기
	 /* $("ul.dropdownlist").hide(); */
	
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

	console.log("${sessionScope.loginuser}");
	
	/* $("ul.dropdownlist").mouseover(function(){
		$(this).hide();
	});
	
	$("a.navmenu").hover(function(){	//마우스오버 시
			$("ul.dropdownlist").show();
		},
		function(){	//마우스아웃 시
			$("ul.dropdownlist").hide();
	}); */

	
	
});



</script>

</head>
<body>

<div id="navbar-fixed">
  <div id="top-nav-container" class="content-width">
	  <a href="<%=ctxPath%>/cscenter/csHome.to">고객센터</a>
	  <a href="<%=ctxPath%>/cart/cart.to">장바구니</a>
	  <c:if test="${not empty sessionScope.loginuser.userid}">
	  	<a href="<%=ctxPath%>/member/memberAccount.to">마이페이지</a>
	  </c:if>
	  <c:choose>
   		<c:when test="${empty sessionScope.loginuser}"><a href="<%=ctxPath%>/login/login.to">로그인</a></c:when>
   		<c:when test="${not empty sessionScope.loginuser}"><a href="<%=ctxPath%>/login/logout.to">로그아웃</a></c:when>
	  </c:choose> <!-- 로그아웃해도 기존 페이지에 머무르기 추가 -->

	  <a href="<%=ctxPath%>/member/memberRegister.to">회원가입</a>
	  <c:if test="${sessionScope.loginuser.userid eq 'admin'}">	<!-- 관리자 로그인 시 보이는 관리자 전용 페이지 이동 아이콘 -->	
	  	<a id="admin" href="<%=ctxPath%>/admin/home.to"><i class="fas fa-user-cog"></i></a>	
	  </c:if>
	  
  </div>
</div>

<div class="header">
	<a href="<%=ctxPath%>/home.to"><img style="margin-top: 5px;"src="<%=ctxPath%>/images/logo.jpg"/></a>
</div>



<div id="navbar" class="nohidden">
	<div id="bottom-nav-container" class="nav nohidden">
	    <ul class="nohidden">
	        <li class="nav-main">
	            <a class="navmenu" href="#">Best 상품</a>
	            <ul class="dropdownlist">
	                <li><a href="<%=ctxPath%>/product/prodListBySpec.to?snum=2&cnum=1">토트백</a></li>
	                <li><a href="<%=ctxPath%>/product/prodListBySpec.to?snum=2&cnum=2">숄더백</a></li>
	                <li><a href="<%=ctxPath%>/product/prodListBySpec.to?snum=2&cnum=3">백팩</a></li>
	                <li><a href="<%=ctxPath%>/product/prodListBySpec.to?snum=2&cnum=4">클러치백</a></li>
	            </ul>
	        </li>
	        <li class="nav-main">
	            <a class="navmenu" href="#">Sale 상품</a>
	            <ul class="dropdownlist">
	                <li><a href="<%=ctxPath%>/product/prodListBySpec.to?snum=3&cnum=1">토트백</a></li>
	                <li><a href="<%=ctxPath%>/product/prodListBySpec.to?snum=3&cnum=2">숄더백</a></li>
	                <li><a href="<%=ctxPath%>/product/prodListBySpec.to?snum=3&cnum=3">백팩</a></li>
	                <li><a href="<%=ctxPath%>/product/prodListBySpec.to?snum=3&cnum=4">클러치백</a></li>
	            </ul>
	        </li>
	        <li class="nav-main"><a class="navmenu" href="<%=ctxPath%>/List.to?cnum=1">토트백</a>
	        <li class="nav-main"><a class="navmenu" href="<%=ctxPath%>/List.to?cnum=2">숄더백</a></li>
	        <li class="nav-main"><a class="navmenu" href="<%=ctxPath%>/List.to?cnum=3">백팩</a></li>
	        <li class="nav-main"><a class="navmenu" href="<%=ctxPath%>/List.to?cnum=4">클러치백</a></li>
	        <li class="nav-main">
	        	<a class="navmenu" href="<%=ctxPath%>/List.to?cnum=5">악세사리</a>
	        </li>
	    </ul>
	</div>
</div>