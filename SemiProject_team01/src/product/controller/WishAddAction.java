package product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.CartDAO2;
import product.model.InterCartDAO2;
import product.model.InterWishDAO;
import product.model.WishDAO;

public class WishAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pnum = request.getParameter("pnum");
		
		String userid = request.getParameter("userid");
		
		InterWishDAO wdao = new WishDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pnum", pnum);
		
		int n = wdao.wishAdd(paraMap);
		// n => 1 이라면 정상등록 아니라면 등록실패
		
		String msg = "";
		
		if(n==1) {
			msg = "위시리스트 등록되었습니다.";
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("msg", msg);
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}
		
}


