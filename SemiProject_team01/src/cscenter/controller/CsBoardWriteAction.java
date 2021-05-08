package cscenter.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import cscenter.model.CsBoardDAO;
import cscenter.model.CsBoardVO;
import cscenter.model.InterCsBoardDAO;

public class CsBoardWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_bigcateno = request.getParameter("fk_bigcateno");
		request.setAttribute("fk_bigcateno", fk_bigcateno);		
		
		InterCsBoardDAO bdao = new CsBoardDAO();
		List<CsBoardVO> boardList = bdao.GetSmallCategoryList(fk_bigcateno);
		
		request.setAttribute("boardList", boardList);
		
		super.setViewPage("/WEB-INF/cscenter/CsBoardWrite.jsp");		
	}

}
