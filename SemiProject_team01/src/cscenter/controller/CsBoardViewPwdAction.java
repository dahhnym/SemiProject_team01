package cscenter.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class CsBoardViewPwdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 사용자가 작성한 글을 보기 전에 비밀번호를 입력하는 View단을 보여주기 위한 Action단
		
		String boardno = request.getParameter("boardno");
		
		request.setAttribute("boardno", boardno);
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/cscenter/CsBoardViewPwd.jsp");

	}

}
