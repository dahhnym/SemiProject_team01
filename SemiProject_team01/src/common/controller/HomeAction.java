package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HomeAction extends AbstractController {
 
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/home.jsp");
		
		
		
		
	}

}
