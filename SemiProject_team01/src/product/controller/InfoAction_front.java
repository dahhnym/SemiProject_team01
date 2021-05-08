package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.InterProductDAO2;
import product.model.InterProductdetailDAO2;
import product.model.ProductDAO;
import product.model.ProductDAO2;
import product.model.ProductVO;
import product.model.ProductVO2;
import product.model.ProductdetailDAO2;

public class InfoAction_front extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.goBackURL(request);
		
		//카테고리 목록을 조회해오기
		super.getFaqCategoryList(request);
		
		String pnum = request.getParameter("pnum"); // 제품번호
		request.setAttribute("pnum", pnum);
		
		InterProductDAO pdao = new ProductDAO();
		InterProductDAO2 pdao2 = new ProductDAO2();
		
		InterProductdetailDAO2 pddao2 = new ProductdetailDAO2();
		
		// 제품번호로 해당 제품의 정보를 조회하기
		ProductVO2 pvo2 = pdao2.selectOneProductByCnum(pnum);
		
		// 제품번호를 가지고서 해당 제품의 추가된 이미지 정보를 조회해오기 
		List<String> imgList = pdao2.getImagesByPnum(pnum);
		
		// 제품 번호로 옵션 조회해오기
		List<HashMap<String,String>> optionList = pddao2.getOptionByPnum(pnum);
		
		
		String snum = "3";	// 세일상품
		String start = "1";
		String end = "18";
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("snum", snum);
		paraMap.put("start", start);
		paraMap.put("end", end);
		
		
		// 세일상품 이미지 슬라이드 출력을 위해 세일상품 select 해오기(snum = 
		List<ProductVO> productList = pdao.selectBESTonly(paraMap);
		request.setAttribute("productList", productList);
		
		
		
		if(pvo2 == null) {
			// GET 방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 제품번호를 입력한 경우
			String message = "검색하신 제품은 존재하지 않습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;	
		}
		else {
			// 제품이 있는 경우 
			request.setAttribute("pvo2", pvo2);         // 제품의 정보
			request.setAttribute("imgList", imgList); // 해당 제품의 추가된 이미지 정보
			request.setAttribute("optionList", optionList);

			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product/productInfo_front.jsp");
		}
		
		
		
		
		super.setViewPage("/WEB-INF/product/productInfo_front.jsp");
		
	}

}
