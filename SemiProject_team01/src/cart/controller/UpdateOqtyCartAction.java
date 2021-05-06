package cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;

public class UpdateOqtyCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			
	         
	         String message = "비정상적인 경로를 통해 들어왔습니다.!!";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
		
		}
		
		else {
			String userid = request.getParameter("userid");
			String cartnum = request.getParameter("cartnum");
			String oqty = request.getParameter("oqty");
			String fk_pdetailnum= request.getParameter("fk_pdetailnum");
			InterCartDAO cdao = new CartDAO();
			
			// 수량 변경하기
			int n = cdao.updateOqty(userid, cartnum, oqty,fk_pdetailnum);
      
		      JSONObject jsobj = new JSONObject();
				
				jsobj.put("n", n);
				 
				String json = jsobj.toString(); // 문자열 형태로 변환해줌
				 
				request.setAttribute("json", json);
			
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
			
			
		}
	}
}
