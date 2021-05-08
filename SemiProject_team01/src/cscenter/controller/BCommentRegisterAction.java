package cscenter.controller;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import cscenter.model.*;
import my.util.MyUtil;

public class BCommentRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("sf");
		String boardno = request.getParameter("boardno");
		String contents = request.getParameter("contents");
		System.out.println("boardno" + boardno);
		System.out.println("contents" + contents);
		
		// **** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 **** // 
		contents = MyUtil.secureCode(contents);
		
		contents = contents.replaceAll("\r\n", "<br>");
		
		BoardAdminCommentVO adcommvo = new BoardAdminCommentVO();
		
		adcommvo.setFk_boardno(Integer.parseInt(boardno));
		adcommvo.setBcontent(contents);
		
		InterCsBoardDAO bdao = new CsBoardDAO();
		
		int n = 0;
		try {
			n = bdao.addComment(adcommvo);
		} catch(SQLIntegrityConstraintViolationException e) { // 제약조건에 위배된 경우 (동일한 제품에 대하여 동일한 회원이 제품후기를 2번 쓴 경우 unique 제약에 위배됨)
			e.printStackTrace();
			n = -1;
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		String json = jsonObj.toString();  // {"n":1} 또는 {"n":-1} 또는  {"n":0} 
		System.out.println("json" + json);
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");

	}

}
