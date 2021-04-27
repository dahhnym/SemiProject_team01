<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
<% String ctxPath=request.getContextPath(); %>

	<div id="demo" class="carousel slide" data-ride="carousel">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
  </ul>
  
  <!-- The slideshow -->
  <div class="carousel-inner">
    <div class="carousel-item active">
	      <img src="<%=ctxPath%>/images/pic01.jpg" alt="Los Angeles" width="100%" height="500">
	    </div>
	    <div class="carousel-item">
	      <img src="<%=ctxPath%>/images/pic02.jpg" alt="Chicago" width="100%" height="500">
	    </div>
	    <div class="carousel-item">
	      <img src="<%=ctxPath%>/images/pic03.jpg" alt="New York" width="100%" height="500">
    </div>
  </div>
  
  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>
	
	
	
	
	
	
	
	
	
	
	<h3 class="itemtitle">Best Seller</h3>
	
	신상품 multi item carousel 삽입
	
	
	<h3 class="itemtitle">New Arrival</h3>
	
	
	
	<p style="text-align: center;">제품 목록 이미지 추가</p>





<jsp:include page="/WEB-INF/footer.jsp"/>

