<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>   
<jsp:include page="../header.jsp"/>
<!DOCTYPE html>
<html>
<head>

  <title>:::주문 내역 조회:::</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<%=ctxPath%>/css/hanseoyeon.css"/>

<!-- Google Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

<!-- 제이쿼리 -->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <link rel="stylesheet" href="/resources/demos/style.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>



<script type="text/javascript">

	$( function() {
		
		$('ul.tabs li').click(function(){							//선택자를 통해 tabs 메뉴를 클릭 이벤트를 지정해줍니다.
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('current');			//선택 되있던 탭의 current css를 제거하고 
			$('.tab-content').removeClass('current');		

			$(this).addClass('current');								////선택된 탭에 current class를 삽입해줍니다.
			$("#" + tab_id).addClass('current');
		})
		
        var dateFormat = "mm/dd/yy",
        from = $( "#from" )
          .datepicker({
            defaultDate: "+1w",
            changeMonth: true,
            numberOfMonths: 1
          })
          .on( "change", function() {
            to.datepicker( "option", "minDate", getDate( this ) );
          }),
        to = $( "#to" ).datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 1
        })
        .on( "change", function() {
          from.datepicker( "option", "maxDate", getDate( this ) );
      
		          
		
  	} ); // end of $( function()
	
	function getDate( element ) {
	      var date;
	      try {
	        date = $.datepicker.parseDate( dateFormat, element.value );
	      } catch( error ) {
	        date = null;
	      }
	 
	      return date;
	    }
	  } ); // end of function getDate( element ) 
	  
	

</script>


<%-- 주문 내역 조회 탭 --%>

<div class="container">

		<h2>주문 내역 조회</h2>
		<div class="container">
<!-- 탭 메뉴 상단 시작 -->
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">주문내역조회</li>
		<li class="tab-link" data-tab="tab-2">취소/반품/교환 내역</li>
	</ul>
<!-- 탭 메뉴 상단 끝 -->

<!-- 탭1 메뉴 내용 시작 -->
	<div id="tab-1" class="tab-content current">
		<div class="tab">
			<div class="tab1"> 
					<select class="orderStatus" id="orderStatus1">
						<option value="all" selected>전체 주문처리상태</option>
						<option value="before">입금전</option>
						<option value="preparing">배송준비중</option>
						<option value="shipping">배송중</option>
						<option value="completed">배송완료</option>
					</select>
			</div>
			
		
			<div id="days">
				<button id="today">오늘</button>
				<button id="week">1주일</button>
				<button id="month1">1개월</button>
				<button id="month3">3개월</button>
				<button id="month6">6개월</button>
			</div>
			
			<div class="dayChoice">
				<label for="from"></label>
				<input type="text" id="from" name="from">
				<label for="to">&nbsp;~&nbsp;</label>
				<input type="text" id="to" name="to">
	 		</div>
	 
			<button id="search">조회</button>
		</div> 
		<div id="left">
		- 기본적으로 최근 3개월 간의 자료가 조회되며, 기간 검색 시 지난 주문 내역을 조회하실 수 있습니다.<br>- 주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.
		</div>
	<br>
	<br>
	<h4 id="left">주문 상품 정보</h4>
	<br>
	
	<table id="prodInfo">
		<thead align="center">
			<tr>
				<th>주문일자<br>[주문번호]</th>
				<th>이미지</th>
				<th width="30%">상품정보</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>주문처리상태</th>
				<th>교환/환불</th>
			</tr>
		</thead>
		
		<tbody align="center">
			<tr>
				<td>2021-04-17<br><a=href="">[주문번호링크]</a></td>
				<td>이미지 연결</td>
				<td align="left">[상품정보]링크걸기<br>[옵션:컬러]</td>
				<td>1</td>
				<td>30,000원</td>
				<td>입금전</td>
				<td><button>취소/교환/반품</button></td>
			</tr>
		</tbody>
	</table>
		
	</div>
<!-- 탭1 메뉴 내용 끝 -->
	
	<!-- 탭2 메뉴 내용 시작 -->
	<div id="tab-2" class="tab-content">
		<div class="tab">
			<div class="tab2"> 
					<select class="orderStatus" id="orderStatus2">
					<option value="all" selected>전체 주문처리상태</option>
					<option value="proceeding">진행중</option>
					<option value="completed">완료</option>
				</select>
			</div>
			
			<div id="days">
				<button id="today">오늘</button>
				<button id="week">1주일</button>
				<button id="month1">1개월</button>
				<button id="month3">3개월</button>
				<button id="month6">6개월</button>
			</div>
			
			<div class="dayChoice">
				<label for="from"></label>
				<input type="text" id="from" name="from">
				<label for="to">&nbsp;~&nbsp;</label>
				<input type="text" id="to" name="to">
	 		</div>
	 		
			<button id="search">조회</button>
		</div> 
		<div id="left">
		- 기본적으로 최근 3개월 간의 자료가 조회되며, 기간 검색 시 지난 주문 내역을 조회하실 수 있습니다.<br>- 주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.
		</div>
	<br>
	<br>
	<h4 id="left">주문 상품 정보</h4>
	<br>
	
	<table id="prodInfo">
		<thead align="center">
			<tr>
				<th>주문일자<br>[주문번호]</th>
				<th>이미지</th>
				<th width="30%">상품정보</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>주문처리상태</th>
				<th>교환/환불</th>
			</tr>
		</thead>
		
		<tbody align="center">
			<tr>
				<td>2021-04-17<br><a=href="">[주문번호링크]</a></td>
				<td>이미지 연결</td>
				<td align="left">[상품정보]링크걸기<br>[옵션:컬러]</td>
				<td>1</td>
				<td>30,000원</td>
				<td>입금전</td>
				<td>교환</td>
			</tr>
		</tbody>
	</table>
  
  	</div> <!-- 탭2 메뉴 내용 끝 -->
	
<!-- 탭 메뉴 내용 끝 -->

</div>
</div>



<jsp:include page="../footer.jsp"/> 