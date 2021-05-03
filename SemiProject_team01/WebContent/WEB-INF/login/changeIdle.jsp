<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="../css/login.css"/>

<script type="text/javascript">
	var bool = false;

	$(function(){
		$("div#alert_changeIdle").hide();
		
		$("button#changeIdle").click(function(){	// 비 휴면처리하기
			checkCurrentPwd();
			
			if(bool) {
				var real_id = "${sessionScope.loginuser.userid}";
				$("input#real_id").val(real_id);  
				
				var frm = document.changeIdleFrm;
				frm.action="changeIdle.to";
				frm.method="POST";
				frm.submit();
			}	
		});
	});// end of $(function() ------------------------------------------------------------
	
			
	function checkCurrentPwd() {	// 비밀번호 확인란 체크
		var currentPwd = $("input#changeIdlePwd").val();
		if(currentPwd==""){
			$("div#alert_changeIdle").show();
			$("div#alert_changeIdle").html("본인 확인을 위한 비밀번호를 입력해주세요.");
			bool=false;
		} else if(currentPwd!="${sessionScope.loginuser.pwd}"){
				$("div#alert_changeIdle").show();
				$("div#alert_changeIdle").html("현재 비밀번호와 다릅니다. 다시 입력해주세요.");
				b_flag=false;
		} else {
			$("div#alert_changeIdle").hide();
			bool=true;
		}			
	}// end of function goConfirm() ----------------------------------------------------------
</script> 


<div id="changeIdleContainer">
	<form name="changeIdleFrm" id="changeIdleFrm">
		<div style="text-align: center;">
		    <h3 class="bold" >계정이 휴면상태입니다.</h3>
		    <span>1년간 로그인 이력이 없어 휴면 전환된 계정을 해제하여 다시 사용하실 수 있습니다.</span><br><br>
		</div>
		<div id="changeIdleContents">
			<h4 class="bold">휴면 계정 해제</h4>
			<span>휴면 상태를 해제하시면 다시 정상적으로 사용이 가능합니다.</span><br>
			<span>휴면 상태를 해제 후에는 다시 로그인이 필요 합니다.</span><br>
		 </div>	
		 <input type="password" name="changeIdlePwd" id="changeIdlePwd" placeholder="비밀번호 확인"/> 	      	 	      	 	
	  	 <button type="button" id="changeIdle" class="btn btn-primary" >휴면상태 해제</button>	
	  	 <input type="hidden" name="real_id" id="real_id"/>
	  	 <div id="alert_changeIdle"></div>			 
	</form>        	   
</div>   
 
<jsp:include page="../footer.jsp" />