package member.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/memberRegister.jsp");
					
		if("post".equalsIgnoreCase(method)) {	// 회원가입 유효성 검사를 거친 후
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
			
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday); 
			
			InterMemberDAO dao = new MemberDAO();
			
			try {
				int n = dao.registerMember(member);
			
				if(n==1) {
					// 회원가입이 성공되면 로그인 되도록 하겠다.
					request.setAttribute("userid", userid);
					request.setAttribute("pwd", pwd);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/login/registerAfterAutoLogin.jsp");
					
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
				
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/error.up");
			}
			
		} else {	// 회원가입창 띄우기			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");	
		}
			
	}
	
}
