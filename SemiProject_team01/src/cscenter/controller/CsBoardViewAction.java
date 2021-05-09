package cscenter.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;
import cscenter.model.*;
import my.util.MyUtil;

public class CsBoardViewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// DB에 등록되어있는 모든 글을 페이징처리해서 보여주는 Action단
		
		String fk_bigcateno = request.getParameter("fk_bigcateno"); //카테고리 번호
				
		if(fk_bigcateno == null) {
			fk_bigcateno = "";
		}
		// *** 카테고리번호에 해당하는 제품들을 페이징 처리하여 보여주기 *** //
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
		// 카테고리 메뉴에서 카테고리명만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
		// currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
		
		String sizePerPage = request.getParameter("sizePerPage");
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		if(sizePerPage == null ) { 
			sizePerPage = "10";
		}
		// 한 페이지당 화면상에 보여줄 제품의 개수는 10 으로 한다. sizePerPage 는 ProductDAO 에서 상수로 설정해 두었음.
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자 아닌 문자를 입력한 경우 또는 
	    //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		
		try {
			Integer.parseInt(currentShowPageNo);
		}catch (NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		InterCsBoardDAO bdao = new CsBoardDAO();
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_bigcateno", fk_bigcateno);
		String bigcatename = bdao.getBigCategoryName(fk_bigcateno);
		
		request.setAttribute("bigcatename", bigcatename);
		
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage);
		
		 //  페이지바를 만들기 위해서 특정카테고리의 제품개수에 대한 총페이지수 알아오기(select)
		int totalPage = bdao.getTotalPage(fk_bigcateno);
		
		// 특정 카테고리에 속하는 제품들을 페이지바를 이용한 페이징 처리하여 조회(select)해오기 
		List<CsBoardVO> BoardList = bdao.selectBoardByCategory(paraMap, fk_bigcateno);
		request.setAttribute("BoardList", BoardList);
		request.setAttribute("sizePerPage", sizePerPage);
		
		/*
		 * String fk_bigcatename = bdao.getBigCategoryName(fk_bigcateno);
		 * request.setAttribute("fk_bigcatename", fk_bigcatename);
		 */
		
		// **** ========= 페이지바 만들기 ========= **** //
	      /*
	          1개 블럭당 10개씩 잘라서 페이지 만든다.
	          1개 페이지당  10개행을 보여준다라면 총 몇개 블럭이 나와야 할까? 
	             총 제품의 개수가 423개 이고, 1개 페이지당 보여줄 제품의 개수가 10개 이라면 
	          412/10 = 41.2 ==> 42(totalPage)        
	              
	          1블럭               1 2 3 4 5 6 7 8 9 10 [다음]
	          2블럭   [이전] 11 12 13 14 15 16 17 18 19 20 [다음]
	          3블럭   [이전] 21 22 23 24 25 26 27 28 29 30 [다음]
	          4블럭   [이전] 31 32 33 34 35 36 37 38 39 40 [다음]
	          5블럭   [이전] 41 42 
	       */
	      
	     
		// ==== !!! 공식 !!! ==== // 
		   /*
		       1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은  1 이다.
		       11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.   
		       21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
		       
		       currentShowPageNo      pageNo
		       --------------------------------------------------------------------------------------
		            1                   1  = ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1 
		            2                   1  = ( (2 - 1)/10 ) * 10 + 1
		            3                   1  = ( (3 - 1)/10 ) * 10 + 1
		            4                   1  = ( (4 - 1)/10 ) * 10 + 1
		            5                   1  = ( (5 - 1)/10 ) * 10 + 1
		            6                   1  = ( (6 - 1)/10 ) * 10 + 1
		            7                   1  = ( (7 - 1)/10 ) * 10 + 1
		            8                   1  = ( (8 - 1)/10 ) * 10 + 1
		            9                   1  = ( (9 - 1)/10 ) * 10 + 1
		            10                  1  = ( (10 - 1)/10 ) * 10 + 1
		            
		            11                 11  = ( (11 - 1)/10 ) * 10 + 1
		            12                 11  = ( (12 - 1)/10 ) * 10 + 1 
		            13                 11  = ( (13 - 1)/10 ) * 10 + 1
		            14                 11  = ( (14 - 1)/10 ) * 10 + 1
		            15                 11  = ( (15 - 1)/10 ) * 10 + 1
		            16                 11  = ( (16 - 1)/10 ) * 10 + 1
		            17                 11  = ( (17 - 1)/10 ) * 10 + 1
		            18                 11  = ( (18 - 1)/10 ) * 10 + 1
		            19                 11  = ( (19 - 1)/10 ) * 10 + 1
		            20                 11  = ( (20 - 1)/10 ) * 10 + 1  
		            
		            21                 21  = ( (21 - 1)/10 ) * 10 + 1 
		            22                 21  = ( (22 - 1)/10 ) * 10 + 1 
		            23                 21  = ( (23 - 1)/10 ) * 10 + 1 
		            ..                 21  = ( (.. - 1)/10 ) * 10 + 1 
		            29                 21  = ( (29 - 1)/10 ) * 10 + 1 
		            30                 21  = ( (30 - 1)/10 ) * 10 + 1 
		    */
		
		String pageBar = ""; 
		int blockSize = 10;// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		int loop = 1; // loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
		int pageNo = 0; // pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		
		// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! // 
	      pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1; 
	      
	   // **** [맨처음][이전] 만들기 **** //
	      // pageNo - 1 == 11 - 1 == 10 ==> currentShowPageNo
	      if( pageNo != 1 ) {
	         pageBar += "&nbsp;<a href='csBoardView.to?fk_bigcateno="+fk_bigcateno+"&currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[맨처음]</a>&nbsp;"; 
	         pageBar += "&nbsp;<a href='csBoardView.to?fk_bigcateno="+fk_bigcateno+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp;";
	      }
	      
	      while( !(loop > blockSize || pageNo > totalPage) ) {
	         
	         if( pageNo == Integer.parseInt(currentShowPageNo) ) {
	            pageBar += "&nbsp;<span>"+pageNo+"</span>&nbsp;"; 
	         }
	         else {
	            pageBar += "&nbsp;<a href='csBoardView.to?fk_bigcateno="+fk_bigcateno+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a>&nbsp;";    
	         }
	         
	         loop++;    // 1 2 3 4 5 6 7 8 9 10 
	         
	         pageNo++;  //  1  2  3  4  5  6  7  8  9 10
	                    // 11 12 13 14 15 16 17 18 19 20
	                    // 21 
	      }// end of while----------------------------------------------
	      
	      // **** [다음][마지막] 만들기 **** //
	      // pageNo ==> 11 
	      
	   //   if( !(pageNo > totalPage) ) {
	      if( pageNo <= totalPage ) {
	         pageBar += "&nbsp;<a href='csBoardView.to?fk_bigcateno="+fk_bigcateno+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a>&nbsp;"; 
	         pageBar += "&nbsp;<a href='csBoardView.to?fk_bigcateno="+fk_bigcateno+"&currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'>[마지막]</a>&nbsp;";
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
	      
	      
	      request.setAttribute("fk_bigcateno", fk_bigcateno);
		super.setViewPage("/WEB-INF/cscenter/CsBoardView.jsp");
	}

}