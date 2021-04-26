package Ohdayoon;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;


public class CartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
	//	HttpSession session = request.getSession();
	//	MemberVO loginuser=(MemberVO)session.getAttribute("loginuser");
	
	//	if(loginuser!=null ) {}
		super.setRedirect(false);
		super.setViewPage("WEB-INF/Ohdayoon/cart.jsp");
		
	}

}
