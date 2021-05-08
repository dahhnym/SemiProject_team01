package cscenter.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import cscenter.model.*;
import member.model.MemberVO;

public class BoardRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 사용자가 작성한 글 등록
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			super.setViewPage("/WEB-INF/cscenter/CsBoardWrite.jsp");
		} else {
			
			// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
			super.goBackURL(request);

			// == 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다 ==
			HttpSession session = request.getSession();
			
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if( loginuser != null ) {
			
			MultipartRequest mtrequest = null;
            
            ServletContext svlCtx = session.getServletContext();
            String imagesDir = svlCtx.getRealPath("/images");
            
            System.out.println(session);
            
            try {
            	mtrequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
            } catch (IOException e) {
            	e.printStackTrace();
			}

			String fk_bigcateno = mtrequest.getParameter("fk_bigcateno");
			fk_bigcateno = fk_bigcateno.trim();
			String fk_smallcateno = mtrequest.getParameter("fk_smallcateno");
			String boardtitle = mtrequest.getParameter("boardtitle");
			String fk_userid = mtrequest.getParameter("fk_userid");
			String boardpwd = mtrequest.getParameter("boardpwd");
			String boardcontent = mtrequest.getParameter("boardcontent");
			boardcontent = boardcontent.replace("<", "&lt;");
			boardcontent =  boardcontent.replace(">", "&gt;");
	         
	         //입력한 내용에서 엔터는 <br>로 변환시키기
			boardcontent =  boardcontent.replace("\r\n", "<br>");
			
			String boardfile = mtrequest.getFilesystemName("boardfile");
			
			
			
			InterCsBoardDAO bdao = new CsBoardDAO();
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
			
			
		}else {
			//로그인 안한 경우
			String message = "로그인하세요.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	      //super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}

	}}

}
