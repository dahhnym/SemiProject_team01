package product.controller;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import my.util.MyUtil;
import product.model.InterProductDAO2;
import product.model.ProductDAO2;
import product.model.PurchaseReviewsVO;

public class CommentRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_userid = request.getParameter("fk_userid");
		String pnum = request.getParameter("pnum");
		String rvcontent = request.getParameter("rvcontent");
		
		// **** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 **** // 
		rvcontent = MyUtil.secureCode(rvcontent);
		
		rvcontent = rvcontent.replaceAll("\r\n", "<br>");
		
		PurchaseReviewsVO reviewsvo = new PurchaseReviewsVO();
		reviewsvo.setFk_userid(fk_userid);
		reviewsvo.setPnum(Integer.parseInt(pnum));
		reviewsvo.setRvcontents(rvcontent);
		
		InterProductDAO2 pdao = new ProductDAO2();
		
		int n = 0;
		try {
			n = pdao.addComment(reviewsvo);
		} catch(SQLIntegrityConstraintViolationException e) { // 제약조건에 위배된 경우 (동일한 제품에 대하여 동일한 회원이 제품후기를 2번 쓴 경우 unique 제약에 위배됨)
			e.printStackTrace();
			n = -1;
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		String json = jsonObj.toString();  // {"n":1} 또는 {"n":-1} 또는  {"n":0} 
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}
		

}
