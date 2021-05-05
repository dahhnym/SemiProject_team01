<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="sum" value="0"/>

<jsp:include page="../header.jsp"/>


<link rel="stylesheet" href="<%=ctxPath%>/css/Ohdayoon.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
	table.wishlist_table, table.cart_table, table.price_table{
		width:100%;
		border-top: solid 1px #CCD1D1;
		border-bottom: solid 1px #CCD1D1;
		vertical-align: middle;
	}

	th{
		text-align: center;
		height: 40px;
	}
	tr{
		border-bottom: solid 1px #CCD1D1;
		vertical-align: middle;
		text-align: center;
	}
	
	
	tr.cartprice{
		text-align: center;
		vertical-align: middle;
		height: 70px;
	}
	
	button.btn_option{
	display: inline-block;
	border: solid 1px #CCD1D1;
	cursor: pointer;
	margin-top: 10px;
	padding: 0px 7px;
	font-size: 10pt;
	width: 107px;
	text-align: center;
	background-color: #fff;
	}
	
	button.btnLarge{
	display: inline-block;
	width: 160px;
	height: 50px;
	border-radius: 0px;
	font-weight: bold;
	cursor: pointer;
	text-align: center;
	padding: 10px 10px;
	text-decoration: none;
	opacity: 1;
	background-color: #fff;
	border: solid 1px #CCD1D1;
	}
</style>
  
