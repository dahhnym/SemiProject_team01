package login.controller;

import java.util.*;
import javax.servlet.http.*;
import common.controller.AbstractController;
import login.controller.GoogleMail;

public class SendRndPwdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			String email = request.getParameter("email");
			
			///////////////////////////////////////////////////////////////
			// 랜덤 인증번호(영문자, 숫자, 특수기호 10자리) 생성
			Random rnd = new Random();
			String rndPwd = "";	
			
			char randchar = ' ';
			for (int i=0; i<4; i++) {
				randchar = (char)(rnd.nextInt('z' - 'a' + 1) + 'a');
				rndPwd += randchar;				
			}			
			int randnum = 0;
			for (int i=0; i<4; i++) {
				randnum = rnd.nextInt(9 - 0 + 1) + 0;
				rndPwd += randnum;
			}
			randchar = ' ';
			for (int i=0; i<4; i++) {
				randchar = (char)(rnd.nextInt('+' - '!' + 1) + '!');
				rndPwd += randchar;				
			}
			//////////////////////////////////////////////////////////////
			
			boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도	
			
			GoogleMail mail = new GoogleMail();
			
			try {
				mail.sendmail(email, rndPwd);
			
				HttpSession session = request.getSession();
				session.setAttribute("rndPwd", rndPwd);
				
				sendMailSuccess=true;
			
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(sendMailSuccess) {
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/login/pwdFind.jsp");				
			} 			
		}// end of if("POST".equalsIgnoreCase(method)) ------------------------------------		
	
	}

}
