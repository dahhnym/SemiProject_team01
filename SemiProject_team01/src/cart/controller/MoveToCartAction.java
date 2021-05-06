package cart.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;

public class MoveToCartAction extends AbstractController {

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
		  String wnum = request.getParameter("wnum");
		  String fk_pnum = request.getParameter("fk_pnum");
		  String fk_pdetailnum = request.getParameter("fk_pdetailnum");


		  
		  Map<String,String> paraMap = new HashMap<>();
		  paraMap.put("userid", userid);
		  paraMap.put("wnum",wnum);
		  paraMap.put("fk_pnum",fk_pnum);
		  paraMap.put("fk_pdetailnum",fk_pdetailnum);

		  
		  InterCartDAO cdao = new CartDAO();
		  
		  int n=0;
		// 해당 상품을 위시리스트에 삭제(delete)하고 장바구니에 추가(insert)
		  try {
			  n = cdao.deleteWishAddCart(paraMap);

		  }catch (Exception e) {
			e.printStackTrace();
		}
		
		
	      JSONObject jsonObj = new JSONObject();
		  jsonObj.put("n", n);
			
			String json = jsonObj.toString(); // {"n":1} 또는 {"n":0}
		
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}  
		
	}

}
