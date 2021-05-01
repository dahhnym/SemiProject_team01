<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="../css/yh_css/tabs.css">
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="../css/yh_css/bootstrap-table-expandable.css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
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
    <c:forEach var="map" items="${requestScope.faqcategoryList}">
         <li class="tabs_li " data-tab-target="#${map.fccode}"><a href="<%=request.getContextPath()%>/cscenter/csFaq?fcNo="></a>${map.fcname}</li>
      </c:forEach>
  </ul>

  <div class="tab-content">
    <div id="home" data-tab-content class="active">
      <jsp:include page="../cscenter/faq/faq_all.jsp" />
      <div align="center">
	   	<a class="paging" href="#" style="padding-right:15px">1</a>
	   	<a class="paging" href="#">2</a>
	   </div>
    </div>
    <c:forEach var="map" items="${requestScope.faqcategoryList}">
		<div id="${map.fccode}" data-tab-content >
	    	<jsp:include page="../cscenter/faq/faq_${map.fccode}.jsp" />
	    </div>
    </c:forEach>
	</div>
</div>
<br><br><br>

<h2 align="center">문의 게시판</h2><br> 
  	<div align="center">
  	<table>
  		<tr>
  			<td class="pd_right"><h3><a class="menu_cs" href="#">전체보기</a></h3></td>
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