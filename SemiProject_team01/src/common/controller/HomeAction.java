package common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class HomeAction extends AbstractController {
 
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
 
		// 홈에 이미지 슬라이드 출력
		String snum = "1";	// 신상품
		String start = "1";
		String end = "12";
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("snum", snum);
		paraMap.put("start", start);
		paraMap.put("end", end);

		InterProductDAO pdao = new ProductDAO();
		
		List<ProductVO> productList = pdao.selectBESTonly(paraMap);
		request.setAttribute("productList", productList);
		
		
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/home.jsp");
		
		
		
		
	}

}
