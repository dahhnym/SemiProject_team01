<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="../css/member.css"/>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
    var bool = false;
	
	$(function(){
		
		$("span.confirm").hide();
		$("tr#etc").hide();
		$("input#userid").focus();
		
		
		// 이메일주소를 select한 경우 
		$("input#emailAddress").val($("select#selectedEmailAddress option:selected").val());	// 기본값
		
		$("select#selectedEmailAddress").change(function(){			
			if($("select#selectedEmailAddress").val()=="기타"){	// select 기타 선정시
				$("tr#etc").show();	
				$("input#etcEmailAddress").blur(function(){
					$("input#emailAddress").val($(this).val());	
				});						
			} else {	// 그 외 select 옵션 선택시
				$("tr#etc").hide();	
				$("input#etcEmailAddress").val("");
				$("input#emailAddress").val($("select#selectedEmailAddress option:selected").val());	
			}
		});		
		
		
		// 약관동의 처리
		$("input#Agreements1").click(function(){	// 모두 동의를 클릭한 경우
			if($("input#Agreements1").is(":checked")){
				$("input#Agreements2").prop("checked",true);
				$("input#Agreements3").prop("checked",true);
				$("input#checkedAgreements3").val("1");
			} else {
				$("input#Agreements2").prop("checked",false);
				$("input#Agreements3").prop("checked",false);
				$("input#checkedAgreements3").val("0");
			}			
		});
		$("input#Agreements2").click(function(){	// 모두 동의 외 약관이 모두 체크된 경우의 모두 동의 체크하기
			if($("input#Agreements2").is(":checked")&&$("input#Agreements3").is(":checked")){
				$("input#Agreements1").prop("checked",true);
				$("input#checkedAgreements3").val("1");
			} else {
				$("input#Agreements1").prop("checked",false);
				$("input#checkedAgreements3").val("0");
			}
		});
		$("input#Agreements3").click(function(){	// 모두 동의 외 약관이 모두 체크된 경우의 모두 동의 체크하기
			if($("input#Agreements2").is(":checked")&&$("input#Agreements3").is(":checked")){
				$("input#Agreements1").prop("checked",true);
				$("input#checkedAgreements3").val("1");
			} else if($("input#Agreements3").is(":checked")) {
				$("input#checkedAgreements3").val("1");
			} else if(!$("input#Agreements3").is(":checked")) {
				$("input#Agreements1").prop("checked",false);
				$("input#checkedAgreements3").val("0");
			} 
			
		});

		
		// 회원가입 버튼을 누른 경우
		$("button#register").click(function(){
			window.scrollTo(0,0);
			goCheck();	// 유효성 검사 함수
			
			if(!bool) {
				var frm = document.registerFrm;
				frm.action="memberRegister.to";
				frm.method="POST";
				frm.submit();
			}
		});
		
		
	});	// end of $(function() -----------------------------------------------------------
	

	// register 버튼 클릭시, 유효성 검사
	function goCheck(){
		
		// 아이디 체크
		useridCheck();
		$("input#userid").blur(function(){
			useridCheck();
		});		
		
		// 비밀번호 체크
		pwdCheck();	
		$("input#pwd").blur(function(){
			pwdCheck();
		});
		
		// 비밀번호 확인 체크
		pwdCheck2();
		$("input#pwd2").blur(function(){
			pwdCheck2();
		});
		
		// 이름 체크
		nameCheck();
		$("input#name").blur(function(){
			nameCheck();
		});
		
		// 생년월일 체크
		birthdayCheck();
		$("input#birthday").blur(function(){
			birthdayCheck();
		});
		
		// 성별 체크
		genderCheck();
		$("button#gender").blur(function(){
			genderCheck();
		});
		
		// 이메일 아이디 체크
		emailIDCheck();
		$("input#emailID").blur(function(){
			emailIDCheck();
		});		
		
		// 기타 이메일 주소 체크
		$("select#selectedEmailAddress").change(function(){		
			if($("select#selectedEmailAddress").val()=="기타"){	// select 기타 선정시
				etcEmailAddressCheck();
				$("input#etcEmailAddress").blur(function(){
					etcEmailAddressCheck();
				});	
			}
		});	

		// 전화번호 체크
		ph2Check();
		$("input#ph2").blur(function(){
			ph2Check();
		});
		
		// 우편번호 체크
		postcodeCheck();
		$("input#postcode").blur(function(){
			postcodeCheck();
		});
		
		// 필수 약관 체크
		agreementsCheck();
		$(document).on("click","input#Agreements1", function(){
			agreementsCheck();
		});
		$(document).on("click","input#Agreements2", function(){
			agreementsCheck();
		});
		
		
	}// end of function goCheck() ------------------------------------------------------------------
	
	
	// 아이디 체크 함수
	function useridCheck(){
		var userid = $("input#userid").val().trim();
		if(userid==""){
			$("span#useridCheck").show();
			$("span#useridCheck").html("아이디를 입력해주세요.");
			$(this).val('');
			$(this).focus();
			bool=true;
			return true;	// *정정사항
		} else {
			$("span#useridCheck").hide();
			bool=false;
		}
	}
	
	
	// 비밀번호 체크 함수
	function pwdCheck(){
		var pwd = $("input#pwd").val().trim();
		if(pwd==""){
			$("span#pwdCheck").show();
			$("span#pwdCheck").html("비밀번호를 입력해주세요.");
			bool=true;
		} else {
			// 비밀번호 8-15자리, 영문자,숫자,특수기호 혼합 정규표현식
			var regExp= /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			var bool = regExp.test(pwd);
			if(!bool){
				$("span#pwdCheck").html("비밀번호는 8-15자리의 영문자, 숫자, 특수기호를 혼합해야 합니다.");
				bool=true;
			} else {
				$("span#pwdCheck").hide();
				bool=false;
			}
		}
	}
	
	
	// 비밀번호 체크 함수
	function pwdCheck2(){
		var pwd2 = $("input#pwd2").val().trim();
		if(pwd2==""){
			$("span#pwdCheck2").show();
			$("span#pwdCheck2").html("비밀번호 확인을 입력해주세요.");
			bool=true;
		} else {
			// 비밀번호 8-15자리, 영문자,숫자,특수기호 혼합 정규표현식
			if($("input#pwd").val().trim()!=pwd2){
				$("span#pwdCheck2").show();
				$("span#pwdCheck2").html("일치하지 않는 비밀번호입니다.");
				bool=true;
			} else {
				$("span#pwdCheck2").hide();
				bool=false;
			}
		}
	}
	
	
	// 이름 체크 함수
	function nameCheck(){
		var name = $("input#name").val().trim();
		if(name==""){
			$("span#nameCheck").show();
			$("span#nameCheck").html("이름을 입력해주세요.");
			$(this).focus();
			bool=true;
		} else {
			$("span#nameCheck").hide();
			bool=false;
		}
	}
	
	
	// 생년월일 체크 함수
	function birthdayCheck(){
		var birthday = $("input#birthday").val().trim();
		if(birthday==""){
			$("span#birthdayCheck").show();
			$("span#birthdayCheck").html("생년월일을 입력해주세요.");
			$(this).focus();
			bool=true;
		} else {
			// 6자리 생년월일 정규표현식
			var regExp=/([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))/;
			var bool = regExp.test(birthday);
			if(!bool){
				$("span#birthdayCheck").show();
				$("span#birthdayCheck").html("생년월일 날짜형식이 올바르지 않습니다.");
				bool=true;
			} else {
				$("span#birthdayCheck").hide();
				bool=false;
			}
		}
	}
	
	
	// 성별 체크 함수
	function genderCheck(){
		if($("input#gender").val().trim()==""){
			$("span#genderCheck").show();
			$("span#genderCheck").html("성별을 선택해주세요.");
			bool=true;
		}
	}
	
	
	// 성별 값 input 입력함수
	function genderInput(checkedbtn){
		$("input#gender").val($(checkedbtn).attr('value'));	
		$("span#genderCheck").html("");
		bool=false;
	}

	
	// 이메일 아이디 체크 함수
	function emailIDCheck(){
		var emailID = $("input#emailID").val().trim();
		if(emailID==""){
			$("span#emailIDCheck").show();
			$("span#emailIDCheck").html("이메일 아이디를 입력해주세요.");
			$(this).focus();
			bool=true;
		} else {
			$("span#emailIDCheck").hide();
			bool=false;
		}
	}
	
	
	// 기타 이메일 주소 체크 함수
	function etcEmailAddressCheck(){
		var etcEmailAddress = $("input#etcEmailAddress").val().trim();
		var regExp=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
		var b = regExp.test(etcEmailAddress);
		
		if(etcEmailAddress==""){
			$("span#etcEmailAddressCheck").show();
			$("span#etcEmailAddressCheck").html("이메일 주소를 입력해주세요.");
			$(this).focus();
			bool=true;
		} else {
			if(etcEmailAddress.includes("@")){
				$("span#etcEmailAddressCheck").show();
				$("span#etcEmailAddressCheck").html("@ 제외 주소값만 입력해주세요.");
				bool=true;
			} else if(!b) {
				$("span#etcEmailAddressCheck").show();
				$("span#etcEmailAddressCheck").html("이메일 형식이 올바르지 않습니다. 다시 입력해주세요.");
				bool=true;
			} else {
				$("span#etcEmailAddressCheck").hide();
				bool=false;
			}
		}
	}
	
	
	// 전화번호 체크 함수
	function ph2Check(){
		var ph2 = $("input#ph2").val().trim();
		if(ph2==""){
			$("span#ph2Check").show();
			$("span#ph2Check").html("전화번호를 입력해주세요.");
			$(this).focus();
			bool=true;
		} else {
			// 010 뒤 8자리 정규표현식
			var regExp=/[0-9]{8}/;
			var bool = regExp.test(ph2);
			if(!bool){
				$("span#ph2Check").show();
				$("span#ph2Check").html("010 뒤 숫자 8자리를 입력해주세요.");
				bool=true;
			} else {
				$("span#ph2Check").hide();
				bool=false;
			}
		}
	}
	
	// 우편번호 체크 함수
	function postcodeCheck(){
		var postcode = $("input#postcode").val().trim();
		if(postcode==""){
			$("span#postcodeCheck").show();
			$("span#postcodeCheck").html("우편번호 찾기를 해주세요.");
			bool=true;
		} else {
			$("span#postcodeCheck").hide();
			bool=false;
		}
	}
	
	// 우편번호 찾기 클릭시 에러문구 삭제하기
	function postcodeError(){
		$("span#postcodeCheck").hide();
		bool=false;
	}	
		
	// 약관 체크 함수
	function agreementsCheck(){
		if($("input#Agreements1").is(":checked")||$("input#Agreements2").is(":checked")){
		   $("span#agreementsCheck").hide();	
		   bool=false;
		} else {
			$("span#agreementsCheck").show();
			$("span#agreementsCheck").html("필수 약관에 동의해주세요.");
			bool=true;
		}
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////
	// 아이디 중복확인 함수	
	function idDuplicateCheck() {
		useridCheck();
		if($("input#userid").val().trim()!="") {
			$.ajax({
				url:"<%= ctxPath%>/member/idDuplicateCheck.to",
				data:{"userid":$("input#userid").val().trim()},
				dataType:"json",	
				success:function(json){
					if(json.idDuplicated) {
	 					// 입력한 userid 가 이미 사용중이라면
	 					$("span#useridCheck").show();
	 					$("span#useridCheck").html($("input#userid").val()+" 은 중복된 ID 이므로 사용불가 합니다.").css("color","red");
	 					$("input#userid").val("");
	 				} else {
	 					// 입력한 userid 가 DB 테이블에 존재하지 않는 경우라면
	 					$("span#useridCheck").show();
	 					$("span#useridCheck").html("사용가능한 ID 입니다.").css("color","green");
	 				} 
				},
					error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            	}    				
			}); // end of $.ajax ----------------------------------------------
		}		
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////
	var b_sendCode = false;	// 인증번호 발송여부 확인용
	
	// 전화번호 인증번호 발송 함수
	function func_sendCode() {
		var ph2 = $("input#ph2").val().trim();
		if(ph2==""){
			$("span#ph2Check").show();
			$("span#ph2Check").html("전화번호를 입력해주세요.");
			$(this).focus();
			bool=true;
			
		} else {			
			// 010 뒤 8자리 정규표현식
			var regExp=/[0-9]{8}/;
			var bool = regExp.test(ph2);
			if(!bool){
				$("span#ph2Check").show();
				$("span#ph2Check").html("010 뒤 숫자 8자리를 입력해주세요.");
				$("input#ph2").html("");
				$("input#ph2").focus();
				bool=true;
			} else {
				$("span#ph2Check").hide();
				$.ajax({
					url:"<%= ctxPath%>/member/sendCode.to",
					dataType:"json",
					data: {"ph2":$("input#ph2").val().trim()},
					success:function(json){
						if(json!=null&&json!="") {
		 					// 인증코드가 발송되었다면
		 					$("span#sendCodeCheck").show();
		 					$("span#sendCodeCheck").html("인증번호가 발송되었습니다.").css("color","green");
		 					b_sendCode=true;
		 				} else {
		 					// 인증코드가 발송되지 않았다면
		 					$("span#sendCodeCheck").show();
		 					$("span#sendCodeCheck").html("인증번호 발송에 실패했습니다.").css("color","red");
		 					bool=true;
		 				} 
					},
						error: function(request, status, error){
		                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }    				
				}); // end of $.ajax ----------------------------------------------
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////
	// 인증번호 일치여부 확인 함수
	function func_codeCheck() {
		var certificationCode = $("input#certificationCode").val().trim();	
	
		if(b_sendCode&&certificationCode==""){	// 발송되었는데 인증번호 입력이 안된 경우
			$("span#codeCheck").show();
			$("span#codeCheck").html("인증번호를 입력해주세요.");	
			bool=true;
			
		} else if(b_sendCode&&certificationCode!="") {	// 발송되었고 인증번호 입력된 경우
			$.ajax({
				url:"<%= ctxPath%>/member/codeConfirm.to",
				data:{"inputCode":$("input#certificationCode").val().trim()},
				dataType:"json",
				success:function(json){ 
					// json 은 {"result":true}  또는  {"result":false} 이다. 
					if(json.result) {
	 					// 발송된 인증코드와 사용자가 입력해준 발송코드가 일치한다라면
	 					$("span#sendCodeCheck").show();
	 					$("span#sendCodeCheck").html("인증되었습니다.").css("color","green");
	 				} else {
	 					// 발송된 인증코드와 사용자가 입력해준 발송코드가 일치하지 않으면
	 					alert("인증실패");
	 					$("span#sendCodeCheck").show();
	 					$("span#sendCodeCheck").html("인증에 실패했습니다. 다시 인증번호를 입력해주세요.").css("color","red");
	 					$("input#certificationCode").val("");
	 					$("input#certificationCode").focus();
	 					bool=true;
	 				} 
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }    				
			}); // end of $.ajax ----------------------------------------------
			
		}
		
	}
	
	///////////////////////////////////////////////////////////////////////////////////////
	// 카카오 우편번호 API
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("postcode").value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }// end of function execDaumPostcode() --------------------------------------------------------
	////////////////////////////////////////////////////////////////////////////////////////////////
	
</script> 


<div id="registerContainer">
   <form name="registerFrm">
   	   <div id="registerContainer">
   	   	   <h2 style="text-align:center; font-weight: bold;">회원가입</h2>
   	   	   <hr>
		   <table id="registerTable">
		      <tbody>
			      <tr>
			      	 <td>
			      	 	<input type="text" name="userid" id="userid" class="space" placeholder="아이디"/>
			      	 	<button type="button" class="btn btn-secondary check" onclick="idDuplicateCheck()">아이디 중복확인</button>
			      	 	<span id="useridCheck" class="confirm"></span>
			      	 </td>
			      </tr>
			      <tr>
			      	 <td colspan="2" class="design">
			      	 	<input type="password" name="pwd" id="pwd" class="space" placeholder="비밀번호" />
			      	 	<span id="pwdCheck" class="confirm"></span>
			      	 </td>    
			      </tr>
			      <tr>
			      	 <td colspan="2">
			      	 	<input type="password" name="pwd2" id="pwd2" class="space" placeholder="비밀번호 확인" />     
			      	 	<span id="pwdCheck2" class="confirm"></span>
			      	</td> 
			      </tr>
	      		  <tr>
			      	 <td colspan="2" class="design">
			      	 	<input type="text" name="name" id="name" class="space" placeholder="이름" />
  			      	 	<span id="nameCheck" class="confirm"></span>
  			      	 </td>   
			      </tr>
			      <tr>
			      	 <td colspan="2" class="design">
			      	 	<input type="text" name="birthday" id="birthday" class="space" placeholder="생년월일(ex 201010)" />    
			      		<span id="birthdayCheck" class="confirm"></span>
			      	</td> 
			      </tr>
			      <tr>
			      	 <td colspan="2" class="design">
			      	 	<button type="button" class="check btn btn-outline-secondary" style="width: 118px;" id="male" value="1" onclick="genderInput(this)" >남자</button>
			      	 	<button type="button" class="check btn btn-outline-secondary" style="width: 118px; margin-right: 20px;" id="female" value="2" onclick="genderInput(this)" >여자</button>
			      	 	<input type="hidden" name="gender" id="gender" />
			      	 	<span id="genderCheck" class="confirm"></span>
			      	 </td>    
			      </tr>
			      <tr>
			      	 <td colspan="2" class="design">
			      	 	<input type="text" name="emailID" id="emailID" style="width: 100px;" placeholder="이메일 아이디" />
				      	<select id="selectedEmailAddress" class="space" style="width: 135px; height: 30px;">
					      	<option value="gmail.com">gmail.com</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
						 	<option value="hanmail.net">hanmail.net</option>
						 	<option value="kakao.com">kakao.com</option>
						 	<option value="기타">기타</option>
				      	</select> 
				      	<input type="hidden" name="emailAddress" id="emailAddress" />
			      	 	<span id="emailIDCheck" class="confirm"></span>
			      	 </td>    
			      </tr>
			      <tr id="etc">
			      	 <td>
			      	 	<input type="text" name="etcEmailAddress" id="etcEmailAddress" class="space" placeholder="이메일 주소" />
			      	 	<span id="etcEmailAddressCheck" class="confirm"></span>
			      	 </td>    
			      </tr>
			      <tr>
			      	 <td class="design">
			      	 	<input type="text" name="ph1" id="ph1" placeholder="010" readonly />
			      	    <input type="text" name="ph2" id="ph2" class="space" style="width:185px;" />
			      	 	<span id="ph2Check" class="confirm"></span>
			      	 </td>
			      </tr>
			      <tr>
			      	 <td>
			      	 	<button type="button" id="sendCode" class="btn btn-secondary" style="width:240px;" onclick="func_sendCode()" >인증번호 발송</button>
			      	 	<span id="sendCodeCheck" class="confirm"></span>
			      	 </td>
			      <tr>
			      	 <td>
			      	 	<input type="text" name="certificationCode" id="certificationCode" style="width: 138px;" placeholder="인증번호" />
			      	    <button type="button" class="btn btn-secondary check" style="width: 100px;" onclick="func_codeCheck()" >인증번호 확인</button>
			      	 	<span id="codeCheck" class="confirm"></span>
			      	 </td> 
			      </tr>
			      <tr>
			         <td class="design">
				         <input type="text" name="postcode" id="postcode"  style="width: 138px;" placeholder="우편번호" />
				         <button type="button" class="btn btn-secondary check" id="zipcodeSearch" style="width: 100px; margin-right:25px;" onclick="execDaumPostcode(); postcodeError();" >우편번호 찾기</button>
			        	 <span id="postcodeCheck" class="confirm"></span>
			         </td>
			      </tr>
			      <tr>
			         <td><input type="text" id="address" name="address" class="space" placeholder="주소" /></td>
			      </tr>
			      <tr>
			         <td><input type="text" id="detailAddress" name="detailAddress" class="space" placeholder="상세주소" /></td>
			      </tr>
			      <tr>
			         <td><input type="text" id="extraAddress" name="extraAddress" class="space" placeholder="(기타주소)" /></td>
			      </tr>
			    </tbody>
			</table>
			<br>
			<div id="Agreements">
				<h4>Agreements</h4><br>
				<input type="checkbox" id="Agreements1" name="Agreements1" value="1" >
				<label for="Agreements1">&nbsp;&nbsp;모두 동의</label>	
			    <span id="agreementsCheck" class="confirm" style="margin-left:370px;"></span><br>
				<input type="checkbox" id="Agreements2" name="Agreements2" value="2" >
			    <label for="Agreements2">&nbsp;&nbsp;<a href="<%= ctxPath%>/member/agreements.to">이용약관 및 개인정보 처리방침</a>에 동의하십니까? (필수)</label><br>
			    <input type="checkbox" id="Agreements3" name="Agreements3" value="3">
			    <label for="Agreements3">&nbsp;&nbsp;뉴스레터 및 프로모션정보를 받고 싶습니다! (선택)</label><br>
			    <input type="hidden" name="checkedAgreements3" id="checkedAgreements3" />
			</div>
			<br>
			
			<button type="button" name="register" id="register" class="btn btn-primary">회원가입하기</button>
		<br><br>
		</div>
	</form>
</div>   
 
<jsp:include page="../footer.jsp" />