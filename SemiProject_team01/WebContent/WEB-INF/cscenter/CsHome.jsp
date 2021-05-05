<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="../css/yh_css/tabs.css">
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="../js/yh_js/bootstrap-table-expandable.js"></script>

<script type="text/javascript">

  
  $(function() {
	  var html = "";
	  
	  $(document).on('click','a.nav-link',function(){
		  
		  if($(this).text() == "전체보기") {
			  location.href="csHome.to";
		  } else {
			  var cnt = 0;
			  $.ajax({
			   url:"/SemiProject_team01/cscenter/csFaq.to",
			   type:"GET",
			   data:{"fcname" : $(this).text()},
		   	   dataType:"json",
		   	   success:function(json) {
		   		html += "<table class='table table-hover table-striped'>"+
					   			"<thead>" + 
						   	      "<tr>" + 
						   	        "<th>NO</th>" +
						   	        "<th>분류</th>"+
						   	        "<th>제목</th>"+
						   	      "</tr>"+
						   	    "</thead>" +
						   	    "<tbody>";
		   			$.each(json, function(index, item){
		   				cnt++;
					   html += "<tr data-toggle='collapse' data-target='#"+(item.fccode+index)+"'>"+
					   					"<td>"+cnt+"</td>"+
					   					"<td>"+item.fcname+"</td>"+
					   					"<td>"+item.faqtitle+"</td>"+
				   					"</tr>"+  
			   				"<tr id='"+(item.fccode+index)+"' class='collapse'>"+
			   					"<td colspan='4'>"+item.faqcontent +"</td>"+		   					
			   				"</tr>";
			   			}); // end of each ---------------------------------------------
			   	      html +=  "</tbody>" + "</table>";
		   		$("div.tab-pane").html(html);
		   		html ="";
		   	   },
		   	   error: function(request, status, error){
			      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   }
		   });// end of ajax--------------------
		  }
		  
		  
	  });
  });
</script>
<!-- partial:index.partial.html -->
<div class="container_Tabs">
<br><br><br>
<h1 align="center" style="font-weight:bold;">고객센터</h1><br><br>
<h2 align="center">자주 묻는 질문</h2><br>
  <ul class="nav nav-tabs">
    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="<%=request.getContextPath()%>/cscenter/csHome.to">전체보기</a></li>
    <c:forEach var="map" items="${requestScope.faqcategoryList}">
         <li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#${map.fccode}">${map.fcname}</a>
		</li>
      </c:forEach>
  </ul>

  <div class="tab-content">
    <div class="tab-pane fade show active" id="home">
      <table class="table table-hover table-striped">
	    <thead>
	      <tr>
	        <th>NO</th>
	        <th>분류</th>
	        <th>제목</th>
	      </tr>
	    </thead>
	    <tbody>
	    <c:forEach var="fvo" items="${requestScope.faqList}" varStatus="status" >
	     <tr data-toggle="collapse" data-target="#main${status.count}">
	        <td>${fvo.faqNo}</td>
	        <td>${fvo.fcvo.fcname}</td> <%-- 자식 클래스에서 부모 클래스를 private FaqCategoryVO fcvo; 라고 해뒀으니 fcvo.fcname --%>
	        <td>${fvo.faqtitle}</td>
	      </tr>
	      <tr id="main${status.count}" class="collapse">
	      <td colspan="4">${fvo.faqcontent}</td>
	      </tr>
	      </c:forEach>
	     </tbody>
	     </table>
     <div class="pagebar">
     	${pageBar}
     </div>
    </div>
    
    <c:forEach var="map" items="${requestScope.faqcategoryList}">
		<div class="tab-pane fade show" id="${map.fccode}">
	    </div>
    </c:forEach>
	</div>
</div>
<br><br><br><br>
<h2 align="center">문의 게시판</h2><br> 
  	<div align="center">
  	<table>
  		<tr>
  			<td class="pd_right"><h3><a class="menu_cs" href="<%=request.getContextPath()%>/cscenter/csBoardView.to">전체보기</a></h3></td>
  			<td class="pd_right"><h3><a class="menu_cs" href="<%=request.getContextPath()%>/cscenter/csBoardView.to?fk_bigcateno=1">상품문의</a></h3></td>
  			<td class="pd_right"><h3><a class="menu_cs" href="<%=request.getContextPath()%>/cscenter/csBoardView.to?fk_bigcateno=2">배송전취소/변경</a></h3></td>
  			<td class="pd_right"><h3><a class="menu_cs" href="<%=request.getContextPath()%>/cscenter/csBoardView.to?fk_bigcateno=3">배송/교환/반품</a></h3></td>
  			<td><h3><a class="menu_cs" href="<%=request.getContextPath()%>/cscenter/csBoardView.to?fk_bigcateno=4">입금확인/입금자변경</a></h3></td>
  		</tr>
  	</table>
  	</div>
  	
<!-- partial -->
<jsp:include page="../footer.jsp" />