package login.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class ChangeIdleAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String method = request.getMethod();
 
		if("post".equalsIgnoreCase(method)) {	// 비 휴면상태로 만들기
			
			String userid = request.getParameter("real_id"); 
			
			InterMemberDAO dao = new MemberDAO();
			
			try {
				int n = dao.changeIdle(userid);	
				if(n==1) {				
					String message = userid+"님의 계정이 비 휴면처리 되었습니다.";
					String loc = request.getContextPath()+"/login/changePwd.to";  // 비밀번호 변경페이지로 이동
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");		
				} else {
					// super.setRedirect(false);
					super.setViewPage("/WEB-INF/login/login.jsp");	
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
		} else {	// get 방식으로 들어온 경우		
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/changeIdle.jsp");	
		}
			
	}
}
