package member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

import my.util.MyUtil;
import order.model.InterOrderDAO;
import order.model.OrderDAO;
import order.model.OrderDetailVO;

import product.model.ProductVO;

public class ReviewListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		String userid = request.getParameter("userid");
		
		InterOrderDAO odao = new OrderDAO();
		List<OrderDetailVO> pdrvList = odao.pendingReview(userid);
		int pdrvListNo = odao.pdrvListNo(userid);
		request.setAttribute("pdrvList", pdrvList);		
		
		List<OrderDetailVO> wtrvList = odao.writtenReview(userid);
		request.setAttribute("wtrvList", wtrvList);
	/*	if( loginuser != null ) {*/
			// 회원 로그인 했을 경우
		/*	
			InterProductDAO pdao = new ProductDAO();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
			
			String sizePerPage = "5";
			// 한 페이지당 화면상에 보여줄 회원의 개수 : 5개로 고정!
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid",userid);
			paraMap.put("currentShowPageNo", currentShowPageNo);
			// 현재 보려고 클릭한 페이지 번호
			
			///////////////////////////////////////////////////////////
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에
			//     토탈페이지수 보다 큰 값을 입력하여 장난친 경우를 1페이지로 가게끔 막아주는 것 시작.  
			
			// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select)
			int totalPage = pdao.selectTotalPage(paraMap);
		//	System.out.println("~~~ 확인용 totalPage => " + totalPage);
			
			if( Integer.parseInt(currentShowPageNo)	> totalPage ) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
			// 토탈페이지수 보다 큰 값을 입력하여 장난친 경우를 1페이지로 가게끔 막아주는 것 끝.
            ///////////////////////////////////////////////////////////////
			
			List<ProductVO> reviewList = pdao.selectPagingReview(paraMap);
			
			request.setAttribute("reviewList", reviewList);
			request.setAttribute("sizePerPage", sizePerPage);
			
			// **** ========= 페이지바 만들기 ========= **** //
			
			String pageBar = "";
			
			int blockSize = 10;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
			
			int pageNo = 0;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
						
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! // 
			pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			

			
			
			// **** [맨처음][이전] 만들기 **** //
			if(pageNo != 1) {
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo=1'>[맨처음]</a>&nbsp;";       
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp;";
			}
			if(pageNo==0) {
				pageBar="아무것도 없음";
			}
				
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</span>&nbsp;";        
				}
				else {
					pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a>&nbsp;";
				}
				
				loop++;
				
				pageNo++; //             1  2  3  4  5  6  7  8  9 10 [다음][마지막]
				          // [맨처음][이전]11 12 13 14 15 16 17 18 19 20 [다음][마지막]
				          // [맨처음][이전]21 22 23 24 25 26 27 28 29 30 [다음][마지막]
				          // [맨처음][이전]31 32 33 34 35 36 37 38 39 40 [다음][마지막]
				          // [맨처음][이전]41 
			}// end of while--------------------------------
			
			// **** [다음][마지막] 만들기 **** //
			// pageNo ==> 11
			// pageNo ==> 21
			// pageNo ==> 31
			// pageNo ==> 41
			// pageNo ==> 42 [다음][마지막]이 없어야 한다.  
			if( pageNo <= totalPage ) {
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'>[마지막]</a>&nbsp;";
			}
			 
			request.setAttribute("pageBar", pageBar);
			*/
		
		
		
			////////////////////////////////////////////////////////////
			// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
			String currentURL = MyUtil.getCurrentURL(request);
			// 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.
			
		//	System.out.println("~~~ 확인용 currentURL => " + currentURL);
			// ~~~ 확인용 currentURL => member/memberList.up?currentShowPageNo=8&sizePerPage=10&searchType=name&searchWord=%EC%98%81 
			
			currentURL = currentURL.replaceAll("&", " ");
		//	System.out.println("~~~ 확인용 currentURL => " + currentURL);
			// ~~~ 확인용 currentURL => member/memberList.up?currentShowPageNo=8 sizePerPage=10 searchType=name searchWord=%EC%98%81
			
			request.setAttribute("goBackURL", currentURL);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/reviewList.jsp");
	/*	}
		else {
			// 로그인을 안한 경우  
			String message = "로그인을 먼저 해주세요.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}*/

	

	}

}
