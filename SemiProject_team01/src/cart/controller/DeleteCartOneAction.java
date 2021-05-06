package cart.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;

public class DeleteCartOneAction extends AbstractController {

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
		
			String cartnum = request.getParameter("cartnum");
			
			String userid = request.getParameter("userid");
			InterCartDAO cdao = new CartDAO();
			
			int n = 0;
			
			try {
				n=cdao.deleteCartOne(userid, cartnum);
			}catch(SQLException e) {
				e.printStackTrace();
			}
			
			
			String msg = "";
		      
		      if(n==1) {
		         msg = "해당 제품을 장바구니에서 삭제하였습니다.";
		      }
		      else {
		         msg = "상품 삭제를 실패했습니다.";
		      }
			
		      JSONObject jsonObj = new JSONObject();
		      jsonObj.put("msg", msg);
		      
		      String json = jsonObj.toString(); 
			
		      request.setAttribute("json", json);
		      
		      super.setRedirect(false);
		      super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}
}
