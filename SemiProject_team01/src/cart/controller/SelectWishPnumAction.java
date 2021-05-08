package cart.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import cart.model.*;
import common.controller.AbstractController;

public class SelectWishPnumAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pdetailnum = request.getParameter("pdetailnum");
		System.out.println(pdetailnum);
		InterCartDAO cdao = new CartDAO();
		
		// 위시리스트 제품 정보 알아오기
		List<WishListVO> wprodList = cdao.selectWishProdInfo(pdetailnum);
	
		JSONArray jsArr = new JSONArray();
		

		if( wprodList.size() > 0 ) {
			for(WishListVO wprodInfo : wprodList) {
				JSONObject jsobj = new JSONObject();
				jsobj.put("cartnum",wprodInfo.getWnum());
				jsobj.put("pname", wprodInfo.getPvo().getPname());
				jsobj.put("oqty", wprodInfo.getOqty());
				jsobj.put("optionname", wprodInfo.getPdetailvo().getOptionname());
				jsobj.put("saleprice", wprodInfo.getPvo().getSaleprice());
				jsobj.put("pdetailnum", wprodInfo.getPdetailvo().getPdetailnum());
				jsobj.put("pnum", wprodInfo.getPvo().getPnum());
				jsobj.put("pimage",wprodInfo.getPvo().getPimage1());
				
				jsArr.put(jsobj);
			}
		}
				
		String json = jsArr.toString();
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
		
	}

}
