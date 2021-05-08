package order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class OrderAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		String odrname = request.getParameter("odrname");
		String odrmobile = request.getParameter("odrmobile");
		String odremail = request.getParameter("odremail");
		String odrpostcode = request.getParameter("odrpostcode");
		String odraddress = request.getParameter("odraddress");
		String odrdtaddress = request.getParameter("odrdtaddress");
		String odrextddress = request.getParameter("odrextddress");
		String fk_paymentno = request.getParameter("fk_paymentno");
		String deliname = request.getParameter("deliname");
		String delimobile = request.getParameter("delimobile");
		String delipostcode = request.getParameter("delipostcode");
		String deliaddress = request.getParameter("deliaddress");
		String delidtaddress = request.getParameter("delidtaddress");
		String deliextddress = request.getParameter("deliextddress");
		String delimsg = request.getParameter("delimsg");
		String usePoint = request.getParameter("usePoint");
		String rvsPoint = request.getParameter("rvsPoint");
		
		String pdetailnum = request.getParameter("pdetailnum");
		
		Map<String, Object> paraMap = new HashMap<String, Object>();

		

	//	paraMap.put("pdetailnum", pdetailnum); // 제품상세테이블 재고량 update
	
		paraMap.put("userid",loginuser.getUserid());
		paraMap.put("odrname",odrname);
		paraMap.put("odrmobile",odrmobile);
		paraMap.put("odremail",odremail);
		paraMap.put("odrpostcode",odrpostcode);
		paraMap.put("odraddress",odraddress);
		paraMap.put("odrdtaddress",odrdtaddress);
		paraMap.put("odrextddress",odrextddress);
		paraMap.put("fk_paymentno",fk_paymentno);
		paraMap.put("deliname",deliname);
		paraMap.put("delimobile",delimobile);
		paraMap.put("delipostcode",delipostcode);
		paraMap.put("deliaddress",deliaddress);
		paraMap.put("delidtaddress",delidtaddress);
		paraMap.put("deliextddress",deliextddress);
		paraMap.put("delimsg",delimsg);
		paraMap.put("usePoint",usePoint);
		paraMap.put("rvsPoint",rvsPoint);
		
		InterOrderDAO odao = new OrderDAO();
		
		
		// 주문코드 알아오기
		int odrcode = odao.getOdrcode(loginuser.getUserid());
		paraMap.put("odrcode", odrcode); // 주문테이블 insert 
		
		// 근데 만약에 개별 주문 하는 사람이면? null 값아닌데 삭제해버릴 수도 있잖아.
		// cartnum 알아오기 카트 삭제하기 위해서
		int cartnum = odao.getCartnum(loginuser.getUserid());
		paraMap.put("cartnum", cartnum); // 카트 delete 
		
		// 주문 테이블에 update
		int isSuccess = odao.orderAdd(paraMap);
		
		JSONObject jsobj = new JSONObject();
		jsobj.put("isSuccess", isSuccess); //성공되면 1값 넘겨줌
		
	}

	

}
