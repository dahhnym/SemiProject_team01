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
		
		if("post".equalsIgnoreCase(method)) {	// POST
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("name", name);
			paraMap.put("userid", userid);
			paraMap.put("email", email);
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.checkAccount(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			
			String json = jsonObj.toString();
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");			
						
		} else {	// GET 
			 // super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/pwdFind.jsp");
		}
	}
}
