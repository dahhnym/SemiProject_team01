package login.controller;

import java.util.*;
import javax.servlet.http.*;
import org.json.JSONObject;
import common.controller.AbstractController;
import member.model.*;


public class PwdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		///////////////////////////////////////////////////////////////
		// 랜덤 비밀번호(영문자, 숫자, 특수문자 10자리) 생성
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
		char randspecial = ' ';
		for (int i=0; i<2; i++) {
			randspecial = (char)(rnd.nextInt('&' - '!' + 1) + '!');
			rndPwd += randspecial;				
		}
		//////////////////////////////////////////////////////////////
		
		
		if("post".equalsIgnoreCase(method)) {	// POST		
			
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("name", name);
			paraMap.put("userid", userid);
			paraMap.put("email", email);
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.checkAccount(paraMap);	// 회원계정 존재여부 확인하기
			
			if(n==1) {	// 회원계정이 있다면			
				boolean bool = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도	
				
				GoogleMail mail = new GoogleMail();
				
				try {
					n = mdao.saveRndPwd(rndPwd, userid);	// 임시비밀번호 저장하기				
					mail.sendmail(email, rndPwd);	// 메일전송하기					
					bool=true;	
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("bool", bool);
				
				String json = jsonObj.toString();
				request.setAttribute("json", json);
				
				//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");			
				
				} // end of if(n==1) -----------------------------------------
			
			} else { // GET 
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/login/pwdFind.jsp");				
			}
			
	}
}
