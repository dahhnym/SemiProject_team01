<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>  
<c:set var="sum" value="0"/>  

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

<!-- 다음 우편번호 제이쿼리 -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

var str_pnum="";
var totalsum = $("[name=totalsum ]").val();
$(function(){
	
	
	///// ===== ***** 상품 목록 보여주기 ***** ===== /////
	displayOdr();
	
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
	
	
    
    // 모달창 만들기
    $('#testBtn1').click(function(e){
		e.preventDefault();
		$('#testModal1').modal("show");
	});
    
    $('#testBtn2').click(function(e){
		e.preventDefault();
		$('#testModal2').modal("show");
	});
    
    
    
    
    
    // 주문자 정보와 동일 클릭하면 자동으로 채워넣기
    $("input#sameLoginusesr").click(function(){
    	
    	var name = $("input#orderName").val();
    	var hp2 = $("[name=ordererHp2]").val();
    	var hp3 = $("[name=ordererHp3]").val();
    	var zip = $('[name=orderZip]').val();
    	var addr1 = $('[name=addr1]').val();
    	var addr2 = $('[name=addr2]').val();
    	var extraAddress = $('[name=extraAddress]').val();
    	
    	if($(this).is(":checked")){
	    	$("input#shipName").val(name);
	    	$("[name=shipHp2]").val(hp2);
	    	$("[name=shipHp3]").val(hp3);
	    	$("[name=shipZip]").val(zip);
	    	$("[name=addr3]").val(addr1);
	    	$("[name=addr4]").val(addr2);
	    	$("[name=extraAddress2]").val(extraAddress);	
	    	alert(delivery);
    	}
    	else {
    		$("input#shipName").val("");
	    	$("[name=shipHp2]").val("");
	    	$("[name=shipHp3]").val("");
	    	$("[name=shipZip]").val("");
	    	$("[name=addr3]").val("");
	    	$("[name=addr4]").val("");
	    	$("[name=extraAddress2]").val("");
    	}
    });
    
    
    
	// 첫번째 모달창에서 동의하기클릭하면 체크하기
	$("#modalY").click(function(){
		$("#agree1").prop("checked",true);
	});
	
	// 두번째 모달창에서 동의하기클릭하면 체크하기
	$("#modalY2").click(function(){
		$("#agree2").prop("checked",true);
	});
	
	
	
	// 연락처 hp2 숫자 4자리 아닐 경우
	$("[name=hp2]").blur(function(){
         
            var regExp = /^[1-9][0-9]{3}$/i; 
            // 첫번째 숫자는 0을 제외하고 나머지 3개는 0을 포함한 숫자만 오도록 검사해주는 정규표현식 객체 생성  
         
            var bool = regExp.test($(this).val());
            
            if(!bool) {
            	alert("전화번호 4자리를 올바르게 입력하세요");
            }
         });
    
	
    $("input#hp3").blur(function(){
       
       var regExp = /^\d{4}$/i; 
       // 숫자 4개만 오도록 검사해주는 정규표현식 객체 생성  
    
       var bool = regExp.test($(this).val());
       
       if(!bool) {
          alert("전화번호 4자리를 올바르게 입력하세요");
       }
       
    });
         
         
	// 이메일 정규표현식 검사
	$("input#email").blur(function(){
         
         //   var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
         //  또는   
            var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
            // 이메일 정규표현식 객체 생성   
         
            var bool = regExp.test($(this).val());
            
            if(!bool) {
               // 이메일이 정규표현식에 위배된 경우
            	alert("올바른 이메일 형식으로 작성하십시오");
            }
            
         }); // 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
      
	
	// 사용 포인트 입력했을 때
	$('input#usePoint').blur(function(){
		var usePoint = $(this).val().trim();
		var bool = isNaN(usePoint);
		var havingPoint=$('input#havingPoint').val();
				
		if(bool){
			// 숫자 외 다른 문자 친 경우
			$(this).val("");
		}
		
		else if(usePoint>havingPoint){
			// 만약 보유포인트보다 큰 숫자 입력했으면 val()값 보유 적립금 금액으로 바꾸기	
			$(this).val(havingPoint);
		}
		
		else{
			$('input#usePoint').val(usePoint);
		}
		
	});
	
         
    // 결제 총 금액 계산 *****************************
    var sum = parseInt($('[name=sum]').val());
    var delivery = parseInt($('[name=delivery]').val());
    
    var usePoint = parseInt($('input#usePoint').val().trim());
    
    if(isNaN(usePoint)){
    	usePoint=0;
    }
   var totalPrice = sum+delivery-usePoint;
   const TP = totalPrice.toLocaleString('ko-KR');
   
    $("input.totalPrice").val(totalPrice);
    $("input#totalPrice").val(TP);
	
 
	

	// 결제방법 선택 시 선택 및 선택 외 버튼들 css변경해주기
	$("[name=payment]").click(function(){
		$(this).parent().find('[name=payment]').css('background-color','');
		$(this).parent().find('[name=payment]').css('color','');
		$(this).css('background-color','#8c8c8c');
		$(this).css('color','white');
	});
	
	
});






