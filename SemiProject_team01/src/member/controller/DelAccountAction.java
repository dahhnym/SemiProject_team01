package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;


public class DelAccountAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		HttpSession session = request.getSession();
		
		if("post".equalsIgnoreCase(method)) {
			String userid = request.getParameter("userid");
			System.out.println(userid);
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.delAccount(userid);
			if(n==1) {
				session.setAttribute("loginuser", "");

			//  super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/delAccount.jsp");
			} else {
			//  super.setRedirect(false);
			//	super.setViewPage("/WEB-INF/home.jsp");
						
			}
		} else {
		//  super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/delAccount.jsp");
		}
		
	}

}
