package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
public class OrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		//if(loginuser != null) {
		// 로그인이 되어 있을 경우
			
			String method=request.getMethod();
			if(!"POST".equalsIgnoreCase(method)) { // GET 이라면 
				
				// 장바구니 상품 목록을 조회해오기
			//	super.getCartList(request);				
				
				// 로그인한 사용자 정보를 조회해오기
			//	InterProductDAO pdao = new productDAO();
			//	List<ProdVO> specList = pdao.selectSpecList();
			//	request.setAttribute("specList", specList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/order/order.jsp");
			}
			else {
				String orderName = request.getParameter("orderName");
				String orderZip = request.getParameter("orderZip");
				String addr1 = request.getParameter("addr1");
				String addr2 = request.getParameter("addr2");
				String extraAddress = request.getParameter("extraAddress");
				String ordererHp1 = request.getParameter("ordererHp1");
				String ordererHp2 = request.getParameter("ordererHp2");
				String ordererHp3 = request.getParameter("ordererHp3");
				String orderEmail = request.getParameter("orderEmail");
				String shipName = request.getParameter("shipName");
				String shipZip = request.getParameter("shipZip");
				String addr3 = request.getParameter("addr3");
				String addr4 = request.getParameter("addr4");
				String extraAddress2 = request.getParameter("extraAddress2");
				String shipHp1 = request.getParameter("shipHp1");
				String shipHp2 = request.getParameter("shipHp2");
				String shipHp3 = request.getParameter("shipHp3");
				String shippingMsg = request.getParameter("shippingMsg");

						
				
			}
	//	}
		
		
		
	}

}
