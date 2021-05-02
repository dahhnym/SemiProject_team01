<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   

<%--  <jsp:include page="../header.jsp" /> --%>

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

	var lenList=8;
	// HIT 상품 "스크롤"을 할때 보여줄 상품의 개수(단위)크기 
	
	var start=1;
	
	$(document).ready(function(){
		
		$("span#totalListCount").hide();
		$("span#countList").hide();
		
		
		// HIT상품 게시물을 더보기 위하여 "스크롤" 이벤트에 대한 초기값 호출하기 
	    // 즉, 맨처음에는 "스크롤" 을 하지 않더라도 클릭한 것 처럼 8개의 HIT상품을 게시해주어야 한다는 말이다. 
	      displayList(start);
	
		// ====== 스크롤 이벤트 발생시키기 시작 ====== //
			$(window).scroll(function(){		      
			       // 아래는 이벤트가 발생되는 숫자를 만들기 위해서 스크롤탑의 위치값에 +1 을 더해서 보정해준 것이다.(디바이스 문제로 1을 더해주는 것이기 때문에 빼도 무방하다.)
			        console.log( "$(window).scrollTop() + 1  => " + ( $(window).scrollTop() + 1  ) );
			        console.log( "$(document).height() - $(window).height() => " + ( $(document).height() - $(window).height() ) );
			                      // 보여줄 전체 문서 높이   -   디바이스 높이: 앞으로 보여줄 문서 높이
			        if($(window).scrollTop()+1 >= $(document).height() - $(window).height()){
			        	
			        	var totalListCount =   Number( $("span#totalListCount").text() ); 
			            var countList = Number( $("span#countList").text() ); // 8 16
			            
			             if( totalListCount != countList ) {
			                start = start + lenList; //1+8=> 9
			                displayList(start);
			             }
			        }
			        
			        if($(window).scrollTop() == 0){ // 스크롤이 맨 위로 올라가면
			        	// 다시 처음부터 시작하도록 한다.
			        	$("div#displayList").empty();
			        	$("span#end").empty();
			        	$("span#countList").text("0");
			        	start=1;
			        	displayHIT(start);
			        }
			        
			});
		// ====== 스크롤 이벤트 발생시키기 끝 ====== //
	}); // end of $(document).ready(function(){});
	
	// display 할  List상품 정보를 추가 요청하기(Ajax 로 처리함)
	   function displayList(start) { 
	      
	      $.ajax({
	         url:"/SemiProject_team01/poduct/mallDisplayJSON.to", 
	      //   type:"GET",
	         data:{"start":start  // "1"   "9"   "17"   "25"   "33"
	             ,"len":lenList}, //  8     8     8      8      8
	         dataType:"JSON",
	         success:function(json){
	        	 
	            
	             var html = "";
	            
	             if(start == "1" && json.length == 0) {
	                 // 처음부터 데이터가 존재하지 않는 경우
	                html += "현재 상품 준비중....";
	                
	                // List 상품 결과를 출력하기
	                $("div#displayList").html(html);
	              }   
	               
	             else if( json.length > 0 ) {
	               // 데이터가 존재하는 경우 
	               
	               $.each(json, function(index, item){
	                  
	                  html +=  "<div class='moreProdInfo'>"+
		                           "<ul style='list-style-type: none; border: solid 0px red; padding :0px; width :220px;'>"+
		                              "<li style='border: solid 0px red; padding-bottom: 10px;'><a href='/SemiProject_team01/product/prodView.up?pnum="+item.pnum+"'><img width='120px;' height='130px' src='/MyMVC/images/"+item.pimage1+"'/></a></li>"+
		                              "<li>"+item.pname+"</li>"+
	                                  "<li>"+(item.saleprice).toLocaleString('en')+"<span> 원</span></li>"+
	                                "</ul>"+
	                          "</div>";
	                   
	                  if ( (index+1)%4 == 0 ) {
	                     html += "<br>";
	                  }
	               }); // end of $.each(json, function(index, item){})------------
	            
	               // HIT 상품 결과를 출력하기
	               $("div#displayList").append(html);
	            
	               // countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
	               $("span#countList").text( Number($("span#countList").text()) + json.length ); 
	               
	               // 스크롤을 계속해서  countHIT 값과 totalHITCount 값이 일치하는 경우 
	               if( $("span#countList").text() == $("span#totalListCount").text() ) { 
	                  $("span#end").html("더이상 조회할 제품이 없습니다.");
	               }
	               
	               // header.jsp 의 하단에 표시된 div content 의 height 값을 구해서, header.jsp 의 div sideinfo 의 height 값으로 설정하기 
	               func_height(); // footer2.jsp 에 있음
	            }
	            
	         },
	         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
	      });
	      
	   }// end of function displayHIT( ){}-----------------------------
</script>


	<div id="sortby">
	<br><br><br>
		<nav id="sortby-nav">
			<ul>
				<li>높은가격순</li>
				<li>낮은가격순</li>
				<li>신상품순</li>
				<li>리뷰순</li>
			</ul>
		</nav>
		
		<div id="image" style="display: inline-block; margin: 20px 0;">
			<span id="end" style="font-size: 16pt; font-weight: bold; color: red;"></span><br/>
			<span id="totalListCount">${requestScope.totalListCount}</span>
			<span id="countList">0</span>
		</div>
		
	</div>
	

<%--  <jsp:include page="../footer.jsp" /> --%>
