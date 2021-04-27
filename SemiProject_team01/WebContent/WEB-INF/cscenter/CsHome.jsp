<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="../css/yh_css/tabs.css">
<link rel="stylesheet" href="../css/yh_css/accodian.css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="../css/yh_css/bootstrap-table-expandable.css">
<script src="../yh_js/bootstrap-table-expandable.js"></script>
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
<div class="container">

<h1 align="center" style="font-weight:bold;">고객센터</h1><br><br>
<h2 align="center">자주 묻는 질문</h2><br>
  
  <ul class="tabs">
    <li data-tab-target="#home" class="active">전체보기</li>
    <li class="tabs_li" data-tab-target="#payment">입금결제</li>
    <li class="tabs_li" data-tab-target="#shipping">배송관련</li>
    <li class="tabs_li" data-tab-target="#exchange">반품/교환</li>
    <li class="tabs_li" data-tab-target="#cancel">배송 전 변경/취소</li>
    <li class="tabs_li" data-tab-target="#acc">기타문의</li>
  </ul>

  <div class="tab-content">
    <div id="home" data-tab-content class="active">
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
        <td>34</td>
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
        <td>33</td>
        <td>배송관련</td>
        <td>택배를 받았는데 상품이 누락되거나 분실된 것 같아요.</td>
      </tr>
      <tr>
      <td colspan="4">
     	1. 다음의 경우엔 분실 가능성이 있으니 고객센터로 연락 주시기 바랍니다.<br>
		1) 마이 페이지에서 전 상품 모두 '배송 중' 또는 '배송완료'로 표기된 경우<br>
		2) 상품을 수령하지 못하였는데, 운송장 조회 결과가 3일이 지나도록 운송장 조회 결과가 업데이트 되지 않는 경우<br><br>
		
		2. 상품 누락 또는 일부 분실로 추정되는 경우<br>
		1) 액세서리와 같은 작은 상품은 함께 주문하신 옷에 부착되어 있거나 별도로 포장하여 박스 안쪽에 위치해 있을 가능성이 높으니, 함께 주문하신 상품과 박스 안을 다시 한번 확인하여 주시기 바랍니다.<br>
		2) 위 1)의 방법으로도 주문하신 상품이 확인되지 않는다면, CCTV 영상 확인하여 택배사의 분실로 추정될 경우 택배사와의 협의를 통해 고객님께서 피해가 발생하지 않도록 조치하고 있습니다.<br>
		
		3. 택배사의 분실로 추정되는 경우<br>
		택배사의 분실 사고로 상품을 일절 받아보시지 못 한 경우. CJ대한통운택배에 분실 접수 후 반하루 고객센터로 연락 주시기 바랍니다.
      </td>
      </tr>
     <tr>
        <td>32</td>
        <td>반품/교환</td>
        <td>교환/반품시 배송비는 어떻게 되나요?</td>
      </tr>
      <tr>
      <td colspan="4">
      	1.교환 배송비<br>
		단순 변심에 의한 교환: 왕복 배송비 5,000원<br><br>
		
		2.반품 배송비 [실결제금액기준]<br>
		1)단순 변심에 인한 전체 반품일 경우 5,000원<br><br>
		
		2)단순 변심에 인한 부분 반품일 경우<br>
		*구매 확정상품이 5만원 미만일 경우 5,000원<br>
		*구매 확정상품이 5만원 이상일 경우 2,500원<br><br>
		
		3.상품 하자 또는 오배송의 의한 교환/반품 : 반하루 부담<br><br>
		
		◆저희 반하루의 계약택배는 CJ대한통운택배이며, 그 외 택배로 보내주실경우 선불로 꼭 접수 부탁드립니다.<br>
		*불량 및 오배송이더라도 타택배 이용시 선불로 접수 하여 보내주세요
      </td>
      </tr>
      <tr>
        <td>31</td>
        <td>반품/교환</td>
        <td>반품 했는데 환불 처리가 되지 않았어요.</td>
      </tr>
      <tr>
      <td colspan="4">
      1. CJ대한통운택배로 반송한 경우<br>
		수거된 상품을 처리 부서에 전달하고 검수 및 고객 정보 확인 후에 환불 처리를 진행하므로, 수거일로부터 실제 처리 완료까지 평균 3일 정도의 시간이 소요됩니다. (영업일 기준)<br><br>

		2. 타사 택배로 반송한 경우 ( CJ대한통운택배가 아닌 경우 )<br>
		저희와 계약된 CJ대한통운택배가 아닌 다른 택배사를 이용하신 경우(편의점 택배 포함), 운송장 번호로 확인되는 수거일로부터 실제 반하루의 상품 인계까지 평균 일주일의 시간이 소요됩니다. 따라서 실제 처리 완료까지는 최소 일주일 이상의 시간이 소요되오니, 그 때까지 시간 양해 부탁 드리며 가급적 CJ대한통운택배를 이용하여 반송해 주시기 바랍니다.
      </td>
      </tr>
      <tr>
        <td>30</td>
        <td>입금결제</td>
        <td>상품가격이 5만원 이상인데 배송비가 적용되었어요!</td>
      </tr>
      <tr>
      <td colspan="4">
      	5만원 이상 구매시 무료 배송 조건에 적용 되십니다.<br>
		단, 배송비 무료 적용 기준은 실결제 금액 입니다.<br>
		쿠폰/적립금 등을 사용하여 총 결제 금액이 5만원 미만이시면 무료 배송 기준에 해당되지 않습니다.<br>
		이 점 참고하시어 반하루와 함께 즐거운 쇼핑되세요~♥<br><br>
		
		* 반품 배송비 측정금액도 실결제 금액 기준이오니 이 점 참고 부탁드려요!<br>
      </td>
      </tr>
      <tr>
        <td>29</td>
        <td>배송관련</td>
        <td>배송 메세지에 옵션, 주소 바꿔달라고 했는데 변경이 안됐어요.</td>
      </tr>
      <tr>
      <td colspan="4">
      	배송메시지는 택배기사님께서 배송시 참고 하시는 항목으로 반하루에서는 별도로 확인 하지 않습니다. 따라서 상품, 주소, 연락처 변경 등의 조치가 필요한 경우엔 꼭 반하루 게시판이나 고객센터로 연락 주셔야 변경 가능합니다.
      </td>
      </tr>
      <tr>
        <td>28</td>
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
        <td>27</td>
        <td>입금결제</td>
        <td>여러가지 상품을 따로 주문했는데 한번에 입금해도 되나요?</td>
      </tr>
      <tr>
      <td colspan="4">
      	입금 확인은 주문번호를 기준으로 처리됨에 따라, 한번에 입금하실 경우엔 입금확인이
		자동으로 진행되지 않습니다. 따라서 입금 후'입금자명, 입금액, 입금일, 입금은행'을 확인하여
		고객센터로 문의주셔야 입금 확인이 가능합니다.
      </td>
      </tr>
      <tr>
        <td>26</td>
        <td>배송전 변경/취소</td>
        <td>주문 상품이 아직 배송전인데 다른 상품으로 교환하고 싶어요.</td>
      </tr>
      <tr>
      <td colspan="4">
      	결제 완료와 동시에 반하루에서는 상품 및 배송 준비 작업을 진행하게 됩니다.<br>
		다만, 실제 작업 중인 내용이 전산에 반영되기까지 다소의 시간 차가 있어
		실제로는 상품이 배송되었어도 마이 페이지에서는'상품 준비중'으로 표기될 수 있습니다.<br>
		따라서 배송 전, 상품 변경 및 교환을 하고자 하실 경우
		게시판 문의글을 남겨 주시거나 고객센터로 연락 주시면 상세히 답변 드리겠습니다.
      </td>
      </tr>
    </tbody>
  </table>
    </div>
    <div id="payment" data-tab-content>
      <h3>About</h3>
      <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    </div>
    <div id="shipping" data-tab-content>
      <h3>Contact</h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
    </div>
    <div id="exchange" data-tab-content>
      <h3>Contact</h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
    </div>
    <div id="cancel" data-tab-content>
      <h3>Contact</h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
    </div>
    <div id="acc" data-tab-content>
      <h3>Contact</h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
    </div>
    <div>
    
    </div>
  </div>
  <ul class="pagination">
	    <li class="page-item disabled"><a class="page-link" href="#"><<</a></li>
	    <li class="page-item"><a class="page-link" href="#">1</a></li>
	    <li class="page-item"><a class="page-link" href="#">2</a></li>
	    <li class="page-item"><a class="page-link" href="#">3</a></li>
	    <li class="page-item"><a class="page-link" href="#">>></a></li>
  	</ul>
  	<br><br><br>
  	
 
</div>

<h2 align="center">문의 게시판</h2><br> 
  	<div align="center">
  	<table>
  		<tr>
  			<td class="mg_right"><h3><a href="#">전체보기</a></h3></td>
  			<td class="mg_right"><h3><a href="#">상품문의</a></h3></td>
  			<td class="mg_right"><h3><a href="#">배송전취소/변경</a></h3></td>
  			<td class="mg_right"><h3><a href="#">배송/교환/반품</a></h3></td>
  			<td><h3><a href="#">입금확인/입금자변경</a></h3></td>
  		</tr>
  	</table>
	<br><br><br><br><br><br>
  	</div>
  	
<!-- partial -->
<script  src="../yh_js/script.js"></script>
<jsp:include page="../footer.jsp" />