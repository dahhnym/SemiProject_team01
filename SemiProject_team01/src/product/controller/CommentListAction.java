package product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO2;
import product.model.ProductDAO2;
import product.model.PurchaseReviewsVO;


public class CommentListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_pnum = request.getParameter("fk_pnum");  // 제품번호 
		
		InterProductDAO2 pdao = new ProductDAO2();
		List<PurchaseReviewsVO> commentList = pdao.commentList(fk_pnum);
		
		JSONArray jsArr = new JSONArray(); // [] 
		
		if(commentList != null && commentList.size() > 0) {
			for(PurchaseReviewsVO reviewsvo : commentList) {
				JSONObject jsobj = new JSONObject();                // {} 
				jsobj.put("contents", reviewsvo.getRvcontents());     // {"contents":"제품후기내용물"}
				jsobj.put("name", reviewsvo.getMvo().getName());    // {"contents":"제품후기내용물","name":"작성자이름"} 
				jsobj.put("writeDate", reviewsvo.getRvdate());   // {"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자"}         
				jsobj.put("userid", reviewsvo.getFk_userid());      // {"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디"} 
				jsobj.put("review_seq", reviewsvo.getReviewno()); // {"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디","review_seq":제품후기글번호}   
				
				jsArr.put(jsobj); // [{"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디","review_seq":제품후기글번호}]	
			}
		}
		
		String json = jsArr.toString(); // 문자열 형태로 변환해줌. 
		//   "[{"contents":"제품후기내용물","name":"작성자이름","writeDate":"작성일자","userid":"사용자아이디","review_seq":제품후기글번호}]"  
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
