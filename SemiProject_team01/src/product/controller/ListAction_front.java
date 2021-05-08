package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ListAction_front extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		String cnum = request.getParameter("cnum");
		String cname = request.getParameter("cname");
		String pnum = request.getParameter("pnum");
		
		// *** 카테고리번호에 해당하는 제품들을 페이징 처리하여 보여주기 *** //
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		// 한 페이지당 화면상에 보여줄 제품의 개수는 12로 한다. sizePerPage 는 ProductDAO 에서 상수로 설정해 두었음.
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자 아닌 문자를 입력한 경우 또는 
	    // int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		InterProductDAO pdao = new ProductDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("cnum", cnum);
		paraMap.put("cname", cname);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<ProductVO> productList = pdao.selectCateonly(paraMap);
		request.setAttribute("productList", productList);
		
		int totalPage = pdao.getTotalPage(cnum);
		
		String pageBar = "";
		
		int blockSize = 5;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1;
		// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
		
		int pageNo = 0;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		
		// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! // 
        pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
        
        // *** [맨처음][이전]만들기 ***
        
        if(pageNo != 1) {
        	pageBar += "&nbsp;<a href='List.to?cnum="+cnum+"&currentShowPageNo=1'>[맨처음]</a>&nbsp;";
        	pageBar += "&nbsp;<a href='List.to?cnum="+cnum+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a>&nbsp;";
        
        }
		
        pageBar += "&nbsp;<a class='pagebar-style' href='List.to?cnum="+cnum+"&currentShowPageNo="+totalPage+">[마지막]</a>&nbsp;";
        
        
        while( !(loop > blockSize || pageNo > totalPage)){
        	
        	if( pageNo == Integer.parseInt(currentShowPageNo)) {
        		pageBar += "&nbsp;<span class='pagebar-style' style='font-weight: bold; padding: 2px 4px;'>"+pageNo+"<span>&nbsp;";
        	} else {
        		pageBar += "&nbsp;<a class='pagebar-style' href='List.to?'cnum="+cnum+"&currentShowPageNo="+pageNo+">"+pageNo+"</a>&nbsp;";
        	}
        	
        	loop++;
        	
        	pageNo++;
        
        }// end of while ----------------
     // *** [다음][마지막]만들기 ***
        // pageNo ==> 11
        
        if( !(pageNo > totalPage)) {
	        pageBar += "&nbsp;<a href='List.to?cnum="+cnum+"&currentShowPageNo="+pageNo+">[다음]</a>&nbsp;";
	        pageBar += "&nbsp;<a href='List.to?cnum="+cnum+"&currentShowPageNo="+totalPage+">[마지막]</a>&nbsp;";
        }
		
        System.out.println(pageNo);
        System.out.println("확인용 currentShowPageNo "+currentShowPageNo);
        request.setAttribute("pageBar", pageBar);
        
        
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productList_front.jsp");
		
	}

}
