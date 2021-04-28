<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="../css/yh_css/tabs.css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="../css/yh_css/bootstrap-table-expandable.css">
<script src="../js/yh_js/bootstrap-table-expandable.js"></script>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
<!-- partial:index.partial.html -->
<div class="container_Tabs">
<br><br><br>
<h1 align="center" style="font-weight:bold;">고객센터</h1><br><br>
<h2 align="center">자주 묻는 질문</h2><br>
  
  <ul class="tabs">
    <li data-tab-target="#home">전체보기</li>
    <li class="tabs_li " data-tab-target="#payment">입금결제</li>
    <li class="tabs_li " data-tab-target="#shipping">배송관련</li>
    <li class="tabs_li " data-tab-target="#exchange">반품/교환</li>
    <li class="tabs_li " data-tab-target="#cancel">배송 전 변경/취소</li>
    <li class="tabs_li " data-tab-target="#acc">기타문의</li>
  </ul>

  <div class="tab-content">
    <div id="home" data-tab-content class="active">
      <jsp:include page="../cscenter/faq/faq_all.jsp"/>
    </div>
    <div id="payment" data-tab-content>
     <jsp:include page="../cscenter/faq/faq_payment.jsp"/>
    </div>
    <div id="shipping" data-tab-content>
      <jsp:include page="../cscenter/faq/faq_shipping.jsp"/>
    </div>
    <div id="exchange" data-tab-content>
      <jsp:include page="../cscenter/faq/faq_exchange.jsp"/>
    </div>
    <div id="cancel" data-tab-content>
      <table class="table table-hover table-expandable table-striped">
    <thead>
      <tr>
        <th>NO</th>
        <th>분류</th>
        <th>제목</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>2</td>
        <td>배송전 변경/취소</td>
        <td>배송전 주문취소하고 싶어요</td>
      </tr>
      <tr>
      <td colspan="4">
     	주문/결제 완료후 취소를 원하실경우 주문서 상태가 입금전일 경우에만 고객님이 직접 주문취소가 가능하시며, 결제완료되어 배송 준비중 단계로 넘어가게 되면 직접 주문취소가 불가능하기 때문에
		고객센터(☎1544-6105) 또는 게시판 배송전 취소/변경 문의글로 요청사항 남겨주시면 확인후 안내 도움드리겠습니다.단, 주문상태는 발송준비중이나, 이미 포장단계를 거쳐 택배사로 넘어간경우 배송전 주문건 취소 및 변경이 불가하십니다.
      </td>
      </tr>
     <tr>
        <td>1</td>
        <td>배송전 변경/취소</td>
        <td>주문 상품이 아직 배송전인데 다른 상품으로 교환하고 싶어요.</td>
      </tr>
      <tr>
      <td colspan="4">
     	결제 완료와 동시에 상품 및 배송 준비 작업을 진행하게 됩니다.<br>
		다만, 실제 작업 중인 내용이 전산에 반영되기까지 다소의 시간 차가 있어
		실제로는 상품이 배송되었어도 마이 페이지에서는'상품 준비중'으로 표기될 수 있습니다.<br>
		따라서 배송 전, 상품 변경 및 교환을 하고자 하실 경우
		게시판 문의글을 남겨 주시거나 고객센터로 연락 주시면 상세히 답변 드리겠습니다.
      </td>
      </tr>
     </tbody>
     </table>
    </div>
    <div id="acc" data-tab-content>
      <table class="table table-hover table-expandable table-striped">
    <thead>
      <tr>
        <th>NO</th>
        <th>분류</th>
        <th>제목</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>4</td>
        <td>기타문의</td>
        <td>전화상담이 안되는 데 어떻게 하나요?</td>
      </tr>
      <tr>
      <td colspan="4">
     고객님의 문의가 많아서 전화연결이 어려우실 경우에는 게시판으로 문의 해주시면 실시간으로 답변 드리고 있습니다. <br>
	 상담시간 : AM 10:00 - PM 04:00 점심시간 : PM 12:00 - PM 13:00 / 주말, 공휴일 휴무
      </td>
      </tr>
     <tr>
        <td>3</td>
        <td>기타문의</td>
        <td>가방냄새가 너무많이나요 이유가뭔가요?</td>
      </tr>
      <tr>
      <td colspan="4">
     	전 제품은 주문 들어온 후 주문제작으로 즉시 생산후 고객님에게 바로 발송 되기 때문에 제품에따라 합성피혁의 냄새가 더 나실수있습니다.
      </td>
      </tr>
     <tr>
        <td>2</td>
        <td>기타문의</td>
        <td>품절 연락을 받았어요</td>
      </tr>
      <tr>
      <td colspan="4">
      	먼저 품절로 불편드려 죄송합니다.<br>
		재고를 두고 판매하지 않는 방식으로, 고객님들께서 주문/결제 해주신 그 다음날부터 상품준비에 들어갑니다.<br>
		갑자기 거래처 사정에 의해 품절되는 경우가 부득이하게 생길 수 있으며, 품절될경우 고객님께 바로 연락을 드리고 있습니다. 품절된 상품은 다른 상품으로 교환 혹은 환불등 요청하시는 대로 처리해드리고 있습니다.
      </td>
      </tr>
      <tr>
        <td>1</td>
        <td>기타문의</td>
        <td>현금영수증 신청은 어떻게 하나요?</td>
      </tr>
      <tr>
      <td colspan="4">
      현금영수증 신청은 현금결제만 신청가능하며, 고객센터/게시판으로 사업자번호, 핸드폰번호 와 함께 신청해 주시면 발행 가능 합니다. 배송 완료된 상태에서만 신청이 가능하며 현금 영수증 발행 기간은 상품 수령 후 일주일 후 입니다.
      </td>
      </tr>
    </tbody>
  </table>
    <div>
    
    </div>
  </div>
 </div>
</div>
<br><br><br>

<h2 align="center">문의 게시판</h2><br> 
  	<div align="center">
  	<table>
  		<tr>
  			<td class="pd_right"><h3><a class="menu_cs" href="<%= request.getContextPath()%>/cscenter/csBoard.to">전체보기</a></h3></td>
  			<td class="pd_right"><h3><a class="menu_cs" href="#">상품문의</a></h3></td>
  			<td class="pd_right"><h3><a class="menu_cs" href="#">배송전취소/변경</a></h3></td>
  			<td class="pd_right"><h3><a class="menu_cs" href="#">배송/교환/반품</a></h3></td>
  			<td><h3><a class="menu_cs" href="#">입금확인/입금자변경</a></h3></td>
  		</tr>
  	</table>
	<br><br><br><br><br><br>
  	</div>
  	
<!-- partial -->
<script  src="../js/yh_js/script.js"></script>
<jsp:include page="../footer.jsp" />