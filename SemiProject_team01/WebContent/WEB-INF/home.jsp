<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="header.jsp"/>
<link rel="stylesheet" href="<%=ctxPath%>/css/kimdanim.css" />


<script type="text/javascript">

var lenNEW = 8;
var start = 1;

$(document).ready(function(){

	if(self.name!='reload'){
	      self.name='reload'
	      self.location.reload();
	   } else self.name="";
	
	$("span#totalNEWCount").hide();
	$("span#countNEW").hide();
	
		displayNEW(start);
	
	$(window).scroll(function(){
	
		if($(window).scrollTop() + 200 >= $(document).height() - $(window).height()){
		
			var totalNEWCount =   Number( $("span#totalNEWCount").text() );
	        var countNEW = Number( $("span#countNEW").text() );
	        
	         if( totalNEWCount != countNEW ) {
	            start = start + lenNEW;
	            displayNEW(start);
	         }
			
		} 
		
		 if( $(window).scrollTop() == 0){
			 //다시 처음부터 시작하도록 한다.
			 $("div#displayNEW").empty();
			 $("span#end").empty();
			 $("span#countNEW").text("0");
			 start = 1;
			 displayNEW(start);
		 }	
	
		 
		 
	
	}); // end of $(window).scroll(function() ------


}); //end of $(document).ready(function() --------------------

// Function Declaration
function displayNEW(start) { 
  $.ajax({
     url:"<%=ctxPath%>/product/prodDisplayJSON.to", 
  //   type:"GET",
     data:{"sname":"NEW"
         ,"start":start
         ,"len":lenNEW},
     dataType:"JSON",
     success:function(json){
        
         var html = "";
        
         if(start == "1" && json.length == 0) {
            html += "현재 상품 준비중....";
            
            $("div#displayNEW").html(html);
          }   
           
         else if( json.length > 0 ) {
           $.each(json, function(index, item){
                html += "<div class='moreProdInfo prodImg'>"+
               			"<div class='overlay' style='height:75px' onclick='location.href=\"<%=ctxPath%>/product/Info.to?pnum="+item.pnum+"\"'>"+
           					"<span>제품명 : "+item.pname+"</span><br>"+
			           		"<span style='text-decoration: line-through'>정가 : "+(item.price).toLocaleString('en')+"원</span><br>"+
			           		"<span>할인가 : "+(item.saleprice).toLocaleString('en')+"원</span>"+
         				"</div>"+
         				"<a href='<%=ctxPath%>/product/Info.to?pnum="+item.pnum+"'>"+
               				"<img class='prodImg' width='100%' height='300px' src='/SemiProject_team01/images/"+item.pimage1+"'>"+
         			  	"</a>"+
               			"</div>";
                  			 
             				  
              if ( (index+1)%4 == 0 ) {
                 html += "<br>";
              }
           }); // end of $.each(json, function(index, item){})------------
        
           // NEW 상품 결과를 출력하기
           $("div#displayNEW").append(html);
        
           // countNEW 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
           $("span#countNEW").text( Number($("span#countNEW").text()) + json.length ); 
           
           // 스크롤을 계속해서  countNEW 값과 totalNEWCount 값이 일치하는 경우 
           if( $("span#countNEW").text() == $("span#totalNEWCount").text() ) { 
              $("span#end").html("더이상 조회할 제품이 없습니다.");
           }
           
        }
        
     },
     error: function(request, status, error){
        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
     }
  });
  
}// end of function displayNEW( ){}-----------------------------
	

<%-- 제품 이미지 클릭시 제품 상세 페이지 이동--%>
function goProdDetail(pnum) {
	window.location.href = "<%=ctxPath%>/product/Info.to?pnum="+pnum;
}


</script>


<div id="content-container" class="content-width">

<!-- 광고/행사 배너 이미지 Carousel -->
<div id="demo" class="carousel slide" data-ride="carousel">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
  </ul>
  
  <!-- The slideshow    -->
  <div class="carousel-inner">
    	<div class="carousel-item active clickable">
	      <img class="clickable" src="<%=ctxPath%>/images/ad1.jpg" alt="ad1" width="100%" height="500" onclick="location.href='<%=ctxPath%>/List.to'">
	    </div>
	    <div class="carousel-item clickable">
	      <img class="clickable" src="<%=ctxPath%>/images/ad2.jpg" alt="ad2" width="100%" height="500" onclick="goProdDetail(this)">
	    </div>
	    <div class="carousel-item clickable">
	      <img class="clickable" src="<%=ctxPath%>/images/ad3.jpg" alt="ad3" width="100%" height="500" onclick="goProdDetail(this)">
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
	
	
<!-- 인기상품 이미지 슬라이드 -->	
<div class="hr-sect itemtitle">Best Seller</div>

