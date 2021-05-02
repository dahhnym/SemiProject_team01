package login.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class ChangePwdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {	// 비밀번호 변경하기를 누른 경우
			String newPwd = request.getParameter("newPwd"); 
			
			InterMemberDAO dao = new MemberDAO();
			/*
			try {
				int n = dao.changePwd(newPwd);	// 비밀번호 변경해서 DB 에 넣기
			
				
			} catch(SQLException e) {
				e.printStackTrace();
			}
			*/
		} else {	// 비정상적 경로로 들어온 경우		
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");	
		}
			
	}
		
}


