<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp"/>


<link rel="stylesheet" href="<%=ctxPath%>/css/Ohdayoon.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<style>

	table#prodtable {
		border: solid 1px gray;
		border-collapse: collapse;	
		width: 80%;
		margin-left: 120px;
	}
	
	table#prodtable td{
		font-size: 12pt;
		padding-top: 20pt; 
		padding-bottom: 20pt;
	}
	
	   .error {color: red; font-weight: bold; font-size: 10pt; display: inline-block; margin-left: 10px;}
	  
	 input#btnRegister{
	 	display : inline-block; 
 		width: 100px;
	 	heiht: 50px;
	 	background-color: #000;
	 	color: #fff;
	 	border: 0px;
	 	font-size: 18pt;
	 
	 }
	 input#reset{
	 	display : inline-block; 
 		width: 100px;
	 	heiht: 50px;
	 	background-color: #fff;
	 	color: #000;
	 	border: solid 1px #000;
	 	font-size: 18pt;
	 
	 }
</style>


<script>

$(document).ready(function(){
	
	$("span.error").hide();
	
	
	// 카테고리 선택 유효성 검사
		$("select[name=fk_cnum]").change(function(){
			if($("select[name=fk_cnum]").val()==""){
				$(this).next().show();
				$(this).val("");	
			}
			else{
				$(this).next().hide();
			}
		});
		 
		// 제품명 유효성 검사
		$("input[name=pname]").blur(function(){
			if($(this).val().trim()==""){
				$(this).next().show();
				$(this).val("");
				
			}
			else{
				$(this).next().hide();
			}
		});
		
		// 제조사 유효성 검사
		$("input[name=pcompany]").blur(function(){
			if($(this).val().trim()==""){
				$(this).next().show();
				$(this).val("");
			}
			else{
				$(this).next().hide();
			}
		});

	
		
		// 제품 정가 유효성 검사
		$("input[name=price]").blur(function(){
						var price = $(this).val().trim();
						console.log(price);
						if(price="" || price==0 || isNaN(price)){
							$(this).next().show();
							$(this).val("");
						}
						else{
							$(this).next().hide();
						}
		});
		
		// 제품 판매가격 유효성 검사
		$("input[name=saleprice]").blur(function(){
			var saleprice = $(this).val().trim();
			if(saleprice="" || saleprice=="0" || isNaN(saleprice)){
				$(this).next().html();
				$(this).val("");
			}
			else{
				$(this).next().hide();
			}
		});
	
		// 제품 스펙 유효성 검사
		$("select[name=fk_snum]").change(function(){
			if($("select[name=fk_cnum]").val()==""){
			$(this).next().show();
			$(this).val("");
			}
			else{
				$(this).next().hide();
			}
		});
		
		
		// 대표이미지 유효성 검사
		var pimage1 = $("input[name=pimage1]");
		pimage1.on('change', function(){ 
			if(pimage1==""){
				$(this).next().show();
			}
		
			else{
				$(this).next().hide();
			}
		});	
			
		
		// 상세이미지 유효성 검사
	
		var pimage2 = $("input[name=pimage2]");
		pimage2.on('change', function(){ 
			if(pimage2==""){
				$(this).next().show();
			}
		
			else{
				$(this).next().hide();
			}
		});	
	
		
		// 옵션추가
		$('.multi-field-wrapper').each(function() {
		    var $wrapper = $('.multi-fields', this);
		    $(".add-field", $(this)).click(function(e) {
		        $('.multi-field:first-child', $wrapper).clone(true).appendTo($wrapper).find('input').val('').focus();
		    });
		    $('.multi-field .remove-field', $wrapper).click(function() {
		        if ($('.multi-field', $wrapper).length > 1)
		            $(this).parent('.multi-field').remove();
		    });
		});
       
		// 이미지 추가
		$('.btnAdd').click (function () {                                        
            $('.buttons').append (                        
                '<input type="file" name="attach"> <input type="button" class="btnRemove" value="Remove"><br>'                    
            ); // end append                            
            $('.btnRemove').on('click', function () { 
                $(this).prev().remove (); // remove the textbox
                $(this).next ().remove (); // remove the <br>
                $(this).remove (); // remove the button
            });
        }); // end click   
        
	$("input#btnRegister").click(function(){
		
		var cnt=0;
		$(".infoData").each(function(index,item){ // infoData 클래스를 가진 모든 태그를 유효성 검사 each로 반복문
			var val = $(item).val().trim();
		
			if(val==""){
				$(item).next().show(); //span태그인 error를 보여야한다.
				cnt++;
			}
			else{
				$(item).next().hide();
			}
		
		});
	
		if(cnt>0){
			return false;
		}				
		
		if(cnt==0){ //flag가 false라면 즉 필수입력사항을 입력했다면
		
			
			var frm = document.registerFrm;
			frm.action="<%= ctxPath%>/shop/admin/productRegister.to";
			frm.method="post";
			frm.enctype="multipart/form-data"
			frm.submit();
		}
	});
}); // end of $(document).ready(function(){}------------




