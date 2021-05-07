<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="<%=ctxPath%>/css/kimdanim.css" />

<style>
	div#sortby {
		width: 1500px;
		margin-left: auto;
		margin-right: auto;
	}
	
	nav#sortby-nav {
		text-align: right;
		margin-top: 0;
	}

	nav#sortby-nav > ul > li {
		font-size: 20px;
		font-weight: bold;
		display: inline;
	}
	
	
</style>

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
     url:"<%=ctxPath%>/product/prodDisplayJSON2.to?cnum=${map.cnum}", 
  //   type:"GET",
     data:{"cnum": cnum
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
	window.location.href = "<%= ctxPath %>/Info.to?pnum=${requestScope.pvo.pnum}";
}

</script>


	<div id="sortby">
	<br><br><br>
		<!-- <nav id="sortby-nav">
			<ul>
				<li>높은가격순</li>
				<li>낮은가격순</li>
				<li>신상품순</li>
				<li>리뷰순</li>
			</ul>
		</nav> -->
		<div class="hr-sect itemtitle">BEST Arrival</div>

	   <div>
	      <div id="displayNEW"></div>
	   
	      <div style="margin: 20px 0;">
	        <span id="totalNEWCount">${requestScope.totalHITCount}</span>
	         <span id="countNEW">0</span>
	      </div>
	   </div> 
	 	
	</div>
	

<jsp:include page="../footer.jsp" />
