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
public class OrderInfoAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

        InterOrderDAO odao = new OrderDAO();
        
        // 주문코드 알아오기
        int odrcode =Integer.parseInt(request.getParameter("odrcode"));
        
        // 주문정보 알아오기
        
        OrderVO orderInfo = odao.selectOrderInfo(odrcode);
        
        request.setAttribute("orderInfo", orderInfo);
        
        
        // 주문내역 리스트 가져오기
		String userid = loginuser.getUserid();

        List<OrderDetailVO> orderList = odao.orderList(userid);
        request.setAttribute("orderList", orderList);

        
        super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/orderInfo.jsp");		
	}

}