</script>







<div class="container">

	<div class="contents" >
		
		<div style="text-align: center; margin-bottom: 100px">
			<h2>제품 등록</h2>
		</div>
	
		<form name="registerFrm">
		
			<table	id="prodtable">
				<tr>
					<td width="25%" style="text-align: center; font-weight: bold;"><span style="color: red;">*</span>카테고리</td>
					<td>
						<select name="fk_cnum" class="infoData">
							<option value="">선택하세요</option>
							<c:forEach var="map" items="${categoryList}">
								<option value="${map.cnum}">${map.cname}</option>
							</c:forEach>
						</select><span class="error">카테고리를 선택하세요.</span>
					</td>
				</tr>
				
				<tr>
					<td width="25%" style="text-align: center; font-weight: bold;"><span style="color: red;">*</span>제품명</td>
					<td><input type="text" class="infoData" name="pname"><span class="error">제품명을 입력하세요.</span></td>
				</tr>
				<tr> 
					<td width="25%" style="text-align: center; font-weight: bold;"><span style="color: red;">*</span>제조사</td>
					<td><input type="text" class="infoData" name="pcompany"><span class="error">제조사를 입력하세요.</span></td>
				</tr>
				<tr>
					<td width="25%" style="text-align: center; font-weight: bold;"><span style="color: red;">*</span>제품정가</td>
					<td><input type="text" class="infoData" name="price"><span class="error">제품 정가를 숫자로 입력하세요.</span></td>
				</tr>
				<tr>
					<td width="25%" style="text-align: center; font-weight: bold;"><span style="color: red;">*</span>제품판매가</td>
					<td><input type="text" class="infoData" name="saleprice"><span class="error">제품 판매가를 숫자로 입력하세요.</span></td>
				</tr>
				<tr>
					<td width="25%" style="text-align: center; font-weight: bold;"><span style="color: red;">*</span>제품스펙</td>
					<td>
						<select name="fk_snum" class="infoData">
							<option value="">선택하세요</option>
							<c:forEach var="spvo" items="${specList}">
								<option value="${spvo.snum}">${spvo.sname}</option>
							</c:forEach>
						</select>
						<span class="error">제품 스펙을 선택하세요.</span>
					</td>
				</tr>
				 <tr>
				      <td width="25%" style="text-align: center; font-weight: bold;"><span style="color: red;">*</span>제품이미지</td>
				      <td width="75%" align="left">
				         <input type="file" name="pimage1" class="infoData" /><span class="error">대표이미지를 선택하세요.</span><br>
				         <input type="file" name="pimage2" class="infoData" /><span class="error">상세이미지를 선택하세요.</span>
				      </td>
			    </tr>
			 	<tr>
				      <td width="25%" style="text-align: center; font-weight: bold;"><span style="color: red;">*</span>제품옵션</td>
				      <td width="75%" align="left" >
				      		<div class="multi-field-wrapper">
						      <div class="multi-fields">
						        <div class="multi-field">
						          <span>옵션</span><input type="text" name="optionname" class="optionname"><span class="error">옵션을 입력하세요.</span>
						          <span>수량</span><input type="text" name="pqty" class="pqty">
						          <span class="error">수량을 숫자로 입력하세요.</span>
						          <button type="button" class="remove-field">삭제</button>
						        </div>
						      </div>
						    <button type="button" class="add-field">추가</button>
						  </div>
				     
				      </td>
			    </tr>
				<tr>
				      <td width="25%" style="text-align: center; font-weight: bold;">제품설명</td>
				      <td width="75%" align="left">
				         <textarea name="pcontent" rows="5" cols="60"></textarea>
				      </td>
			    </tr>
			<%-- ==== 첨부파일 타입 추가하기 ==== --%>
			    <tr>
			          <td width="25%" style="text-align: center; font-weight: bold;" >추가이미지파일(선택)</td>
			          <td>
			              <div class="buttons">            
						        <input type="file" name="attach"> <input type="button" class="btnAdd" value="추가"><br>        
				        	</div>  
			          </td>
			    </tr>

				<tr style="height: 70px;">
				      <td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
				          <input type="button" value="제품등록" id="btnRegister"  /> 
				          &nbsp;
				          <input type="reset" value="취소" id="reset" style="width: 80px;" />   
				      </td>
			   </tr>
			
			
			</table>
		
		
		
	
		
		
		
		
		
		</form>
	
		</div>
	
	</div>








<jsp:include page="../footer.jsp"/>


