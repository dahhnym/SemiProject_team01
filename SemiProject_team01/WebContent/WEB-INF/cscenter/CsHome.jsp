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
      <div align="center">
	      <a href="<%= request.getContextPath()%>/cscenter/csHome.to">1&nbsp;&nbsp;</a>
	      <a href="<%= request.getContextPath()%>/cscenter/csHome.to?page=2">2</a>
      </div>
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
      <jsp:include page="../cscenter/faq/faq_cancel.jsp"/>
    </div>
    <div id="acc" data-tab-content>
      <jsp:include page="../cscenter/faq/faq_acc.jsp"/>
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
  			<td class="pd_right"><h3><a class="menu_cs" href="<%= request.getContextPath()%>/cscenter/csBoard.to?cateno=0">전체보기</a></h3></td>
  			<td class="pd_right"><h3><a class="menu_cs" href="<%= request.getContextPath()%>/cscenter/csBoard.to?cateno=1">상품문의</a></h3></td>
  			<td class="pd_right"><h3><a class="menu_cs" href="<%= request.getContextPath()%>/cscenter/csBoard.to?cateno=2">배송전취소/변경</a></h3></td>
  			<td class="pd_right"><h3><a class="menu_cs" href="<%= request.getContextPath()%>/cscenter/csBoard.to?cateno=3">배송/교환/반품</a></h3></td>
  			<td><h3><a class="menu_cs" href="<%= request.getContextPath()%>/cscenter/csBoard.to?cateno=4">입금확인/입금자변경</a></h3></td>
  		</tr>
  	</table>
	<br><br><br><br><br><br>
  	</div>
  	
<!-- partial -->
<script  src="../js/yh_js/script.js"></script>
<jsp:include page="../footer.jsp" />