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
		
		String fk_bigcateno = request.getParameter("fk_bigcateno");
		InterCsBoardDAO bdao = new CsBoardDAO();
		List<CsBoardVO> boardList = bdao.GetSmallCategoryList(fk_bigcateno);
		
		JSONArray jsonArr = new JSONArray();
		
		if(boardList.size() > 0) {
			for(CsBoardVO bvo : boardList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("smallcateno", bvo.getCbscvo().getSmallcateno());
				jsonObj.put("smallcatename", bvo.getCbscvo().getSmallcatename());
				
				 jsonArr.put(jsonObj);
			}
			String json = jsonArr.toString();
			System.out.println("json" + json);
			request.setAttribute("json", json);
			
			super.setViewPage("/WEB-INF/jsonview.jsp");		
		}

	}

}
