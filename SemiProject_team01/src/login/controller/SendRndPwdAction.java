package login.controller;

import java.util.*;
import javax.servlet.http.*;
import common.controller.AbstractController;

public class SendRndPwdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
			
			///////////////////////////////////////////////////////////////
			// 랜덤 임시비밀번호 (영문자, 숫자 10자리) 생성
			Random rnd = new Random();
			String rndPwd = "";	
			
			char randchar = ' ';
			for (int i=0; i<5; i++) {
				randchar = (char)(rnd.nextInt('z' - 'a' + 1) + 'a');
				rndPwd += randchar;				
			}			
			int randnum = 0;
			for (int i=0; i<5; i++) {
				randnum = rnd.nextInt(9 - 0 + 1) + 0;
				rndPwd += randnum;
			}			
			//////////////////////////////////////////////////////////////
			
			boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도	
			
			GoogleMail mail = new GoogleMail();
			
			try {
				mail.sendmail(email, rndPwd, userid);
			
				HttpSession session = request.getSession();
				session.setAttribute("rndPwd", rndPwd);
				
				sendMailSuccess=true;
			
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(sendMailSuccess) {
				System.out.println("보냄");
			//	super.setRedirect(false);
			//	super.setViewPage("/WEB-INF/login/rndChangePwd.jsp");				
			} 			
		}// end of if("POST".equalsIgnoreCase(method)) ------------------------------------		
	
	}

}
