package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;

import common.controller.AbstractController;

public class CodeConfirmAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean result = false;
		
		HttpSession session = request.getSession();
		
		String certificationCode = (String) session.getAttribute("certificationCode");
		
		if(certificationCode != null && certificationCode.equals(request.getParameter("inputCode"))) {
			result = true;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);  // {"result":true}  또는  {"result":false} 
	   
		String json = jsonObj.toString();  // "{"result":true}"  또는  "{"result":false}" 

	    request.setAttribute("json", json);
	    
	 // super.setRedirect(false);
	    super.setViewPage("/WEB-INF/jsonview.jsp");

	}

}
