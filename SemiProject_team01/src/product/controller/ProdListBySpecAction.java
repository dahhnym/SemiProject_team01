package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ProdListBySpecAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.getCategoryList(request);
		
		String cnum = request.getParameter("cnum");
		String cname = request.getParameter("cname");
		String snum = request.getParameter("snum");
		
		// *** 카테고리번호에 해당하는 제품들을 페이징 처리하여 보여주기 *** //
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		InterProductDAO pdao = new ProductDAO();
		
		String sizePerPage = "12"; // 한 페이지당 화면상에 보여줄 제품의 개수는 12 으로 한다.
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("cnum", cnum);
		paraMap.put("cname", cname);
		paraMap.put("snum", snum);
		paraMap.put("sizePerPage", sizePerPage);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<ProductVO> productList = pdao.selectByBothSpecCateg(paraMap);
		request.setAttribute("productList", productList);
		
		int totalPage = pdao.getTotalPage(cnum);
		
		if(Integer.parseInt(currentShowPageNo)>totalPage) {
			currentShowPageNo="1";
			paraMap.put("currentShowPageNo", currentShowPageNo);
		}
		
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
        // pageNo - 1 == 11 -1 == 10 ==> currentShowPageNo
        
        if(pageNo != 1) {
        	pageBar += "&nbsp;<a class='pagebar-style' href='List.to?cnum="+cnum+"&currentShowPageNo=1'><i class='fas fa-angle-double-left' style='font-size:12px'></i></a>&nbsp;";
        	pageBar += "&nbsp;<a class='pagebar-style' href='List.to?cnum="+cnum+"&currentShowPageNo="+(pageNo-1)+"'><i class='fas fa-angle-left' style='font-size:12px'></i></a>&nbsp;";
        
        }
		
        
        while( !(loop > blockSize || pageNo > totalPage)){
        	
        	if( pageNo == Integer.parseInt(currentShowPageNo)) {
        		pageBar += "&nbsp;<span class='pagebar-style' style='font-weight: bold; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
        	} 
        	else {
        		pageBar += "&nbsp;<a class='pagebar-style' href='List.to?cnum="+cnum+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";
        	}
        	
        	loop++;
        	
        	pageNo++;
        
        }// end of while ----------------
     // *** [다음][마지막]만들기 ***
        // pageNo ==> 11
        
        if( !(pageNo > totalPage)) {
	        pageBar += "&nbsp;<a href='List.to?cnum="+cnum+"&currentShowPageNo="+pageNo+"'><i class='fas fa-angle-right' style='font-size:12px'></i></a>&nbsp;";
	        pageBar += "&nbsp;<a href='List.to?cnum="+cnum+"&currentShowPageNo="+totalPage+"'><i class='fas fa-angle-double-right' style='font-size:12px'></i></a>&nbsp;";
        }
		
        System.out.println(pageNo);
        System.out.println("확인용 currentShowPageNo "+currentShowPageNo);
        request.setAttribute("pageBar", pageBar);
        
        
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productListBySpec.jsp");
		
		
	}

}
