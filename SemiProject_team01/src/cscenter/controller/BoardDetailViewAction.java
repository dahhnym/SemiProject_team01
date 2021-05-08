package cscenter.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import cscenter.model.*;

public class BoardDetailViewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		// 사용자가 작성한 글 자세히 보여주는 Action단
		
		String boardno = request.getParameter("boardno");
		
		InterCsBoardDAO bdao = new CsBoardDAO();
		CsBoardVO bvo = bdao.selectBoardDetail(boardno);
		
		request.setAttribute("boardno", boardno);
		request.setAttribute("bvo", bvo);
		
		super.setRedirect(false); //false는 forward 방식
		super.setViewPage("/WEB-INF/cscenter/BoardDetailView.jsp");
	}

}
