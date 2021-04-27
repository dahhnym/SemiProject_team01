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
				<li id="register">회원가입</li>
				<li>로그인</li>
				<li>마이페이지</li>
				<li>장바구니</li>
				<li>고객센터</li>
			</ul>
			
		</nav>
		<a href="<%=ctxPath%>/home.to"><img id="logo" src="../images/logo.jpg"/></a>
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