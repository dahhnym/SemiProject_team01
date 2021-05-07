package login.controller;

import javax.mail.*;

public class MySMTPAuthenticator extends Authenticator {

	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		// Gmail 의 경우 @gmail.com 을 제외한 아이디만 입력한다.
		return new PasswordAuthentication("anjfkrhgkwl7","anjfkrhgkwl77++"); 	// 임시 ==> *정정사항
																				// 브랜드 명의 계정 생성하기
	}	
}