//////////////////////////////////////////////////////////////////////////////////


function displayOdr(){
	
	$.ajax({
		url:"<%= request.getContextPath()%>/orderView.to",
		tyle:"POST",
		data:{"pnum":"${requestScope.pnum}",
			"oqty":"${requestScope.oqty}",
			"saleprice":"${requestScope.saleprice}",
			"pdetailnum":"${requestScope.pdetailnum}",
			"optionname":"${requestScope.optionname}",
			"pname":"${requestScope.pname}",
			"level":"${sessionScope.loginuser.level}",
			"pimage":"${requestScope.pimage}"},
		dataType:"JSON",
		success:function(json){
			var cnt=json.length;
			var html = "";
			var html2 ="";
			$.each(json, function(index,item){
				console.log("gl"+item.point);
				 html+='<tr id="prodInfo">'
				 			+'<td></td>'
							+'<td><a href="<%=ctxPath%>/Info.to?pnum="'+item.pnum+'"><img class="pimage1" src="<%=ctxPath%>/images/'+item.pimage+'" width= "90px;" height="90px;"/></a></td>'
							+'<td align="left"><span class="cname"><a href="<%=ctxPath%>/Info.to?pnum='+item.pname+'">'+item.pname+'</a></span><br>[옵션: '+item.optionname+']</td>'
							+'<td>'+item.oqty+'</td>'
							+'<td>'+item.saleprice+'원</td>'		 //	물건 1개 값				
							+'<td align="center">'
								+'<div id="pointbox">'
									+'<c:if test="${sessionScope.loginuser.level == 1}">'
										+'<fmt:formatNumber value="1" type="number"/>'
									+'</c:if>'
									+'<c:if test="${sessionScope.loginuser.level == 2}">'
									+'<fmt:formatNumber value="3" type="number"/>P'
									+'</c:if>'
									+'<c:if test="${sessionScope.loginuser.level == 3}">'
									+'<fmt:formatNumber value="5" type="number"/>P'
									+'</c:if>'
									+'% 적립'
									+'</div>'
									+item.point+'P'
									+'<input type="hidden" value="'+item.point+'"/>'
									+'</td>'
								+'<td>'
									+item.delivery+'원'
								+'</td>'
								+'<td>'
									+item.totalprice+'원'
								+'</td>'
							+'</tr>';
							if(cnt==1){
								var totalsum = item.sum+item.delivery;
								html+='<tr>' 
								+'<td id="sumtbl" colspan="8">상품구매금액 '+item.sum+'원'
								+'<input type="hidden" name="sum" value="'+item.sum+'"/>'
								+'+&nbsp;배송비&nbsp;'+item.delivery			
								+'원'
								+'= 합계 : <span id="sum">'+totalsum+'원'
								+'</td></tr>';
								
								
									}
							cnt--;
							

							html2+="<input type='hidden' name='sum' value='"+item.sum+"'>";
							html2+="<input type='hidden' name='totalsum' value='"+item.totalsum+"'>";
							html2+="<input type='hidden' name='delivery' value='"+item.delivery+"'>";
						

			});

		
			$("table#prodInfo").find("tbody").html(html);
			$("form#orderForm").append(html2);

			
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
			
	});
	
}




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



// 첫번째 우편번호 함수
function openZipSearch() {
	new daum.Postcode({
		oncomplete: function(data) {
			$('#postcode1').val(data.zonecode); // 우편번호 (5자리)
			$('[name=addr1]').val(data.address);
			$('[name=addr2]').val(data.buildingName);
		}
	}).open();
}

//두번째 우편번호 함수
function openZipSearch2() {
	new daum.Postcode({
		oncomplete: function(data) {
			$('#postcode2').val(data.zonecode); // 우편번호 (5자리)
			$('[name=addr3]').val(data.address);
			$('[name=addr4]').val(data.buildingName);
		}
	}).open();
}




//장바구니 개별 삭제하기 
function goDel(ordnum) {		
	var $target = $(event.target);
	var pname = $target.parent().parent().find(".cname").text();
//	console.log(pname);
	var bool = confirm("주문목록에서 ["+pname+"] 상품을 삭제하시겠습니까?");
//	alert(ordnum);
	if(bool){
		$.ajax({
			url:"<%= ctxPath%>/cart/deleteCartOne.to",
			type: "post",
			data: {"userid":"${sessionScope.loginuser.userid}","cartnum":cartnum},
			dataType: "json",
			success:function(json){
					alert(json.msg);
					location.href="javascript:history.go(0);"; // 새로고침해주기
			},
			 error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		     }  
		});
		
	}
	else{
		return false;
	}
}




