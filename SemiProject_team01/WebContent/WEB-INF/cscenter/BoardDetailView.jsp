<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<jsp:include page="../header.jsp"/>
<style>
div.mb-3 > select#fk_bigcateno, select#fk_smallcateno {
	width: 40%;
}
span:hover{
	cursor:pointer;
}
div.container_b {
	
	max-width: 600px;
	margin: 0 auto;
}

tr > td{
	padding: 0 25px 20px 0;
}
td.label {
	font-size: 20pt;
	font-weight: bold;
	
}

td.content {
font-size: 17pt;
}
textarea#commentContents {font-size: 12pt;}
	
	div#viewComments {width: 80%;
	           		  margin: 3% 0 0 0; 
	                  text-align: left;
	                  max-height: 300px;
	                  overflow: auto;
	                  /* border: solid 1px red; */
	}
	
	span.markColor {color: #ff0000; }
	
	div.customDisplay {display: inline-block;
	                   margin: 1% 3% 0 0;
	}
	                
	div.spacediv {margin-bottom: 5%;}
	
	div.commentDel {font-size: 8pt;
	                font-style: italic;
	                cursor: pointer; 
	 }
	
	div.commentDel:hover {background-color: navy;
	                      color: white;	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("span.error").hide();
		
		
		var loginuserid = "${bvo.mvo.name}";
		console.log("login" + loginuserid);
		if(${sessionScope.loginuser.userid eq 'admin'}) { // 로그인 한 사용자가 관리자일 때
			$("form#commentFrm").css("display","inline-block"); // 답변을 쓸 수 있는 form의 style을 none->inline-block으로 바꿔준다.
			$("div.btn-sumit").css("display","none"); // 사용자가 글을 수정, 삭제할 수 있는 버튼은 관리자일 때 보일 수 없게한다.
		}
			goCommentListView(); // 작성된 답변 보여주기 
		
		
		$("button.btnCommentOK").click(function(){	  		// 답변 등록 이벤트   
	  		   var commentContents = $("textarea#commentContents").val().trim();
	  		   
	  		   if(commentContents == "") {
	  			   alert("제품후기 내용을 입력하세요!!");
				   return; 
	  		   }
	  		   
	  		   //////////////////////////////////////////////////////////////////
	  		   // 보내야할 데이터를 선정하는 첫번째 방법
	  	/*	   
	  		   var queryString = {"fk_userid":"${sessionScope.loginuser.userid}", 
	  			                  "fk_pnum":"${requestScope.pvo.pnum}", 
	  			                  "contents":$("textarea#commentContents").val()};
	  	*/	     		   
	  		   
	  	       // 보내야할 데이터를 선정하는 두번째 방법
			   // jQuery에서 사용하는 것으로써,
			   // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
	  		   var queryString = $("form[name=commentFrm]").serialize();
			   // console.log(queryString);
			   // contents=very%20Good&fk_userid=seoyh&fk_pnum=57
			   // %20 은 공백이다.
			 console.log("gndld")
	  		   $.ajax({
	  			   url:"<%= request.getContextPath()%>/cscenter/bcommentRegister.to",
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
	}); 
		
		function goCommentListView() {
			   $("div#viewComments").css("display","inline-block");
			  $.ajax({
				  url:"<%= request.getContextPath()%>/cscenter/bcommentList.to",
				  type:"GET",
				  data:{"boardno":"${requestScope.boardno}"},
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
							 var loginuserid = "${sessionScope.loginuser.userid}";
							 
							 html +=  "<div> <span class='markColor'>▶</span> "+item.bcontent+"</div>"
					               +  "<div class='customDisplay'>"+item.commDate+"</div>";
					               
					         if( loginuserid == "" ) {
					        	 html += "<div class='customDisplay spacediv'>&nbsp;</div>";
					         }
					         else if( loginuserid != "" && loginuserid=='admin' ) {
					        	 html += "<div class='customDisplay spacediv commentDel' onclick='delMyReview("+item.fk_boardno+")'>후기삭제</div>"; 
					         }
							 
						 });
					 } // end of if ----------------------------------------
					 
					 else {
						 html += "<div style='padding-bottom:10px;'><h3 style='color:#DAD9FF;'>등록된 답변이 없습니다.</h3></div>";
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
		   function delMyReview(boardno) {
			   
			   var bool = confirm("정말로 제품후기를 삭제하시겠습니까?");
		   //  console.log("bool => " + bool); // bool => true , bool => false
		   
		       if(bool) {
		    	   $.ajax({
		    		   url:"<%= request.getContextPath()%>/cscenter/bcommentDel.to",
		    		   type:"post",
		    		   data:{"fk_boardno":boardno},
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
		   
	function goUpdate() { //문의게시글 수정
		var frm = document.form;
		frm.action = "<%=request.getContextPath()%>/cscenter/boardUpdate.to";
		frm.method="post";
		frm.submit();
	}
	
	function goDelete() { // 문의게시글 삭제
		var frm = document.form;
		frm.action = "<%=request.getContextPath()%>/cscenter/boardDelete.to";
		frm.method="post";
		frm.submit();
	}
</script>
<div class="container container_b">

<br><br><h2 align="center">문의 게시판</h2><br><br><br>

			<form name="boardForm" role="form">
			<table>
					<tr>
						<td class="label" >카테고리</td>
						<td>
							<select class="w3-select w3-border" id="fk_bigcateno" name="fk_bigcateno"  disabled>
								<option selected value="${bvo.cbscvo.cbbcvo.bigcateno}" >${bvo.cbscvo.cbbcvo.bigcatename}</option>
							</select>
						</td>
						<td> <%-- 사용자가 작성한 문의글의 카테고리가 배송전변경/취소 또는 배송/교환/반품 일 때 소분류카테고리 select가 보일 수 있게한다. --%>
							<c:if test="${bvo.cbscvo.cbbcvo.bigcateno == '2' || bvo.cbscvo.cbbcvo.bigcateno == '3'}">
								<select class='w3-select w3-border' id='fk_smallcateno' name='fk_smallcateno' style="display:inline-block;" disabled>
									<option selected value="${bvo.fk_smallcateno}" >${bvo.cbscvo.smallcatename}</option>
								</select>
							</c:if><%-- 사용자가 작성한 문의글의 카테고리가 상품문의 또는 입금확인/입금자변경 일 때 소분류카테고리 select가 보이지않게한다. --%>
							<c:if test="${bvo.cbscvo.cbbcvo.bigcateno == '1' || bvo.cbscvo.cbbcvo.bigcateno == '4'}">
								<select class='w3-select w3-border' id='fk_smallcateno' name='fk_smallcateno' style="display:none;" disabled>
								</select>
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="label" >제목</td>
						<td class="content">${bvo.boardtitle}</td>
					</tr>
					<tr>
						<td class="label" >작성자</td>
						<td class="content">${bvo.mvo.name}</td>
					</tr>
					<tr>
						<td class="label" >내용</td>
						<td class="content">${bvo.boardcontent}</td>
					</tr>
					<tr>
						<td class="label" >파일</td>
						<td class="content"><span data-toggle="modal" data-target="#myModal">${bvo.boardfile}</span></td>
					</tr>
			</table>
				<div class="mb-3"><%-- 모달로 이미지 미리보기 --%>
						<div class="modal fade" id="myModal">
					    <div class="modal-dialog">
					      <div class="modal-content">
					        <div class="modal-header">
					          <h4 class="modal-title">이미지 미리보기</h4>
					          <button type="button" class="close" data-dismiss="modal">×</button>
					        </div>
					        <div class="modal-body" align="center">
					          <img src="/SemiProject_team01/images/${bvo.boardfile}" style="width: 300px; height: 400px;" />
					        </div>
					        <div class="modal-footer">
					          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					        </div>
					      </div>
					    </div>
	  					</div>
				</div>
				<br>
			</form>
			<div id="viewComments" style="display:none">
		    	<%-- 여기가 제품사용 후기 내용이 들어오는 곳이다. --%>
		    </div> 
			<div align="center" class="btn-sumit">
				<button type="button" class="btn btn-outline-secondary " id="btnSave" onclick="goUpdate();">수정</button>
				<button type="button" class="btn btn-outline-secondary" id="btnList" onclick="goDelete();">삭제</button>
			</div>
			
			
			
		    <form name="commentFrm" id="commentFrm" style="display:none">
		    	<div>
		    		<textarea cols="85" class="customHeight" name="contents" id="commentContents"></textarea>
		    	</div>
		    	<div align='center' style="padding-top:20px;">
		    		<button type="button" class="btn btn-secondary btnCommentOK">등록</button>
		    	</div>
		    	<input type="hidden" name="boardno" value="${requestScope.boardno}" />
		    </form>
		    
</div>
<br><br><br><br>
<div>
<form name="form">
	<input type="hidden" name="boardno" value="${requestScope.boardno}"/>
	<input type="hidden" name="fk_bigcateno" value="${bvo.cbscvo.fk_bigcateno}"/>
</form>
</div>
<jsp:include page="../footer.jsp"/>