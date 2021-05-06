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

public class AddmyprodAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {
			
					String fk_pnum = request.getParameter("fk_pnum");
				System.out.println(fk_pnum);
				
				InterCartDAO cdao = new CartDAO();
				
				List<ProductDetailVO> optionList = cdao.optionSelect(fk_pnum);
				
				request.setAttribute("optionList", optionList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/cart/addmyprod.jsp");
			
			}
			
	}

}
