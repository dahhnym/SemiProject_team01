package order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;
import order.model.OrderDetailVO;
import order.model.OrderVO;

public class OrderListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser !=null) {
			String userid = loginuser.getUserid();
			InterOrderDAO odao = new OrderDAO();
			
			// 주문내역 리스트 가져오기 (select)
			List<OrderDetailVO> orderList = odao.orderList(userid);
			
			request.setAttribute("orderList", orderList);
			
			
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/orderList.jsp");
			 
		}
		
	}

}