<script type="text/javascript">
$(document).ready(function(){
	
	// 장바구니 옵션창 숨기기
	$("div.optionModify").hide();
	
	// 위시리스트 옵션선택 창 숨기기
	$("div#wishlistlayer").hide();


	// 장바구니 수량 변경하기
	$("input.prodOqty").spinner({
		
		spin:function(event,ui){
			
			if(ui.value<1){ //ui는 input태그를 말함
				$(this).spinner("value",1);
				return false;
			}
		}
	});
	
	
	
	$("input.prodOqty").bind("spinstop",function(){
		
		var index = $("input.prodOqty").index($(this));
	//	alert(index);

		var cartnum = $("input.cartnum").eq(index).val();
	//	alert(cartnum);
		var oqty = $("input.prodOqty").eq(index).val();
	//	alert(oqty);
		var fk_pdetailnum = $("input.fk_pdetailnum").eq(index).val();
	//	alert($(this).val());
		 $.ajax({
				url:"<%= ctxPath%>/cart/updateOqtyCart.to",
				type: "post",
				data: {"userid":"${sessionScope.loginuser.userid}","cartnum":cartnum, "oqty": oqty,"fk_pdetailnum":fk_pdetailnum},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						location.href="javascript:history.go(0);";
					}
					else if(json.n==0){ // 재고 수량이 변경할 수량보다 적을 경우
						alert("상품의 수량이 재고수량 보다 많습니다.");
						return;
					}
				},
				 error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			     }  
			});
			
	});
	
	
	// 장바구니 전체 클릭 
	$("input#prodAllCheck").click(function(){
		var allCheck = $(this).is(":checked");
		
		if (allCheck == false){
			$("input[name=product_check]").prop("checked",false);
		}
		else{
			$("input[name=product_check]").prop("checked",true);
		}
	});
	
	
	
	// === 체크박스 전체 선택/전체 해제 === //
	$("input#prodAllCheck").click(function(){		
		var bool = $(this).prop("checked");
		$("input:checkbox[name=product_check]").prop("checked", bool);
	}); // end of $("input:checkbox[id=checkall]").click(function(){})-------
	
	
	$("input:checkbox[name=product_check]").click(function(){
		
		var bool = $(this).prop("checked");
		
		if(bool){
			
			var flag=false;
			
			$("input:checkbox[name=product_check]").each(function(index, item){
				
				var bChecked = $(item).prop("checked");
				
				if(!bChecked){
					flag=true;
					return false; 
				}
				
			}); // end of $("input:checkbox[name=person]").each(function(index, item){})---------

			if(!flag){		
                $("input#prodAllCheck").prop("checked",true);
			}
		}
		else{
			$("input#prodAllCheck").prop("checked",false);
		}
		
	});// end of $("input:checkbox[name=person]").click(function(){})-----------------
	
	
	/////////////////////////////////////////////////
	// 장바구니 옵션보여주기   
    $("button.option_change").bind("click", function(){
    	
    	 var $target = $(event.target);
			$target.next().show();
	
    	var index = $("button.option_change").index($(this));
    	var fk_pnum = $(this).val();
    //	alert(fk_pnum);
    	console.log("index : " + index +" , fk_pnum : " + fk_pnum);
    	
    	$.ajax({
    		url:"<%= ctxPath%>/cart/optionSelect.to",
    		type:"get",
    		data:{"fk_pnum":fk_pnum},
    		dataType: "json",
			success:function(json){
				    
				    var html = "<option value=''>- [필수] 옵션을 선택해 주세요 -</option>";

				    if(json.length > 1){
						
				    	$.each(json, function(index, item){
							html += "<option value='"+item.pdetailnum+"'>"+item.optionname;
							if(item.pqty ==0){
								html+= "<span>[품절]</span>";
							}
							html+="</option>";
						});
					}
				    
				    
			   //  alert(html);
			   /*
			       <option value=''>- [필수] 옵션을 선택해 주세요 -</option><option>블랙</option><option>네이비</option><option>그레이</option><option>아이보리</option>
			   */
			 

			   var $select = $("select.colorOption").eq(index);
			   $select.html(html);
				
			  
				  	$("button.optionAdd").bind("click",function(){
				  	
				  		var pdetailnum =  $("select.colorOption").eq(index).val(); 
				  //		alert(pdetailnum);
				  //		alert(fk_pnum);
				  		
				  		if(pdetailnum==0){
				  			alert("추가할 옵션을 선택하세요");
				  			return false;
				  		}
				  	
				  		
				  		$.ajax({
				  			url:"<%= ctxPath%>/cart/addOptionCart.to",
							type: "post",
							data: {"userid":"${sessionScope.loginuser.userid}", "pdetailnum":pdetailnum,"fk_pnum":fk_pnum },
							dataType: "json",
							success:function(json){
									if(json.n==1){
										location.href="javascript:history.go(0);"; // 새로고침해주기
									}
									else if(json.n==0){
										alert("재고수량이 없습니다.");
										return false;
									}
							},
							 error: function(request, status, error){
						            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						     }  
						});
				  		
				  	});
				  	
				  	
				  	$("button.optionChange").bind("click",function(){
				  	
				  		var oldpdetailnum = $(this).val();
				  	
				  		var newpdetailnum =  $("select.colorOption").eq(index).val(); 
				  	//	alert(pdetailnum);
				  	//	alert(fk_pnum);
				  		
				  		if(newpdetailnum==0){
				  			alert("추가할 옵션을 선택하세요");
				  			return false;
				  		}
				  	
				  		else if(newpdetailnum==oldpdetailnum){
				  			alert("해당 상품은 이미 장바구니에 존재합니다.");
				  			return false;
				  		}
				  		$.ajax({
							url:"<%= ctxPath%>/cart/changeOptionCart.to",
							type: "post",
							data: {"userid":"${sessionScope.loginuser.userid}", "newpdetailnum":newpdetailnum,"fk_pnum":fk_pnum, "oldpdetailnum":oldpdetailnum},
							dataType: "json",
							success:function(json){
								if(json.n==1){
									location.href="javascript:history.go(0);"; // 새로고침해주기
								}
								else if(json.n==0){
									alert("재고수량이 없습니다.");
									return false;
								}
							},
							 error: function(request, status, error){
						            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						     }  
						});
				  	
				  	});
				  	
	
			},
			 error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		     }  
    		
    	});
    	
    	
    });
	
	
	
    
 // 위시리스트 옵션보여주기   
    $("button.wishChange").bind("click", function(){
    	
    	 var $target = $(event.target);
			$target.next().show();
	
    	var index = $("button.wishChange").index($(this));
    	var fk_pnum = $(this).val();
    //	alert(fk_pnum);
    	console.log("index : " + index +" , fk_pnum : " + fk_pnum);
    	
    	$.ajax({
    		url:"<%= ctxPath%>/cart/optionSelect.to",
    		type:"get",
    		data:{"fk_pnum":fk_pnum},
    		dataType: "json",
			success:function(json){
				    
				    var html = "<option value=''>- [필수] 옵션을 선택해 주세요 -</option>";

					if(json.length > 1){
						
				    	$.each(json, function(index, item){
							html += "<option value='"+item.pdetailnum+"'>"+item.optionname;
							if(item.pqty ==0){
								html+= "<span>[품절]</span>";
							}
							html+="</option>";
						});
					}
				    
				    
			  //   alert(html);
			   /*
			       <option value=''>- [필수] 옵션을 선택해 주세요 -</option><option>블랙</option><option>네이비</option><option>그레이</option><option>아이보리</option>
			   */
			 

			   var $select = $("select.colorWishOption").eq(index);
			   $select.html(html);
			  	
				  	$("button.optionWishChange").bind("click",function(){
				  	
				  		var oldpdetailnum = $(this).val();
				  		var newpdetailnum =  $("select.colorWishOption").eq(index).val(); 
				  		
				  		
				  		if(newpdetailnum==0){
				  			alert("추가할 옵션을 선택하세요");
				  			return false;
				  		}
				  	
				  		else if(newpdetailnum==oldpdetailnum){
				  			alert("해당 상품은 이미 위시리스트에 존재합니다.");
				  			return false;
				  		}
				  		$.ajax({
							url:"<%= ctxPath%>/cart/changeOptionWish.to",
							type: "post",
							data: {"userid":"${sessionScope.loginuser.userid}", "newpdetailnum":newpdetailnum,"fk_pnum":fk_pnum, "oldpdetailnum":oldpdetailnum},
							dataType: "json",
							success:function(json){
								if(json.n==1){
									location.href="javascript:history.go(0);"; // 새로고침해주기
								}
								else if(json.n==0){
									alert("재고수량이 없습니다.");
									return false;
								}
							},
							 error: function(request, status, error){
						            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						     }  
						});
				  	
				  	});
				  
	
			},
			 error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		     }  
    		
    	});
    	
    	
    });
	
	
}); // end of $(document).ready(function(){})-------

	
	// 수량 변경하기 클릭시
	function updateOqtyCart(obj){
	
		var index = $("button.updateOqty").index(obj);
		var cartnum = $("input.cartnum").eq(index).val();
	//	alert(cartnum);
		var oqty = $("input.prodOqty").eq(index).val();
		var fk_pdetailnum = $("input.fk_pdetailnum").eq(index).val();
	//	alert(fk_pdetailnum);
	//	alert(oqty);
		 var regExp=/^[0-9]+$/;
		 
		   var bool = regExp.test(oqty);
		   
		   if(!bool){
			   // 숫자 이외의 값이 들어온 경우
			   alert("수량은 1개 이상이어야 합니다.");
			   $("input.prodOqty").val("1");
		       return; // 종료
		   }
		   
		   // 문자형태로 숫자로만 들어온 경우
		   oqty = parseInt(oqty);
	       if(oqty < 1) {
	         alert("수량은 1개 이상이어야 합니다.");
	         $("input.prodOqty").val("1");
	         return; // 종료
	      }
	       
	       $.ajax({
				url:"<%= ctxPath%>/cart/updateOqtyCart.to",
				type: "post",
				data: {"userid":"${sessionScope.loginuser.userid}","cartnum":cartnum, "oqty": oqty,"fk_pdetailnum":fk_pdetailnum},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						location.href="javascript:history.go(0);";
					}
					else if(json.n==0){ // 재고 수량이 변경할 수량보다 적을 경우
						alert("상품의 수량이 재고수량 보다 많습니다.");
					}
				},
				 error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			     }  
			});
  

	}
	
		// 장바구니 개별 삭제하기 
		function deleteCartOne(cartnum){		
			var $target = $(event.target);
			var pname = $target.parent().parent().find(".cname").text();
		//	console.log(pname);
			var bool = confirm("장바구니에서 "+pname+" 상품을  삭제하시겠습니까?");
		//	alert(cartnum);
			if(bool){
				$.ajax({
					url:"<%= ctxPath%>/cart/deleteCartOne.to",
					type: "post",
					data: {"userid":"${sessionScope.loginuser.userid}","cartnum":cartnum},
					dataType: "json",
					success:function(json){
							alert(json.msg);
							location.href="javascript:history.go(0);"; // 새로고침해주기
					},
					 error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				     }  
				});
				
			}
			else{
				return false;
			}
		}
		
		
		// 위시리스트 개별 삭제하기
		function deleteWishOne(wnum){		
			var $target = $(event.target);
			var wname = $target.parent().parent().find(".wname").text();
		//	console.log(wname);
			var bool = confirm("위시리스트에서 "+wname+" 상품을  삭제하시겠습니까?");
			
			if(bool){
				$.ajax({
					url:"<%= ctxPath%>/cart/deleteWishOne.to",
					type: "post",
					data: {"userid":"${sessionScope.loginuser.userid}", "wnum":wnum},
					dataType: "json",
					success:function(json){
							alert(json.msg);
							location.href="javascript:history.go(0);"; // 새로고침해주기
					},
					 error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				     }  
				});
				
			}
			else{
				return false;
			}
		}
		
		
		
		// 장바구니에서 위시리스트로 이동
		function moveToWish(cartnum, fk_pnum, fk_pdetailnum){		
			var $target = $(event.target);
			var pname = $target.parent().parent().find(".cname").text();
		//	console.log(pname);
		//	console.log(fk_pnum);
		//	console.log(cartnum);
		//	console.log(fk_pdetailnum);
			var bool = confirm("장바구니에서 "+pname+" 상품을 위시리스트에 담으시겠습니까?");
			
			if(bool){
				$.ajax({
					url:"<%= ctxPath%>/cart/moveToWish.to",
					type: "post",
					data: {"userid" : "${sessionScope.loginuser.userid}"
						  ,"cartnum" : cartnum
						  ,"fk_pnum" : fk_pnum
						  ,"fk_pdetailnum" : fk_pdetailnum
							},
						  
					dataType: "json",
					success:function(json){
						if(json.n == 1){
							location.href="javascript:history.go(0);"; // 새로고침해주기
						 }
						 else if(json.n == -1)  {
			             	alert("위시리스트에 이미 존재하는 상품입니다.");
			                  
			             }
							
					},
					 error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				     }  
				});
				
			}
			else{
				return false;
			}
		}
		
		
		
		// 장바구니 비우기
		function deleteAllCart(userid){
			
			var bool = confirm("장바구니를 비우시겠습니까?");
					
			if(bool){
				$.ajax({
					url:"<%= ctxPath%>/cart/deleteAllCart.to",
					type: "post",
					data: {"userid" : "${sessionScope.loginuser.userid}"},
						  
					dataType: "json",
					success:function(json){
						
							location.href="javascript:history.go(0);"; // 새로고침해주기
						
		
					},
					 error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				     }  
				});
				
			}
			else{
				return false;
			}
		}
		
		
		
		
		
