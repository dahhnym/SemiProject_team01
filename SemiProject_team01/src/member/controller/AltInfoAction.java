package member.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class AltInfoAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd"); 
			String name = request.getParameter("name");
			
			String emailID = request.getParameter("emailID"); 
			String emailAddress = request.getParameter("emailAddress"); 
			String email = emailID+"@"+emailAddress;
			
			String mobile = "010"+request.getParameter("ph2"); 
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address"); 
			String detailaddress = request.getParameter("detailAddress"); 
			String extraaddress = request.getParameter("extraAddress"); 
			String gender = request.getParameter("gender"); 
			String birthday = request.getParameter("birthday"); 
					
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday); 			
			InterMemberDAO dao = new MemberDAO();
			
			try {
				
				int n = dao.altMemberInfo(member);
				MemberVO loginuser = dao.getLoginuser(member);

				if(n==1) {	// 수정성공
					HttpSession session = request.getSession();
					session.setAttribute("loginuser", loginuser);
					
					request.setAttribute("userid", userid);
					request.setAttribute("pwd", pwd);
					
					String message = userid+"님의 회원정보를 수정했습니다!";			// *이게 왜 안뜨지.. ==> 정정사항
					String loc = request.getContextPath()+"/member/altInfo.to";  // 수정된 창 띄우기
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");	// 팝업 띄우기			
				}
				else {
					String message = "수정 실패";
					String loc = "javascript:history.back()";  // 자바스크립트를 이용한 이전페이지로 이동하는 것.
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}				
			} catch(SQLException e) {
				e.printStackTrace();
			}
		} else {
			super.setRedirect(false);
		    super.setViewPage("/WEB-INF/member/altInfo.jsp");
		}

		
		// super.setRedirect(false);
	    super.setViewPage("/WEB-INF/member/altInfo.jsp");
	}

}
