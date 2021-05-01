package cscenter.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;
import cscenter.model.*;

public class csFaqAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//카테고리 번호 알아오기
		super.getFaqCategoryList(request);
		String fcNo = request.getParameter("fcNo");
				
		InterFaqboardDAO fadao = new FaqboardDAO();
		Map<String, String> paraMap = new HashMap<>();
		
		
		paraMap.put("fk_fcNo", fcNo);
		System.out.println("cxvxc" + fcNo);
		
		List<FaqboardVO> faqlist = fadao.selectbyfaq(paraMap);
		
		request.setAttribute("faqlist", faqlist);
		
		super.setViewPage("/WEB-INF/cscenter/cstest.jsp");
		
		
		
	}

}
