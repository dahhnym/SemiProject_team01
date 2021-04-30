package login.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.*;
import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.*;


public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("get".equalsIgnoreCase(method)) {	// 로그인 하고자 하는 경우
		 // super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");
			
		} else {	// 로그인하기 버튼을 누른 경우, post 방식
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd"); 
			String clientip = request.getRemoteAddr();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			paraMap.put("clientip", clientip);
						
			InterMemberDAO dao = new MemberDAO();
			
			try {
				MemberVO loginuser = dao.loginConfirm(paraMap);
				
				HttpSession session = request.getSession();
				session.setAttribute("loginuser", loginuser);
			
				if(loginuser!=null) {	// 로그인 성공	
					
					if("1".equals(loginuser.getIdle())) {	// 휴면상태의 회원이라면
					//	super.setRedirect(false);
						super.setViewPage("/WEB-INF/changeIdle.jsp");	
						
					} else if(loginuser.getPwdCycleMonth()>=6) {	// 비밀번호가 변경된지 6개월 이상됐다면
					//	super.setRedirect(false);
						super.setViewPage("/WEB-INF/changePwd.jsp");
					} else {						
						String message = "로그인 성공";
						String loc = "javascript:history.back(-2)";  // 로그인 페이지 전으로 다시 이동
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
					//	super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
					}
				}
				
				else {	// 로그인 실패
					String message = "로그인 실패";
					String loc = "javascript:history.back()";  // 로그인 페이지로 다시 이동
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
			} catch(SQLException e) {
				e.printStackTrace();
			}
	
		}
		
	}

}
