package cscenter.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import cscenter.model.CsBoardDAO;
import cscenter.model.CsBoardVO;
import cscenter.model.InterCsBoardDAO;

public class BoardUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//글 수정
				
		String boardno = request.getParameter("boardno");
		String fk_bigcateno = request.getParameter("fk_bigcateno");
		//System.out.println("boardno" + boardno);
		InterCsBoardDAO bdao = new CsBoardDAO();
		CsBoardVO bvo = bdao.selectBoardDetail(boardno);
		List<CsBoardVO> boardList = bdao.GetSmallCategoryList(fk_bigcateno);
		
		request.setAttribute("boardno", boardno);
		request.setAttribute("boardList", boardList);
		request.setAttribute("bvo", bvo);
		
		super.setViewPage("/WEB-INF/cscenter/BoardUpdate.jsp");
		
	}

}