<div class="container my-4">

  <!--Carousel Wrapper-->
  <div id="multi-item-example" class="carousel slide carousel-multi-item" data-ride="carousel">


    <!--Slides-->
    <div class="carousel-inner" role="listbox">

      <!--First slide-->
      <div class="carousel-item active">
        <div class="row">
	        <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
		        <c:if test="${status.index > 3 && status.index < 8}">
		        <div class="col-md-3" >
		            <div class="card mb-2">
		              <img style="width: 100%; height: 250px;" src="<%=ctxPath%>/images/${pvo.pimage1}" alt="Card image cap" onClick="#">
		              <div class="card-body" style="height: 180px">
		                <h6 class="card-title" style="font-weight: bold;">${pvo.pname}</h6>
		                <p class="card-text" style="margin-bottom: 5px">
		                <span style="text-decoration: line-through; color: #ccc; "><fmt:formatNumber value="${pvo.price}" pattern="#,###" /> 원</span><br>
		                <span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span></p>
		                <button class="prodview-btn" type="button" onclick="goProdDetail(${pvo.pnum});" style="margin-top: 0;">View</button>

		                
		              </div>
		            </div>
		          </div>
		       </c:if>
	        </c:forEach>
        </div>
      </div>
      <!--/.First slide-->

      <!--Second slide-->
      <div class="carousel-item">
        <div class="row">
	        <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
		        <c:if test="${status.index > 7}">
		        <div class="col-md-3">
		            <div class="card mb-2">
		              <img style="width: 100%; height: 250px;" src="<%=ctxPath%>/images/${pvo.pimage1}" alt="Card image cap">
		              <div class="card-body" style="height: 180px">
		                <h6 class="card-title" style="font-weight: bold;">${pvo.pname}</h6>
		              <p class="card-text" style="margin-bottom: 5px">
		                <span style="text-decoration: line-through; color: #ccc;"><fmt:formatNumber value="${pvo.price}" pattern="#,###" /> 원</span><br>
		                <span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span></p>
		                <button class="prodview-btn" type="button" onclick="goProdDetail(${pvo.pnum});" style="margin-top: 0;">View</button>
		              </div>
		            </div>
		          </div>
		       </c:if>
	        </c:forEach>
        </div>
      </div>
      <!--/.Second slide-->
      
      <!--Third slide-->
      <div class="carousel-item">
        <div class="row">
	        <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
		        <c:if test="${status.index < 4}">
		        <div class="col-md-3" >
		            <div class="card mb-2">
		              <img style="width: 100%; height: 250px;" src="<%=ctxPath%>/images/${pvo.pimage1}" alt="Card image cap">
		              <div class="card-body" style="height: 180px">
		                <h6 class="card-title" style="font-weight: bold;">${pvo.pname}</h6>
						<p class="card-text" style="margin-bottom: 5px">
		                <span style="text-decoration: line-through; color: #ccc;"><fmt:formatNumber value="${pvo.price}" pattern="#,###" /> 원</span><br>
		                <span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span></p>
         		        <button class="prodview-btn" type="button" onclick="goProdDetail(${pvo.pnum});" style="margin-top: 0;">View</button>
		              </div>
		            </div>
		          </div>
		       </c:if>
	        </c:forEach>
        </div>
      </div>
      <!--/.Third slide-->

    </div>
    <!--/.Slides-->

<!--Indicators-->
    <ol class="carousel-indicators" style="position: relative;">
      <li style="border:solid 1px gray;" data-target="#multi-item-example" data-slide-to="0" class="active"></li>
      <li style="border:solid 1px gray;" data-target="#multi-item-example" data-slide-to="1"></li>
      <li style="border:solid 1px gray;" data-target="#multi-item-example" data-slide-to="2"></li>
    </ol>
    <!--/.Indicators-->
  </div>
  <!--/.Carousel Wrapper-->


</div>



<!-- 신상품 이미지 Carousel -->
<div id="demo" class="carousel slide" data-ride="carousel" style="margin-top: 150px">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
  </ul>
  
  <!-- The slideshow -->
  <div class="carousel-inner">
    	<div class="carousel-item active clickable">
	      <img class="clickable" src="<%=ctxPath%>/images/newarrival1.jpg" alt="newarrival1" width="100%" height="500" onclick="goProdDetail(this)">
	    </div>
	    <div class="carousel-item clickable">
	      <img class="clickable" src="<%=ctxPath%>/images/newarrival2.jpg" alt="newarrival2" width="100%" height="500" onclick="goProdDetail(this)">
	    </div>
	    <div class="carousel-item clickable">
	      <img class="clickable" src="<%=ctxPath%>/images/newarrival3.jpg" alt="newarrival3" width="100%" height="500" onclick="goProdDetail(this)">
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
	
	<br>
	<br>
 
<!-- 신상품 제품 목록(스크롤 페이징 처리) --> 
 
<div class="hr-sect itemtitle">New Arrival</div>

   <div>
      <div id="displayNEW"></div>
   
      <div style="margin: 20px 0;">
        <span id="totalNEWCount">${requestScope.totalHITCount}</span>
         <span id="countNEW">0</span>
      </div>
   </div> 
 
 

</div> <!-- content-container End -->




<jsp:include page="footer.jsp"/>