</script>


<div class="container" style="z-index: -1">
	<div class="contents" >
		
			<div class="title" >
				<h2>장바구니</h2>
			</div>
		
			<div class="information">
				<div class="decription">
					<div class="member">
						<p>${sessionScope.loginuser.name}님은 [
						
							<c:if test="${sessionScope.loginuser.level == 1}">
								<span style= "font-weight: bold; ">Silver</span>
							</c:if>
							<c:if test="${sessionScope.loginuser.level == 2}">
								<span style= "font-weight: bold; ">Gold</span>
							</c:if>
							<c:if test="${sessionScope.loginuser.level == 3}">
								<span style= "font-weight: bold; ">Platinum</span>
							</c:if>
						] 등급입니다.</p>
						<a href="">적립포인트:&nbsp;&nbsp;<span>${sessionScope.loginuser.point}</span>P</a>&nbsp;
					</div>
				</div>
			</div>
		
			<div style="margin-top: 20px;">
				<h3>일반상품(${fn:length(cartList)})</h3>
			</div>
			
			<table class="cart_table">
				<colgroup>
					<col style="width: 27px">
					<col style="width: 92px">
					<col style="width: auto">
					<col style="width: 105px">
					<col style="width: 105px">
					<col style="width: 105px">
					<col style="width: 95px">
					<col style="width: 100px">
					<col style="width: 120px">									
				</colgroup>
				<thead>
					<tr>
						<th scope="col">
							<input type="checkbox" id="prodAllCheck" />
						</th>
					    <th scope="col">이미지</th>
					    <th scope="col">상품정보</th>
					    <th scope="col">판매가</th>
					    <th scope="col">수량</th>
					    <th scope="col">적립포인트</th>
					    <th scope="col">배송비</th>
					    <th scope="col">합계</th>
					    <th scope="col">선택</th>
				    </tr>
				</thead>
				
				
					<c:if test="${empty requestScope.cartList}">
						<tbody>
							<tr>
								<td colspan="9" height="150px;"><span style="color: black;">장바구니에 담긴 상품이 없습니다.</span></td>
							</tr>
						</tbody>
					</c:if>
					
					<c:if test="${not empty requestScope.cartList}">
						<tbody>
						<c:forEach items="${requestScope.cartList}" var="cart" varStatus="status">
							
							<c:set var="sum" value="${sum+(cart.pvo.saleprice*cart.oqty)}"/>
									<tr class="xans-record-">
										<td scope="col"><input type="checkbox" id="basket_chk_id_0"
											name="product_check" value="${cart.fk_pnum}" onclick="ChangeTotalPrice()" /></td>
										<td scope="col" class="thumb">
										<a href="">
											<img src="<%=ctxPath%>/images/${cart.pvo.pimage1}" width= "90px;" height="90px;"/>
										</a></td>
										<td scope="col" class="product" style="text-align: left;">
										<ul class="xans-element- xans-order xans-order-optionall option" style="margin-top: 15px;">
											<li>
												<a href="">
													<strong class="cname">${cart.pvo.pname}</strong>	
												</a>
												<input type="hidden" class="cartnum" value="${cart.cartnum}"/>
												<input type="hidden" class="fk_pnum" value="${cart.fk_pnum}"/>
												<input type="hidden" class="fk_pdetailnum" value="${cart.fk_pdetailnum}"/>
											</li>
											<li class="xans-record-" value="${cart.fk_pdetailnum}">[옵션: ${cart.pdetailvo.optionname}]<br />
											
											<button class="option_change btn_option" style="width: 80px; margin-top: 3px;" value="${cart.fk_pnum}">옵션변경</button>
							
						<!-- 옵션변경 레이어 -->
					 			<div class="optionModify ec-base-layer2" id="option_modify_layer_0" style="position: absolute !important;">
	                                    <div class="header">
	                                        <h3  style="color: white !important;">옵션변경</h3>
	                                    </div>
	                                    <div class="content">
	                                        <ul class="prdInfo">
												<li>${cart.pvo.pname}</li>
	                                        </ul>
										<div class="prdModify">
	                                            <h4>상품옵션</h4>
	                                            <ul class="xans-element- xans-order xans-order-optionlist"><li class="xans-record-">
												<span>색상</span>
	 											<select class="colorOption" name="color">
		 											<%-- Ajax를 통해서 들어오도록 한다. --%>
												</select>
												</li>
											</ul>
										</div>
	                                    </div>
	                                    <div class="ec-base-button">
	                                        <button class="btn_option optionAdd"  style="border: solid 1px #CCD1D1; width: 70px; height: 30px; ">추가</button>                                       		
	                                        <button class="btn_option optionChange" value="${cart.fk_pdetailnum}" style="border: solid 1px #CCD1D1; width: 70px; height: 30px; ">변경</button>
	                                        	
	                                    </div>
	                                    <a href="#none" class="close" onclick="$('div.optionModify').hide();"><img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기"/></a>
										</div>
						<!-- 옵션변경 레이어 -->
																
											
											
														 
												</li>
											</ul></td>
										<td scope="col" class="price">
											<div class="">
												<strong><fmt:formatNumber value="${cart.pvo.saleprice}" type="number"/> 원</strong>
											</div>
										</td>
										<td scope="col" >
	  										<input class="prodOqty" name="value" style="width: 25px; height: 20px;" value="${cart.oqty}"/>
	  										<input type="hidden" class="pqty" value="${cart.pdetailvo.pqty}"/>
	  										<button  class="updateOqty btn_option" style="width:50px;" onclick="updateOqtyCart(this)" >변경</button>
										</td>
										<td scope="col" class="mileage">
												<c:if test="${sessionScope.loginuser.level == 1}">
													<fmt:formatNumber value="${cart.pvo.saleprice*cart.oqty*0.01}" type="number"/>P
													<input type="hidden" value="${cart.pvo.saleprice*cart.oqty*0.01}"/>
												</c:if>
												<c:if test="${sessionScope.loginuser.level == 2}">
													<fmt:formatNumber value="${cart.pvo.saleprice*cart.oqty*0.03}" type="number"/>P
													<input type="hidden" value="${cart.pvo.saleprice*cart.oqty*0.03}"/>
												</c:if>
												<c:if test="${sessionScope.loginuser.level == 3}">
													<fmt:formatNumber value="${cart.pvo.saleprice*cart.oqty*0.05}" type="number"/>P
													<input type="hidden" value="${cart.pvo.saleprice*cart.oqty*0.05}"/>
												</c:if>
										</td>
										<td scope="col">
												
												<c:if test="${sum >= 100000}"> 
													<span>무료</span><c:set var="delivery" value="0"/>
												</c:if>
												<c:if test="${sum < 100000}">
													<fmt:formatNumber value="2500" type="number" />원
													<c:set var="delivery" value="2500"/>
												</c:if>
										</td>
										<td scope="col" class="total">
											<strong><fmt:formatNumber value="${(cart.pvo.saleprice*cart.oqty)}" type="number" /> 원</strong>
											<input type="hidden" class="sumprice" value="${(cart.pvo.saleprice*cart.oqty)}"/>
										
										</td>
										<td scope="col" class="button">
												<button id="prod_order" class="btn_option" >주문하기</button><br>
										    	<button id="prodtowish" class="btn_option" onclick="moveToWish('${cart.cartnum}','${cart.fk_pnum}','${cart.fk_pdetailnum}')">위시리스트담기</button><br>
										    	<button id="proddelete" class="btn_option" style="margin-bottom: 5px;" onclick="deleteCartOne('${cart.cartnum}')">삭제</button>
										
										</td>
									</tr>
									</c:forEach>
								</c:if>
							</tbody>
				
				
			</table>
			<button id="deleteCart" class="btn_option" style="width: 120px;" onclick="deleteAllCart('${sessionScope.loginuser}')">장바구니 비우기</button>
			<div class="displaynone">
			
			</div>
			<table class="price_table" style="border: solid 1px #CCD1D1;">
				<colgroup>
					<col style="width:20%; ">
					<col style="width:20%; ">
					<col style="width:auto; ">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">총 상품금액</th>
						<th scope="col">총 배송비</th>
						<th scope="col">총 주문금액</th>
					</tr>
				</thead>
				<tbody>
					<tr class="cartprice">
							<td scope="col" style="border-right: solid 1px #CCD1D1;">
								<fmt:formatNumber value="${sum}" type="number" />원
								<input type="hidden" name="sum" value="${sum}"/>
							
							</td>
							<td scope="col" style="border-right: solid 1px #CCD1D1;">
								<c:if test="${sum >= 100000}"> 
									<span>무료</span><c:set var="delivery" value="0"/>
								</c:if>
								<c:if test="${sum < 100000}">
									<fmt:formatNumber value="2500" type="number" />원
									<c:set var="delivery" value="2500"/>
								</c:if>
							</td>
							<td scope="col"><fmt:formatNumber value="${sum+delivery}" type="number" />원</td>
						
					</tr>
				</tbody>	
			</table>
			
			<div style="margin: 30px 0px;">
				<button id="allorder" class="btnLarge" style="background-color: #000; color: #fff; margin-left: 380px; margin-right: 20px;">전체상품주문 </button>
				<button  id="seperateorder" class="btnLarge" style="background-color: #CCD1D1; color: #000;">선택상품주문 </button>
				<span class="btn_right"><a  href="<%= request.getContextPath()%>/home.to"><button id="shoppingcon" class="btnLarge">쇼핑계속하기 </button></a></span>
			</div>
		
	
			<div class="title">
				<h2>위시리스트</h2>
			</div>
		
		<table class="wishlist_table">
				<colgroup>
					<col style="width: 92px">
					<col style="width: auto">
					<col style="width: 105px">
					<col style="width: 105px">
					<col style="width: 95px">
					<col style="width: 105px">
					<col style="width: 120px">									
				</colgroup>
				<thead>
					<tr>
					    <th scope="col">이미지</th>
					    <th scope="col">상품정보</th>
					    <th scope="col">판매가</th>
					    <th scope="col">적립포인트</th>
					    <th scope="col">배송비</th>
					    <th scope="col">합계</th>
					    <th scope="col">선택</th>
				    </tr>
				</thead>
				
				
					<c:if test="${empty requestScope.wishList}">
					<tbody>
						<tr>
							<td colspan="7" height="150px;">
								<span style="color: black;">위시리스트에 담긴 상품이 없습니다.</span></td>
						</tr>
						</tbody>
					</c:if>
						
					
					<c:if test="${not empty requestScope.wishList}">
						<tbody>
						<c:forEach items="${requestScope.wishList}" var="wish">
						<tr>
						<td scope="col" class="thumb">
									<a href="">
										<img src="<%=ctxPath%>/images/${wish.pvo.pimage1}" width= "90px;" height="90px;"/>
									</a></td>
									<td scope="col" class="product" style="text-align: left;">
									<ul class="xans-element- xans-order xans-order-optionall option"  style="margin-top: 15px;">
										<li>
											<a href="">
												<strong class="wname">${wish.pvo.pname}</strong>	
											</a>
											<input type="hidden" value="${wish.wnum}"/>
										</li>
										<c:if test="${wish.fk_pdetailnum !=0}">
											<li class="xans-record-" value="${wish.fk_pdetailnum}">[옵션: ${wish.pdetailvo.optionname}]<br />
										</c:if>	
										<button class="btn_option wishChange" value="${wish.fk_pnum}" style="width: 80px; margin-top: 3px;">옵션변경</button>
													
													
					<!-- 옵션변경 레이어 -->

					 			<div class="optionModify ec-base-layer2" id="option_modify_layer_0" style="position: absolute !important;">
	                                    <div class="header">
	                                        <h3  style="color: white !important;">옵션변경</h3>
	                                    </div>
	                                    <div class="content">
	                                        <ul class="prdInfo">
												<li>${wish.pvo.pname}</li>
	                                        </ul>
										<div class="prdModify">
	                                            <h4>상품옵션</h4>
	                                            <ul class="xans-element- xans-order xans-order-optionlist"><li class="xans-record-">
												<span>색상</span>
	 											<select class="colorWishOption" name="color">
		 											<%-- Ajax를 통해서 들어오도록 한다. --%>
												</select>
												</li>
											</ul>
										</div>
	                                    </div>
	                                    <div class="ec-base-button">                                     		
	                                        <button class="btn_option optionWishChange" value="${wish.fk_pdetailnum}" style="border: solid 1px #CCD1D1; width: 70px; height: 30px; ">변경</button>
	                                        	
	                                    </div>
	                                    <a href="#none" class="close" onclick="$('div.optionModify').hide();"><img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기"/></a>
										</div>
						<!-- 옵션변경 레이어 -->
					
																	 
											</li>
										</ul></td>
									<td scope="col" class="price">
										<div class="">
											<strong><fmt:formatNumber value="${wish.pvo.saleprice}" type="number"/> 원</strong>
										</div>
									</td>
									<td scope="col" class="mileage">
										<c:if test="${sessionScope.loginuser.level == 1}">
													<fmt:formatNumber value="${wish.pvo.saleprice*0.01}" type="number"/>P
													<input type="hidden" value="${wish.pvo.saleprice*0.01}"/>
												</c:if>
												<c:if test="${sessionScope.loginuser.level == 2}">
													<fmt:formatNumber value="${cart.pvo.saleprice*0.03}" type="number"/>P
													<input type="hidden" value="${wish.pvo.saleprice*0.03}"/>
												</c:if>
												<c:if test="${sessionScope.loginuser.level == 3}">
													<fmt:formatNumber value="${cart.pvo.saleprice*0.05}" type="number"/>P
													<input type="hidden" value="${wish.pvo.saleprice*0.05}"/>
										</c:if>
									</td>
									<td scope="col">
										<span><c:if test="${wish.pvo.saleprice >=100000} ">
												0
												</c:if>
												<c:if test="${wish.pvo.saleprice < 100000}">
												<fmt:formatNumber  value="2500" type="number" />원
												</c:if>
										</span>
									</td>
									<td scope="col" class="total">
										<strong>
											<c:if test="${wish.pvo.saleprice >= 100000}"> 
												<fmt:formatNumber value="${wish.pvo.saleprice}" type="number" /> 원</strong>
											</c:if>
											<c:if test="${wish.pvo.saleprice < 100000}"> 
											<fmt:formatNumber value="${wish.pvo.saleprice+2500}" type="number" /> 원</strong>
											</c:if>
									</td>
				    	<td scope="col" class="button">
							<button id="prod_order" class="btn_option" onclick="moveOrder();" >주문하기</button><br>
					    	<button id="prodtowish" class="btn_option" onclick="moveCart();" >장바구니담기</button><br>
					    	<button id="proddelete" class="btn_option" onclick="deleteWishOne('${wish.wnum}')" >삭제</button>
								
					    </td>
					     </tr>
					    </c:forEach>
					</c:if>
					
					
					
				</tbody>
				
			</table>

	</div>


		<!-- 레이어 팝업 만들기  -->
		<div id="wishlistlayer" class="addoption ec-base-layer3" style="position: absolute !important;"> 
			<div class="header">
	     		<h3  style="color: #fff !important; text-align: left;">옵션변경</h3>
			</div>
				<iframe frameborder="0"style="width: 100%; height: 365px; " src="<%= request.getContextPath()%>/cart/addmyprod.to"></iframe>    
			<a href="#none" class="close" onclick="$('div#wishlistlayer').hide();"><img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기"/></a>
		
		<div class="base-bottom">
		<span class="totalprice" style="font-size: 12pt;">총상품금액(수량):</span>&nbsp;<span style="font-size: 18pt;">원</span>
		<div class="bottom_base" style="margin-top:10px;">
	    <a href="#none" class="btn_order" onclick="optionsChange('바로구매하기',${cart.cart_pro_code},${cart.cart_pro_detail_code},${cart.cart_pro_price},${cart.cart_pro_quantity})">
		바로구매하기</a>
		<a href="#none" class="btn_movecart" onclick="optionsChange('변경',${cart.cart_pro_code},${cart.cart_pro_detail_code},${cart.cart_pro_price},${cart.cart_pro_quantity})">
	    	장바구니담기</a>
	    	</div>
    	</div>
		</div>
		<!-- 레이어 팝업 만들기  -->	


		<div class="useInfo"><h3 >이용안내</h3>
			<div class="inner" >
			        <h4 style="font-size: 11pt; padding-left: 12px; ">장바구니 이용안내</h4>
			        <ol>   
			            <li class="item1">ㆍ선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
			            <li class="item2">ㆍ[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
			            <li class="item3">ㆍ장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
			            <li class="item4">ㆍ파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</li>
			        </ol>
			<h4 style="font-size: 11pt; padding-left: 12px;">무이자할부 이용안내</h4>
			        <ol>
			<li class="item1">ㆍ상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.</li>
			            <li class="item2">ㆍ[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
			            <li class="item3">ㆍ단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
			            <li class="item4">ㆍ무이자할부 상품은 장바구니에서 별도 무이자할부 상품 영역에 표시되어, 무이자할부 상품 기준으로 배송비가 표시됩니다.<br/>&nbsp;&nbsp;&nbsp;실제 배송비는 함께 주문하는 상품에 따라 적용되오니 주문서 하단의 배송비 정보를 참고해주시기 바랍니다.</li>
			        </ol>
			</div>
		</div>

</div>

	

<jsp:include page="../footer.jsp"/>