//!!!!!!!!!!! ==== 결제하기 눌렀을 때 ==== !!!!!!!!!!!**********아직 미완성********
function goCheckOut(){
	 //// 최종적으로 필수입력사항에 모두 입력이 되었는지 검사한다. ////
 var bFlagRequiredInfo = false;
 
 $(".requiredInfo").each(function(index, item){
 	var val=$(item).val().trim();
    if(val == "") {
       bFlagRequiredInfo = true;
       alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
       return false; // break 라는 뜻이다.
    }
 });
	
 /// 이용약관 체크했는지 검사
 var checkboxCheckedLength = $("input:checkbox[name=agree]:checked").length;
 
 if(checkboxCheckedLength == 0) {
    alert("이용약관에 동의하셔야 합니다.");
    return; // 종료
 }
 

 if(!bFlagRequiredInfo && checkboxCheckedLength==2) {
	    
             /// === java 단으로 보내야할 최종 데이터 확인용 === //
             var odrname = $("#orderName").val();
             var odrmobile = $("#ordererHp1").val()+"-"+$("#ordererHp2").val()+"-"+$("#ordererHp3").val();
             var odremail = $("[name=orderEmail]").val();
             var odrpostcode = $('[name=orderZip]').val();
             var odraddress = $('[name=addr1]').val();
             var odrdtaddress = $('[name=addr2]').val();
             var odrextddress = $('[name=extraAddress]').val();
             var fk_payment = $("[name=payment]").val();
             var deliname = $("input#shipName").val();
             var delimobile = $("#shipHp1").val()+"-"+$("#shipHp2").val()+"-"+$("#shipHp3").val();
             var delipostcode = $("[name=shipZip]").val();
             var deliaddress = $("[name=addr3]").val();
             var delidtaddress =$("[name=addr4]").val();
             var deliextddress = $("[name=extraAddress2]").val();
             var delimsg = $("select[name=shippingMsg] option:checked").text();
             var usePoint = $("#usePoint").val();
             var rvsPoint = Math.floor($("#rvsPoint").val());
             
             var pnum = $("[name=pnum]").val();
             var oqty = $("[name=oqty]").val();
             var saleprice  = $("[name=saleprice]").val();
             var pdetailnum  = $("[name=pdetailnum]").val();
             var optionname = $("[name=optionname]").val();
             var pname = $("[name=pname]").val();
           console.log(pnum+"gg");
           
        //     var queryString = $("form[name=orderForm]").serialize();
             
             var sum = $("[name=sum]").val();
             var totalsum = $("[name=totalsum]").val();
             var delivery = $("[name=delivery]").val();
             
             
   console.log(odrname+odrmobile+odremail+odrpostcode+odraddress+odrdtaddress+odrextddress+fk_payment+deliname+delimobile+delipostcode+deliaddress+delidtaddress+delimsg+usePoint+rvsPoint);
             
             $.ajax({
	           	 url:"<%=request.getContextPath()%>/orderAdd.to",
	           	 type:"post",
	           	 data:{"odrname":odrname,
	           		 "odrmobile":odrmobile,
	           		 "odremail":odremail,
	           		 "odrpostcode":odrpostcode,
	           		 "odraddress":odraddress,
	           		"odrdtaddress":odrdtaddress,
	           		"odrextddress":odrextddress,
	           		"fk_payment":fk_payment,
	           		"deliname":deliname,
	           		"delimobile":delimobile,
	           		"delipostcode":delipostcode,
	           		"deliaddress":deliaddress,
	           		"delidtaddress":delidtaddress,
	           		"deliextddress":deliextddress,
	           		"delimsg":delimsg,
	           		"usePoint":usePoint,
	           		"rvsPoint":rvsPoint,
	           		"userid":"${sessionScope.loginuser.userid}",
	           		
	           		//개별상품들 하나로 모아둔것
					"pnum":pnum,
					"oqty":oqty,
					"saleprice":saleprice,
					"pdetailnum":pdetailnum,
					"optionname":optionname,
					"pname":pname,
					//"level":level,
					"level":"${sessionScope.loginuser.level}",
	
	           		//최종값
	           		"sum":sum,
	           		"totalsum":totalsum,
	           		"delivery":delivery,
	           		
	           		},
	           	dataType:"json",
	           	success:function(json){
	           		if(json.isSuccess==1){
		           		var frm = document.orderForm;
	           			alert("주문이 완료되었습니다");
	           		   location.href = "<%= request.getContextPath()%>/orderInfo.up";
	           		    
	           		}
	           	
	           	},
	           	error: function(request, status, error){
	                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                } 
	           	 
             });
	  
	 
 
 }
 
 
 
}



  
   </script>

