<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    
<jsp:include page="../header.jsp"/>
<!DOCTYPE html>
<html>
<head>

<title>:::Order:::</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<%=ctxPath%>/css/hanseoyeon.css"/>

<!-- Google Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

<!-- 모달창 부트스트랩 -->
<script src="./jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="./bootstrapt/css/bootstrap.min.css" />
	<script src="./bootstrapt/js/bootstrap.min.js"></script>


<script type="text/javascript">


// == 물건 체크박스 함수 시작 == //

function allCheck(obj) {
    $("[name=product]").prop("checked",$(obj).prop("checked")); 
}// 모두 체크하기

function oneCheck(a){
	var allChkBox = $("[name=checkAll]");
	var chkBoxName = $(a).attr("name");
	
	if( $(a).prop("checked") ){
		    checkBoxLength = $("[name="+ chkBoxName +"]").length;
		    //전체체크박스 수(모두동의하기 체크박스 제외)
		    checkedLength = $("[name="+ chkBoxName +"]:checked").length;
		    //체크된 체크박스 수 
		    if( checkBoxLength == checkedLength ) {
		        allChkBox.prop("checked", true);
		        //전체체크박스수 == 체크된 체크박스 수 같다면 모두체크
		
		    } else {
		        allChkBox.prop("checked", false);
		        
		    }
	}
	else{
	   allChkBox.prop("checked", false);
	}
}

//== 물건 체크박스 함수 끝 == //



// == 동의 체크박스 함수 시작 == //

function allAgree(obj) {
    $("[name=agree]").prop("checked",$(obj).prop("checked")); 
}// 모두 체크하기

function oneAgree(a){
	var allChkBox = $("[name=agreeAll]");
	var chkBoxName = $(a).attr("name");
	
	if( $(a).prop("checked") ){
		    checkBoxLength = $("[name="+ chkBoxName +"]").length;
		    //전체체크박스 수(모두동의하기 체크박스 제외)
		    checkedLength = $("[name="+ chkBoxName +"]:checked").length;
		    //체크된 체크박스 수 
		    if( checkBoxLength == checkedLength ) {
		        allChkBox.prop("checked", true);
		        //전체체크박스수 == 체크된 체크박스 수 같다면 모두체크
		
		    } else {
		        allChkBox.prop("checked", false);
		        
		    }
	}
	else{
	   allChkBox.prop("checked", false);
	}
}


//== 동의 체크박스 함수 끝 == //

function sampleModalPopup(){
        // 팝업 호출 url
        var url = "호출할 URL";
        
        // 팝업 호출
        $("#sampleModalPopup > .modal-dialog").load(url, function() { 
            $("#sampleModalPopup").modal("show"); 
        });
    }


// !!!!!!!!!!! ==== 결제하기 눌렀을 때 ==== !!!!!!!!!!!
function goCheckOut(){
	
	////// 필수사항 값이 없을 때 //////
	var flag = false;
	
	$(".requiredInfo").each(function(index,item){
		var val=$(item).val().trim();
		if(val==""){
			alert("*표시된 필수사항은 모두 입력하셔야 합니다");
			flag=true;
			return false;
		}
	});
	
	if(!flag){
		var frm=document.prodInputFrm;
		frm.action = "memberRegister.up";
		frm.submit();
	}
	///////////////////////////
	
	
	
    // 이용약관
    var checkboxCheckedLength = $("input:checkbox[id=agree]:checked").length;
    
    if(checkboxCheckedLength == 0) {
       alert("이용약관에 동의하셔야 합니다.");
       return; // 종료
    }
    
    //// 최종적으로 필수입력사항에 모두 입력이 되었는지 검사한다. ////
    var bFlagRequiredInfo = false;
    
    $(".requiredInfo").each(function(index, item){
       var data = $(item).val();
       if(data == "") {
          bFlagRequiredInfo = true;
          alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
          return false; // break 라는 뜻이다.
       }
    });
    
    if(!b_flagIdDuplicaateClick){
       //'아이디 중복 확인'을 클릭하지않았을 경우
       alert("아이디 중복확인을 클릭하여 아이디 중복검사를 하세요!!");
       return;
    }
    
    if(!bFlagRequiredInfo) {
       var frm = document.registerFrm;
       frm.action = "memberRegister.up";
       frm.method = "post";
       frm.submit();
    }
}




//////////////////////////////////////////////////////////////////////////////////

