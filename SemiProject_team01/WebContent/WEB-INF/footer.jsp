<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  
<script>
$(window).scroll(function(){
	if ($(this).scrollTop() > 300){
		$('.btn_gotop').show();
	} else{
		$('.btn_gotop').hide();
	}
});
$('.btn_gotop').click(function(){
	$('html, body').animate({scrollTop:0},400);
	
	
	return false;
});

$(document).ready(function(){
	
	$("select#internetBanking").change(function(){
		
		if($("select").val() == "국민은행"){
			window.open("https://obank.kbstar.com/quics?page=obank#loading", "국민은행 인터넷뱅킹");
			$("option#default").prop("selected", true);
		} else if($("select").val() == "우리은행"){
			window.open("https://spib.wooribank.com/pib/Dream?withyou=ps", "우리은행 인터넷뱅킹");
			$("option#default").prop("selected", true);
		} else if($("select").val() == "기업은행"){
			window.open("https://mybank.ibk.co.kr/uib/jsp/index.jsp", "기업은행 인터넷뱅킹");
			$("option#default").prop("selected", true);
		} else if($("select").val() == "농협은행"){
			window.open("https://banking.nonghyup.com/nhbank.html", "농협은행 인터넷뱅킹");
			$("option#default").prop("selected", true);
		} else if($("select").val() == "산업은행"){
			window.open("https://banking.kdb.co.kr/bp/index.jsp", "산업은행 인터넷뱅킹");
			$("option#default").prop("selected", true);
		} else if($("select").val() == "하나은행"){
			window.open("https://www.kebhana.com/", "하나은행 인터넷뱅킹");
			$("option#default").prop("selected", true);
		} else if($("select").val() == "부산은행"){
			window.open("https://ibank.busanbank.co.kr/ib20/mnu/PEB00001", "부산은행 인터넷뱅킹");
			$("option#default").prop("selected", true);
		} else if($("select").val() == "신한은행"){
			window.open("https://bank.shinhan.com/index.jsp?referrer=https%3A%2F%2Fsearch.naver.com%2Fsearch.naver%3Fsm%3Dtab_hty.top%26where%3Dnexearch%26query%3D%25EC%258B%25A0%25ED%2595%259C%25EC%259D%2580%25ED%2596%2589%2B%25EC%259D%25B8%25ED%2584%25B0%25EB%2584%25B7%25EB%25B1%2585%25ED%2582%25B9%26oquery%3D%25EB%25B6%2580%25EC%2582%25B0%25EC%259D%2580%25ED%2596%2589%2B%25EC%259D%25B8%25ED%2584%25B0%25EB%2584%25B7%25EB%25B1%2585%25ED%2582%25B9%26tqi%3Dh4Ju4lprvN8ss7RqjQwssssstIo-053405#010800000000", "신한은행 인터넷뱅킹");
			$("option#default").prop("selected", true);
		}
		
		
	});
		
	
	
	
	
	
});

</script>
  
    
<a href="#" class="btn_gotop">
 <i class="fas fa-angle-up"></i>
</a>



<footer id="footer">
<hr style="margin-top : 200px; margin-bottom: 15px;">
<div class="div-footer content-width">
	<nav id="footer-nav">
		<ul>
			<li>회사소개</li><div class="divider"></div>
			<li>이용약관</li><div class="divider"></div>
			<li>개인정보처리방침</li><div class="divider"></div>
			<li>이용안내</li><div class="divider"></div>
			<li>제휴문의</li>
		</ul>
		<ul id="sns">
			<li><a href="https://facebook.com" target="_blank"><img class="snsicon" id="facebook" src="<%=request.getContextPath()%>/images/facebook.png" /></a></li>
			<li><a href="https://instagram.com" target="_blank"><img class="snsicon" id="instagram" src="<%=request.getContextPath()%>/images/instagram.png" /></a></li>
			<li><a href="https://twitter.com" target="_blank"><img class="snsicon" id="twitter" src="<%=request.getContextPath()%>/images/twitter.png" /></a></li>
		</ul>
	</nav>
</div>
<hr style="margin-top: 15px; margin-bottom: 0">

  <div class="row content-width">
    <div class="col-sm-4">
    	<div class="col-container">
	    	<p class="colname">고객센터</p>
	    	<p style="font-size: 25pt;">070-1234-5678</p>
	    	<p>평일 오전 10:00 ~ 오후 4:00 점심시간 오후 12:00 ~ 1:30 토/일/공휴일 휴무</p>
    	</div>
    </div>
     <div class="col-sm-4" style="padding-left: 100px;">
    	<p class="colname">Account Info</p>
    	<p>국민 김일조</p>
    	<p>654321-12-123456</p>
    	<select id="internetBanking">
    		<option id="default">인터넷뱅킹바로가기</option>
    		<option>국민은행</option>
    		<option>우리은행</option>
    		<option>기업은행</option>
    		<option>농협은행</option>
    		<option>산업은행</option>
    		<option>하나은행</option>
    		<option>부산은행</option>
    		<option>신한은행</option>
    	</select>
    </div>
    <div class="col-sm-4">
    	<p class="colname">Return/Exchange</p>
    	<p>서울특별시 강남구 영동대로 123 SY빌딩 7층 111호</p>
    	<p>자세한 교환,반품절차 안내는 문의란 및 공지사항을 참고해주세요.</p>
    	
    </div>
  </div>
<hr style="margin: 0;">
<div class="bottom-footer" style="background-color: #f2f2f2; padding: 20px 0;">
	<div class="div-footer bottom-footer-content content-width">
		<p>COMPANY : Ladies and gents&nbsp;&nbsp;&nbsp;OWNER: 김일조&nbsp;&nbsp;BUSINESS LICENSE : 111-22-3333 &nbsp;&nbsp;<span><button type="button" id="companyInfoCheck" style="display: inline-block;" onclick="window.open('https://www.ftc.go.kr/www/bizCommList.do?key=232')">사업자정보조회</button></span></p>
		<p>ADDRESS: 12345 서울특별시 강남구 영동대로 123 SY빌딩 7층 111호&nbsp;&nbsp;&nbsp;TEL : 02-9876-5432&nbsp;&nbsp;FAX: 02-1234-5678</p>
		<p>CPO: 최세미&nbsp;&nbsp;&nbsp;&nbsp;CONTACT US: abcd@gmail.com</p>
		<p>COPYRIGHT ⓒ Ladies and gents ALL RIGHTS RESERVED.</p>
	</div>

</div>
</footer>

</body>
</html>