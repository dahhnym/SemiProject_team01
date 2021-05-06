package cscenter.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

import common.controller.AbstractController;
import cscenter.model.*;
import my.util.MyUtil;

public class CsFaqAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		//카테고리 번호 알아오기
		super.getFaqCategoryList(request);		
		String fcname = request.getParameter("fcname");
		
		Map<String, String> paraMap = new HashMap<>();
		
		InterFaqboardDAO fadao = new FaqboardDAO();
		
		paraMap.put("fcname", fcname);
		
		List<FaqboardVO> faqlist = fadao.selectbyfaq(paraMap);
		
		
		JSONArray jsonArr = new JSONArray();
		
		if(faqlist.size() > 0) {
			
			for(FaqboardVO fvo : faqlist) {
				JSONObject jsonObj = new JSONObject(); // { } { } { } ... { }
				
				jsonObj.put("faqNo", fvo.getFaqNo());
				jsonObj.put("fcname", fvo.getFcvo().getFcname());
				jsonObj.put("fccode", fvo.getFcvo().getFccode());
				jsonObj.put("faqtitle", fvo.getFaqtitle());
	            jsonObj.put("faqcontent", fvo.getFaqcontent());
	            
	            //jsonObj => {"pnum":1, "pname":"스마트TV", "code":"100000", "pcompany":"삼성", ...}
	          //jsonObj => {"pnum":2, "pname":"노트북", "code":"100000", "pcompany":"엘지", ...}
	            
	           jsonArr.put(jsonObj);
				
			}// end of for ------------
			
		String json = jsonArr.toString();
		//System.out.println("json : " + json);
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");		
		
	  }
	}

}
