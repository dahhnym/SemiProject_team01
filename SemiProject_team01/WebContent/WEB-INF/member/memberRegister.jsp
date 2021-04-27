<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../kimdanim/header.jsp" />

<style type="text/css">
	table {
		height: 500px;
		margin-top: 50px;
	}
	td {
		margin-top: 30px;	
		/* border: solid 1px black; */	
	}
	td.star {
		width: 20px;
		font-weight: bold;
	}
	input.space {	<%-- 정정해야할 사항 --%>
		margin-right: 20px;	
		height: 30px;
		width: 240px;
	}
	.design {
		padding-top:15px;
	}
	div#Aggrements {
		margin: 50px 0 0 30%;
	}
	input[type="checkbox"] {
		margin-top: 5px;	
	}
	button.check {
		font-size: 8pt;
	}
	input#ph1 {
		width: 50px;
		margin-right: 0;	
	}
	button#submit {
		margin-left: 60%;
		width: 200px;
		height: 40px;	
	}
	.confirm {
		margin-left: 50px;
		font-weight: bold;
		color: red;
	}
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
    var bool = false;

	$(function(){

		$("span.confirm").hide();
		$("tr#etc").hide();
		$("input#userid").focus();
		
		// 이메일주소를 기타로 설정한 경우
		$("select#emailAddress").change(function(){
			if($("select#emailAddress").val()=="6"){
				$("tr#etc").show();	
			} else {
				$("tr#etc").hide();		
			}
		});		
		
		// 회원가입 버튼을 누른 경우
		$("button#submit").click(function(){
			goCheck();
			
			if(!bool) {
				var frm = document.registerFrm;
				frm.action="";
				frm.method="POST";
				frm.submit();
			}
		});
	});	// end of $(function() -----------------------------------------------------------
	

	// submit 버튼 클릭시, 유효성 검사
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
		birthdateCheck();
		$("input#birthdate").blur(function(){
			birthdateCheck();
		});
		
		// 이메일 아이디 체크
		emailIDCheck();
		$("input#emailID").blur(function(){
			emailIDCheck();
		});
		
		// 기타 이메일 주소 입력여부
		if($("select#emailAddress").val()=="6"){
			
		}
		
		
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
			return true;
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
			} else 
				$("span#pwdCheck2").hide();
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
		}
	}
	
	
	// 생년월일 체크 함수
	function birthdateCheck(){
		var birthdate = $("input#birthdate").val().trim();
		if(birthdate==""){
			$("span#birthdateCheck").show();
			$("span#birthdateCheck").html("생년월일을 입력해주세요.");
			$(this).focus();
			bool=true;
		} else {
			// 6자리 생년월일 정규표현식
			var regExp=/([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))/;
			var bool = regExp.test(birthdate);
			if(!bool){
				$("span#birthdateCheck").show();
				$("span#birthdateCheck").html("생년월일 날짜형식이 올바르지 않습니다.");
			} else {
				$("span#birthdateCheck").hide();
			}
		}
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
			$("span#emailIDCheck").show();
			$("span#emailIDCheck").hide();
		}
	}
	
	
	// 기타 이메일 주소 체크 함수
	function etcEmailAddressCheck(){
		var etcEmailAddress = $("input#etcEmailAddress").val().trim();
		if(etcEmailAddress==""){
			$("span#etcEmailAddressCheck").html("이메일 주소를 입력해주세요.");
			$(this).focus();
			bool=true;
		} else {
			$("span#etcEmailAddressCheck").hide();
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


<div style="padding-top: 200px;">	<%-- 정정해야할 사항 --%>
   <form name="registerFrm">
   	   <div style="margin-left:500px;" id="main">
   	   	   <h2 style="margin-left:20%;">회원가입</h2>
   	   	   <span style="margin-left:18%;">(* 는 필수입력항목입니다.)</span>
   	   	     	   	   
		   <table id="registerTable">
		      <tbody>
			      <tr>
			      	 <td class="star">*</td>
			      	 <td><input type="text" name="userid" id="userid" class="space" placeholder="아이디"/></td>
			      	 <td><button type="button" class="check">아이디 중복확인</button></td> <%-- 정정해야할 사항 --%>
			      	 <td><span id="useridCheck" class="confirm"></span></td>    
			      </tr>
			      <tr>
			      	 <td class="star design">*</td>
			      	 <td colspan="2" class="design"><input type="password" name="pwd" id="pwd" class="space" placeholder="비밀번호" /></td>   
			      	 <td class="design"><span id="pwdCheck" class="confirm"></span></td> 
			      </tr>
			      <tr>
			         <td></td>
			      	 <td colspan="2"><span style="color:gray">※ 비밀번호는 8-15자리의 영문자, 숫자, 특수기호를 혼합해야 합니다.</span></td>  
			      </tr>
			      <tr>
			         <td class="star">*</td>
			      	 <td colspan="2"><input type="password" name="pwd2" id="pwd2" class="space" placeholder="비밀번호 확인" /></td>     
			      	 <td><span id="pwdCheck2" class="confirm"></span></td> 
			      </tr>
	      		  <tr>
	      		     <td class="star design">*</td>
			      	 <td colspan="2" class="design"><input type="text" name="name" id="name" class="space" placeholder="이름" /></td>  
			      	 <td class="design"><span id="nameCheck" class="confirm"></span></td>   
			      </tr>
			      <tr>
			         <td class="star design">*</td>
			      	 <td colspan="2" class="design"><input type="text" name="birthdate" id="birthdate" class="space" placeholder="생년월일(ex 201010)" /></td>    
			      	 <td class="design"><span id="birthdateCheck" class="confirm"></span></td> 
			      </tr>
			      <tr>
			         <td class="star design">*</td>
			      	 <td colspan="2" class="design">
			      	 	<input type="text" name="emailID" id="emailID" style="width: 100px;" placeholder="이메일 아이디" />
				      	<select id="emailAddress" style="width: 140px; height: 30px;">
					      	<option value="1">gmail.com</option>
							<option value="2">naver.com</option>
							<option value="3">daum.net</option>
						 	<option value="4">hanmail.net</option>
						 	<option value="5">kakao.com</option>
						 	<option value="6">기타</option>
				      	</select> 
			      	 <td><span id="emailIDCheck" class="confirm"></span></td>    
			      </tr>
			      <tr id="etc">
			         <td class="star">*</td>
			      	 <td><input type="text" name="etcEmailAddress" id="etcEmailAddress" class="space" placeholder="이메일 주소" /></td> 
			      	 <td><span id="etcEmailAddressCheck" class="confirm"></span></td>    
			      </tr>
			      <tr>
			         <td class="star design">*</td>
			      	 <td class="design">
			      	 	<input type="text" name="ph1" id="ph1" placeholder="010" readonly />
			      	    <input type="text" name="ph2" id="ph2" />
			      	 </td>
			      	 <td class="design"><span id="ph2Check" class="confirm"></span></td>
			      </tr>
			      <tr>
			         <td class="star">*</td>
			      	 <td><button type="button" id="sendCode" style="width: 240px;">인증번호 발송</button></td>
			      	 <td><span id="sendCode" class="confirm"></span></td>
			      <tr>
			         <td class="star">*</td>
			      	 <td>
			      	 	<input type="text" name="certifyCode" id="certifyCode" style="width: 138px;" placeholder="인증번호" />
			      	    <button type="button" class="check" style="width: 100px;">인증번호 확인</button>
			      	 </td>
			      	 <td><span id="codeCheck" class="confirm"></span></td> 
			      </tr>
			      <tr>
			      	 <td class="star design">*</td>
			         <td class="design">
				         <input type="text" name="postcode" id="postcode"  style="width: 100px;" placeholder="우편번호" />
				         <button type="button" class="check" id="zipcodeSearch" onclick="execDaumPostcode()" >우편번호 찾기</button>
			         </td>
			         <td class="design"><span id="postcodeCheck" class="confirm"></span></td>
			      </tr>
			      <tr>
			         <td class="star">*</td>
			         <td><input type="text" id="address" name="address" class="space" placeholder="주소" /></td>
			      </tr>
			      <tr>
			         <td class="star">*</td>
			         <td><input type="text" id="detailAddress" name="detailAddress" class="space" placeholder="상세주소" /></td>
			      </tr>
			      <tr>
			         <td class="star">*</td>
			         <td><input type="text" id="extraAddress" name="extraAddress" class="space" placeholder="(기타주소)" /></td>
			      </tr>
			    </tbody>
			</table>
		</div>
		<br><br>

		<div id="Aggrements">
			<h4>Aggrements</h4><br>
			<input type="checkbox" id="Aggrements1" name="Aggrements1" value="1">
		    <label for="Aggrements1">&nbsp;&nbsp;<a>이용약관 및 개인정보 처리방침</a>에 동의하십니까? (필수)</label>
		    <span id="aggrementsCheck" class="confirm"></span><br>
		    <input type="checkbox" id="Aggrements2" name="Aggrements2" value="2">
		    <label for="Aggrements2">&nbsp;&nbsp;뉴스레터 및 프로모션정보를 받고 싶습니다! (선택)</label><br>
		    <input type="checkbox" id="Aggrements3" name="Aggrements3" value="3">
		    <label for="Aggrements3">&nbsp;&nbsp;모두 동의</label><br><br>		
		</div>
		<br>
		<button type="button" id="submit" >회원가입하기</button>
	</form>
</div>   
 
<jsp:include page="../kimdanim/footer.jsp" />