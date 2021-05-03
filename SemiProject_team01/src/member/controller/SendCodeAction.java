package member.controller;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import net.nurigo.java_sdk.api.Message;

public class SendCodeAction extends AbstractController {

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
		String api_key = "NCSQQMN335PG2H0S";	// 오다윤
		String api_secret = "JW2ABIXCHSC2RJENROP6BH4N3IBDGEFF";	  // 오다윤
		
		Message sms = new Message(api_key, api_secret);
		
		//////////////////////////////////////////////////////////////////////////
		// 모바일 인증번호 만들기
		// 인증키는 영문소문자 3글자 + 숫자 3글자 로 만들겠습니다.
		Random rnd = new Random();
		String certificationCode = "";
		
		char randchar = ' ';
		for (int i=0; i<3; i++) {  
		randchar = (char)(rnd.nextInt('z' - 'a' + 1) + 'a');
		certificationCode += randchar;
		
		}// end of for (int i=0; i<5; i++) --------------------
		
		int randnum = 0;
		for (int i=0; i<3; i++) {
		randnum = rnd.nextInt(9 - 0 + 1) + 0;
		certificationCode += randnum;
		}

		
		HttpSession session = request.getSession();
		session.setAttribute("certificationCode", certificationCode);
	    
		
		///////////////////////////////////////////////////////////////////////////
		
		String mobile = "010"+request.getParameter("ph2");
		String smsContent = "[ladies and gents] "+certificationCode+" (이)가  회원가입을 위한 모바일 인증번호입니다.";
		 
		// == 4개 파라미터(to, from, type, text)는 필수사항이다. == 
	    HashMap<String, String> paraMap = new HashMap<String, String>();
	    paraMap.put("to", mobile); // 수신번호
	    paraMap.put("from", "01099453169"); // 발신번호 오다윤
	    paraMap.put("type", "SMS"); // Message type ( SMS(단문), LMS(장문), MMS, ATA )
	    paraMap.put("text", smsContent); // 문자내용    
	    paraMap.put("app_version", "JAVA SDK v2.2"); // application name and version
	//  paraMap.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다. 포인트와 무관.
	    
	    JSONObject jsobj = (JSONObject)sms.send(paraMap);
	    
	    String json = jsobj.toString();
    //  System.out.println("~~~~ 확인용 json => "+json);
	    

	    request.setAttribute("json", json);
	    
	 // super.setRedirect(false);
	    super.setViewPage("/WEB-INF/jsonview.jsp");

	}
	
}


