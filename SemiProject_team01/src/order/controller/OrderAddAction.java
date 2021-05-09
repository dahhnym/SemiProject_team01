package order.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class OrderAddAction extends AbstractController {

	// 전표(주문코드)를 생성해주는 메소드 생성하기
		private int getOdrcode() throws SQLException{
			// 전표(주문코드) 형식 : 주문 테이블의 주문번호 기본 seq 가져옴
			
		      InterOrderDAO odao = new OrderDAO();
		      
		      int seq = odao.getSeq_tbl_order();
		      // pdao.getSeq_tbl_order(); 는 시퀀스 seq_tbl_order 값을 채번해오는 것.
		      
		      return seq;		
		} // end of private String getOdrcode() throws SQLException{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//***주문페이지에서 결제하기 눌렀을 때 보내주는 값들***//
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 주문자가 입력한 주문자정보, 배송지정보, 포인트 사용정보
		String odrname = request.getParameter("odrname");
		String odrmobile = request.getParameter("odrmobile");
		String odremail = request.getParameter("odremail");
		String odrpostcode = request.getParameter("odrpostcode");
		String odraddress = request.getParameter("odraddress");
		String odrdtaddress = request.getParameter("odrdtaddress");
		String odrextddress = request.getParameter("odrextddress");
		String payment = request.getParameter("fk_payment");
		String deliname = request.getParameter("deliname");
		String delimobile = request.getParameter("delimobile");
		String delipostcode = request.getParameter("delipostcode");
		String deliaddress = request.getParameter("deliaddress");
		String delidtaddress = request.getParameter("delidtaddress");
		String deliextddress = request.getParameter("deliextddress");
		String delimsg = request.getParameter("delimsg");
		String usePoint = request.getParameter("usePoint");
		String rvsPoint = request.getParameter("rvsPoint");
		String userid = request.getParameter("userid");
		
		// 주문할 제품 정보(string으로 묶여있음)
		String pnum = request.getParameter("pnum");
		String oqty = request.getParameter("oqty");
		String saleprice = request.getParameter("saleprice");
		String pdetailnum = request.getParameter("pdetailnum");
		String optionname = request.getParameter("optionname");
		String pname = request.getParameter("pname");
		String level = request.getParameter("level");
		
		// 주문할 제품 정보(,로 끊어서 배열에 담아주기)
		String[] pnumArr = pnum.split(",");
		String[] oqtyArr = oqty.split(",");
		String[] salepriceArr = saleprice.split(",");
		String[] pdetailnumArr = pdetailnum.split(",");
		String[] optionnameArr = optionname.split(",");
		String[] pnameArr = pname.split(",");
		
		// 주문 총 합계
		String sum = request.getParameter("sum"); // 상품가격총합
		String totalsum = request.getParameter("totalsum"); // 상품가격총합+배송비
		String delivery = request.getParameter("delivery"); // 배송비
		
		Map<String, Object> paraMap = new HashMap<String, Object>();
	
		paraMap.put("userid",userid);
		paraMap.put("odrname",odrname);
		paraMap.put("odrmobile",odrmobile);
		paraMap.put("odremail",odremail);
		paraMap.put("odrpostcode",odrpostcode);
		paraMap.put("odraddress",odraddress);
		paraMap.put("odrdtaddress",odrdtaddress);
		paraMap.put("odrextddress",odrextddress);
		paraMap.put("payment",payment);
		paraMap.put("deliname",deliname);
		paraMap.put("delimobile",delimobile);
		paraMap.put("delipostcode",delipostcode);
		paraMap.put("deliaddress",deliaddress);
		paraMap.put("delidtaddress",delidtaddress);
		paraMap.put("deliextddress",deliextddress);
		paraMap.put("delimsg",delimsg);
		paraMap.put("usePoint",usePoint);
		paraMap.put("rvsPoint",rvsPoint);
		
		paraMap.put("pnumArr", pnumArr);
		paraMap.put("oqtyArr", oqtyArr);
		paraMap.put("salepriceArr", salepriceArr);
		paraMap.put("pdetailnumArr", pdetailnumArr);
		paraMap.put("optionnameArr", optionnameArr);
		paraMap.put("pnameArr", pnameArr);
		
		paraMap.put("sum",sum);
		paraMap.put("totalsum",totalsum);
		paraMap.put("delivery",delivery);
		
		
		// 1. seq 주문코드 생성
		OrderDAO odao = new OrderDAO();
		int odrcode = getOdrcode();
		paraMap.put("odrcode",odrcode);
		
		// 2. 주문/주문상세테이블 insert		
		int isSuccess = odao.orderAdd(paraMap);
		JSONObject jsobj = new JSONObject();
		jsobj.put("isSuccess",isSuccess);
		// 성공하면 1 값, 실패하면 0 값
         String json = jsobj.toString();

		 System.out.println("json" + json);
		 request.setAttribute("json", json);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/orderInfo.jsp");
		
	}

	

}
