package order.controller;

import java.util.List;

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
		
		if(loginuser != null) {
		// 로그인이 되어 있을 경우
			
			String method=request.getMethod();
			if(!"POST".equalsIgnoreCase(method)) { // GET 이라면 
				
				// 장바구니 상품 목록을 조회해오기
			//	super.getCategoryList(request);
				
				// 로그인한 사용자 정보를 조회해오기
			//	InterProductDAO pdao = new productDAO();
			//	List<ProdVO> specList = pdao.selectSpecList();
			//	request.setAttribute("specList", specList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/order/order.jsp");
			}
		}
		
		
		
	}

}
