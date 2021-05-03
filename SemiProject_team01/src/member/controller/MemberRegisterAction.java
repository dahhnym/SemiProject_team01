package member.controller;

import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.*;


import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/*
		 * HttpSession session = request.getSession(); session.setAttribute("userid",
		 * request.getParameter("userid")); // 세션 아이디 저장
		 */
				
		String method = request.getMethod();
					
		if("post".equalsIgnoreCase(method)) {	// 회원가입 폼 DB 에 넣기
			String clientip = request.getRemoteAddr();
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd"); 
			String name = request.getParameter("name");
			
			String emailID = request.getParameter("emailID"); 
			String emailAddress = request.getParameter("emailAddress"); 
			String email = emailID+"@"+emailAddress;
			
			String mobile = "010"+request.getParameter("hp2"); 
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address"); 
			String detailaddress = request.getParameter("detailAddress"); 
			String extraaddress = request.getParameter("extraAddress"); 
			String gender = request.getParameter("gender"); 
			String birthday = request.getParameter("birthday"); 
			String adagreements = request.getParameter("checkedAgreements3"); 
			
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday, adagreements); 
			
			InterMemberDAO dao = new MemberDAO();
			
			try {
				int n = dao.registerMember(member, clientip);
			
				if(n==1) {	// 회원가입 성공
					request.setAttribute("userid", userid);
					request.setAttribute("pwd", pwd);
					
					String message = userid+"님 ladies and gents 에 가입을 환영합니다!";
					String loc = request.getContextPath()+"/home.to";  // 로그인된 상태로 홈으로 이동
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");	// 팝업 띄우기			
				}
				else {
					String message = "회원가입 실패";
					String loc = "javascript:history.back()";  // 자바스크립트를 이용한 이전페이지로 이동하는 것.
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}				
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
		} else {	// 회원가입창 띄우기			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");	
		}
			
	}
	
}
