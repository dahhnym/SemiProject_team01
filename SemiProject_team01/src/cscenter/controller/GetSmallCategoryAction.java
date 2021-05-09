package cscenter.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import cscenter.model.*;

public class GetSmallCategoryAction extends AbstractController {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 사용자가 문의글 작성 시 어떤 카테고리에서 글쓰기 버튼을 눌렀는지에 따라서
		// 그에 맞는 select의 option명을 설정해주기 위한 Action단
		
		String fk_bigcateno = request.getParameter("fk_bigcateno");
		if(fk_bigcateno == "") {
			fk_bigcateno = "1";
		}
		InterCsBoardDAO bdao = new CsBoardDAO();
		List<CsBoardVO> boardList = bdao.GetSmallCategoryList(fk_bigcateno);
		JSONArray jsonArr = new JSONArray();
		
		if(boardList.size() > 0) {
			for(CsBoardVO bvo : boardList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("smallcateno", bvo.getCbscvo().getSmallcateno());
				jsonObj.put("smallcatename", bvo.getCbscvo().getSmallcatename());
				jsonObj.put("bigcatename", bvo.getCbscvo().getCbbcvo().getBigcatename());
				
				 jsonArr.put(jsonObj);
			}
			String json = jsonArr.toString();
			//System.out.println("json" + json);
			request.setAttribute("json", json);
			
			super.setViewPage("/WEB-INF/jsonview.jsp");		
		}

	}

}
