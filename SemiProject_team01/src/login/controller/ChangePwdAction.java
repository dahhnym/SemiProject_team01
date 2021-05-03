package login.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;


public class ChangePwdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String method = request.getMethod();
		
		
		if("post".equalsIgnoreCase(method)) {	// 비밀번호 변경하기를 누른 경우
			
			String userid = request.getParameter("real_id"); 
			String newPwd = request.getParameter("newPwd"); 
			
			InterMemberDAO dao = new MemberDAO();
			
			try {
				int n = dao.changePwd(userid, newPwd);	// 비밀번호 변경해서 DB 에 넣기
				if(n==1) {		
					
					String message = userid+"님의 비밀번호가 변경되었습니다!";
					String loc = request.getContextPath()+"/home.to";  // 로그인된 상태로 홈으로 이동
					
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
			super.setViewPage("/WEB-INF/login/changePwd.jsp");	
		}
			
	}
		
}


