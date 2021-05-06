package cart.controller;


import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;
import product.model.ProductDetailVO;

public class OptionSelectAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_pnum = request.getParameter("fk_pnum");
		
		InterCartDAO cdao = new CartDAO();
		
		// String 값으로 받음
	//	List<String> optionList = cdao.optionSelect(fk_pnum);

		List<ProductDetailVO> optionList = cdao.optionSelect(fk_pnum);
		
		JSONArray jsArr = new JSONArray();
				
	/*	if( optionList.size() > 0 ) {
			for(String option : optionList) {
				JSONObject jsobj = new JSONObject();
				jsobj.put("option",option);
				jsArr.put(jsobj);
			}
		}
	*/
		if( optionList.size() > 0 ) {
			for(ProductDetailVO option : optionList) {
				JSONObject jsobj = new JSONObject();
				jsobj.put("optionname",option.getOptionname());
				jsobj.put("pdetailnum",option.getPdetailnum());
				jsobj.put("pqty",option.getPqty());
				jsArr.put(jsobj);
			}
		}
		
		
		
		String json = jsArr.toString();
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
