<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   

<jsp:include page="../header.jsp" />

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

	var lenHIT=8;
	// HIT 상품 "스크롤"을 할때 보여줄 상품의 개수(단위)크기 
	
	var start=1;
	
$(document).ready(function(){
		
		$("span#totalHITCount").hide();
		$("span#countHIT").hide();
		
		
		// HIT상품 게시물을 더보기 위하여 "스크롤" 이벤트에 대한 초기값 호출하기 
	    // 즉, 맨처음에는 "스크롤" 을 하지 않더라도 클릭한 것 처럼 8개의 HIT상품을 게시해주어야 한다는 말이다. 
	      displayHIT(start);
	
		// ====== 스크롤 이벤트 발생시키기 시작 ====== //
			$(window).scroll(function(){
				// 스크롤탑의 위치값 
			    //  console.log( "$(window).scrollTop() => " + $(window).scrollTop() );
			      
			       // 보여주어야할 문서의 높이값(더보기를 해주므로 append 되어져서 높이가 계속 증가 될것이다)
			       // console.log( "$(document).height() => " + $(document).height() );
			      
			       // 웹브라우저창의 높이값(디바이스마다 다르게 표현되는 고정값) 
			       // console.log( "$(window).height() => " + $(window).height() ); 
			      
			       // 아래는 이벤트가 발생되는 숫자를 만들기 위해서 스크롤탑의 위치값에 +1 을 더해서 보정해준 것이다.(디바이스 문제로 1을 더해주는 것이기 때문에 빼도 무방하다.)
			        console.log( "$(window).scrollTop() + 1  => " + ( $(window).scrollTop() + 1  ) );
			        console.log( "$(document).height() - $(window).height() => " + ( $(document).height() - $(window).height() ) );
			                      // 보여줄 전체 문서 높이   -   디바이스 높이: 앞으로 보여줄 문서 높이
			        if($(window).scrollTop()+1 >= $(document).height() - $(window).height()){
			        	
			        	var totalHITCount =   Number( $("span#totalHITCount").text() ); //36
			            var countHIT = Number( $("span#countHIT").text() ); // 8 16
			            
			             if( totalHITCount != countHIT ) {
			                start = start + lenHIT; //1+8=> 9
			                displayHIT(start);
			             }
			        }
			        
			        if($(window).scrollTop() == 0){ // 스크롤이 맨 위로 올라가면
			        	// 다시 처음부터 시작하도록 한다.
			        	$("div#displayHIT").empty();
			        	$("span#end").empty();
			        	$("span#countHIT").text("0");
			        	start=1;
			        	displayHIT(start);
			        }
			        
			});
		// ====== 스크롤 이벤트 발생시키기 끝 ====== //
	}); // end of $(document).ready(function(){});
	
	// display 할  HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	   function displayHIT(start) { // start가 1   이라면  1~8     까지 상품 8개를 보여준다.
	                          // start가 9   이라면  9~16   까지 상품 8개를 보여준다.
	                          // start가 17 이라면  17~24 까지 상품 8개를 보여준다.
	                          // start가 25 이라면  25~32 까지 상품 8개를 보여준다.
	                          // start가 33 이라면  33~36 까지 상품 4개를 보여준다.(마지막 상품) 
	      
	      $.ajax({
	         url:"/SemiProject_team01/product/mallDisplayJSON.to", 
	      //   type:"GET",
	         data:{"sname":"HIT"
	             ,"start":start  // "1"   "9"   "17"   "25"   "33"
	             ,"len":lenHIT}, //  8     8     8      8      8
	         dataType:"JSON",
	         success:function(json){
	        	 
	        	/*	
	 			//	console.log(json);
	 			//	console.log(typeof json); object
	 				
	 				var str_json = JSON.stringify(json); // JSON.stringify() : object를 string으로 변환해주는 함수
	 			//	console.log(typeof str_json); string으로 변환되었다.
	 				console.log(str_json);
	 			
	 				var obj_json = JSON.parse(str_json); // obj_json은 function함수 옆에 나와있는 json값과 일치한다.
	 			//	console.log(typeof obj_json); // object
	 			//	console.log(obj_json);
	 			*/
	 			
	            /*
	               json ==>  [{"pnum":1,"code":"100000","pname":"스마트TV","pcompany":"삼성","saleprice":800000,"point":50,"pinputdate":"2020-11-13","pimage1":"tv_samsung_h450_1.png","pqty":100,"pimage2":"tv_samsung_h450_2.png","pcontent":"42인치 스마트 TV. 기능 짱!!","price":1200000,"sname":"HIT"},{"pnum":2,"code":"100000","pname":"노트북","pcompany":"엘지","saleprice":750000,"point":30,"pinputdate":"2020-11-13","pimage1":"notebook_lg_gt50k_1.png","pqty":150,"pimage2":"notebook_lg_gt50k_2.png","pcontent":"노트북. 기능 짱!!","price":900000,"sname":"HIT"},{"pnum":3,"code":"200000","pname":"바지","pcompany":"S사","saleprice":10000,"point":5,"pinputdate":"2020-11-13","pimage1":"cloth_canmart_1.png","pqty":20,"pimage2":"cloth_canmart_2.png","pcontent":"예뻐요!!","price":12000,"sname":"HIT"},{"pnum":4,"code":"200000","pname":"남방","pcompany":"버카루","saleprice":13000,"point":10,"pinputdate":"2020-11-13","pimage1":"cloth_buckaroo_1.png","pqty":50,"pimage2":"cloth_buckaroo_2.png","pcontent":"멋져요!!","price":15000,"sname":"HIT"},{"pnum":5,"code":"300000","pname":"세계탐험보물찾기시리즈","pcompany":"아이세움","saleprice":33000,"point":20,"pinputdate":"2020-11-13","pimage1":"book_bomul_1.png","pqty":100,"pimage2":"book_bomul_2.png","pcontent":"만화로 보는 세계여행","price":35000,"sname":"HIT"},{"pnum":6,"code":"300000","pname":"만화한국사","pcompany":"녹색지팡이","saleprice":120000,"point":60,"pinputdate":"2020-11-13","pimage1":"book_koreahistory_1.png","pqty":80,"pimage2":"book_koreahistory_2.png","pcontent":"만화로 보는 이야기 한국사 전집","price":130000,"sname":"HIT"},{"pnum":7,"code":"100000","pname":"노트북1","pcompany":"DELL","saleprice":1000000,"point":60,"pinputdate":"2020-11-13","pimage1":"1.jpg","pqty":100,"pimage2":"2.jpg","pcontent":"1번 노트북","price":1200000,"sname":"HIT"},{"pnum":8,"code":"100000","pname":"노트북2","pcompany":"에이서","saleprice":1000000,"point":60,"pinputdate":"2020-11-13","pimage1":"3.jpg","pqty":100,"pimage2":"4.jpg","pcontent":"2번 노트북","price":1200000,"sname":"HIT"}] 
	               json ==>  []
	             */
	            
	             var html = "";
	            
	             if(start == "1" && json.length == 0) {
	                 // 처음부터 데이터가 존재하지 않는 경우
	                // !!! 주의 !!!
	                // if(json == null) 이 아님!!!
	                // if(json.length == 0) 으로 해야함!!
	                html += "현재 상품 준비중....";
	                
	                // HIT 상품 결과를 출력하기
	                $("div#displayHIT").html(html);
	              }   
	               
	             else if( json.length > 0 ) {
	               // 데이터가 존재하는 경우 
	               
	               $.each(json, function(index, item){
	                  
	            	   html +=  "<div class='moreProdInfo'>"+
			                       "<ul style='list-style-type: none; border: solid 0px red; padding :0px; width :220px;'>"+
			                          "<li style='border: solid 0px red; padding-bottom: 10px;'><a href='/SemiProject_team01/product/prodView.to?pnum="+item.pnum+"'><img width='120px;' height='130px' src='/SemiProject_team01/images/"+item.pimage1+"'/></a></li>"+
			                          "<li>"+item.pname+"</li>"+
			                          "<li>"+(item.saleprice).toLocaleString('en')+"<span> 원</span></li>"+
			                        "</ul>"+
			                  "</div>";
	                   
	                  if ( (index+1)%4 == 0 ) {
	                     html += "<br>";
	                  }
	               }); // end of $.each(json, function(index, item){})------------
	            
	               // HIT 상품 결과를 출력하기
	               $("div#displayHIT").append(html);
	            
	               // countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
	               $("span#countHIT").text( Number($("span#countHIT").text()) + json.length ); 
	               
	               // 스크롤을 계속해서  countHIT 값과 totalHITCount 값이 일치하는 경우 
	               if( $("span#countHIT").text() == $("span#totalHITCount").text() ) { 
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
	

<jsp:include page="../footer.jsp" />
