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
		
		// 임시비밀번호 발송 버튼 누른 경우
		$("button#pwdFind").click(function(){
			var registerName = $("input#registerName").val().trim();
			var registerEmail = $("input#registerEmailID").val().trim()+"@"+$("input#emailAddress").val().trim();
			var registerUserid = $("input#registerUserid").val().trim();
			
			goConfirm();

			if(bool) {	
				findPwdCheck();
			}	
		});	
		
		// 아이디 찾기 버튼 누른 경우
		$("button#idFind").click(function(){	// *에러문구 잠깐 뜨는 것  ==> 정정사항
			location.href = "<%=ctxPath%>/login/idFind.to";
		});
		
		// 회원가입 하기 버튼 누른 경우
		$("button#goRegister").click(function(){	
			location.href = "<%=ctxPath%>/member/memberRegister.to";
		});

	});// end of $(function() ------------------------------------------------------------


	function goConfirm() {	// 비밀번호 찾기를 누른 경우		
		
		// 성명 체크
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
		
		// 아이디 체크
		if(registerUserid=="") {
			$("div#registerUserid").show();
			$("div#registerUserid").html("회원가입시 아이디를 입력해주세요.");
			$(this).focus();
			bool=false;
			return;
		} else {
			$("div#registerUserid").hide();
			bool=true;
		}	
		
		// 이메일 아이디 체크 
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
		
		if($("select#selectedEmailAddress").val().trim()=="기타"){
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

		
	// 일치하는 회원계정 존재여부 확인함수	
	function findPwdCheck() {	
		var registerName = $("input#registerName").val().trim();
		var registerEmail = $("input#registerEmailID").val().trim()+"@"+$("input#emailAddress").val().trim();
		var registerUserid = $("input#registerUserid").val().trim();
		
		$.ajax({
			url:"<%= ctxPath%>/login/pwdFind.to",
			type: "post",
			data:{"name":registerName, "email":registerEmail, "userid":registerUserid},
			dataType:"json",	
			success:function(json){
				
				if(json.bool==1) {		// 회원계정이 존재한다면
					$("div#findPwd").show();
					$("div#findPwd").html("이메일로 임시 비밀번호를 발송했습니다.").css("color","green");
					
 				} else { 	// 회원계정이 존재하지 않는다면
 					$("div#findPwd").show();
 					$("div#findPwd").html("일치하는 회원정보가 없습니다.").css("color","red");
 				} 
			},
				error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        	}    				
		}); 
	}// end of function findPwdCheck()  ----------------------------------------------
	
	
</script> 


<div id="pwdFindContainer">
	<form name="pwdFindFrm" id="pwdFindFrm">
		<h3 style="font-weight: bold; margin-bottom: 30px;">비밀번호 찾기</h3>
		<div id="pwdFind">
			<input type="text" name="registerName" id="registerName" class="pwdFindSpace" placeholder="성명"/>
	  	   	<div id="registerName" class="infoConfirm"></div><br>
	  	   	
	  	   	<input type="text" name="registerUserid" id="registerUserid" class="pwdFindSpace" placeholder="아이디"/>
	  	   	<div id="registerUserid" class="infoConfirm"></div><br>
	  	   	
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
	      		<input type="text" name="etcEmailAddress" id="etcEmailAddress" class="pwdFindSpace" placeholder="이메일 주소" />
			    <div id="etcEmailAddressCheck" class="infoConfirm"></div>
	      	</div>
	      	<input type="hidden" name="emailAddress" id="emailAddress" />
      	 	
	  	    <button type="button" name="pwdFind" id="pwdFind" class="btn btn-primary pwdFindSpace" style="margin-top: 30px;">임시비밀번호 발송</button>
	  	    <div id="findPwd" class="infoConfirm" style="margin-top: 10px;"></div><br>
	  	    <button type="button" name="idFind" id="idFind" class="btn btn-outline-secondary pwdFindSpace2" >아이디 찾기</button> 
	  	    <button type="button" name="goRegister" id="goRegister" class="btn btn-outline-secondary pwdFindSpace2" >회원가입 하기</button> 
	   </div> 	
	</form>        	   
</div>   
 
<jsp:include page="../footer.jsp" />