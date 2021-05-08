package cart.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import cart.model.*;
import common.controller.AbstractController;
import product.model.ProductDetailVO;


public class SelectPnumAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

			String pdetailnum = request.getParameter("pdetailnum");
			System.out.println(pdetailnum);
			InterCartDAO cdao = new CartDAO();
			
			// 제품 정보 알아오기
			List<CartVO> prodList = cdao.selectProdInfo(pdetailnum);
		
			JSONArray jsArr = new JSONArray();
			
	
			if( prodList.size() > 0 ) {
				for(CartVO prodInfo : prodList) {
					JSONObject jsobj = new JSONObject();
					jsobj.put("cartnum",prodInfo.getCartnum());
					jsobj.put("pname", prodInfo.getPvo().getPname());
					jsobj.put("oqty", prodInfo.getOqty());
					jsobj.put("optionname", prodInfo.getPdetailvo().getOptionname());
					jsobj.put("saleprice", prodInfo.getPvo().getSaleprice());
					jsobj.put("pdetailnum", prodInfo.getPdetailvo().getPdetailnum());
					jsobj.put("pnum", prodInfo.getPvo().getPnum());
					jsobj.put("pimage",prodInfo.getPvo().getPimage1());
					
					jsArr.put(jsobj);
				}
			}
					
			String json = jsArr.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
	}

}
