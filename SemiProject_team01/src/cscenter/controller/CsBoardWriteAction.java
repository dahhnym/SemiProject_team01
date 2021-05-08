package cscenter.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import cscenter.model.CsBoardDAO;
import cscenter.model.CsBoardVO;
import cscenter.model.InterCsBoardDAO;
import member.model.MemberVO;

public class CsBoardWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 사용자가 문의글을 작성할 수 있도록 View단을 보여주고
		// 이 전 페이지에서 가져온 카테고리번호를 이용해 자동으로 select의 값을 지정해준다.
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
		super.goBackURL(request);

		// == 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다 ==
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if( loginuser != null ) {
			
			String fk_bigcateno = request.getParameter("fk_bigcateno");
			request.setAttribute("fk_bigcateno", fk_bigcateno);		
			
			InterCsBoardDAO bdao = new CsBoardDAO();
			List<CsBoardVO> boardList = bdao.GetSmallCategoryList(fk_bigcateno);
			
			request.setAttribute("boardList", boardList);
			
			super.setViewPage("/WEB-INF/cscenter/CsBoardWrite.jsp");		
		} else {
			//로그인 안한 경우
			String message = "로그인하세요.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	      //super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}
