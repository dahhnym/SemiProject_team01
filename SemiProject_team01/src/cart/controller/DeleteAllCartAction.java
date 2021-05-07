package cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;

public class DeleteAllCartAction extends AbstractController {

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
			
			
			InterCartDAO cdao = new CartDAO();
			
			// 옵션 추가하기 
			int n = cdao.deleteAllCart(userid);
	
		      JSONObject jsonObj = new JSONObject();
		      
		      String json = jsonObj.toString(); 
			
		      request.setAttribute("json", json);
		      
		      super.setRedirect(false);
		      super.setViewPage("/WEB-INF/jsonview.jsp");
			
			
			}
		
	}

}
