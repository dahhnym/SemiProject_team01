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

		// 로그인한 사용자 가져오기 위한 용도
        HttpSession session = request.getSession();

        InterOrderDAO odao = new OrderDAO();
        
        // 주문코드 알아오기
        int odrcode =Integer.parseInt(request.getParameter("odrcode"));
        System.out.println(odrcode);
        
        // 주문정보 알아오기
        OrderVO orderInfo = odao.selectOrderInfo(odrcode);
        request.setAttribute("orderInfo", orderInfo);
        
        // 주문내역 리스트 가져오기
        List<OrderDetailVO> orderList = odao.orderList(odrcode);
        request.setAttribute("orderList", orderList);

        
        super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/orderInfo.jsp");		
	}

}
