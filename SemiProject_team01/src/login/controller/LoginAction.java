package login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("get".equalsIgnoreCase(method)) {
			// 로그인 하고자 하는 경우
		 // super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");
		} else {
			// 로그인하기 버튼을 누른 경우
			
			
		}
		
	}

}
