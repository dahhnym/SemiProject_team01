package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// ***** 제품목록(Category)을 보여줄 메소드 생성하기 ***** //
		super.getCategoryList(request);
		
		InterProductDAO pdao = new ProductDAO();
		
		int totalHitCount = pdao.totalPspecCount("1");
		
		request.setAttribute("totalListCount", totalHitCount);
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productList.jsp");
		
	}

}
