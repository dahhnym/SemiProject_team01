package order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;
import order.model.OrderVO;
public class OrderInfoAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

        InterOrderDAO odao = new OrderDAO();
        
        // 주문정보 알아오기
       // List<OrderVO> orderInfo = odao.selectOrderInfo(loginuser.getUserid());
        
      //  request.setAttribute("orderInfo", orderInfo);
        
        super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/orderInfo.jsp");		
	}

}
