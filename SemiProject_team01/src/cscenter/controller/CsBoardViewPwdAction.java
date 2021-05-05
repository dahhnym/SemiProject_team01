package cscenter.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class CsBoardViewPwdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String boardno = request.getParameter("boardno");
		
		request.setAttribute("boardno", boardno);
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/cscenter/CsBoardViewPwd.jsp");

	}

}
