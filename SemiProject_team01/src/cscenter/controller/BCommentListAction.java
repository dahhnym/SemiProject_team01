package cscenter.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import cscenter.model.*;

public class BCommentListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String boardno = request.getParameter("boardno");  // 제품번호 
		System.out.println("boardno" + boardno);
		InterCsBoardDAO bdao = new CsBoardDAO();
		List<BoardAdminCommentVO> commentList = bdao.commentList(boardno);
		
		JSONArray jsArr = new JSONArray(); // [] 
		
		if(commentList != null && commentList.size() > 0) {
			for(BoardAdminCommentVO reviewsvo : commentList) {
				JSONObject jsobj = new JSONObject();                // {} 
				jsobj.put("bcommentno", reviewsvo.getBcommentno());     
				jsobj.put("bcontent", reviewsvo.getBcontent());     
				jsobj.put("commDate", reviewsvo.getCommDate());            
				jsobj.put("fk_boardno", reviewsvo.getFk_boardno());       
				
				jsArr.put(jsobj); // [{"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디","review_seq":제품후기글번호}]	
			}
		}
		
		String json = jsArr.toString(); // 문자열 형태로 변환해줌. 
		//   "[{"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디","review_seq":제품후기글번호}]"  
		System.out.println("json이용" + json);
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");

	}

}
