package cart.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import cart.model.*;
import common.controller.AbstractController;
import product.model.ProductDetailVO;

public class CartAction extends AbstractController {
// cartAction은 CartList를 보여줌!
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		

		super.setRedirect(false);
		super.setViewPage("/WEB-INF/cart/cart.jsp");
	
		String userid = request.getParameter("userid");
		
		InterCartDAO cdao = new CartDAO();
		
		// 장바구니 리스트 보여주기 (select)
		List<CartVO> cartList =  cdao.cartList();// 괄호에 userid넣어야함
	//	System.out.println("확인용"+cartList.size());
		request.setAttribute("cartList", cartList);
	
		// 위시리스트 보여주기 (select)
		List<WishListVO> wishList = cdao.wishList(); // 괄호에 userid넣어야함
		request.setAttribute("wishList", wishList);
	
		String fk_pnum = request.getParameter("fk_pnum");
		// 옵션리스트 보여주기(select)
	//	List<ProductDetailVO> optionList = cdao.optionList(fk_pnum);
		
		
		
	}

}
