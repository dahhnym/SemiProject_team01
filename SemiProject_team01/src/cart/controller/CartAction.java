package cart.controller;


import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;


public class CartAction extends AbstractController {
// cartAction은 CartList를 보여줌!
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		

		if(loginuser !=null && !loginuser.getUserid().equals("admin")) {
			
			String userid = loginuser.getUserid();
			
			InterCartDAO cdao = new CartDAO();
			
			// 장바구니 리스트 보여주기 (select)
			List<CartVO> cartList =  cdao.cartList(userid);// 괄호에 userid넣어야함
		//	System.out.println("확인용"+cartList.size());
			request.setAttribute("cartList", cartList);
		
			// 위시리스트 보여주기 (select)
			List<WishListVO> wishList = cdao.wishList(userid); // 괄호에 userid넣어야함
			request.setAttribute("wishList", wishList);
		
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			String sizePerPage = "5";
		
			if(currentShowPageNo == null ) {
					currentShowPageNo="1";
			}

		
			try {
				Integer.parseInt(currentShowPageNo);
			}catch (NumberFormatException e) {
				currentShowPageNo="1";
			}


			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			paraMap.put("userid", userid);
			
			// 페이징처리를 위해서 회원의 위시리스트 총페이지 개수 알아오기(select)  
			int totalPage = cdao.selectTotalPage(paraMap);
	
			if(Integer.parseInt(currentShowPageNo)>totalPage) {
				currentShowPageNo="1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
			
			
			List<WishListVO> wishPageList = cdao.selectPagingMember(paraMap);
			
			request.setAttribute("wishPageList", wishPageList);
			request.setAttribute("sizePerPage", sizePerPage);

			String pageBar = "" ;
			
			int blockSize = 5;
			
			int loop=1;
		
			int pageNo = 0;
			  
			pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1 ;
			
			if(pageNo!=1) { 
				pageBar += "&nbsp;<a href='cart.to?currentShowPageNo=1'><i class='fas fa-angle-double-left' style='font-size:12px'></i></a>&nbsp;";
				pageBar += "&nbsp;<a href='cart.to?currentShowPageNo="+(pageNo-1)+"'><i class='fas fa-angle-left' style='font-size:12px'></i></a>&nbsp;";
			}
			
			while(!(loop > blockSize || pageNo>totalPage)) {
				
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "&nbsp;<span style='font-weight: bold;'>"+pageNo+"</span>&nbsp;"; 
				}
				else {
					pageBar += "&nbsp;<a href='cart.to?currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;"; 
				}
				loop++;
				
				pageNo++; 
			} // end of while-----------------------
			
			if( pageNo<=totalPage) {
				pageBar += "&nbsp;<a href='cart.to?currentShowPageNo="+pageNo+"'><i class='fas fa-angle-right' style='font-size:12px'></i></a>&nbsp;";
				pageBar += "&nbsp;<a href='cart.to?currentShowPageNo="+totalPage+"'><i class='fas fa-angle-double-right' style='font-size:12px'></i></a>&nbsp;";
			}
			
			request.setAttribute("pageBar", pageBar);
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/cart/cart.jsp");
		
		}
		
		else if(loginuser != null && loginuser.getUserid().equals("admin")){
			
			String message = "관리자는 이용할 수 없는 페이지입니다.";
			String loc = request.getContextPath()+"/login/login.to";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}
		else  {
			String message = "로그인 후 이용 가능합니다.";
			String loc = request.getContextPath()+"/login/login.to";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
	}
}