$(function(){

	
	$("[name=checkAll]").click(function(){
	    allCheck(this);
	    //모두동의하기 체크박스 클릭시
	});
	
	$("[name=product]").each(function(){
	    $(this).click(function(){
	        oneCheck($(this));
	    });
	});
	
	$("[name=agreeAll]").click(function(){
		allAgree(this);
	    //모두동의하기 체크박스 클릭시
	});
	
	$("[name=agree]").each(function(){
	    $(this).click(function(){
	    	oneAgree($(this));
	    });
	});
	
	// 우편번호 클릭시
    $("img#zipcodeSearch").click(function(){
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
                  document.getElementById('postcode').value = data.zonecode;
                  document.getElementById("address").value = addr;
                  // 커서를 상세주소 필드로 이동한다.
                  document.getElementById("detailAddress").focus();
              }
          }).open();
     });   
    
    // 모달창 만들기
    $('#testBtn1').click(function(e){
		e.preventDefault();
		$('#testModal1').modal("show");
	});
    
    $('#testBtn2').click(function(e){
		e.preventDefault();
		$('#testModal2').modal("show");
	});
    
    
    
    // 주문상품 삭제하기 클릭하면 다시 새로고침되면서 체크한 상품 삭제하고 보여주기
    
    
    // 주문자 정보와 동일 클릭하면 자동으로 채워넣기
    
    
	// 모달창에서 동의하기클릭하면 체크하기
	
	
	
	
	
	

	
});

</script>


</head>

