package member.controller;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class PointListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		

		if(loginuser !=null && !loginuser.getUserid().equals("admin")) {
		
			String userid = loginuser.getUserid();
			
			InterMemberDAO mdao = new MemberDAO();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
	        // 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
	        // currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
			
			String sizePerPage = "10";
			// 한 페이지당 화면상에 보여줄 회원의 개수
	        // 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
	        // sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
	        // "10" or "5" or "3" 
			
			if(currentShowPageNo == null ) {//처음 memberlist.up을 들어가면 데이터 전송이 없기 때문에  null이 발생한다.
					currentShowPageNo="1";
			}
	
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자 아닌 문자를 입력한 경우 또는 
	        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			try {
				Integer.parseInt(currentShowPageNo);
			}catch (NumberFormatException e) {
				currentShowPageNo="1";
			}

			
			//////////////////////////////////////////////////////////////////////////
			// ==== 날짜가 들어온 경우
			String from=request.getParameter("from");
			String to=request.getParameter("to");

			
			String fromdate="";
			if(from!=null) {
				String[] fArr = from.split("-");
				for(int i=0;i<fArr.length;i++) {
					fromdate+=fArr[i];
				}
			}
		
			
			
			String todate="";
			if(to!=null) {
				String[] toArr = to.split("-");
				for(int i=0;i<toArr.length;i++) {
					todate+=toArr[i];
				}
			}
		
		
				Map<String,String> paraMap = new HashMap<>();
				paraMap.put("currentShowPageNo", currentShowPageNo);
				paraMap.put("sizePerPage", sizePerPage);
				paraMap.put("userid", userid);
				// 검색어가 들어온 경우
				paraMap.put("fromdate", fromdate);
				paraMap.put("todate", todate);
				
				
				/*
				// 페이징처리를 위해서 회원 포인트 적립 내역의 총페이지 개수 알아오기(select)  
				int totalPage = mdao.selectTotalPointPage(paraMap);
			
				public int selectTotalPage(Map<String, String> paraMap) throws SQLException {

				int totalPage = 0;
				
				try {
					conn = ds.getConnection();
		
					String sql = " select ceil( count(*)/? ) "
							   + " from tbl_point"
							   + " where userid == ? ";
					
					// ======검색어가 있는경우 시작 =========== 
					String fromdate = paraMap.get("fromdate");
					String todate = paraMap.get("todate");
		
					
					if( fromdate != null && todate !=null) {
					// 검색어를 아예 안 쓰거나 공백(space)만 입력한 것이 아닌 검색어를 입력한 경우
						sql += " and fk_orderdate between ? and ? ";
						// 위치홀더는 데이터값에만 사용됨. 테이블명이나 컬럼명에는 위치홀더를 사용할 수 없다.
					}
					// ======검색어가 있는경우 끝 ===========
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("sizePerPage"));
		
					if( fromdate != null && todate !=null) {
						// 검색어를 아예 안 쓰거나 공백(space)만 입력한 것이 아닌 검색어를 입력한 경우
						pstmt.setString(2, paraMap.get("fromdate");
						pstmt.setString(3, paraMap.get("todate");
					}
					
					rs = pstmt.executeQuery();
					
					rs.next();
					
					totalPage = rs.getInt(1);	// 첫번째 컬럼값을 totalPage에 넣어준다
												// 회원 5명씩 보여준다면 페이지수는 ceil( count(*)/5 ) ==> 42
					
				} finally {
					close();
				}
				
				
				return totalPage;
			
			}
				/////////////////////////////////////////////////////////////////////////
				// 토탈페이지수 보다 큰 값을 입력하여 장난친 경우를 1페이지로 가게끔 막아주는 것 끝.
				if(Integer.parseInt(currentShowPageNo)>totalPage) {
					currentShowPageNo="1";
					paraMap.put("currentShowPageNo", currentShowPageNo);
					
				}
		
			if(Integer.parseInt(currentShowPageNo)>totalPage) {
				currentShowPageNo="1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
				
			}
			
			List<PointVO> PointList = mdao.selectPagingPoint(paraMap);
			
			
			
			// 페이징 처리를 회원의 적립금 목록 보여주기
	@Override
	public List<PointVO> selectPagingMember(Map<String, String> paraMap) throws SQLException {
		List<PointVO> PointList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();

			String sql = "select fk_orderdate, point, fk_odrcode, status\n"+
						 "from\n"+
						 "(\n"+
						 "    select rownum as rno, fk_orderdate, point, fk_odrcode, status\n"+
						 "    from\n"+
						 "    (\n"+
						 "    select fk_orderdate, point, fk_odrcode, status\n"+
						 "    from tbl_point \n"+
						 "    where fk_userid == ? ";
			
			// ======검색어가 있는경우 시작 =========== 
			String fromdate = paraMap.get("fromdate");
			String todate = paraMap.get("todate");

			
			if( fromdate != null && todate != null) {
			// 날짜를 조회한 경우
				sql += " and fk_orderdate between ? and ? ";
				// 위치홀더는 데이터값에만 사용됨. 테이블명이나 컬럼명에는 위치홀더를 사용할 수 없다.
			}
			// ======검색어가 있는경우 끝 ===========
			
			sql += "    order by fk_orderdate desc"+
				   "    ) V\n"+
				   ") T\n"+
				   "where rno between ? and ?";
			
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);

			
			if( fromdate != null && todate != null) {
				// 날짜 조회한 경우
				
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, fromdate);
				pstmt.setString(3, todate);
				pstmt.setInt(4, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(5, (currentShowPageNo * sizePerPage));
			} else {
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				pointVO pointvo = new pointVO();
				
				pointvo.
				
				pointList.add(pointvo);
				
			}//end of while(rs.next())------------------------------------------------
			

		} finally {
			close();
		}
		
		return pointList;
	}
			
			
			
			
			
			request.setAttribute("pointList", pointList);
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("from", from);
			request.setAttribute("to", to);
		
			
			
			String pageBar = "" ;
			
			int blockSize = 10;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop=1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
		
			int pageNo = 0;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
			
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //    
			pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1 ;
			
			///////////////////////////////////////
			if(from== null ) {
				from="";
			}
			if(to== null ) {
				to="";
			}
			//////////////////////////////////////
							
			// **** [맨처음][이전] 만들기 **** //
			if(pageNo!=1) { 
				pageBar += "&nbsp;<a href='pointList.to?currentShowPageNo=1&sizePerPage="+sizePerPage+"&fromdate="+fromdate+"&todate="+todate+"'>[맨처음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='pointList.to?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&fromdate="+fromdate+"&todate="+todate+"'>[이전]</a>&nbsp;";
			}
			
			while(!(loop > blockSize || pageNo>totalPage)) {
				
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "&nbsp;<span style='border: solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</span>&nbsp;"; 
				}
				else {
					pageBar += "&nbsp;<a href='pointList.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&fromdate="+fromdate+"&todate="+todate+"'>"+pageNo+"</a>&nbsp;"; 
				}
				loop++;
				
				pageNo++; //             1  2  3  4  5  6  7  8  9 10 [다음][마지막]
				          // [맨처음][이전]11 12 13 14 15 16 17 18 19 20 [다음][마지막]
				          // [맨처음][이전]21 22 23 24 25 26 27 28 29 30 [다음][마지막]
						  // [맨처음][이전]31 32 33 34 35 36 37 38 39 40 [다음][마지막]
				          // 41
			} // end of while-----------------------
			
			
			// **** [다음][마지막] 만들기 **** //
			// pageNo ==> 11
			// pageNo ==> 21
			// pageNo ==> 31
			// pageNo ==> 41
			// pageNo ==> 42
			if( pageNo<=totalPage) {
				pageBar += "&nbsp;<a href='pointList.to?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&fromdate="+fromdate+"&todate="+todate+"'>[다음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='pointList.to?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&fromdate="+fromdate+"&todate="+todate+"'>[마지막]</a>&nbsp;";
			}
			
			request.setAttribute("pageBar", pageBar);
			
			
			
			
			*/
			
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/pointList.jsp");
		
		
		}
		
		else if(loginuser != null && loginuser.getUserid().equals("admin")){
			
			String message = "관리자는 이용할 수 없는 페이지입니다.";
			String loc = request.getContextPath()+"/login/login.to";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}
		else  {
			String message = "로그인 후 이용 가능합니다.";
			String loc = request.getContextPath()+"/login/login.to";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}

