package cart.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.ProductDetailVO;

public class CartAction extends AbstractController {
// cartAction은 CartList를 보여줌!
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		

		if(loginuser !=null) {
			String userid = loginuser.getUserid();
			InterCartDAO cdao = new CartDAO();
			
			// 장바구니 리스트 보여주기 (select)
			List<CartVO> cartList =  cdao.cartList(userid);// 괄호에 userid넣어야함
		//	System.out.println("확인용"+cartList.size());
			request.setAttribute("cartList", cartList);
		
			// 위시리스트 보여주기 (select)
			List<WishListVO> wishList = cdao.wishList(userid); // 괄호에 userid넣어야함
			request.setAttribute("wishList", wishList);
		
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/cart/cart.jsp");
		
		}
		
		else{
			String message = "로그인 하세요";
			String loc = request.getContextPath()+"/login/login.to";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
	}
}
