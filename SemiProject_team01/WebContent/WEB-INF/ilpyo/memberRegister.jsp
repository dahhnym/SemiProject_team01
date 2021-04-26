<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../kimdanim/header.jsp" />

<style type="text/css">
	table {
		height: 500px;
	}
	td {
		margin-top: 30px;	
		/* border: solid 1px black; */	
	}
	td.star {
		width: 20px;
		font-weight: bold;
	}
	input.space {
		margin-right: 20px;	
		height: 30px;
		width: 240px;
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
	input[type="submit"] {
		margin-left: 60%;
		width: 200px;
		height: 40px;	
	}
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
    var bool = false;

	$(function(){
		$("input#userid").focus();
		
		$("input[type:submit]").click(function(){
			goCheck();
			
			if(bool) {
				
			} else {
				var frm = document.registerFrm;
				frm.action="";
				frm.method="POST";
				frm.submit();
			}
		});
	});	
	
	
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
    }
	
	// input 사항 체크
	function goCheck(){
		
		// 아이디 체크
		if($("input#userid").val().trim()==""){
			$("span#useridCheck").html("아이디를 입력해주세요.");
			bool=true;
		}
	}
	
</script> 


<div style="padding-top: 200px;">	<%-- 정정해야할 사항 --%>
   <form name="registerFrm">
   	   <div align="center" id="main">
   	   	   <span><h2>회원가입</h2>(* 는 필수입력항목입니다.)</span>
   	   	   <hr style="width:70%;">
		   <table id="registerTable">
		      <tbody>
			      <tr>
			      	 <td class="star">*</td>
			      	 <td><input type="text" name="userid" id="userid" class="space" placeholder="아이디"/></td>
			      	 <td><button type="button" class="check">아이디 중복확인</button></td> <%-- 정정해야할 사항 --%>
			      	 <td><span id="useridCheck" class="confirm"></span></td>    
			      </tr>
			      <tr>
			      	 <td class="star">*</td>
			      	 <td colspan="2"><input type="password" name="pwd" id="pwd" class="space" placeholder="비밀번호" /></td>   
			      	 <td><span id="pwdCheck" class="confirm"></span></td> 
			      </tr>
			      <tr>
			         <td class="star">*</td>
			      	 <td colspan="2"><input type="password" name="pwdCheck" id="pwdCheck" class="space" placeholder="비밀번호 확인" /></td>     
			      	 <td><span id="pwdCheck2" class="confirm"></span></td> 
			      </tr>
	      		  <tr>
	      		     <td class="star">*</td>
			      	 <td colspan="2"><input type="text" name="name" id="name" class="space" placeholder="이름" /></td>  
			      	 <td><span id="nameCheck" class="confirm"></span></td>   
			      </tr>
			      <tr>
			         <td class="star">*</td>
			      	 <td colspan="2"><input type="text" name="birthdate" id="birthdate" class="space" placeholder="생년월일(ex 201010)" /></td>    
			      	 <td><span id="birthdateCheck" class="confirm"></span></td> 
			      </tr>
			      <tr>
			         <td class="star">*</td>
			      	 <td>
			      	 	<input type="text" name="emailID" id="emailID" style="width: 100px;" placeholder="이메일 아이디" />
				      	<select id="emailAddress" style="width: 140px;">
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
			      	 <td><span id="addtionalEmailAddressCheck" class="confirm"></span></td>    
			      </tr>
			      <tr>
			         <td class="star">*</td>
			      	 <td>
			      	 	<input type="text" name="ph1" id="ph1" placeholder="010" readonly />
			      	    <input type="text" name="ph2" id="ph2" />
			      	 </td>
			      	 <td><span id="ph2Check" class="confirm"></span></td>
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
			      	 <td class="star">*</td>
			         <td>
				         <input type="text" name="postcode" id="postcode"  style="width: 100px;" placeholder="우편번호" />
				         <button type="button" class="check" id="zipcodeSearch" onclick="execDaumPostcode()" >우편번호 찾기</button>
			         </td>
			         <td><span id="postcodeCheck" class="confirm"></span></td>
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
		<input type="submit" value="회원가입하기" >
	</form>
</div>   
 
<jsp:include page="../kimdanim/footer.jsp" />