<div class="container">

	<h2>Order</h2>
	<br><br><br>
	<div id="left">
	<h4>주문 상품 정보</h4>
	<br>
	</div>
	
	<table id="prodInfo">
		<thead align="center">
			<tr id="prodInfo">
				<th><input type="checkbox" name="checkAll"/></th>
				<th>이미지</th>
				<th width="30%">상품정보</th>
				<th>수량</th>
				<th>판매가</th>
				<th>적립포인트</th>
				<th>배송비</th>
				<th>합계</th>
			</tr>
		</thead>
			<tr id="prodInfo">
				<th><input type="checkbox" name="product"  /></th>
				<td><a href="">이미지 연결</a></td>
				<td align="left"><a href="">[상품정보]링크걸기</a><br>[옵션:컬러]</td>
				<td>1</td>
				<td>30,000원</td>
				<td align="center"><div id="pointbox">5% 적립</div>150원</td>
				<td>[무료]</td>
				<td>30,000원</td>
			</tr>
			<tr>
				<td id="sumtbl" colspan="8">상품구매금액 원 + 배송비 원 = 합계 : <span id="sum">원</span></td>				
			</tr>
		</tbody>
	</table>	 
	<div class="left" style="font-size:10pt;">
	! 상품의 옵션 및 수량 변경은 상품 상세 혹은 장바구니에서 가능합니다.
	<br>선택상품을 <input type="button" value="삭제하기" id="deleteBtn" style="border:none; font-size:9pt;""/>
	</div>
	<br><br>
	
	<div class="left" style="display:inline-block; float:left; ">
		<span style="font-size:15pt; font-weight: bold;">주문 정보</span>
	</div>
	<div style="float:right;display:inline-block;" align="right">
		<span style="font-size:10pt;"><span class="star">*</span>&nbsp;필수입력사항</span>
	</div>
	<br>
	
	<hr>
	
	
	<table id="ordererInfo" class="left">
		
			<tr>
				<th>
					<label for="name" >이름&nbsp;<span class="star">*</span></label>
				</th>
			</tr>
			<tr>
				<td>
					<input type="text" name="name" id="name" class="requiredInfo" /> 
				</td>
			</tr>	
			<tr>
				<th>
					<label for="name" >주소&nbsp;<span class="star">*</span></label>
				</th>
			</tr>
			<tr>
				<td>
					<input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
					<%-- 우편번호 찾기 --%>
					<img id="zipcodeSearch" src="../b_zipcode.gif" style="vertical-align: middle;" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="address" name="address" size="40" placeholder="주소" /><br/>
				</td>
			</tr>
			<tr>		
				<td>
					<input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
				</td>
			</tr>
			<tr>
         		<th>연락처&nbsp;<span class="star">*</span><th>
         	</tr>
         	<tr>
         		<td>
	             	<input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
	             	<input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
	             	<input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
             	</td>
    	<tr>
	         	<th>이메일</th>
			</tr>
	        <tr>	         	
	         	<td><input type="text" name="email" id="email" placeholder="abc@def.com" /> </td>
            </tr>
	</table>
	<hr>
	
	<br><br>

	

	
	<div class="left" style="display:inline-block; float:left; ">
		<span style="font-size:15pt; font-weight: bold;">배송 정보</span>
		<span style="font-size:10pt;">&nbsp;<input type="checkbox"/>&nbsp;주문자 정보와 동일</span>
	</div>
	<div style="float:right;display:inline-block;" align="right">
		<span style="font-size:10pt;"><span class="star">*</span>&nbsp;필수입력사항</span>
	</div>
	
	<br>
	<hr>
	
	<table id="shippingInfo" class="left">
		
			<tr>
				<th>
					<label for="name" >이름&nbsp;<span class="star">*</span></label>
				</th>
			</tr>
			<tr>
				<td>
					<input type="text" name="name" id="name" class="requiredInfo" /> 
				</td>
			</tr>	
			<tr>
				<th>
					<label for="name" >주소&nbsp;<span class="star">*</span></label>
				</th>
			</tr>
			<tr>
				<td>
					<input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
					<%-- 우편번호 찾기 --%>
					<img id="zipcodeSearch" src="../b_zipcode.gif" style="vertical-align: middle;" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="address" name="address" size="40" placeholder="주소" /><br/>
				</td>
			</tr>
			<tr>		
				<td>
					<input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
				</td>
			</tr>
			<tr>
         		<th>연락처&nbsp;<span class="star">*</span><th>
         	</tr>
         	<tr>
         		<td>
	             	<input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
	             	<input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
	             	<input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
             	</td>
	      	<tr>
	         	<th>배송 메세지</th>
			</tr>
	        <tr>	         	
	         	<td>
	         		<select class="orderStatus" id="shippingMsg" style="margin-left:0px;">
						<option value="" selected>&nbsp;&nbsp;배송 요청사항을 입력해주세요&nbsp;&nbsp;</option>
						<option value="opt_1">문 앞에 놓아주세요</option>
						<option value="opt_2">경비(관리)실에 맡겨주세요</option>
						<option value="opt_3">택배함에 넣어주세요</option>
						<option value="opt_4">직접 받겠습니다</option>						
					</select>					
	         	</td>
            </tr>
	</table>
	<hr>
	<br><br>
	
	
	<div class="left">
		<span style="font-size:15pt; font-weight: bold;">할인 정보</span>
	</div>
	<hr>
	
	<table id="discountInfo">
		<tr>
			<th style="text-align:left; width:40%; ">보유 point</th>
			<td style="text-align:right; width:60%;">
				<input type="text" style="width:100%; border:none; text-align:right; background-color:#e6e6e6;" value="로그인사용자point" readonly/>
			</td>
		</tr>
		<tr>
			<th style="text-align:left; width:40%; ">사용 point</th>
			<td style="text-align:right; width:60%;"">
				<input type="text" style="width:100%;border:1px solid gray; text-align:right;" value="원" />
			</td>
		</tr>
		<tr>	         	
			<th style="text-align:left; width:40%; ">할인 쿠폰</th>
         	<td>
         		<select class="orderStatus" id="coupon" style=" margin-right:0px;">
					<option value="" selected>&nbsp;쿠폰을 사용하시겠습니까?&nbsp;</option>
					<c:forEach var="" items="">
						<option value=""></option>
					</c:forEach>
				</select>				
         	</td>
		</tr>
	</table>
	<hr>
	<br><br>
	
	
	<div class="left">
		<span style="font-size:15pt; font-weight: bold;">결제 정보</span>
	</div>
	<hr>
	<div class="left">
		<input type="button" value="신용카드" id="btnCredit" style="width:100px; height:40px; border:none; margin-right:20px;"/>
		<input type="button" value="무통장" id="btnCredit" style="width:100px; height:40px; border:none; margin-right:20px;"/>
		<input type="button" value="휴대폰결제" id="btnCredit" style="width:100px; height:40px; border:none;"/>
	</div>
	<br><br>
	
	
	<div class="left">
		<span style="font-size:15pt; font-weight: bold;">주문 금액</span>
	</div>
	<hr>
	
	<table style="width:100%;">
		<tr>
			<td style="text-align:left;">상품금액</td>
			<td style="text-align:right;">30,000원</td>
		</tr>
		<tr>
			<td style="text-align:left;">배송비</td>
			<td style="text-align:right;">원</td>
		</tr>
		<tr>
			<td style="text-align:left;">쿠폰 사용</td>
			<td style="text-align:right;">원</td>
		</tr>
		<tr>
			<td style="text-align:left;">포인트 사용</td>
			<td style="text-align:right;">원</td>
		</tr>
		<tr>
			<td style="text-align:left; font-size:13pt; font-weight:bold;">최종 결제금액</td>
			<td style="text-align:right; font-size:15pt; font-weight:bold;">30,000원</td>
		</tr>
	</table>
	<br><br>
	
	<table class="left" style="width:40%;">
	<tr>
		<td>
			<input type="checkbox" name="agree" id="agree1"/>
		</td>
		<td>
			<label for="agree1">쇼핑몰 이용약관에 동의합니다.(필수)</label>
			&nbsp;<button id="testBtn1" class="btn" style=";font-size:10pt; text-decoration:underline;">약관보기</button>
	
		  <!-- 약관보기 Modal-->
			<div class="modal fade" id="testModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">쇼핑몰 이용약관(공정거래위원회 표준 약관)</h5>
							<button class="close" type="button" data-dismiss="modal" aria-label="Close">						
							</button>
						</div>
						<div class="modal-body">
							<div class="terms">
								제1조(목적)
			이 약관은 (유)내고향시푸드(전자거래 사업자)이 운영하는 홈페이지(이하 "쇼핑몰"이라 한다)에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 한다)를 이용함에 있어 (유)내고향시푸드와 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.
			※ 「PC통신 등을 이용하는 전자거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다」
			
			
			제2조(정의)
			① "쇼핑몰" 이란 사업자가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 쇼핑몰을 운영하는 사업자의 의미로도 사용합니다.
			
			② "이용자"란 "쇼핑몰"에 접속하여 이 약관에 따라 "쇼핑몰"이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
			
			③ "회원"이라 함은 "쇼핑몰"에 개인정보를 제공하여 회원등록을 한 자로서, "쇼핑몰"의 정보를 지속적으로 제공받으며, "쇼핑몰"이 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
			
			④ "비회원"이라 함은 회원에 가입하지 않고 "쇼핑몰"이 제공하는 서비스를 이용하는 자를 말합니다.
			
			
			제3조 (약관의 명시와 개정)
			① "쇼핑몰"은 이 약관의 내용과 상호, 영업소 소재지, 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등) 등을 이용자가 알 수 있도록 사이트의 초기 서비스화면(전면)에 게시합니다.
			
			② "쇼핑몰"은 약관의 규제 등에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망 이용촉진 등에 관한 법률, 방문판매 등에 관한법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
			
			③ "쇼핑몰"이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 홈페이지의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
			
			④ "쇼핑몰"이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 "쇼핑몰"에 송신하여 "쇼핑몰"의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.
			
			⑤ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 정부가 제정한 전자거래소비자보호지침 및 관계법령 또는 상관례에 따릅니다.
			
			
			제4조(서비스의 제공 및 변경)
			① "쇼핑몰"은 다음과 같은 업무를 수행합니다.
			1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결
			2. 구매계약이 체결된 재화 또는 용역의 배송
			3. 기타 "쇼핑몰"이 정하는 업무
			
			② "쇼핑몰"은 재화의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화·용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화·용역의 내용 및 제공일자를 명시하여 현재의 재화·용역의 내용을 게시한 곳에 그 제공일자 이전 7일부터 공지합니다.
			
			③ "쇼핑몰"이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 "쇼핑몰"은 이로 인하여 이용자가 입은 손해를 배상합니다. 단, "쇼핑몰"에 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.
			
			
			제5조(서비스의 중단)
			① "쇼핑몰"은 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.
			
			② 제1항에 의한 서비스 중단의 경우에는 "쇼핑몰"은 제8조에 정한 방법으로 이용자에게 통지합니다.
			
			③ "쇼핑몰"은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단 "쇼핑몰"에 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.
							</div>
						</div>
						<div class="modal-footer">
							<button class="btn" type="button" data-dismiss="modal">닫기</button>
							<a class="btn" id="modalY" data-dismiss="modal" style="color:#0099ff;">동의합니다</a>
						</div>
					</div>
				</div>
			</div>
		</td>
		
	</tr>
	<tr>
		<td>
			<input type="checkbox" name="agree" id="agree2"/>
		</td>
		<td>
			<label for="agree2">쇼핑몰 취소/반품 정책에 동의합니다.(필수)</label>
			&nbsp;<button id="testBtn2" class="btn" style=";font-size:10pt; text-decoration:underline;">약관보기</button>
					 <!-- 약관보기 Modal-->
			<div class="modal fade" id="testModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">쇼핑몰 취소/반품 정책</h5>
							<button class="close" type="button" data-dismiss="modal" aria-label="Close">						
							</button>
						</div>
						<div class="modal-body">
							<div class="terms">
								일반적으로 소비자는 자신이 체결한 전자상거래 계약에 대해 그 계약의 내용을 불문하고 그 청약철회 및 계약해제의 기간(통상 7일) 내에는 청약철회 등을 자유롭게 할 수 있습니다(「전자상거래 등에서의 소비자보호에 관한 법률」 제17조제1항).
