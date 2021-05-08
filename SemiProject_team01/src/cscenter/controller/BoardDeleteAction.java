package cscenter.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import cscenter.model.*;

public class BoardDeleteAction extends AbstractController {

	// 사용자가 작성한 게시글 삭제
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//글 삭제
		String boardno = request.getParameter("boardno");
		String fk_bigcateno = request.getParameter("fk_bigcateno");
		
		
		InterCsBoardDAO bdao = new CsBoardDAO();
		int n = bdao.BoardDelete(boardno);
		
		if(n == 1) {
			String message = "글 삭제 성공"; 
	   		 String loc = request.getContextPath()+"/cscenter/csBoardView?fk_bigcateno="+fk_bigcateno;
	   		 
	   		 request.setAttribute("message", message); request.setAttribute("loc", loc);
			 
			 super.setRedirect(false); //false는 forward 방식
			 super.setViewPage("/WEB-INF/msg.jsp");
		}else {
			 String message = "글 삭제실패"; 
	   		 String loc = "javascript:history.back()";
	   		 
	   		 request.setAttribute("message", message); request.setAttribute("loc", loc);
			 
			 super.setRedirect(false); //false는 forward 방식
			 super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
