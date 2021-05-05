package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO2;
import product.model.ProductDAO2;
import product.model.ProductVO2;


public class MallDisplayJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sname = request.getParameter("sname");
		String start = request.getParameter("start");
		String len = request.getParameter("len");
		
		InterProductDAO2 pdao = new ProductDAO2();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("sname", sname);   // "HIT"  "NEW" 
		paraMap.put("start", start);   //  start   "1"  "9"  "17"  "25"  33"
		
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1);
		paraMap.put("end", end);   // end => start + len - 1;
		                           // end    "8"  "16"  "24"  "32"  "40"  
		
		List<ProductVO2> prodList = pdao.selectBySpecName(paraMap);
		
		JSONArray jsonArr = new JSONArray();  // [] 
		
		if( prodList.size() > 0 ) {
			
			for(ProductVO2 pvo : prodList) {
				
				JSONObject jsonObj = new JSONObject(); // {} {} {} ... {}
				
				jsonObj.put("pnum", pvo.getPnum());
				jsonObj.put("pname", pvo.getPname());
				jsonObj.put("code", pvo.getCategvo().getCode());
				jsonObj.put("pcompany", pvo.getPcompany());
				jsonObj.put("pimage1", pvo.getPimage1());
				jsonObj.put("pimage2", pvo.getPimage2());
				jsonObj.put("price", pvo.getPrice());
				jsonObj.put("saleprice", pvo.getSaleprice());
				jsonObj.put("sname", pvo.getSpvo().getSname());
				jsonObj.put("pcontent", pvo.getPcontent());
				
			
				jsonArr.put(jsonObj);
			
				
			}// end of for-----------------------------
			
			String json = jsonArr.toString(); // 문자열로 변환 
			
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		
		else {
			// DB에서 조회된 것이 없다라면 
			
			String json = jsonArr.toString(); // 문자열로 변환 
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}

}
