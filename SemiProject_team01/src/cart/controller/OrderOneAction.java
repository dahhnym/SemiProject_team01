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

public class OrderOneAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			HttpSession session =  request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			String userid = loginuser.getUserid();
			
		
			String pnum = request.getParameter("pnum");
			String oqty = request.getParameter("oqty");
			String pdetailnum = request.getParameter("pdetailnum");
			String totalPrice = request.getParameter("totalPrice");
			String optionname = request.getParameter("optionname");
		
			
			System.out.println(pnum);
			System.out.println(oqty);
			System.out.println(pdetailnum);
			System.out.println(totalPrice);
			System.out.println(optionname);
			
		
			JSONObject jsobj = new JSONObject();
			String json = "";
			
			if(pnum!=null && 
			   oqty!=null && 
			   pdetailnum!=null &&
			   totalPrice!=null && 
			   optionname !=null) {
				// 장바구니에서 주문하기를 한 경우
			   

				InterCartDAO cdao = new CartDAO();
				
				int odrnum = cdao.getSeq_tbl_order();
				String odrcode = Integer.toString(odrnum);
				System.out.println(odrcode);
				
				Map<String,String> paraMap = new HashMap<>(); 
				// Object: string, string[] 을 모두 받을 수 있다.
				
				
				// 주문테이블에 insert
				// 전표(주문코드)를 생성 해주는 체번을 해주는 메소드 호출하기
				
		
				paraMap.put("odrcode",odrcode);					
				paraMap.put("userid", userid);
				
				// 주문 상세 테이블에 insert
				paraMap.put("pnum", pnum);
				paraMap.put("oqty", oqty);
				paraMap.put("totalPrice", totalPrice);
				paraMap.put("pdetailnum",pdetailnum);
				paraMap.put("optionname",optionname);
				
		
				int isSuccess = cdao.orderOneAdd(paraMap);// Transcation 처리를 해주는 메소드 호출
				
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
