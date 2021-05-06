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
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
		super.goBackURL(request);

		// == 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다 ==
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getUserid())){	//관리자(admin)로 로그인한 경우
			InterMemberDAO mdao = new MemberDAO();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			String sizePerPage = request.getParameter("sizePerPage");
			
			if(currentShowPageNo == null ) {
				currentShowPageNo = "1";
			}
			
			if(sizePerPage == null || !("10".equals(sizePerPage) || "20".equals(sizePerPage) || "30".equals(sizePerPage)) ) {
				sizePerPage = "10";
			}
			
			try {
				Integer.parseInt(currentShowPageNo); 
			} catch (NumberFormatException e) { // 웹브라우저 주소창에서 currentShowPageNo 에 숫자 아닌 문자를 입력한 경우 또는 int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다.
				currentShowPageNo = "1";
			}
			////////////////////////////////////////////////////////
			// == 검색어가 들어온 경우 ==
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			// searchWord 경우의 수 -> null, 공백, 검색어
			
			//System.out.println("확인용 searchType: "+searchType);
			//System.out.println("확인용 searchWord: "+searchWord);
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			// 검색어가 들어온 경우
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			int totalPage = mdao.selectTotalPage(paraMap);
			
			if(Integer.parseInt(currentShowPageNo) > totalPage) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
			
			
			List<MemberVO> memberList = mdao.selectPagingMember(paraMap);	// DB 테이블의 행 하나하나가 MemberVO 이다
			
			request.setAttribute("memberList", memberList);
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			
			
			String pageBar = "";
			
			int blockSize = 5;
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
			
			int pageNo = 0;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //    
			pageNo  = ( (Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1; 
			
			if(searchType == null) {
				searchType = "";
			}
			
			if(searchWord == null) {
				searchWord = "";
			}
			
			// *** [맨처음] [이전] 만들기 *** //
			if( pageNo != 1 ) {
				pageBar += "&nbsp;<a href='memberList.to?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='memberList.to?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
			}
			
			
			while(!(loop > blockSize || pageNo > totalPage )) {	// blockSize가 현재 10이므로 loop가 11로 넘어가면 안된다 따라서 loop가 blockSize인 10보다 커지면 while문 탈출
																// totalPage보다도 pageNo가 커지면 안된다 현재는 totalPage가 42인데 pageNo가 계속해서 반복하면서 43,44 나오면 안된다..
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "&nbsp;<span style='font-weight: bolder; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
				
				} else {
					pageBar += "&nbsp;<a href='memberList.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;";
				
				}
				loop++;
				pageNo++;
				
			}//end of while() ----------------------------------------------
			
			// *** [다음] [마지막] 만들기 *** //
			if( pageNo <= totalPage ) {
				pageBar += "&nbsp;<a href='memberList.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='memberList.to?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a>";
			} 
			
			
			request.setAttribute("pageBar", pageBar);
			
			// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 
			String currentURL = MyUtil.getCurrentURL(request);
			// 회원조회를 했을 시 현재 그 페이지로 그대로 되돌아가길 위한 용도
			
			currentURL = currentURL.replaceAll("&", " ");
			
			request.setAttribute("goBackURL", currentURL);
			
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/memberList.jsp");
				
				
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
