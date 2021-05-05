<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="../header.jsp" />




<style>
	div#info {
		width: 1300px;
		margin-left: 300px;
		margin-right: auto;
		/*border: solid 1px red;*/
	}
	
	nav#info-list {
		text-align: left;
		margin-top: 0;
		/*border: solid 1px blue;*/
	}

	nav#info-list > ul > li {
		font-size: 20px;
		font-weight: bold;
		display: inline;
	}
	
	div#imagebox{
		float:left;
		height: 1000px;
		width: 650px;
		margin-left: 0px;
		margin-right: auto;
		border: solid 1px gray; 
		
	}
	
	div#myCarousel {
		height: 700px;
		width: 600px;
		margin-top: 50px;
		margin-left: auto;
		margin-right: auto;
	}
	
	div#order{
		float:left;
		position:relative;
		height: 1000px;
		width: 648px;
		margin-left: auto;
		margin-right: 0px;
		border: solid 1px gray; 
		border-left-style: none;
		padding: 50px;
	}
	
	span#itemname {
		font-size: 40px;
		font-weight: bold;
		/*border: solid 1px red;*/
	}
	
	span#sale {
		font-size: 45px;
		font-weight: bold;
		color: red;
		/*border: solid 1px red;*/
	}
	
	span#normalprice {
		font-size: 20px;
		font-weight: bold;
		color: gray;
		text-decoration: line-through;
		text-align:right;
		margin-left: 280px;
		margin-bottom: 40px;
		/*border: solid 1px red;*/
		
	}
	
	span#price {
		font-size: 30px;
		font-weight: bold;
		color: black;
		text-decoration: none;
		float: right;
		margin-left: 0px;
		margin-top: 20px;
	}
	
	 fieldset {
      border: 0;
    }
    label {
      display: block;
      margin: 30px 0 0 0;
    }
    .overflow {
      height: 200px;
    }
    
    select#option1 {
    	width: 80%;
    	height: 10%;
    	margin-left: 50px;
		margin-right: auto;
		font-size: 30px;
		/*border: solid 1px red;*/
    }
    
    option#choption{
    	font-size: 30px;
    	
    }
    div#basket {
    	width: 250px;
    	height: 80px;
    	float: left;
    	/*border: solid 1px red;*/
    }
    
    div#wish {
    	width: 250px;
    	height: 80px;
    	float: right;
    	/*border: solid 1px red;*/
    }
    
    div#buynow{
    	width: 500px;
    	height: 80px;
    	/*border: solid 1px red;*/
    	margin-left: 80px;
    }
    
    .btn-primary {
    	width: 250px;
    	height: 80px;
    	
    }
    
    .btn-success {
    	float: right;
    	width: 550px;
    	height: 80px;
    	
    }
    
    span#texttest {
    	font-size: 30px;
    }
    
   	div#bestproductdiv{
    	padding-top: 1050px;
    	/*border: solid 1px red;*/
    }
    
    span#tbltextname {
    	font-size: 15px;
    }
    
    span#tblbestprice {
    	font-size: 15px;
    	font-weight: bold;
    }
    
    li#tabli {
    	width: 324px;
    	font-size: 20px;
    	text-align: center;
    }
    
    td.qasortno {
    	width: 150px;
    	height: 60px;
    	border-top: solid 2px black;
    	border-bottom: solid 1px gray;
    	font-weight: bold;
    	text-align: center;
    }
    
    td.qasortac {
    	width: 150px;
    	height: 60px;
    	border-top: solid 2px black;
    	border-bottom: solid 1px gray;
    	font-weight: bold;
    	text-align: center;
    }
    
    td.qasorttitle {
    	width: 350px;
    	height: 60px;
    	border-top: solid 2px black;
    	border-bottom: solid 1px gray;
    	font-weight: bold;
    	text-align: center;
    }
    
    td.qasortwriter {
    	width: 150px;
    	height: 60px;
    	border-top: solid 2px black;
    	border-bottom: solid 1px gray;
    	font-weight: bold;
    	text-align: center;
    }
    
    td.qasortdate {
    	width: 250px;
    	height: 60px;
    	border-top: solid 2px black;
    	border-top: solid 2px black;
    	border-bottom: solid 1px gray;
    	font-weight: bold;
    	text-align: center;
    }
    
    td.qasorttdno {
    	width: 150px;
    	height: 60px;
    	border-bottom: solid 1px gray;
    	text-align: center;
    }
    
    td.qasorttdac {
    	width: 150px;
    	height: 60px;
    	border-bottom: solid 1px gray;
    	text-align: center;
    }
    
    td.qasorttdtitle {
    	width: 350px;
    	height: 60px;
    	border-bottom: solid 1px gray;
    	text-align: left;
    }
    
    td.qasorttdwriter {
    	width: 150px;
    	height: 60px;
    	border-bottom: solid 1px gray;
    	text-align: center;
    }
    
    td.qasorttddate {
    	width: 250px;
    	height: 60px;
    	border-bottom: solid 1px gray;
    	text-align: center;
    }
    
    span.qasorttext{
    	font-size: 20px;
    }
    
    span.rvch {
    	font-size: 20px;
    	margin-top: 20px;
    	margin-left: 30px;
    	
	}
    
    
    
    

	
