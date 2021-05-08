package cscenter.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import cscenter.model.*;

public class BoardViewCheckUserAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String boardpwd = request.getParameter("boardpwd");
		String boardno = request.getParameter("boardno");
		//System.out.println("확인용 boardpwd"+boardpwd);
		//System.out.println("확인용 boardno"+boardno);
		
		InterCsBoardDAO bdao = new CsBoardDAO();
		
		//System.out.println("확인용 n" + n);
		
		try {
			int n = bdao.checkUserPwd(boardpwd, boardno);
			
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			String json = jsonObj.toString();
			System.out.println("json" + json);
			request.setAttribute("json", json);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
			
		} catch(SQLException e) {
			e.printStackTrace();
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/error.up");
		}

	}

}
