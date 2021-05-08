<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="<%=ctxPath%>/css/Ohdayoon.css"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">


<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">

button{
	background-color: #fff;
	border: solid 1px #CCD1D1; 
}

</style>


<script type="text/javascript">

$(document).ready(function(){
    
	
	//모든 datepicker에 대한 공통 옵션 설정
    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd' //Input Display Format 변경
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
        ,changeYear: true //콤보박스에서 년 선택 가능
        ,changeMonth: true //콤보박스에서 월 선택 가능                
        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트             
    });

    //input을 datepicker로 선언
    $("input#fromDate").datepicker();                    
    $("input#toDate").datepicker();
    
    //From의 초기값을 오늘 날짜로 설정
    $('input#fromDate').datepicker('setDate', '-1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
    
    //To의 초기값을 3일후로 설정
    $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)

    
 
    
    $("button.searchdate").click(function(){
   
    	
    	var fromdate = $("input#fromDate").val();	
    	
    	
    	var fArr = fromdate.split("-");
    	var fromdate= "";	
    	for(var i=0;i<fArr.length;i++){
    		fromdate+=fArr[i];
    	}
    	
    	
    	var todate = $("input#toDate").val();
    	
    	var tArr = todate.split("-");   
     	var todate= "";
     	
     	for(var i=0;i<tArr.length;i++){
     		todate+=tArr[i];
     	}

     	var from = new Date($("input#fromDate").datepicker("getDate"));
        var to = new Date($("input#toDate").datepicker("getDate"));
    
        // 조회기간 종료일이 시작일 보다 작을 때 경고
         if (to - from < 0){
         alert("조회기간 종료일이 시작일 보다 작습니다."); return false;
        }
         
    
    		var frm = document.pointFrm;
    		frm.action = "pointList.to";
    		frm.method = "GET";
    		frm.submit();
    	
         
    });
    
    
    
    
    
    
    
    
    
    
    
    
});// end of $(document).ready(function(){}-----------------------



</script>



<div class="container">

	<div class="contents" >
		
		<div style="text-align: center; margin-bottom: 100px">
			<h2>포인트</h2>
			<p>고객님의 사용가능한 포인트 금액입니다.</p>
		</div>
		
		<table class="w3-table w3-bordered" style=" border: solid 1px #CCD1D1; height: 50px; ">
				<tr >
					<td width="400px;"  style="vertical-align: middle;"><strong>- 총 보유 포인트</strong></td>
					<td width="95px;" style="text-align: center; vertical-align: middle;">0&nbsp;P</td>
					<td width="400px;"style="vertical-align: middle;"><strong>- 총 사용 포인트</strong></td>
					<td width="95px;" style="text-align: center; vertical-align: middle;">0&nbsp;P</td>
				</tr>
		</table>
		
		<form name="pointFrm">
			<div style="margin-top: 70px; text-align: right; margin-bottom: 50px;" > 
			<input type="text" id="fromDate" name="from" style="width: 120px;" readonly="readonly">&nbsp;&nbsp; 
            ~&nbsp;&nbsp; <input type="text" id="toDate" name="to" style="width: 120px;" readonly="readonly">
            <button class="searchdate">조회</button>
			</div>
		</form>
	
			
			<table class="w3-table w3-bordered" id="pointInfo" >
				<tr>
					<th style="text-align: center;">주문날짜</th>
					<th style="text-align: center;">적립금</th>
					<th style="text-align: center;">관련주문</th>
					<th style="text-align: center;">내역</th>
				</tr>
				<tr>
				<%-- <c:if>
						<tr>
								<td colspan="4" height="150px;"><span >적립금 내역이 없습니다.</span></td>
						</tr>
					</c:if>
					--%>
					<td style="text-align: center;"></td>
					<td style="text-align: center;"></td>
					<td style="text-align: center;"></td>
					<td style="text-align: center;"></td>
				</tr>
				
			</table>
		
	
		
		
		
		
		
	</div>
		



<div class="useInfo" >
    <h3>적립금 안내</h3>
    <div class="content">
      <ol> 
        <li class="item1 ">ㆍ적립된 금액이 1,000원 이상 누적되었을 때, 사용하실 수 있습니다.</li>
        <li class="item2 ">ㆍ결제 시 적립금 사용 여부를 확인할 수 있는 안내문이 나옵니다.</li>
        </ol>
    </div>
</div>



</div>


<jsp:include page="../footer.jsp"/>





		