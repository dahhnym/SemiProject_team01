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
		
		// 사용자가 작성한 글을 보기 전에 작성시 입력한 비밀번호와 현재 입력한 비밀번호가 일치하는지 알아오는 Action단
		// AJAX
		
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
			request.setAttribute("json", json);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
			
		} catch(SQLException e) {
			e.printStackTrace();
			//SQL 오류 시
			String message = "에러발생 ;P";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	      //super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
			
		}

	}

}
