package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.*;

public class ProdDisplayJSONAction extends AbstractController { 

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String sname = request.getParameter("sname");	// "NEW"
		String start=request.getParameter("start");
		String len=request.getParameter("len");
		
		InterProductDAO pdao = new ProductDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("sname",sname);
		paraMap.put("start",start);		// start	"1"		"9"		"17"	"25"	"33"
		
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1);
		paraMap.put("end", end);	// end => start + len - 1
									// end		"8"  "16"	"24"	"32"	"40"
		
		List<ProductVO> prodList = pdao.selectNEWonly(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(prodList.size() > 0) {
			
			for(ProductVO pvo :prodList) {
				
				JSONObject jsonObj = new JSONObject();	// JSON 객체 생성 {} {} {} ... {}
				
				jsonObj.put("pnum", pvo.getPnum());
				jsonObj.put("pname", pvo.getPname());
	            jsonObj.put("pimage1", pvo.getPimage1());
	            jsonObj.put("price", pvo.getPrice());
	            jsonObj.put("saleprice", pvo.getSaleprice());
	            
	            jsonArr.put(jsonObj);
	           
			}//end of for ----------------

			
			String json = jsonArr.toString();	//문자열로 변환
			
			//System.out.println("확인용 json : "+json);
	
			request.setAttribute("json", json);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			 
			
		} else {	//DB에서 조회된 것이 없는 경우
			
			String json = jsonArr.toString();	//문자열로 변환
			
			// *** 만약에  select 되어진 정보가 없다라면 [] 로 나오므로 null 이 아닌 요소가 없는 빈배열이다. *** --   
			//System.out.println("확인용 json : "+json);
			//확인용 json : []

			request.setAttribute("json", json);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		
	}


}
