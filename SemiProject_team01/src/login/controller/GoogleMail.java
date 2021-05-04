package login.controller;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;


public class GoogleMail {

	public void sendmail(String recipient, String rndPwd) throws Exception {
		
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
    	msg.setContent("<h4 style='font-weight:bold;'>안녕하세요, ladies and gents 고객님. </h4><br><br>"
    			     + "<span>요청하신 임시 비밀번호는 다음과 같습니다.<br>"
    			     + "임시 비밀번호: "+rndPwd+"</span><br><br>"
    			     + "<button type='button'>비밀번호 바로 변경하기</button><br><br>"
    			     + "<div style='margin:10px 0;'>임시 비밀번호를 사용해서 로그인 하신 후 바로 비밀번호를 변경하셔야 정상적으로 로그인이 가능합니다.<br>"
    			     + "다른 문의사항는 고객센터(000-000-0000)으로 문의해 주시기 바랍니다.</div>"
    			     + "<h5 style='font-weight:bold;'>감사합니다.</h5>"
    			     , "text/html;charset=UTF-8");
    	
    	// 메일 발송하기
    	Transport.send(msg);
    	
	}// end of public void sendmail(String recipient, String certificationCode) throws Exception---------------------------- 
	
	
	/*
	 *  DEBUG: setDebug: JavaMail version 1.4.7
		java.lang.NullPointerException
	*/
}
