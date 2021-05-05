package login.controller;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;


public class GoogleMail {
	
	public static void sendmail(String recipient, String rndPwd, String userid) throws Exception {
        String user = "anjfkrhgkwl7@gmail.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
        String password = "anjfkrhgkwl77++";    // 패스워드

        // SMTP 서버 정보를 설정한다.
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com"); 
        prop.put("mail.smtp.port", 465); 
        prop.put("mail.smtp.auth", "true"); 
        prop.put("mail.smtp.ssl.enable", "true"); 
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(user));

        //수신자메일주소
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); 

        // Subject
        message.setSubject("[ladies and gents] 임시비밀번호 발송"); //메일 제목을 입력

        // Text
        message.setText("<h4 style='font-weight:bold;'>안녕하세요, ladies and gents 고객님. </h4><br><br>"
				     + "<span>요청하신 임시 비밀번호는 다음과 같습니다.<br>"
				     + "임시 비밀번호: "+rndPwd+"</span><br><br>"
				     + "<button type='button'>비밀번호 바로 변경하기</button><br><br>"
				     + "<div style='margin:10px 0;'>임시 비밀번호를 사용해서 로그인 하신 후 바로 비밀번호를 변경하셔야 정상적으로 로그인이 가능합니다.<br>"
				     + "다른 문의사항는 고객센터(000-000-0000)으로 문의해 주시기 바랍니다.</div>"
				     + "<h5 style='font-weight:bold;'>감사합니다.</h5>"
				     , "text/html;charset=UTF-8");
	
		// 메일 발송하기
		Transport.send(message);
        
		System.out.println("하하하");
	}// end of public void sendmail(String recipient, String rndPwd, String userid) throws Exception -------------------------- 
	

}
