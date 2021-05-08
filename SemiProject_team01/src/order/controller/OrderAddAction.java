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
			// 전표(주문코드) 형식 : s+날짜+sequence  s20210504-1
			
		      InterOrderDAO odao = new OrderDAO();
		      
		      int seq = odao.getSeq_tbl_order();
		      // pdao.getSeq_tbl_order(); 는 시퀀스 seq_tbl_order 값을 채번해오는 것.
		      
		      return seq;		
		} // end of private String getOdrcode() throws SQLException{

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
		
		String pnum = request.getParameter("pnum");
		System.out.println("ㅎㅎ"+pnum);
		String oqty = request.getParameter("oqty");
		String saleprice = request.getParameter("saleprice");
		String pdetailnum = request.getParameter("pdetailnum");
		String optionname = request.getParameter("optionname");
		String pname = request.getParameter("pname");
		String level = request.getParameter("level");
		
		String[] pnumArr = pnum.split(",");
		String[] oqtyArr = oqty.split(",");
		String[] salepriceArr = saleprice.split(",");
		String[] pdetailnumArr = pdetailnum.split(",");
		String[] optionnameArr = optionname.split(",");
		String[] pnameArr = pname.split(",");
		
		String sum = request.getParameter("sum");
		System.out.println("sum" + sum);
		String totalsum = request.getParameter("totalsum");
		String delivery = request.getParameter("delivery");
		
		Map<String, Object> paraMap = new HashMap<String, Object>();

		

	//	paraMap.put("pdetailnum", pdetailnum); // 제품상세테이블 재고량 update
	
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
         String json = jsobj.toString();

		 System.out.println("json" + json);
		 request.setAttribute("json", json);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/orderInfo.jsp");
		
	}

	

}
