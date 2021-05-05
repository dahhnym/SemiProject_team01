package cscenter.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import cscenter.model.*;

public class BoardRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			super.setViewPage("/WEB-INF/cscenter/CsBoardWrite.jsp");
		} else {
			
			String fk_bigcateno = request.getParameter("fk_bigcateno");
			fk_bigcateno = fk_bigcateno.trim();
			InterCsBoardDAO bdao = new CsBoardDAO();
			
			
			String fk_smallcateno = request.getParameter("fk_smallcateno");
			String boardtitle = request.getParameter("boardtitle");
			String fk_userid = request.getParameter("fk_userid");
			String boardpwd = request.getParameter("boardpwd");
			String boardcontent = request.getParameter("boardcontent");
			String boardfile = request.getParameter("boardfile");
			
			
			
			
			CsBoardVO board = new CsBoardVO(fk_smallcateno, boardtitle, fk_userid, boardpwd, boardcontent, boardfile);
			
			
			try {
				int n = bdao.registerBoard(board);
				
				if(n == 1) {
					 String message = "글 등록 완료"; 
	        		 String loc = request.getContextPath() + "/cscenter/csBoardView.to";
	        		 
	        		 request.setAttribute("message", message); request.setAttribute("loc", loc);
					 
					 super.setRedirect(false); //false는 forward 방식
					 super.setViewPage("/WEB-INF/msg.jsp");
				} else {
					 String message = "글 등록 실패"; 
	        		 String loc = "javascript:history.back()";
	        		 
	        		 request.setAttribute("message", message); request.setAttribute("loc", loc);
					 
					 super.setRedirect(false); //false는 forward 방식
					 super.setViewPage("/WEB-INF/msg.jsp");
	        	 }
				
			} catch(SQLException e) {
				e.printStackTrace();
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/error.up");
			}
			
			
		}

	}

}
