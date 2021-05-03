package login.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;


public class ChangePwdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		
		if("post".equalsIgnoreCase(method)) {	// 비밀번호 변경하기를 누른 경우
			
			String userid = request.getParameter("real_id"); 
			String newPwd = request.getParameter("newPwd"); 
			
			InterMemberDAO dao = new MemberDAO();
			
			try {
				int n = dao.changePwd(userid, newPwd);	// 비밀번호 변경해서 DB 에 넣기
				if(n==1) {
					System.out.println("비밀번호 변경성공!");
					
					// super.setRedirect(false);
					super.setViewPage("/WEB-INF/home.jsp");
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
		} else {	// 비정상적 경로로 들어온 경우		
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");	
		}
			
	}
		
}


