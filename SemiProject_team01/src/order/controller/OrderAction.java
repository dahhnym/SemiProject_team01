package order.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.*;

public class OrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();

		// 로그인한 사용자 정보를 조회해오기
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
		if(loginuser !=null) {
			// 주문페이지로 넘어오는 값들 order 뷰단으로 넘겨주기
			String pnum = request.getParameter("pnum");
			String oqty = request.getParameter("oqty");
			String saleprice = request.getParameter("saleprice");
			String pdetailnum = request.getParameter("pdetailnum");
			String optionname = request.getParameter("optionname");
			String pname = request.getParameter("pname");
			String pimage = request.getParameter("pimage");

			request.setAttribute("pnum", pnum);
			request.setAttribute("oqty", oqty);
			request.setAttribute("saleprice", saleprice);
			request.setAttribute("pdetailnum", pdetailnum);
			request.setAttribute("optionname", optionname);
			request.setAttribute("pname", pname);
			request.setAttribute("pimage", pimage);
						 
	        super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/order.jsp");
		}
		
		else{
			String message = "로그인을 해야 이용 가능한 페이지입 니다.";
			String loc = request.getContextPath()+"/login/login.to";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}

