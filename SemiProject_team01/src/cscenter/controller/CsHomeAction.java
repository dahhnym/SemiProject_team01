package cscenter.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import cscenter.model.FaqboardDAO;
import cscenter.model.FaqboardVO;
import cscenter.model.InterFaqboardDAO;
import my.util.MyUtil;

public class CsHomeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getFaqCategoryList(request);
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
        // 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
        // currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
		String sizePerPage = "10";
		// 한 페이지당 화면상에 보여줄 회원의 개수
        // 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
        // sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
        // "10" or "5" or "3" 
		
		if(currentShowPageNo == null ) {
			currentShowPageNo = "1";
		}
		
		try {
			Integer.parseInt(currentShowPageNo);
		} catch (NumberFormatException e){
			currentShowPageNo = "1";
		}
		
		InterFaqboardDAO fadao = new FaqboardDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage);
		
		int totalPage = fadao.selectTotalPage(paraMap);
		
		if( Integer.parseInt(currentShowPageNo)   > totalPage ) {
			currentShowPageNo = "1";
			paraMap.put("currentShowPageNo", currentShowPageNo);
		}
		
		request.setAttribute("sizePerPage", sizePerPage);
		 
		List<FaqboardVO> faqList = fadao.selectPagingFaq(paraMap);
		
		request.setAttribute("faqList", faqList); //리스트 뷰단으로 넘겨줌
		request.setAttribute("sizePerPage", sizePerPage);
		
		String pageBar = "";
		int blockSize = 10;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1;
		// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
		
		int pageNo = 0;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		
		// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //    
		pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1 ;
				
		// ** [맨처음] [이전] 만들기**//
		if( pageNo != 1 ) {
			pageBar += "&nbsp;<a href='csHome.to?currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[<<]</a>&nbsp;";
			pageBar += "&nbsp;<a href='csHome.to?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp;"; 
		}				
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
			pageBar += "&nbsp;<span style = 'padding:2px 4px;'>"+pageNo+"</span>&nbsp;";
			} else {
			pageBar += "&nbsp;<a href='csHome.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a>&nbsp;"; 
			}
			
			loop++;
			pageNo++;
		}// end of while ---------------------------------------
		
		// ** [다음] [마지막] 만들기**//
		if( pageNo <= totalPage ) {
			System.out.println("h");
		pageBar += "&nbsp;<a href='csHome.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a>&nbsp;"; 
		pageBar += "&nbsp;<a href='csHome.to?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'> [>>]</a>&nbsp;"; 
		}
		
		
		request.setAttribute("pageBar", pageBar);
		
		
		///////////////////////////////////////////////////////////////////
		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ***//
		String currentURL = MyUtil.getCurrentURL(request);
		//회원조회를 했을 시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 쓰임.
		
		//System.out.println("~~~ 확인용 currentURL : " + currentURL);
		//~~~ 확인용 currentURL : member/memberList.up?currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%98%81
		
		currentURL = currentURL.replaceAll("&", " ");
		
		request.setAttribute("goBackURL", currentURL);
		//System.out.println("~~~ 확인용 currentURL : " + currentURL);
		
		super.setViewPage("/WEB-INF/cscenter/CsHome.jsp");
		
	}

}
