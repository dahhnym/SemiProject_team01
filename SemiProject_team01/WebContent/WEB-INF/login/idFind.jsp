<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="../css/login.css"/>

<script type="text/javascript">		//*엔터키 정정사항
	var bool = false;

	$(function(){
		$("div#etcEmailAddress").hide();
		$("div.infoConfirm").hide();
		
		// 이메일주소를 select한 경우 
		$("input#emailAddress").val($("select#selectedEmailAddress option:selected").val());	// 기본값
		
		$("select#selectedEmailAddress").change(function(){			
			if($("select#selectedEmailAddress").val()=="기타"){	// select 기타 선정시
				$("div#etcEmailAddress").show();	
				$("input#etcEmailAddress").blur(function(){
					$("input#emailAddress").val($(this).val());	
				});						
			} else {	// 그 외 select 옵션 선택시
				$("div#etcEmailAddress").hide();	
				$("input#etcEmailAddress").val("");
				$("input#emailAddress").val($("select#selectedEmailAddress option:selected").val());	
			}
		});	
		
		// 아이디 찾기 버튼 누른 경우
		$("button#idFind").click(function(){
			goConfirm();
			
			if(bool) {				
				findUseridCheck();
			}	
		});
		
		
		// 비밀번호 찾기 버튼 누른 경우
		$("button#pwdFind").click(function(){	
			location.href = "<%=ctxPath%>/login/pwdFind.to";
		});
		
		// 회원가입 하기 버튼 누른 경우
		$("button#goRegister").click(function(){	
			location.href = "<%=ctxPath%>/member/memberRegister.to";
		});

	});// end of $(function() ------------------------------------------------------------
	
			
	function goConfirm() {	// 아이디 찾기를 누른 경우		
		
		// 성명 체크
		var registerName = $("input#registerName").val();
		if(registerName=="") {
			$("div#registerName").show();
			$("div#registerName").html("회원가입시 성명을 입력해주세요.");
			$(this).focus();
			bool=false;
			return;
		} else {
			$("div#registerName").hide();
			bool=true;
		}	
		
		// 이메일 아이디 체크 
		var registerEmailID = $("input#registerEmailID").val().trim();
		if(registerEmailID==""){
			$("div#registerEmailID").show();
			$("div#registerEmailID").html("이메일 아이디를 입력해주세요.");
			$(this).focus();
			bool=false;
			return;
		} else {
			$("div#registerEmailID").hide();
			bool=true;
		}		
		
		if($("select#selectedEmailAddress").val()=="기타"){
			// 기타 주소 체크
			var etcEmailAddress = $("input#etcEmailAddress").val().trim();
			var regExp=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
			var b = regExp.test(etcEmailAddress);
			
			if(etcEmailAddress==""){
				$("div#etcEmailAddressCheck").show();
				$("div#etcEmailAddressCheck").html("이메일 주소를 입력해주세요.");
				$(this).focus();
				bool=false;
				return;
			} else {
				if(etcEmailAddress.includes("@")){
					$("div#etcEmailAddressCheck").show();
					$("div#etcEmailAddressCheck").html("@ 제외 주소값만 입력해주세요.");
					$(this).focus();
					bool=false;
					return;
				} else if(!b) {
					$("div#etcEmailAddressCheck").show();
					$("div#etcEmailAddressCheck").html("이메일 형식이 올바르지 않습니다. 다시 입력해주세요.");
					$(this).focus();
					bool=false;
					return;
				} else {
					$("div#etcEmailAddressCheck").hide();
					bool=true;
				}
			}
		}
		
	}// end of function goConfirm() ----------------------------------------------------------

	
	// 아이디 존재여부 확인함수	
	function findUseridCheck() {
		var name = $("input#registerName").val().trim();
		var email = $("input#registerEmailID").val().trim()+"@"+$("input#emailAddress").val().trim();
		
		$.ajax({
			url:"<%= ctxPath%>/login/idFind.to",
			type: "post",
			data:{"name":name, "email":email},
			dataType:"json",	
			success:function(json){
				if(json.userid!="") {	// 아이디가 존재한다면
 					$("div#findUserid").show();
 					$("div#findUserid").html("해당하는 ID 는 [ "+json.userid+" ] 입니다.").css("color","green");
 					$("input#userid").val("");
 					
 				} else { // 아이디가 없다면
 					$("div#findUserid").show();
 					$("div#findUserid").html("일치하는 ID는 없습니다.").css("color","red");
 				} 
			},
				error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        	}    				
		}); // end of $.ajax ----------------------------------------------
	}
</script> 


<div id="idFindContainer">
	<form name="idFindFrm" id="idFindFrm">
		<h3 style="font-weight: bold; margin-bottom: 30px;">아이디 찾기</h3>
		<div id="idFind">
	  	   	<input type="text" name="registerName" id="registerName" class="idFindSpace" placeholder="성명"/>
	  	   	<div id="registerName" class="infoConfirm"></div><br>
	  	   	
		    <input type="text" name="registerEmailID" id="registerEmailID" style="width: 120px;" placeholder="이메일 아이디" />
	      	<select id="selectedEmailAddress" class="space" style="width: 150px; height: 30px;">
		      	<option value="gmail.com">gmail.com</option>
				<option value="naver.com">naver.com</option>
				<option value="daum.net">daum.net</option>
			 	<option value="hanmail.net">hanmail.net</option>
			 	<option value="kakao.com">kakao.com</option>
			 	<option value="기타">기타</option>
	      	</select> 
	      	<div id="registerEmailID" class="infoConfirm"></div><br>
	      	
	      	<div id="etcEmailAddress">
	      		<input type="text" name="etcEmailAddress" id="etcEmailAddress" class="idFindSpace" placeholder="이메일 주소" />
			    <div id="etcEmailAddressCheck" class="infoConfirm"></div>
	      	</div>
	      	<input type="hidden" name="emailAddress" id="emailAddress" />
      	 	
	  	    <button type="button" name="idFind" id="idFind" class="btn btn-primary idFindSpace" >아이디 찾기</button>
	  	    <div id="findUserid" class="infoConfirm" style="margin-top: 10px;"></div><br>
	  	    <button type="button" name="pwdFind" id="pwdFind" class="btn btn-outline-secondary idFindSpace2" >비밀번호 찾기</button> 
	  	    <button type="button" name="goRegister" id="goRegister" class="btn btn-outline-secondary idFindSpace2" >회원가입 하기</button> 
	   </div> 	
	</form>        	   
</div>   
 
<jsp:include page="../footer.jsp" />