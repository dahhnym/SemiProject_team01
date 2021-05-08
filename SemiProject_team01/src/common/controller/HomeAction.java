package common.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class HomeAction extends AbstractController {
 
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
 
		int snum = 1;	// 신상품

		InterProductDAO pdao = new ProductDAO();
		
		List<ProductVO> productList = pdao.selectBESTonly(snum);
		
		request.setAttribute("productList", productList);
		
		
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/home.jsp");
		
		
		
		
	}

}