</style>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script>
  $( function() {
    $( "#speed" ).selectmenu();
 
    $( "#files" ).selectmenu();
 
    $( "#number" )
      .selectmenu()
      .selectmenu( "menuWidget" )
        .addClass( "overflow" );
 
    $( "#salutation" ).selectmenu();
    
    goCommentListView();  // 제품 구매후기를 보여주는 것.
    
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
		   // console.log(queryString);
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
    
    
  } );
  
  function goCart(pnum) {
	  
	if( ${empty sessionScope.loginuser}) {
		alert("장바구니에 등록하려면 먼저 로그인해야합니다!!");
		return;
	}
	
	$.ajax({
		url:"<%= request.getContextPath()%>/product/cartAdd.to",
		   type:"post",
		   data:{"userid":"${sessionScope.loginuser.userid}"
			    ,"pnum":pnum},
		   dataType:"json",
		   success:function(json){
			   swal(json.msg);
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	});
	
	function goWish(pnum) {
		  
		if( ${empty sessionScope.loginuser}) {
			alert("위시리스트에 등록하려면 먼저 로그인해야합니다!!");
			return;
		}
		
		$.ajax({
			url:"<%= request.getContextPath()%>/product/wishAdd.to",
			   type:"post",
			   data:{"userid":"${sessionScope.loginuser.userid}"
				    ,"pnum":pnum},
			   dataType:"json",
			   success:function(json){
				   swal(json.msg);
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
			  data:{"fk_pnum":"${requestScope.pvo.pnum}"},
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
						 
						 html +=  "<div> <span class='markColor'>▶</span> "+item.contents+"</div>"
				               +  "<div class='customDisplay'>"+item.name+"</div>"      
				               +  "<div class='customDisplay'>"+item.writeDate+"</div>";
				               
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
 


	<div id="info">
	
	<br>
		<nav id="info-list">
			<ul>
				<li></li>	
			</ul>
		</nav>
		<div id="imagebox">
			<div id="myCarousel">
				<img src="/SemiProject_team01/images/${requestScope.pvo2.pimage1}" style="width: 100%; height: 100%;" />
			</div>
		</div>
		<div id="order">
			<span id="itemname">${requestScope.pvo2.pname}</span>
			<br><br>
			<hr style="background:#fff; height:5px; color:#fff; display:block;">
			<br>
			<span id="sale">10%<span id="normalprice">${requestScope.pvo2.price}원</span></span><span id="price">${requestScope.pvo2.saleprice}원</span>
			<br><br><br>
			<hr style="background:#fff; height:5px; color:#fff; display:block;">
			<br><br><br>
			<div class="demo">
 
				<form action="#">
				 
				  <fieldset >
				    <select name="옵션1" id="option1">
				      <option selected="selected" id="choption">색상선택</option>
				      <c:forEach items="" var="option">
				      	<%-- <option value="${requestScope.option.option}">${requestScope.option.option}</option> --%>
				      </c:forEach>
				    </select>
				   </fieldset>
				  </form>
			</div>
			<br><br><br>
			<hr style="background:#fff; height:5px; color:#fff; display:block;">
			<br><br><br>
			<div id="button-container" >
				<div class="container" id="basket">      
				  <button type="button" class="btn btn-primary" id="btn-basket" onClick="goCart('${requestScope.pvo2.pnum}');"><span id="texttest">장바구니</span></button>
				  
				</div>
				
				<div class="container" id="wish">      
				  <button type="button" class="btn btn-primary" id="btn-wishlist" onClick="goWish('${requestScope.pvo2.pnum}');"><span id="texttest">위시리스트</span></button>
				 
				</div>
			</div>
			<br><br><br><br><br>
			<div>
				<div class="container" id="buynow">     
				  <button type="button" class="btn btn-success" id="btn-buynow" onClick="goBuy('${requestScope.pvo2.pnum}');"><span id="texttest">바로구매</span></button>
			
				</div>
			</div>
			
		</div>
		
		<div id="bestproductdiv">
			<table>
				<tr>
				    <td><img src="/SemiProject_team01/images/${requestScope.pvo2.pimage1}" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="/SemiProject_team01/images/${requestScope.pvo2.pimage1}" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="/SemiProject_team01/images/${requestScope.pvo2.pimage1}" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="/SemiProject_team01/images/${requestScope.pvo2.pimage1}" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="/SemiProject_team01/images/${requestScope.pvo2.pimage1}" style="width:130px; height:150px; margin-left:75px;"></image></td>
					<td><img src="/SemiProject_team01/images/${requestScope.pvo2.pimage1}" style="width:130px; height:150px; margin-left:75px;"></image></td>
				</tr>
				<tr>
					<td style="padding-left: 100px;"><span id="tbltextname">${requestScope.pvo2.pname}</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">${requestScope.pvo2.pname}</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">${requestScope.pvo2.pname}</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">${requestScope.pvo2.pname}</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">${requestScope.pvo2.pname}</span></td>
					<td style="padding-left: 100px;"><span id="tbltextname">${requestScope.pvo2.pname}</span></td>
				</tr>
				<tr>
					<td style="padding-left: 100px;"><span id="tblbestprice">${requestScope.pvo2.saleprice}원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">${requestScope.pvo2.saleprice}원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">${requestScope.pvo2.saleprice}원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">${requestScope.pvo2.saleprice}원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">${requestScope.pvo2.saleprice}원</span></td>
					<td style="padding-left: 100px;"><span id="tblbestprice">${requestScope.pvo2.saleprice}원</span></td>
				</tr>
			</table>
		</div>
		
		<div>
			<br><br><br><br>
		  <ul class="nav nav-tabs">
		    <li class="active" id="tabli"><a data-toggle="tab" href="#home">상세정보</a></li>
		    <li id="tabli"><a data-toggle="tab" href="#menu1">리뷰</a></li>
		    <li id="tabli"><a data-toggle="tab" href="#menu2">Q&A</a></li>
		    <li id="tabli"><a data-toggle="tab" href="#menu3">반품/교환정보</a></li>
		  </ul>
		
		  <div class="tab-content">
		    <div id="home" class="tab-pane fade in active" style="padding-top: 20px; padding-left: 90px;">
		     <img src="/SemiProject_team01/images/${requestScope.pvo2.pimage2}" style="width:90%; height:90%"><br>
		    </div>
		    <div id="menu1" class="tab-pane fade">
		      <h2>상품리뷰</h2>
		      <div id="viewComments">
    				<%-- 여기가 제품사용 후기 내용이 들어오는 곳이다. --%>
			    </div> 
			    <form name="commentFrm">
			    	<div>
			    		<textarea cols="85" class="customHeight" name="contents" id="commentContents"></textarea>
			    	</div>
			    	<div>
			    		<button type="button" class="customHeight btnCommentOK">후기등록</button>
			    	</div>
			    	<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
			    	<input type="hidden" name="fk_pnum" value="${requestScope.pvo.pnum}" />
			    </form>
			    </div>
		    <div id="menu2" class="tab-pane fade"  >
		    <br>
		      <table style="margin-left: auto; margin-right: auto;">
		      	<tr>
		      		<td class="qasortno"><span class="qasorttext">No</span></td>
		      		<td class="qasortac"><span class="qasorttext">답변상태</span></td>
		      		<td class="qasorttitle"><span class="qasorttext">제목</span></td>
		      		<td class="qasortwriter"><span class="qasorttext">작성자</span></td>
		      		<td class="qasortdate"><span class="qasorttext">작성일</span></td>
		      	</tr>
		      	<tr>
		      		<td class="qasorttdno"><span class="qasorttext">1</span></td>
		      		<td class="qasorttdac"><span class="qasorttext">답변대기중</span></td>
		      		<td class="qasorttdtitle"><span class="qasorttext">배송관련 문의 드립니다.</span></td>
		      		<td class="qasorttdwriter"><span class="qasorttext">sdf***</span></td>
		      		<td class="qasorttddate"><span class="qasorttext">2021-05-02</span></td>
		      	</tr>
		      	<tr>
		      		<td class="qasorttdno"><span class="qasorttext">2</span></td>
		      		<td class="qasorttdac"><span class="qasorttext">답변대기중</span></td>
		      		<td class="qasorttdtitle"><span class="qasorttext">반품관련 문의 드립니다.</span></td>
		      		<td class="qasorttdwriter"><span class="qasorttext">sef***</span></td>
		      		<td class="qasorttddate"><span class="qasorttext">2021-05-01</span></td>
		      	</tr>
		      	<tr>
		      		<td class="qasorttdno"><span class="qasorttext">3</span></td>
		      		<td class="qasorttdac"><span class="qasorttext">답변완료</span></td>
		      		<td class="qasorttdtitle"><span class="qasorttext">교환관련 문의 드립니다.</span></td>
		      		<td class="qasorttdwriter"><span class="qasorttext">wef***</span></td>
		      		<td class="qasorttddate"><span class="qasorttext">2021-04-30</span></td>
		      	</tr>
		      	<tr>
		      		<td class="qasorttdno"><span class="qasorttext">4</span></td>
		      		<td class="qasorttdac"><span class="qasorttext">답변완료</span></td>
		      		<td class="qasorttdtitle"><span class="qasorttext">반품관련 문의 드립니다.</span></td>
		      		<td class="qasorttdwriter"><span class="qasorttext">xod***</span></td>
		      		<td class="qasorttddate"><span class="qasorttext">2021-04-29</span></td>
		      	</tr>
		      	<tr>
		      		<td class="qasorttdno"><span class="qasorttext">5</span></td>
		      		<td class="qasorttdac"><span class="qasorttext">답변완료</span></td>
		      		<td class="qasorttdtitle"><span class="qasorttext">교환관련 문의 드립니다.</span></td>
		      		<td class="qasorttdwriter"><span class="qasorttext">wos***</span></td>
		      		<td class="qasorttddate"><span class="qasorttext">2021-04-28</span></td>
		      	</tr>
		      	
		      
		      </table>
		      
		    </div>
		    <div id="menu3" class="tab-pane fade">
		      <div class="well" style="font-size: 15pt;">
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