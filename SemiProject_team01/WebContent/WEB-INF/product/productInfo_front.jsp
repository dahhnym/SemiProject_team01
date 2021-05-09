<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="<%=ctxPath%>/css/kimdanim.css"/>

 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


 
 <script>
  $( function() {
	  if(self.name!='reload'){
	      self.name='reload'
	      self.location.reload();
	   } else self.name="";
	// 색상 옵션 선택 전 수량선택div 숨기기
	$("div#oqty").hide();
	
    $( "#speed" ).selectmenu();
 
    $( "#files" ).selectmenu();
 
    $( "#number" )
      .selectmenu()
      .selectmenu( "menuWidget" )
        .addClass( "overflow" );
 
    $( "#salutation" ).selectmenu();
    
    goCommentListView();  // 제품 구매후기를 보여주는 것.
    
  //바로 주문하기    
    $("button#btn-buynow").click(function(){
        
        if( ${empty sessionScope.loginuser}) {
          alert("주문하려면 먼저 로그인해야합니다!!");
          return;
       } else {
          var frm = document.cartform;
          console.log("후잉" + frm.pnum.value);
          frm.action="<%=request.getContextPath()%>/order.to";
          frm.method="post";
          frm.submit();
       }
     });
    
    
 	// **** 제품후기 쓰기(로그인만 하면 누구나 작성할 수 있는 것) **** // 
	   $("button.btnCommentOK").click(function(){
		   
		   if(${empty sessionScope.loginuser}) {
			   alert("제품사용 후기를 작성하시려면 먼저 로그인 하셔야 합니다.");
			   return;
		   }
		   
		   var commentContents = $("textarea#commentContents").val().trim();
		   
		   if(commentContents == "") {
			   alert("제품후기 내용을 입력하세요!!");
			   return; 
		   }
		   
		   // jQuery에서 사용하는 것으로써,
		   // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
		   var queryString = $("form[name=commentFrm]").serialize();
		   console.log(queryString);
		   // contents=very%20Good&fk_userid=seoyh&fk_pnum=57
		   // %20 은 공백이다.
		 
		   $.ajax({
			   url:"<%= request.getContextPath()%>/product/commentRegister.to",
			   type:"post",
			   data:queryString,
			   dataType:"json",
			   success:function(json){ // {"n":1} 또는 {"n":-1} 또는  {"n":0}
				   if(json.n == 1) {
					   // 제품후기 등록(insert)이 성공했으므로 제품후기글을 새로이 보여줘야(select) 한다.
					   goCommentListView(); // 제품후기글을 보여주는 함수 호출하기 
				   }
				   else if(json.n == -1)  {
					   // 동일한 제품에 대하여 동일한 회원이 제품후기를 2번 쓰려고 경우 unique 제약에 위배됨 
					// alert("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
					   swal("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
				   }
				   else  {
					   // 제품후기 등록(insert)이 실패한 경우 
					   alert("제품후기 글쓰기가 실패했습니다.");
				   }
				   
				   $("textarea#commentContents").val("").focus();
			   },
	  		   error: function(request, status, error){
	 			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 		   }
		   });
		   
	   });
    
	// 수량입력 spinner
    $("input.oqty").spinner({
        spin:function(event,ui){
           if(ui.value<1){ //ui는 input태그를 말함
              $(this).spinner("value",1);
              return false;
           }
        }
     });
    
    var html ="";
    var cnt = 0;
    //색상 옵션 select 변경하면 수량선택부분 보이기
    $("select#option1").change(function(){
    	if($("select").val() == "0"){
    		$("div#oqty").hide();
    	} else {
    		$.ajax({
	    		url:"<%= request.getContextPath()%>/product/getOption.to",
	 		   type:"get",
	 		   data:{"pdetailnum": $("select").val()},
	 		   dataType:"json",
	 		   success:function(json){
	 			  $.each(json, function(index, item){
	 				 
	 				 html += 	"<tr>" +
	 				 				"<td>"+item.pname+"["+item.optionname+"]</td>" +
				    				"<td>" +
				    					"<p>" +
											"<input type='number' class='oqty' name='oqty' style='width: 40px; height: 20px;' value='1'>" +
										"</p>" +
				    				"</td>" +
				    				"<td id='totalamount'>"+item.saleprice+"원 </td></tr>";
	 			  }); 
	 			  $("table.table").find("tbody").html(html); $("div#oqty").show();
	 		   },
	 		   error: function(request, status, error){
	 				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 		   }
 		   });
    	}
    });
    
    
	
    
    
    
    
    
    
  });	// $(function(){}) -------------
  
  // Function Declartion
  
  function goCart(pnum) {
	  
	if( ${empty sessionScope.loginuser}) {
		alert("장바구니에 등록하려면 먼저 로그인해야합니다!!");
		return;
	}
	$.ajax({
		url:"<%= request.getContextPath()%>/product/cartAdd.to",
		   type:"post",
		   data:{"userid":"${sessionScope.loginuser.userid}"
			    ,"pnum":pnum, "oqty":$("input.oqty").val(), "fk_pdetailnum" : $("select").val()},
		   dataType:"json",
		   success:function(json){
			   alert(json.msg);
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	});
  }
	function goWish(pnum) {
		  
		if( ${empty sessionScope.loginuser}) {
			alert("위시리스트에 등록하려면 먼저 로그인해야합니다!!");
			return;
		}
		
		$.ajax({
			url:"<%= request.getContextPath()%>/product/wishAdd.to",
			   type:"post",
			   data:{"userid":"${sessionScope.loginuser.userid}"
				    ,"pnum":pnum, "oqty":$("input.oqty").val(), "fk_pdetailnum" : $("select").val()},
			   dataType:"json",
			   success:function(json){
				   alert(json.msg);
			   },
			   error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   }
		});
		
  }
	
  // 특정 제품의 제품후기글들을 보여주는 함수
  function goCommentListView() {
   
  $.ajax({
	  url:"<%= request.getContextPath()%>/product/commentList.to",
	  type:"GET",
	  data:{"fk_pnum":"${requestScope.pvo2.pnum}"},
	  dataType:"json",
	  success:function(json){
		 /*
		    [{"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디","review_seq":제품후기글번호}
		    ,{"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디","review_seq":제품후기글번호} 
		    ]  
		 */ 
		 var html = "";
		 
		 if(json.length > 0) {
			 $.each(json, function(index, item){
				 var writeuserid = item.userid;
				 var loginuserid = "${sessionScope.loginuser.userid}";
				 
				 html +=  "<div id='rvcontent' class='customDisplay'> <span class='markColor'>▶&nbsp;</span> "+item.contents+"</div>"
		               +  "<div id='writer' class='customDisplay'>"+writeuserid+"</div>"      
		               +  "<div id='writedate' class='customDisplay'>"+item.writeDate+"</div>";
		               
		         if( loginuserid == "" ) {
		        	 html += "<div class='customDisplay spacediv'>&nbsp;</div>";
		         }     
		         else if( loginuserid != "" && writeuserid != loginuserid ) {
		        	 html += "<div class='customDisplay spacediv'>&nbsp;</div>";
		         }
		         else if( loginuserid != "" && writeuserid == loginuserid ) {
		        	 html += "<div class='customDisplay spacediv commentDel' onclick='delMyReview("+item.review_seq+")'>후기삭제</div>"; 
		         }
				 
			 });
		 } // end of if ----------------------------------------
		 
		 else {
			 html += "<div>등록된 상품후기가 없습니다.</div>";
		 }// end of else ---------------------------------------
		 
		 $("div#viewComments").html(html);
		 
		// == "div#sideinfo" 의 height 값 설정해주기 == 
		var contentHeight =	$("div#content").height();
		//	alert(contentHeight);
		$("div#sideinfo").height(contentHeight);
		 
	  },
	  error: function(request, status, error){
		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	  }
  });
   
  }// end of function goCommentListView() {}------------------------------
	   
	   
  // 특정 제품의 제품후기를 삭제하는 함수
  function delMyReview(review_seq) {
   
   var bool = confirm("정말로 제품후기를 삭제하시겠습니까?");
  //  console.log("bool => " + bool); // bool => true , bool => false
  
      if(bool) {
   	   $.ajax({
   		   url:"<%= request.getContextPath()%>/product/commentDel.to",
   		   type:"post",
   		   data:{"review_seq":review_seq},
   		   dataType:"json",
   		   success:function(json){ // {"n":1} 또는 {"n":0}
   			   if(json.n == 1) {
   				   alert("제품후기 삭제가 성공되었습니다.");
   				   goCommentListView();
   			   }
   			   else {
   				   alert("제품후기 삭제가 실패했습니다.");
   			   }
   		   },
   		   error: function(request, status, error){
   			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   		  }
   	   });
      }
   
  }// end of function delMyReview(review_seq) {}--------------------------
  
  
 </script>
 


<div id="prod-content-container">

	<div id="prod-page-top">
		<div id="imagebox" class="proddetailmain" style="padding: 10px; ">
			<img id="mainimage" src="<%=ctxPath%>/images/${requestScope.pvo2.pimage1}" />
		</div>
		<div id="order" class="proddetailmain">
			<span id="itemname">${requestScope.pvo2.pname}</span>
			<span id="normalprice" style="text-decoration: line-through"><fmt:formatNumber value="${requestScope.pvo2.price}" pattern="#,###"/>원</span>
			<span id="price"><fmt:formatNumber value="${requestScope.pvo2.saleprice}" pattern="#,###"/>원</span>
			
			<hr style="background:#fff; margin: 10px 0; color:#fff; display:block;">

			<div id="purchaseinfo">
				<p><b>구매혜택</b><!-- DB에서 포인트 가져오기 --> Point 적립예정</p>
				<p><b>배송 방법</b>&nbsp;&nbsp;택배</p>
				<p><b>배송비</b>&nbsp;&nbsp;2,500원(50,000원 이상 무료배송)</p>
			</div>
			
			<form action="#">
			  <fieldset>
			    <span id="opt-title" style="display:inline-block; margin-bottom: 5px"><b>색상</b></span>
			    <select name="option" id="option1">
			      <option selected id="choption" value="0">-[필수]색상선택-</option>
			      <c:forEach var="option" items="${requestScope.optionList}" >
			      	<option value="${option.pdetailnum}">${option.optionname}</option>
			      </c:forEach>
			    </select>
			    <br>
			    <span style="margin-top: 100px;"><br>(최소주문 수량 1개이상)</span>
			    <hr style="background:#fff; color:#fff; margin: 5px 0;">
			    <div id="oqty">
			    	<table class="table">
			    		<thead>
			    			<tr>
			    				<td>제품명</td>
			    				<td>수량</td>
			    				<td>금액</td>
			    			</tr>
			    		</thead>
			    		<tbody>
			    		</tbody>
			    	</table>
			      </div>
			   </fieldset>
			 </form>

			<div id="button-container" style="margin-top:50px">
				<button type="button" id="btn-buynow">바로구매</button>
				<button type="button" id="btn-basket" onClick="goCart('${requestScope.pvo2.pnum}');">장바구니</button>
				<button type="button" id="btn-wishlist" onClick="goWish('${requestScope.pvo2.pnum}');">위시리스트</button>
			</div>
		</div><!-- div#order end -->
	</div><!-- prod-page-top end -->
	
	<div id="bestproductdiv" clear:both;">
	<h4>이 상품도 추천해요!</h4><!-- 이미지 슬라이드 시작 -->
  <!--Carousel Wrapper-->
  <div id="multi-item-example" class="carousel slide carousel-multi-item" data-ride="carousel">

    <!--Indicators-->
    <ol class="carousel-indicators" >
      <li data-target="#multi-item-example" data-slide-to="0" class="active"></li>
      <li data-target="#multi-item-example" data-slide-to="1"></li>
      <li data-target="#multi-item-example" data-slide-to="2"></li>
    </ol>
    <!--/.Indicators-->

    <!--Slides-->
     <div class="carousel-inner" role="listbox">
   

      <!--First slide-->
      <div class="carousel-item active">

        <div class="row" style="display: inline-block">
         <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
		   <c:if test="${status.index < 6}">
          <div class="col-md-2">
            <div class="card mb-2" onclick="location.href='<%=ctxPath%>/Info.to?pnum=${pvo.pnum}'">
              <img class="card-img-top" src="<%=ctxPath%>/images/${pvo.pimage1}" style="width:100%; height:222px;"
                   alt="Card image cap">
              <div class="card-body" onclick="location.href='<%=ctxPath%>/Info.to?pnum=${pvo.pnum}'" style="height:110px;">
                <h6 class="card-title" style="font-weight: bold;">${pvo.pname}</h6>
                <p class="card-text" style="margin-bottom: 5px">
                <span style="text-decoration: line-through; color: #ccc; "><fmt:formatNumber value="${pvo.price}" pattern="#,###" /> 원</span><br>
                <span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span></p>
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

        <div class="row" style="display: inline-block">
         <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
		   <c:if test="${status.index >= 6 && status.index < 12}">
          <div class="col-md-2">
            <div class="card mb-2" onclick="location.href='<%=ctxPath%>/Info.to?pnum=${pvo.pnum}'">
              <img class="card-img-top" src="<%=ctxPath%>/images/${pvo.pimage1}" style="width:100%; height:222px;"
                   alt="Card image cap">
              <div class="card-body" onclick="location.href='<%=ctxPath%>/Info.to?pnum=${pvo.pnum}'" style="height:110px;">
                <h6 class="card-title" style="font-weight: bold;">${pvo.pname}</h6>
                <p class="card-text" style="margin-bottom: 5px">
                <span style="text-decoration: line-through; color: #ccc; "><fmt:formatNumber value="${pvo.price}" pattern="#,###" /> 원</span><br>
                <span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span></p>
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

        <div class="row" style="display: inline-block">
         <c:forEach var="pvo" items="${requestScope.productList}" varStatus="status">
		   <c:if test="${status.index >= 12}">
          <div class="col-md-2">
            <div class="card mb-2" onclick="location.href='<%=ctxPath%>/Info.to?pnum=${pvo.pnum}'">
              <img class="card-img-top" src="<%=ctxPath%>/images/${pvo.pimage1}" style="width:100%; height:222px;"
                   alt="Card image cap">
              <div class="card-body" onclick="location.href='<%=ctxPath%>/Info.to?pnum=${pvo.pnum}'" style="height:110px;">
                <h6 class="card-title" style="font-weight: bold;">${pvo.pname}</h6>
                <p class="card-text" style="margin-bottom: 5px">
                <span style="text-decoration: line-through; color: #ccc; "><fmt:formatNumber value="${pvo.price}" pattern="#,###" /> 원</span><br>
                <span><fmt:formatNumber value="${pvo.saleprice}" pattern="#,###" /> 원</span></p>
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


  </div>
  <!--/.Carousel Wrapper-->
	</div>
	
	<div>
		<br><br><br><br>
	  <ul class="nav nav-tabs">
	    <li class="tabli active"><a data-toggle="tab" href="#home">상세정보</a></li>
	    <li class="tabli"><a data-toggle="tab" href="#menu1">리뷰</a></li>
	    <li class="tabli"><a data-toggle="tab" href="#menu2" onclick="location.href='<%=ctxPath%>/cscenter/csBoardView.to'">Q&A</a></li>
	    <li class="tabli"><a data-toggle="tab" href="#menu3">반품/교환정보</a></li>
	  </ul>
	
	  <div class="tab-content">
	    <div id="home" class="tab-pane fade in active" style="padding-top: 20px; padding-left: 90px;">
	     <img src="/SemiProject_team01/images/${requestScope.pvo2.pimage2}" style="display: block; width:60%; padding-top: 50px; margin-left: auto; margin-right: auto;">
	    </div>
	    <div id="menu1" class="tab-pane fade" align="center">
	      <div id="viewComments">
    	<%-- 여기가 제품사용 후기 내용이 들어오는 곳이다. --%>
		    </div> 
		    <form name="commentFrm">
		    	<div>
		    		<textarea cols="85" class="customHeight" name="rvcontent" id="commentContents"></textarea>
		    	</div>
		    	<div>
		    		<button type="button" class="customHeight btnCommentOK">후기등록</button>
		    	</div>
		    	<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
		    	<input type="hidden" name="fk_pnum" value="${requestScope.pvo2.pnum}" />
		    </form>
		   </div>
	    <div id="menu2" class="tab-pane fade"  >
	    <br>
	      
	      
	    </div>
	    <div id="menu3" class="tab-pane fade">
	      <div class="well" style="font-size: 13pt;">
		      교환/반품 제한사항 <br/>
			ㆍ주문/제작 상품의 경우, 상품의 제작이 이미 진행된 경우<br/>
			ㆍ상품 포장을 개봉하여 사용 또는 설치 완료되어 상품의 가치가 훼손된 경우 (단, 내용 확인을 위한 포장 개봉의 경우는 예외)<br/>
			ㆍ고객의 사용, 시간경과, 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우<br/>
			ㆍ세트상품 일부 사용, 구성품을 분실하였거나 취급 부주의로 인한 파손/고장/오염으로 재판매 불가한 경우<br/>
			ㆍ모니터 해상도의 차이로 인해 색상이나 이미지가 실제와 달라, 고객이 단순 변심으로 교환/반품을 무료로 요청하는 경우<br/>
			ㆍ제조사의 사정 (신모델 출시 등) 및 부품 가격 변동 등에 의해 무료 교환/반품으로 요청하는 경우<br/>
	      </div>
	    </div>
	  </div>
	</div>
	
</div>
	
	





<jsp:include page="../footer.jsp" />