package product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.CartDAO2;
import product.model.InterCartDAO2;
import product.model.InterProductdetailDAO2;
import product.model.ProductdetailDAO2;

public class CartAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pnum = request.getParameter("pnum");
		
		String userid = request.getParameter("userid");
		
		InterCartDAO2 cdao2 = new CartDAO2();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pnum", pnum);
		
		int n = cdao2.cartAdd(paraMap);
		// n => 1 이라면 정상등록 아니라면 등록실패
		
		String msg = "";
		
		if(n==1) {
			msg = "장바구니 등록되었습니다.";
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("msg", msg);
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
