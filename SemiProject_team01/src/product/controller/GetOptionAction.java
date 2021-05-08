package product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import cscenter.model.CsBoardVO;
import product.model.*;

public class GetOptionAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("옵션 쌓기");
		String pdetailnum = request.getParameter("pdetailnum");
		//System.out.println("pnum" + pnum);
		
		InterProductdetailDAO2 pddao = new ProductdetailDAO2();
		List<ProductDetailVO> datailList = pddao.GetSmallCategoryList(pdetailnum);
		
		JSONArray jsonArr = new JSONArray();
		if(datailList.size() > 0) {
			for(ProductDetailVO pdvo : datailList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("pdetailnum", pdvo.getPdetailnum());
				jsonObj.put("pnum", pdvo.getFk_pnum());
				jsonObj.put("optionname", pdvo.getOptionname());
				jsonObj.put("pname", pdvo.getPdvo().getPname());
				jsonObj.put("saleprice", pdvo.getPdvo().getSaleprice());
				
				jsonArr.put(jsonObj);
			}
			String json = jsonArr.toString();
			System.out.println("json" + json);
			request.setAttribute("json", json);
			
			super.setViewPage("/WEB-INF/jsonview.jsp");		

		}
	}

}