</head>
<div id="sum"></div>

<form name="orderFrm">
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
				<th></th>
				<th>이미지</th>
				<th width="30%">상품정보</th>
				<th>수량</th>
				<th>판매가</th>
				<th>적립포인트</th>
				<th>배송비</th>
				<th>합계</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		
		
		
	</table>	
	
	
	
	 
	<div class="left" style="font-size:10pt;">
	! 상품의 옵션 및 수량 변경은 상품 상세 혹은 장바구니에서 가능합니다.
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
					<input type="text" name="orderName" id="orderName" class="requiredInfo" value="${(sessionScope.loginuser).name}"/> 
				</td>
			</tr>	
			<tr>
				<th>
					<label for="name" >주소&nbsp;<span class="star">*</span></label>
				</th>
			</tr>
			<tr>
				<td>
					<input type="text" name="orderZip" id="postcode1" class="requiredInfo" value="${(sessionScope.loginuser).postcode}" size="6" maxlength="5" readonly />&nbsp;&nbsp;
					<%-- 우편번호 찾기 --%>
					<input type="button" value="우편번호" id="zipcodeSearch" style="vertical-align: middle;" onclick="openZipSearch()" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="addr1"  size="40" value="${(sessionScope.loginuser).address}" placeholder="주소" readonly /><br>
				</td>
			</tr>
			<tr>		
				<td>
					<input type="text" name="addr2"  id="extraAddress" value="${(sessionScope.loginuser).extraaddress}" size="40" placeholder="참고항목" readonly />&nbsp;
					<input type="text" name="extraAddress" size="40" value="${(sessionScope.loginuser).detailaddress}"placeholder="상세주소" />
				</td>
			</tr>			
			<tr>
         		<th>연락처&nbsp;<span class="star">*</span><th>
         	</tr>
         	<tr>
         		<td>
	             	<input type="text" id="ordererHp1" name="ordererHp1" size="6" maxlength="3" style="text-align:center;" value="010" class="requiredInfo" />&nbsp;-&nbsp;
	             	<input type="text" id="ordererHp2" name="ordererHp2" size="6" maxlength="4" style="text-align:center;" class="requiredInfo"  />&nbsp;-&nbsp;
	             	<input type="text" id="ordererHp3" name="ordererHp3" size="6" maxlength="4" style="text-align:center;" class="requiredInfo"  />
             	</td>
    	<tr>
	         	<th>이메일</th>
			</tr>
	        <tr>	         	
	         	<td><input type="text" name="orderEmail" id="email" placeholder="abc@def.com" /> </td>
            </tr>
	</table>
	<hr>
	
	<br><br>

	

	
	<div class="left" style="display:inline-block; float:left; ">
		<span style="font-size:15pt; font-weight: bold;">배송 정보</span>
		<span style="font-size:10pt;">&nbsp;<input type="checkbox" id="sameLoginusesr"/>&nbsp;<label for="sameLoginusesr">주문자 정보와 동일</label></span>
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
					<input type="text" name="shipName" id="shipName" class="requiredInfo" /> 
				</td>
			</tr>	
			<tr>
				<th>
					<label for="name" >주소&nbsp;<span class="star">*</span></label>
				</th>
			</tr>
			<tr>
				<td>
					<input type="text" name="shipZip" id="postcode2" class="requiredInfo" size="6" maxlength="5" readonly/>&nbsp;&nbsp;
					<%-- 우편번호 찾기 --%>
					<input type="button" value="우편번호" id="zipcodeSearch" style="vertical-align: middle;" onclick="openZipSearch2()" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="addr3"  size="40" placeholder="주소" readonly /><br>
				</td>
			</tr>
			<tr>		
				<td>
					<input type="text" name="addr4"  id="extraAddress"  size="40" placeholder="참고항목" readonly/>&nbsp;
					<input type="text" name="extraAddress2" size="40" placeholder="상세주소" />
				</td>
			</tr>	
			<tr>
         		<th>연락처&nbsp;<span class="star">*</span><th>
         	</tr>
         	<tr>
         		<td>
	             	<input type="text" id="shipHp1" name="shipHp1" size="6" maxlength="3" style="text-align:center;" value="010" />&nbsp;-&nbsp;
	             	<input type="text" id="shipHp2" name="shipHp2" size="6" maxlength="4" style="text-align:center; class="requiredInfo" />&nbsp;-&nbsp;
	             	<input type="text" id="shipHp3" name="shipHp3" size="6" maxlength="4" style="text-align:center; class="requiredInfo" />
             	</td>
	      	<tr>
	         	<th>배송 메세지</th>
			</tr>
	        <tr>	         	
	         	<td>
	         		<select class="orderStatus" name="shippingMsg" style="margin-left:0px;">
						<option value="" selected id=>&nbsp;&nbsp;배송 요청사항을 입력해주세요&nbsp;&nbsp;</option>
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
				<input type="text" id="havingPoint" style="width:100%; border:none; text-align:right; background-color:#e6e6e6;" value="${(sessionScope.loginuser).point}" readonly/>
			</td>
		</tr>
		<tr>
			<th style="text-align:left; width:40%; ">사용 point</th>
			<td style="text-align:right; width:60%;">
				<input type="text" id="usePoint" style="width:90%;border:1px solid gray; text-align:right; display:inline-block;" />
				원
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
		<input type="button" value="신용카드" name="payment" id="btnCredit" style="width:100px; height:40px; border:none; margin-right:20px;"/>
		<input type="button" value="무통장" name="payment" id="btnAccount" style="width:100px; height:40px; border:none; margin-right:20px;"/>
		<input type="button" value="휴대폰결제" name="payment" id="btnMobile" style="width:100px; height:40px; border:none;"/>
	</div>
	<br><br>
	
	
	<div class="left">
		<span style="font-size:15pt; font-weight: bold;">주문 금액</span>
	</div>
	<hr>
	
	<table style="width:100%;">
		<tr>
			<td style="text-align:left;">상품금액</td>
			<td style="text-align:right;">
				<fmt:formatNumber value="${sum}" type="number" />원
				<input type="hidden" name="sum" value="${sum}"/></td>
		</tr>
		<tr>
			<td style="text-align:left;">배송비</td>
			<td style="text-align:right;">
				<c:if test="${(sum) >= 50000}"> 
					<span>0</span>
					<c:set var="delivery" value="0"/>
					<input type="hidden" name="delivery" class="delivery" value="0"/>
				</c:if>
				<c:if test="${(sum) < 50000}">
					<fmt:formatNumber value="2500" type="number" />
					<input type="hidden" name="delivery" class="delivery" value="2500"/>
					<c:set var="delivery" value="2500"/>
				</c:if>원
			</td>
		</tr>
		<tr>
			<td style="text-align:left;">포인트 사용</td>
			<td style="text-align:right;">
			<input type="text" id="usePoint" style="border:none; text-align: right;" value="(-) 0"/>
			P</td>
		</tr>
		<tr>
			<td style="text-align:left;">포인트 적립</td>
			<td style="text-align:right;">(+)
			<c:if test="${sessionScope.loginuser.level == 1}">
				<fmt:formatNumber value="${sum*0.01}" type="number"/>P
				<input type="hidden" id="rvsPoint" value="${sum*0.01}"/>
			</c:if>
			<c:if test="${sessionScope.loginuser.level == 2}">
				<fmt:formatNumber value="${sum*0.03}" type="number"/>P
				<input type="hidden" id="rvsPoint" value="${sum*0.03}"/>
			</c:if>
			<c:if test="${sessionScope.loginuser.level == 3}">
				<fmt:formatNumber value="${sum*0.05}" type="number"/>P
				<input type="hidden" id="rvsPoint" value="${sum*0.05}"/>
			</c:if>
			</td>
		</tr>
		<tr>
			<td style="text-align:left; font-size:13pt; font-weight:bold;">최종 결제금액</td>
			<td style="text-align:right; font-size:15pt; font-weight:bold;"> 
				<input style="border:none; text-align: right;" id="totalPrice"/>
				원
				<input type="hidden" class="totalprice" />
			</td>
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
							<a class="btn" id="modalY2"data-dismiss="modal" style="color:#0099ff;">동의합니다</a>
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
</form>

<div id="divorder">
<form name='orderForm' id="orderForm">
			<input type='hidden' name='pnum' value='${requestScope.pnum}'/>
			<input type='hidden' name='oqty' value='${requestScope.oqty}' />
			<input type='hidden' name='saleprice' value='${requestScope.saleprice}'>
			<input type='hidden' name='pdetailnum' value='${requestScope.pdetailnum}'>
			<input type='hidden' name='optionname' value='${requestScope.optionname}'>
			<input type='hidden' name='pname' value='${requestScope.pname}'>
			<input type='hidden' name='level' value='${sesseionScope.loginuser.level}'>	
			<input type='hidden' name='pimage' value='${requestScope.pimage}'>			
</form>
</div>

<jsp:include page="../footer.jsp"/> 