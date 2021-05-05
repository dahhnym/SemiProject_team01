<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="../css/yh_css/boardTable.css">
<script type="text/javascript">
	$(function() {
		$("button.write").click(function(){
			
		});
	});
</script>

<div class="container_b containers">

<br><br><br>
<div align="center">
	<h1 style="font-weight:bold;">문의 게시판</h1><br><br>
	<h2>전체보기</h2><br>
</div>


	<table class="table">
    <thead class="thead-light">
      <tr>
        <th>No</th>
        <th>분류</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일자</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>김아무개</td>
        <td>21-04-29</td>
      </tr>
      <tr>
        <td>9</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>박아무개</td>
        <td>21-04-29</td>
      </tr>
      <tr>
        <td>8</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>이아무개</td>
        <td>21-04-29</td>
      </tr>
      <tr>
        <td>7</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>이아무개</td>
        <td>21-04-29</td>
      </tr>
      <tr>
        <td>6</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>이아무개</td>
        <td>21-04-29</td>
      </tr>
      <tr>
        <td>5</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>이아무개</td>
        <td>21-04-29</td>
      </tr>
      <tr>
        <td>4</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>이아무개</td>
        <td>21-04-29</td>
      </tr>
      <tr>
        <td>3</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>이아무개</td>
        <td>21-04-29</td>
      </tr>
      <tr>
        <td>2</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>이아무개</td>
        <td>21-04-29</td>
      </tr>
      <tr>
        <td>1</td>
        <td>상품문의</td>
        <td>상품문의합니다.</td>
        <td>이아무개</td>
        <td>21-04-29</td>
      </tr>
    </tbody>
  </table>
  <a href="<%= request.getContextPath()%>/cscenter/csBoardWrite.to" id="write" class="btn btn-secondary">글쓰기</a>
  <br>  
  
  <div class="div_a" align="center">
	  <a href="#">1</a>
	  <a href="#">2</a>
	  <a href="#">3</a>
	  <a href="#">4</a>
	  <a href="#">5</a>
	  
  </div>
  

  
</div>
<jsp:include page="../footer.jsp"/>