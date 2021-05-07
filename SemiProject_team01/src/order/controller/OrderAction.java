package order.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.*;

public class OrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();

		// 로그인한 사용자 정보를 조회해오기
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		if(loginuser !=null) {
			
	       InterOrderDAO odao = new OrderDAO();
	       InterCartDAO cdao = new CartDAO();
	       
	       	 List<CartVO> cartList =  cdao.cartList(loginuser.getUserid());
	         
	         // 로그인한 사용자의 장바구니에 담긴 주문총액합계 및 총포인트합계 알아오기 
	         HashMap<String,String> sumMap = odao.selectCartSum(loginuser.getUserid());
	         
	         request.setAttribute("cartList", cartList);
	         request.setAttribute("sumMap", sumMap);
	         
	         super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/order.jsp");
		}
		else{
			String message = "로그인을 해야 이용 가능한 페이지입 니다.";
			String loc = request.getContextPath()+"/login/login.to";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}

