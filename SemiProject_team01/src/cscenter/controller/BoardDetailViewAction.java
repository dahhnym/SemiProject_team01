package cscenter.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class BoardDetailViewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		super.setRedirect(false); //false는 forward 방식
		super.setViewPage("/WEB-INF/cscenter/BoardDetailView.jsp");
	}

}
