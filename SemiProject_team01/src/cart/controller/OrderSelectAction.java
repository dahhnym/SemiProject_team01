package cart.controller;

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

public class OrderSelectAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
		 
			HttpSession session =  request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			String userid = loginuser.getUserid();
			
	
		String pnum_es = request.getParameter("pnum_es");
		String oqty_es = request.getParameter("oqty_es");
		String pdetailnum_es = request.getParameter("pdetailnum_es");
		String totalPrice_es = request.getParameter("totalPrice_es");
		String sumtotalPrice = request.getParameter("sumtotalPrice");
		String optionname_es = request.getParameter("optionname_es");
	
	
		JSONObject jsobj = new JSONObject();
		String json = "";
		
		if(pnum_es !=null && 
		   oqty_es!=null && 
		   pdetailnum_es!=null &&
		   totalPrice_es!=null && 
		   sumtotalPrice !=null &&
		   optionname_es !=null) {
			// 장바구니에서 주문하기를 한 경우
		   

			String[] pnumArr = pnum_es.split(",");
			String[] oqtyArr = oqty_es.split(",");
			String[] pdetailnumArr = pdetailnum_es.split(",");
			String[] totalPriceArr = totalPrice_es.split(",");
			String[] optionnameArr = optionname_es.split(",");
		
		
			for(int i=0;i<pnumArr.length;i++) {
				System.out.println("~~~~ 확인용 pnum: " + pnumArr[i] + ", oqty: " + oqtyArr[i] + ", totalPrice: " + totalPriceArr[i]);
			}// end of for-------------------------------
			
			
			InterCartDAO cdao = new CartDAO();
			
			int odrnum = cdao.getSeq_tbl_order();
			String odrcode = Integer.toString(odrnum);
			Map<String,Object> paraMap = new HashMap<>(); 
			// Object: string, string[] 을 모두 받을 수 있다.
			
			
			// 주문테이블에 insert
			// 전표(주문코드)를 생성 해주는 체번을 해주는 메소드 호출하기
			
	
			paraMap.put("odrcode",odrcode);					
			paraMap.put("sumtotalPrice", sumtotalPrice); // 주문 총액
			paraMap.put("userid", userid);
			
			// 주문 상세 테이블에 insert
			paraMap.put("pnumArr", pnumArr);
			paraMap.put("oqtyArr", oqtyArr);
			paraMap.put("totalPriceArr", totalPriceArr);
			paraMap.put("pdetailnumArr",pdetailnumArr);
			paraMap.put("optionnameArr",optionnameArr);
			
	
			int isSuccess = cdao.orderAdd(paraMap);// Transcation 처리를 해주는 메소드 호출
			
			System.out.println(isSuccess);
			
			jsobj.put("isSuccess", isSuccess);
			// 성공되어지면 1
	
		json = jsobj.toString();
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
		}
		}
	}

}