※ 소비자에게 불리한 규정(주문 취소나 반품 금지 등)이 포함된 구매계약은 효력이 없습니다(「전자상거래 등에서의 소비자보호에 관한 법률」 제35조).
 하지만, 다음 어느 하나에 해당하는 경우에는 인터넷쇼핑몰 사업자의 의사에 반(反)해서 주문 취소 및 반품을 할 수 없습니다(「전자상거래 등에서의 소비자보호에 관한 법률」 제17조제2항 본문 및 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」 제21조).
1. 소비자의 잘못으로 물건이 멸실(물건의 기능을 할 수 없을 정도로 전부 파괴된 상태)되거나 훼손된 경우(다만, 내용물을 확인하기 위해 포장을 훼손한 경우에는 취소나 반품이 가능)
2. 소비자가 사용해서 물건의 가치가 뚜렷하게 떨어진 경우
3. 시간이 지나 다시 판매하기 곤란할 정도로 물건의 가치가 뚜렷하게 떨어진 경우
4. 복제가 가능한 물건의 포장을 훼손한 경우
5. 용역 또는 「문화산업진흥 기본법」 제2조제5호의 디지털콘텐츠의 제공이 개시된 경우. 다만, 가분적 용역 또는 가분적 디지털콘텐츠로 구성된 계약의 경우에는 제공이 개시되지 않은 부분은 제외
6. 소비자의 주문에 따라 개별적으로 생산되는 상품 또는 이와 유사한 상품 등의 청약철회 및 계약해제를 인정하는 경우 인터넷쇼핑몰 사업자에게 회복할 수 없는 중대한 피해가 예상되는 경우로서 사전에 주문 취소 및 반품이 되지 않는다는 사실을 별도로 알리고 소비자의 서면(전자문서 포함)에 의한 동의를 받은 경우
 인터넷쇼핑몰 사업자는 위 2.부터 5.까지의 사유에 해당하여 청약철회 등이 불가능한 상품에 대해 그 사실을 상품의 포장이나 그 밖에 소비자가 쉽게 알 수 있는 곳에 명확하게 적거나 시험 사용 상품을 제공하는 등의 방법으로 청약철회 등의 권리 행사가 방해받지 않도록 조치해야 합니다(「전자상거래 등에서의 소비자보호에 관한 법률」 제17조제6항 본문). 만약 사업자가 이와 같은 조치를 안했다면, 소비자는 청약철회 등의 제한사유에도 불구하고 청약철회 등을 할 수 있습니다(「전자상거래 등에서의 소비자보호에 관한 법률」 제17조제2항 단서).
 다만, 위의 5. 중 디지털콘텐츠에 대하여 소비자가 청약철회 등을 할 수 없는 경우에는 청약철회 등이 불가능하다는 사실의 표시와 함께 다음의 어느 하나의 방법에 따라 시험 사용 상품을 제공하는 등의 방법으로 청약철회 등의 권리 행사가 방해받지 않도록 해야 합니다(「전자상거래 등에서의 소비자보호에 관한 법률」 제17조제6항 단서 및 규제「전자상거래 등에서의 소비자보호에 관한 법률 시행령」 제21조의2).
			
			
								</div>

						</div>
						<div class="modal-footer">
							<button class="btn" type="button" data-dismiss="modal">닫기</button>
							<a class="btn" id="modalY"data-dismiss="modal" style="color:#0099ff;">동의합니다</a>
						</div>
					</div>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" name="agreeAll" id="agreeAll"/>
		</td>
		<td>
			<label for="agreeAll">전체 동의</label>
		</td>
	</tr>
	</table>
	<br><br>

	<input type="button" value="결제하기" id="buy" 
	style="width:300px; height:40px; border:none; margin-right:20px; background-color:#737373; color:white;"
	onClick="goCheckOut()"/>
			


</div>


<jsp:include page="../footer.jsp"/> 