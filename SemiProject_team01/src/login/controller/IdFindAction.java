package login.controller;

import javax.servlet.http.*;
import org.json.JSONObject;
import common.controller.AbstractController;
import member.model.*;


public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {	// POST
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			InterMemberDAO mdao = new MemberDAO();
			String userid = mdao.findUserid(name,email);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("userid", userid);
			
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");			
						
		} else {	// GET 
			 // super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/idFind.jsp");
		}
	}
}
