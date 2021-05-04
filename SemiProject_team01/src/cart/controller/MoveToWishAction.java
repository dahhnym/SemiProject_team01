package cart.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;

public class MoveToWishAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

				  
		  String userid = request.getParameter("userid");
		  String cartnum = request.getParameter("cartnum");
		  String fk_pnum = request.getParameter("fk_pnum");
		  String fk_pdetailnum = request.getParameter("fk_pdetailnum");

		  
		  System.out.println(fk_pnum);
		  
		  Map<String,String> paraMap = new HashMap<>();
		  paraMap.put("userid", userid);
		  paraMap.put("cartnum",cartnum);
		  paraMap.put("fk_pnum",fk_pnum);
		  paraMap.put("fk_pdetailnum",fk_pdetailnum);

		  
		  InterCartDAO cdao = new CartDAO();
		  
		  int n=0;
		// 해당 상품을 장바구니에 삭제(delete)하고 위시리스트에 추가(insert)
		  try {
			  n = cdao.deleteCartAddWish(paraMap);
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
