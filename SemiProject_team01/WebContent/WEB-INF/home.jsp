<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="header.jsp"/>
<link rel="stylesheet" href="<%=ctxPath%>/css/kimdanim.css" />


<script type="text/javascript">

var lenNEW = 8;
var start = 1;

$(document).ready(function(){

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
               			"<div class='overlay' style='height:75px' onclick='location.href=\"<%=ctxPath%>/Info.to?pnum="+item.pnum+"\"'>"+
           					"<span>제품명 : "+item.pname+"</span><br>"+
			           		"<span style='text-decoration: line-through'>정가 : "+(item.price).toLocaleString('en')+"원</span><br>"+
			           		"<span>할인가 : "+(item.saleprice).toLocaleString('en')+"원</span>"+
         				"</div>"+
         				"<a href='<%=ctxPath%>/Info.to?pnum="+item.pnum+"'>"+
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
function goProdDetail(imgs) {
	window.location.href = "<%=ctxPath%>/Info.to?pnum=${requestScope.pvo.pnum}";
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

<div class="slide-container">
      	<div class="container-fluid">
      		<div id="carousel-example" class="carousel slide" data-ride="carousel">
      			<div class="carousel-inner row w-75 mx-auto" role="listbox">
   					<div class="carousel-item col-12 col-sm-6 col-md-4 col-lg-4 active slideImg">
   					<table>
   						<tbody>
   							<tr>
   								<td>
					  <div style="float: left; border: solid 1px blue;">
						<img src="/SemiProject_team01/images/w-backpack1.jpg" class="img-fluid mx-auto d-block" alt="img1">
	          			<div id="prodInfo">
	           				<ul>
	           					<li><label class="prodInfoList">제품명</label>화이트백팩</li>
	           					<li><label class="prodInfoList">정가</label>12,000원</li>
	           					<li><label class="prodInfoList">할인가</label>10,000원</li>
	           				</ul>
						</div>
						</div>
						</td>
						<td>
					  <div style="float: left; border: solid 1px blue;">
						<img src="/SemiProject_team01/images/w-backpack3.jpg" class="img-fluid mx-auto d-block" alt="img2">
						<div id="prodInfo">
	           				<ul>
	           					<li><label class="prodInfoList">제품명</label>화이트백팩</li>
	           					<li><label class="prodInfoList">정가</label>12,000원</li>
	           					<li><label class="prodInfoList">할인가</label>10,000원</li>
	           				</ul>
						</div>
					</div>
					</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="carousel-item col-12 col-sm-6 col-md-4 col-lg-3 slideImg">
					<img src="/SemiProject_team01/images/w-backpack5.jpg" class="img-fluid mx-auto d-block" alt="img3">
					<div id="prodInfo">
           				<ul>
           					<li><label class="prodInfoList">제품명</label>화이트백팩</li>
           					<li><label class="prodInfoList">정가</label>12,000원</li>
           					<li><label class="prodInfoList">할인가</label>10,000원</li>
           				</ul>
					</div>
				</div>
				<div class="carousel-item col-12 col-sm-6 col-md-4 col-lg-3 slideImg">
					<img src="/SemiProject_team01/images/w-backpack7.jpg" class="img-fluid mx-auto d-block" alt="img4">
					<div id="prodInfo">
           				<ul>
           					<li><label class="prodInfoList">제품명</label>화이트백팩</li>
           					<li><label class="prodInfoList">정가</label>12,000원</li>
           					<li><label class="prodInfoList">할인가</label>10,000원</li>
           				</ul>
					</div>
				</div>
				<div class="carousel-item col-12 col-sm-6 col-md-4 col-lg-3 slideImg">
					<img src="/SemiProject_team01/images/w-backpack9.jpg" class="img-fluid mx-auto d-block" alt="img5">
					<div id="prodInfo">
           				<ul>
           					<li><label class="prodInfoList">제품명</label>화이트백팩</li>
           					<li><label class="prodInfoList">정가</label>12,000원</li>
           					<li><label class="prodInfoList">할인가</label>10,000원</li>
           				</ul>
					</div>
				</div>
				<div class="carousel-item col-12 col-sm-6 col-md-4 col-lg-3 slideImg">
					<img src="/SemiProject_team01/images/w-backpack11.jpg" class="img-fluid mx-auto d-block" alt="img6">
					<div id="prodInfo">
           				<ul>
           					<li><label class="prodInfoList">제품명</label>화이트백팩</li>
           					<li><label class="prodInfoList">정가</label>12,000원</li>
           					<li><label class="prodInfoList">할인가</label>10,000원</li>
           				</ul>
					</div>
				</div>
				<div class="carousel-item col-12 col-sm-6 col-md-4 col-lg-3 slideImg">
					<img src="/SemiProject_team01/images/w-backpack13.jpg" class="img-fluid mx-auto d-block" alt="img7">
					<div id="prodInfo">
           				<ul>
           					<li><label class="prodInfoList">제품명</label>화이트백팩</li>
           					<li><label class="prodInfoList">정가</label>12,000원</li>
           					<li><label class="prodInfoList">할인가</label>10,000원</li>
           				</ul>
					</div>
				</div>
				<div class="carousel-item col-12 col-sm-6 col-md-4 col-lg-3 slideImg">
					<img src="/SemiProject_team01/images/w-backpack15.jpg" class="img-fluid mx-auto d-block" alt="img8">
					<div id="prodInfo">
           				<ul>
           					<li><label class="prodInfoList">제품명</label>화이트백팩</li>
           					<li><label class="prodInfoList">정가</label>12,000원</li>
           					<li><label class="prodInfoList">할인가</label>10,000원</li>
           				</ul>
					</div>
				</div>
      			</div>
      			<a class="carousel-control-prev" href="#carousel-example" role="button" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a>
			<a class="carousel-control-next" href="#carousel-example" role="button" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
      		</div>
      	</div>
      </div>



<!-- 신상품 이미지 Carousel -->
<div id="demo" class="carousel slide" data-ride="carousel" style="margin-top: 100px">

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

