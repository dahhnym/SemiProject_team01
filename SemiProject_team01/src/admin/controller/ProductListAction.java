package admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import my.util.MyUtil;
import product.model.*;

public class ProductListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// == 관리자(admin)로 로그인했을 때만 조회 가능하도록 하기 ==
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getUserid())){	//관리자(admin)로 로그인한 경우
			InterProductDAO pdao = new ProductDAO();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
	        // 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
	        // currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
			
			String sizePerPage = request.getParameter("sizePerPage");
			// 한 페이지당 화면상에 보여줄 회원의 개수
	        // 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
	        // sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
	        // "10" or "20" or "30" 
			
			
			if(currentShowPageNo == null ) {
				currentShowPageNo = "1";
			}
			
			if(sizePerPage == null || !("10".equals(sizePerPage) || "20".equals(sizePerPage) || "30".equals(sizePerPage)) ) {
				//sizePerPage가 null이던지 10,20,30을 제외한 다른 값을 넣어준 경우
				sizePerPage = "10";
			}
			
			/* === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자 아닌 문자를 입력한 경우 또는 int 범위를 초과한 숫자를 입력한 경우라면
			 currentShowPageNo 는 1 페이지로 만들도록 한다. === */ 
			try {
				Integer.parseInt(currentShowPageNo);
			} catch (NumberFormatException e) {
				currentShowPageNo = "1";
			}
			////////////////////////////////////////////////////////
			// == 검색어가 들어온 경우 ==
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			// searchWord 경우의 수 -> null, 공백, 검색어
			
			//System.out.println("확인용 searchType: "+searchType);
			//System.out.println("확인용 searchWord: "+searchWord);
			
			
			
			////////////////////////////////////////////////////////
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			// 검색어가 들어온 경우
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			

			/////////////////////////////////////////////////////////
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 토탈페이지수 보다 큰 값을 입력하여 장난친 경우를 1페이지로 가게끔 막아주는 것
			// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select)  
			int totalPage = pdao.selectProdTotalPage(paraMap);
			//System.out.println(" ~~ 확인용 totalPage => "+totalPage);
			//System.out.println("확인용 totalPage: "+totalPage);
			/* 페이지당 10명씩 보인다면    확인용 totalPage: 21
			       페이지당 5명씩 보인다면      확인용 totalPage: 42
			       페이지당 3명씩 보인다면      확인용 totalPage: 69 */
			
			// URL주소에 totalPage보다 currentShowPageNo를 큰 수를 넣는 경우 무조건 1페이지로 이동하기
			//[예시] http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=2222&sizePerPage=5
																					// ^^^^ currentShowPageNo가 2222인 페이지가 없다 이런 경우 무조건 1페이지로 이동하기
			if(Integer.parseInt(currentShowPageNo) > totalPage) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
			
			///////////////////////////////////////////////////////////
					
			List<ProductVO> productList = pdao.getProductInfo(paraMap);	// DB 테이블의 행 하나하나가 ProductVO 이다
			
			request.setAttribute("productList", productList);
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			
			String pageBar = "";
			
			int blockSize = 10;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
			
			int pageNo = 0;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //    
			pageNo  = ( (Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1; 
			
			/////////////////////////////////////////////////////////////////
			if(searchType == null) {
				searchType = "";
			}
			
			if(searchWord == null) {
				searchWord = "";
			}
			
			/////////////////////////////////////////////////////////////////
			
			// *** [맨처음] [이전] 만들기 *** //
			if( pageNo != 1 ) {
				pageBar += "&nbsp;<a href='productList.to?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='productList.to?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
			}
			
			
			while(!(loop > blockSize || pageNo > totalPage )) {	// blockSize가 현재 10이므로 loop가 11로 넘어가면 안된다 따라서 loop가 blockSize인 10보다 커지면 while문 탈출
																// totalPage보다도 pageNo가 커지면 안된다 현재는 totalPage가 42인데 pageNo가 계속해서 반복하면서 43,44 나오면 안된다..
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "&nbsp;<span style='font-weight: bolder; font-size:14pt; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
				
				} else {
					pageBar += "&nbsp;<a href='productList.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;";
				
				}
				loop++;
				pageNo++;	//  1  2  3  4  5  6  7  8  9 10 [다음] [마지막]
							// [맨처음] [이전] 11 12 13 14 15 16 17 18 19 20 [다음] [마지막]
							// [맨처음] [이전] 21 22 23 24 25 26 27 28 29 30 [다음] [마지막]
							// [맨처음] [이전] 31 32 33 34 35 36 37 38 39 40 [다음] [마지막]
							// [맨처음] [이전] 41 42 
			}//end of while() ----------------------------------------------
			
			// *** [다음] [마지막] 만들기 *** //
			// pageNo ==> 11
			// pageNo ==> 21
			// pageNo ==> 31
			// pageNo ==> 42 -> [다음] [마지막]이 없어야한다
			if( pageNo <= totalPage ) {
				pageBar += "&nbsp;<a href='productList.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='productList.to?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a>";
			} 
			
			
			request.setAttribute("pageBar", pageBar);
			
			/////////////////////////////////////////////////////////////////////
			// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 
			String currentURL = MyUtil.getCurrentURL(request);
			// 회원조회를 했을 시 현재 그 페이지로 그대로 되돌아가길 위한 용도
			
			//System.out.println("확인용 : "+currentURL);
			// 확인용 : member/memberList.up?searchType=name&searchWord=%EC%97%AC&sizePerPage=10
			
			currentURL = currentURL.replaceAll("&", " ");
			//System.out.println("확인용 : "+currentURL);
			// 확인용 : member/memberList.up?searchType=name searchWord=%EC%97%AC&sizePerPage=10
			
			
			request.setAttribute("goBackURL", currentURL);
			
			
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/productList.jsp");
				
				
		} else {
			//로그인 안한 경우 또는 일반사용자로 로그인한 경우
			String message = "관리자만 접근이 가능합니다.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	      //super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}

		
	}

}
