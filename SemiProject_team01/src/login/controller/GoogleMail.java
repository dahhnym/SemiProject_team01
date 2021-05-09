package login.controller;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class GoogleMail {

	public void sendmail(String recipient, String certificationCode) throws Exception {
		
		// 1. 정보를 담기 위한 객체
    	Properties prop = new Properties();
    	
    	// 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
   	    //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
    	prop.put("mail.smtp.user", "anjfkrhgkwl7@gmail.com");
    	
    	// 3. SMTP 서버 정보 설정
    	//    Google Gmail 인 경우  smtp.gmail.com
    	prop.put("mail.smtp.host", "smtp.gmail.com");
         	
    	
    	prop.put("mail.smtp.port", "465");
    	prop.put("mail.smtp.starttls.enable", "true");
    	prop.put("mail.smtp.auth", "true");
    	prop.put("mail.smtp.debug", "true");
    	prop.put("mail.smtp.socketFactory.port", "465");
    	prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    	prop.put("mail.smtp.socketFactory.fallback", "false");
    	
    	prop.put("mail.smtp.ssl.enable", "true");
    	prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
    	
    	Authenticator smtpAuth = new MySMTPAuthenticator();
    	Session ses = Session.getInstance(prop, smtpAuth);
    	
    	// 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
    	ses.setDebug(true);
    	
    	// 메일의 내용을 담기 위한 객체생성
    	MimeMessage msg = new MimeMessage(ses);
    	
    	// 제목 설정
    	String subject = "[ladies and gents] 임시비밀번호 발송";
    	msg.setSubject(subject);
    	
    	// 보내는 사람의 메일주소
    	String sender = "anjfkrhgkwl7@gmail.com";
    	Address fromAddr = new InternetAddress(sender);
    	msg.setFrom(fromAddr);
    			
    	// 받는 사람의 메일주소
    	Address toAddr = new InternetAddress(recipient);
    	msg.addRecipient(Message.RecipientType.TO, toAddr);
    	    	
    	// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
    	msg.setContent("<h3>고객님의 임시비밀번호 발급 내역을 안내해 드립니다.</h3><br><br>"
    			     + "임시비밀번호 : <span style='font-size:14pt; color:red;'>"+certificationCode+"</span><br><br>"
    			     + "비밀번호를 변경한 적이 없는데 메일을 받았다면 다른 사람이 내 계정 정보를 알아내어 변경했을 수 있습니다. <br>"
    			     + "비밀번호를 다시 설정하시고, 비밀번호가 변경된 수단이 안전한지도 함께 점검해 주세요.<br><br>"
    			     + "이용해주셔서 감사합니다!", 
    			     "text/html;charset=UTF-8");
    	
    	// 메일 발송하기
    	Transport.send(msg);
    	
	}// end of public void sendmail(String recipient, String certificationCode) throws Exception---------------------------- 
	
}
