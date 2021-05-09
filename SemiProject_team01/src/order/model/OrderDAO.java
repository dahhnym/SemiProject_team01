package order.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import cart.model.CartVO;
import product.model.ProductDetailVO;
import product.model.ProductVO;
import review.model.ReviewVO;


public class OrderDAO implements InterOrderDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public OrderDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	// 로그인한 사용자의 주문 목록 조회하기
		@Override
		public List<OrderDetailVO> selectProductOrder(String userid) throws SQLException {
			List<OrderDetailVO> orderList = new ArrayList<OrderDetailVO>();
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " select a.odrdetailno, b.pdetailnum, c.pnum, c.pimage1, c.pname, a.odrqty, b.optionname, c.saleprice, b.pqty "+
		        		 " from tbl_odrdetail a join tbl_proddetail b "+
		        		 " on a.fk_pdetailnum = b.pdetailnum "+
		        		 " join tbl_product c "+
		        		 " on b.fk_pnum = pnum "+
		        		 " where a.fk_userid = ? ";
		         
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, userid);
		         
		         rs = pstmt.executeQuery();
		         
		         while(rs.next()) {
		        	 
		        	 int odrdetailno=rs.getInt(1);
		        	 int pdetailnum = rs.getInt(2);
		        	 int pnum = rs.getInt(3);
		        	 String pimage1 = rs.getString(4);
		        	 String pname= rs.getString(5);
		        	 int odrqty = rs.getInt(6);
		        	 String optionname = rs.getString(7);
		        	 int saleprice = rs.getInt(8);
		        	 int pqty=rs.getInt(9);
		        	 
		        	OrderDetailVO odtvo = new OrderDetailVO();  
		        	odtvo.setOdrdetailno(odrdetailno);
		        	odtvo.setOdrqty(odrqty);
					
					ProductVO pvo = new ProductVO();
					pvo.setPnum(pnum);
					pvo.setPimage1(pimage1);
					pvo.setPname(pname);
					pvo.setSaleprice(saleprice);
					
					ProductDetailVO pdtvo = new ProductDetailVO();
					pdtvo.setPdetailnum(pdetailnum);
					pdtvo.setOptionname(optionname);
					pdtvo.setPqty(pqty);
					
					odtvo.setPvo(pvo);
					odtvo.setPdtvo(pdtvo);
					
					orderList.add(odtvo);
		        	 	
		         }// end of while---------------------------------
		                  
		      } finally {
		         close();
		      }
		      
		      return orderList;
		}

		

    // 장바구니 테이블에서 특정제품을 장바구니에서 비우기 
	@Override
	public int delCart(String cartno) throws SQLException {
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_cart "
	                  + " where cartno = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, cartno);
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}

	// 주문상세목록 가져오기
	@Override
	public HashMap<String, String> selectCartSum(String userid) throws SQLException {
		HashMap<String, String> sumMap = new HashMap<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select nvl(sum(oqty * saleprice), 0) AS SUMTOTALPRICE "+
	                    " from tbl_cart A join tbl_product B "+
	                    " on A.fk_pnum = B.pnum "+
	                    " where A.fk_userid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         sumMap.put("SUMTOTALPRICE", rs.getString("SUMTOTALPRICE"));
	                  
	      } finally {
	         close();
	      }
	      
	      return sumMap;
	}


	// 주문정보 알아오기
	@Override
	public OrderVO selectOrderInfo(int odrcode) throws SQLException{
		OrderVO orderInfo = new OrderVO();

		try {
			  conn = ds.getConnection();
			  
			  String sql = "select odrcode,totalcost,orderdate,odrstatus,odrprgrss,invoicenum \n"+
					  ",odrname,payment,deliname,delimobile,delipostcode,deliaddress,delidtaddress,deliextddress,delimsg\n"+
					  "from tbl_order\n"+
					  "where odrcode = ? ";
			  
			  pstmt = conn.prepareStatement(sql);
			  pstmt.setInt(1, odrcode);
			  
			  rs = pstmt.executeQuery();
			  
			  while(rs.next()) {
				  
				  orderInfo.setOdrcode(rs.getInt(1));
				  orderInfo.setTotalcost(rs.getInt(2));
				  orderInfo.setOrderdate(rs.getString(3));
				  orderInfo.setOdrstatus(rs.getString(4));
				  orderInfo.setOdrprgrss(rs.getString(5));
				  orderInfo.setInvoicenum(rs.getInt(6));
				  orderInfo.setOdrname(rs.getString(7));
				  orderInfo.setPayment(rs.getString(8));
				  orderInfo.setDeliname(rs.getString(9));
				  orderInfo.setDelimobile(rs.getString(10));
				  orderInfo.setDelipostcode(rs.getString(11));
				  orderInfo.setDeliaddress(rs.getString(12));				
				  orderInfo.setDelidtaddress(rs.getString(13));
				  orderInfo.setDeliextddress(rs.getString(14));
				  orderInfo.setDelimsg(rs.getString(15));
			  
				  
			  }
				  
		} finally {
			close();
		}
		
		
		return orderInfo;
	}


	////////////////// 주문하기 진행 과정 ///////////////////
	
	
	
	////
	
    // 1. tbl_order에서  생성하면 주문코드 반환
	@Override
	public int orderAdd(Map<String, Object> paraMap) throws SQLException {
		int isSuccess = 0;
	      int n1=0, n2=0, n3=0, n4=0, n5=0;

	      try {
	    	  conn = ds.getConnection();
	          
	          conn.setAutoCommit(false);// 수동커믹
	          
	          // 우선은 userid 로만 받아서 하는 걸로 test 하기
	          
	          String sql = " insert into tbl_order( fk_userid, totalcost, odrname, odrmobile,odremail,odrpostcode,odraddress,odrdtaddress,odrextddress,"+ 
	          		"payment ,deliname,delimobile,delipostcode,deliaddress,delidtaddress,deliextddress,delimsg,odrcode) values\r\n" + 
	          		"(?, ?,  ?, ?,  ?, ?, ?, ?, "+ 
	          		"? , ?, ?, ?, ?, ?, ?, ?)";
	          
	          pstmt = conn.prepareStatement(sql);
	          
	          pstmt.setString(1, (String) paraMap.get("userid"));
	          pstmt.setString(2, (String) paraMap.get("totalsum"));
	          
	          pstmt.setString(3, (String) paraMap.get("odrname"));
	          pstmt.setString(4, (String) paraMap.get("odrmobile"));
	          pstmt.setString(5, (String) paraMap.get("odremail"));
	          pstmt.setString(6, (String) paraMap.get("odrpostcode"));
	          pstmt.setString(7, (String) paraMap.get("odraddress"));
	          pstmt.setString(8, (String) paraMap.get("odrdtaddress"));
	          pstmt.setString(9, (String) paraMap.get("odrextddress"));
	          
	          pstmt.setString(10, (String) paraMap.get("payment"));
	          
	          pstmt.setString(11, (String) paraMap.get("deliname"));
	          pstmt.setString(12, (String) paraMap.get("delimobile"));
	          pstmt.setString(13, (String) paraMap.get("delipostcode"));
	          pstmt.setString(14, (String) paraMap.get("deliaddress"));
	          pstmt.setString(15, (String) paraMap.get("delidtaddress"));
	          pstmt.setString(16, (String) paraMap.get("deliextddress"));
	          pstmt.setString(17, (String) paraMap.get("delimsg"));
	          pstmt.setInt(18, (int) paraMap.get("odrcode"));
	          	          
		         n1 = pstmt.executeUpdate();
		          System.out.println("~~~~~~n1 : " + n1);
		        
		         
		 //2. 주문상세테이블에 insert하기 
		 if(n1 == 1) {

    	 String[] pnumArr = (String[]) paraMap.get("pnumArr");
         String[] oqtyArr = (String[]) paraMap.get("oqtyArr");
         String[] salepriceArr = (String[]) paraMap.get("salepriceArr");
         String[] pdetailnumArr = (String[]) paraMap.get("pdetailnumArr");
         String[] optionnameArr = (String[]) paraMap.get("optionnameArr");
         String[] pnameArr = (String[]) paraMap.get("pnameArr");
         
         int cnt = 0; 
         for(int i=0; i<pnumArr.length; i++) {

	         sql = "insert into tbl_odrdetail (fk_userid,fk_pnum,fk_pdetailnum,odrqty,odrprice ,optionname,fk_odrcode)"+
	          		 "values (?,to_number(?),to_number(?),to_number(?),to_number(?),? ,?)";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, (String) paraMap.get("userid"));
	          pstmt.setString(2, pnumArr[i]);
	          pstmt.setString(3, pdetailnumArr[i]);
	          pstmt.setString(4, oqtyArr[i]);
	          pstmt.setString(5, (String) paraMap.get("totalprice"));
	          pstmt.setString(6, optionnameArr[i]);
	          pstmt.setInt(7, (int) paraMap.get("odrcode"));
	          
	          pstmt.executeUpdate();
              cnt++;
          }// end of for----------------------
          
	          if(cnt == pnumArr.length) {
	             n2=1;
	          }
	          System.out.println("~~~~~~n2 : " + n2);
         }// end of if---------------------------

          // 3. 제품테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
         if(n2==1) {
        	 
        	 
             String[] pdetailnumArr = (String[]) paraMap.get("pdetailnumArr");
             String[] oqtyArr = (String[]) paraMap.get("oqtyArr");

             
             int cnt = 0;
             for(int i=0; i<pdetailnumArr.length; i++) {
            	  sql = "update tbl_proddetail set pqty = pqty - ? \n"+
            			 "where pdetailnum = ?";
             
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(oqtyArr[i]) );
                pstmt.setString(2, pdetailnumArr[i] );
                
                pstmt.executeUpdate();
                
                cnt++;
             	}// end of for----------------------
             
	             if(cnt == pdetailnumArr.length) {
	                n3=1;
	             }
             }
         System.out.println("~~~~~~n3: " + n3);
	            	 
	            	
	         
	             
	       // 4. 장바구니 테이블에서 cartnum 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리) 
	         if( paraMap.get("cartnum") != null && n1==1 ) {
	               
	             sql = " delete from tbl_cart "
	                + " where cartnum in ("+ (String)paraMap.get("cartnum") +") ";

	             pstmt = conn.prepareStatement(sql);
	             n4 = pstmt.executeUpdate(); 
	       
	          }// end of if----------------------------
	          
	         if( paraMap.get("cartnum") == null && n1==1 ) {
	             // "제품 상세 정보" 페이지에서 "바로주문하기" 를 한 경우 
	             // 장바구니 번호인 cartnum 이 없는 것이다.
	             n4 = 1;    
	        
	          }// end of if----------------------------
	         
	         
	          System.out.println("~~~~~~n4 : " + n4);

	         
	         
	      // 5. 회원 테이블에서 로그인한 사용자의 사용point를 감하고 적립point 더하기(update)(수동커밋처리) 
	         if(n4 > 0) {
	             sql = " update tbl_member set point = point - ? + ? " 
	                + " where userid = ? ";
	             
	             pstmt = conn.prepareStatement(sql);
	             
	             pstmt.setInt(1, Integer.parseInt((String)paraMap.get("usePoint")) );
	             pstmt.setInt(2, Integer.parseInt((String)paraMap.get("rvsPoint")) );
	             pstmt.setString(3, (String)paraMap.get("userid") );
	             
	             n5 = pstmt.executeUpdate();
	             
	             System.out.println("~~~~~~n5 : " + n5);
	          }// end of if----------------------------------
	         
	         
	       // 6. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	         if(n1*n2*n3*n4*n5 > 0) {
	             
	             conn.commit();
	             
	             conn.setAutoCommit(true); 
	             // 자동커밋으로 전환
	          
	             System.out.println("n1*n2*n3*n4*n5 = " + (n1*n2*n3*n4*n5) );
	             
	             isSuccess = 1;
	          }
	         
	      
	      } catch(SQLException e) {
	    	  
	    	  // 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 
		    
	    	  
	    	  conn.rollback();
		            
	         conn.setAutoCommit(true); 
	         // 자동커밋으로 전환
	            
	         isSuccess = 0;
		         
	      } finally {
	    	  close();
	      }
	      
		return isSuccess;
	   
	}

	// 주문코드 알아오기
	@Override
	public int getOdrcode(String userid) throws SQLException {
		int odrcode = 0;
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = "select fk_odrcode\n"+
	        		  "        from tbl_odrdetail\n"+
	        		  "        where fk_userid= ?";
	        		          
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, userid);
	          rs = pstmt.executeQuery();
	          
	          rs.next();
	          
	          odrcode = rs.getInt("fk_odrcode");
	          
	      } finally {
	         close();
	      }
	      
	      return odrcode;
	}

	
	// cartnum 알아오기
	@Override
	public int getCartnum(String userid) throws SQLException {
		int cartnum = 0;
	      
	      try {
	          conn = ds.getConnection();
	          
				
				String sql = "select cartnum\n"+
				"from tbl_cart\n"+
				"where fk_userid= ? ";
	        		          
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, userid);
	          rs = pstmt.executeQuery();
	          
	          rs.next();
	          
	          cartnum = rs.getInt("cartnum");
	          
	      } finally {
	         close();
	      }
	      
	      return cartnum;
	}


	// 주문내역 리스트 가져오기 (select)
	@Override
	public List<OrderDetailVO> orderList(String userid) throws SQLException {

		List<OrderDetailVO> orderList =  new ArrayList<>();
	      
	      try {
	          conn = ds.getConnection();
	          
				
	          String sql = "select C.odrcode, A.pimage1, pname, optionname, odrqty, odrstatus, odrprgrss,orderdate,odrprice,A.pnum \n"+
	        		  "from tbl_product A join tbl_odrdetail B \n"+
	        		  "on A.pnum = B.fk_pnum \n"+
	        		  "join tbl_order C \n"+
	        		  "on B.fk_odrcode = C.odrcode  \n"+
	        		  "where B.fk_userid = ? "+
	        		  " order by odrcode desc";
	        		          
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, userid);
	          rs = pstmt.executeQuery();
	          
	          while(rs.next()) {
	        	  int odrcode = rs.getInt(1);
	        	  String pimage1 = rs.getString(2);
	        	  String pname= rs.getString(3);
	        	  String optionname = rs.getString(4);
	        	  int odrqty = rs.getInt(5);
	        	  String odrstatus = rs.getString(6);
	        	  String odrprgrss = rs.getString(7);
	        	  String orderdate = rs.getString(8);
	        	  int odrprice = rs.getInt(9);   
	        	  int pnum = rs.getInt(10);
	        	  
	        	  OrderDetailVO odtvo = new OrderDetailVO();
	        	  odtvo.setFk_odrcode(odrcode);
	        	  odtvo.setOptionname(optionname);
	        	  odtvo.setOdrqty(odrqty);
	        	  odtvo.setOdrprice(odrprice);
	        	  
	        	  OrderVO ovo = new OrderVO();
	        	  ovo.setOdrstatus(odrstatus);
	        	  ovo.setOdrprgrss(odrprgrss);
	        	  ovo.setOrderdate(orderdate);
	        	  
	        	  ProductVO pvo = new ProductVO();
	        	  pvo.setPimage1(pimage1);
	        	  pvo.setPname(pname);
	        	  pvo.setPnum(pnum);
	        	  
	        	  odtvo.setOvo(ovo);
	        	  odtvo.setPvo(pvo);
	        	  
	        	  orderList.add(odtvo);
	        	  
	          }	          
	      } finally {
	         close();
	      }
	      
	      return orderList;
	
	}
	
	// 한 주문에 대한 리스트 가져오기
		@Override
		public List<OrderDetailVO> orderList(String userid, int odrcode) throws SQLException {

			List<OrderDetailVO> orderList =  new ArrayList<>();
		      
		      try {
		          conn = ds.getConnection();
		          
					
		          String sql = "select A.pimage1, pname, optionname, odrqty, odrstatus, odrprgrss,orderdate,odrprice,A.pnum \n"+
		        		  "from tbl_product A join tbl_odrdetail B \n"+
		        		  "on A.pnum = B.fk_pnum \n"+
		        		  "join tbl_order C \n"+
		        		  "on B.fk_odrcode = C.odrcode  \n"+
		        		  "where B.fk_userid = ? and C.odrcode = ?"+
		        		  " order by odrcode desc";
		        		          
		          
		          pstmt = conn.prepareStatement(sql);
		          pstmt.setString(1, userid);
		          pstmt.setInt(1, odrcode);
		          rs = pstmt.executeQuery();
		          
		          while(rs.next()) {
		        	  String pimage1 = rs.getString(1);
		        	  String pname= rs.getString(2);
		        	  String optionname = rs.getString(3);
		        	  int odrqty = rs.getInt(4);
		        	  String odrstatus = rs.getString(5);
		        	  String odrprgrss = rs.getString(6);
		        	  String orderdate = rs.getString(7);
		        	  int odrprice = rs.getInt(8);   
		        	  int pnum = rs.getInt(9);
		        	  
		        	  OrderDetailVO odtvo = new OrderDetailVO();
		        	  odtvo.setFk_odrcode(odrcode);
		        	  odtvo.setOptionname(optionname);
		        	  odtvo.setOdrqty(odrqty);
		        	  odtvo.setOdrprice(odrprice);
		        	  
		        	  OrderVO ovo = new OrderVO();
		        	  ovo.setOdrstatus(odrstatus);
		        	  ovo.setOdrprgrss(odrprgrss);
		        	  ovo.setOrderdate(orderdate);
		        	  
		        	  ProductVO pvo = new ProductVO();
		        	  pvo.setPimage1(pimage1);
		        	  pvo.setPname(pname);
		        	  pvo.setPnum(pnum);
		        	  
		        	  odtvo.setOvo(ovo);
		        	  odtvo.setPvo(pvo);
		        	  
		        	  orderList.add(odtvo);
		        	  
		          }	          
		      } finally {
		         close();
		      }
		      
		      return orderList;
		
		}

///////////////////////////////////////////////  리뷰   //////////////////////////////////////////////////////////

	// 작성한 리뷰 리스트 보여주기
	@Override
	public List<OrderDetailVO> writtenReview(String userid) throws SQLException {

		List<OrderDetailVO> wtrvList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = "select A.pnum, A.pimage1, A.pname, B.optionname, C.stars, C.rvdate\n"+
					 "from tbl_product A join tbl_odrdetail B\n"+
					 "on pnum = B.fk_pnum\n"+
					 "join tbl_review C\n"+
					 "on odrdetailno = fk_odrdetailno \n"+
					 "where B.fk_userid= ? and B.odrdetailno=fk_odrdetailno";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1,userid);
			
			 rs = pstmt.executeQuery();
			 
			 
			 
			 while(rs.next()) {
				 
				 ProductVO pvo = new ProductVO();
				 pvo.setPname(rs.getString(1));
				 pvo.setPimage1(rs.getString(2));
				 pvo.setPname(rs.getString(3));
				 
	        	 OrderDetailVO odtvo = new OrderDetailVO();
	        	 odtvo.setOptionname(rs.getString(4));
	        	 
	        	 ReviewVO rvo = new ReviewVO();
	        	 rvo.setStars(rs.getInt(5));
	        	 rvo.setRvdate(rs.getString(6));
				 
	        	 wtrvList.add(odtvo);
	        	 
			 }// end of while(rs.next())---------------------------------------

			 
		} finally {
			close();
		}
		
		return wtrvList;
	}


	// 보류중인 리뷰 갯수 세오기
	@Override
	public int pdrvListNo(String userid) throws SQLException {
		int pdrvListNo = 0;
		try {
			 conn = ds.getConnection();
			 
			 String sql="select count(*)\n" + 
			 		"from(\n" + 
			 		"select rno, pname, pimage1, optionname\n" + 
			 		"from \n" + 
			 		"(\n" + 
			 		"    select rownum AS rno, pimage1, pname, optionname\n" + 
			 		"    from \n" + 
			 		"    (\n" + 
			 		"        select pimage1, pname, optionname \n" + 
			 		"        from tbl_product A join tbl_proddetail B\n" + 
			 		"        on A.pnum=B.fk_pnum\n" + 
			 		"        where pnum = (select fk_pnum\n" + 
			 		"        from tbl_odrdetail\n" + 
			 		"        where fk_userid = ? and odrdetailno != (select fk_odrdetailno from tbl_review where fk_userid = ? ))\n" + 
			 		"    )C\n" + 
			 		")\n" + 
			 		")";
			 pstmt = conn.prepareStatement(sql);

			 pstmt.setString(1,userid);
			 pstmt.setString(2,userid);
			 
			 rs = pstmt.executeQuery();
			 rs.next();
			 pdrvListNo=rs.getInt(1);
			 
		} finally {
			close();
		}
		return pdrvListNo;
	}
	
	// 미성한 리뷰 리스트 보여주기
	@Override
	public List<OrderDetailVO> pendingReview(String userid) throws SQLException {


			List<OrderDetailVO> pdrvList = new ArrayList<>();
			
			try {
				 conn = ds.getConnection();
				 
				 String sql = "select A.pnum, A.pimage1, A.pname, B.optionname\n"+
						 "from tbl_product A join tbl_odrdetail B on A.pnum = B.fk_pnum\n"+
						 "where fk_userid = ? and B.odrdetailno not in (select fk_odrdetailno from tbl_review where fk_userid = ?)";

				 pstmt = conn.prepareStatement(sql);
				 
				 pstmt.setString(1,userid);
				 pstmt.setString(2,userid);
				
				 rs = pstmt.executeQuery();				 
				 
				 while(rs.next()) {
					 
					 ProductVO pvo = new ProductVO();
					 pvo.setPnum(rs.getInt(1));
					 pvo.setPname(rs.getString(2));
					 pvo.setPimage1(rs.getString(3));
					 
					 OrderDetailVO odtvo = new OrderDetailVO();
					 odtvo.setOptionname(rs.getString(4));
					 
					 pdrvList.add(odtvo);
				 }// end of while(rs.next())---------------------------------------

				 
			} finally {
				close();
			}
			
			return pdrvList;
		}


		// 작성한 리뷰 갯수 세오기
		@Override
		public int wtrvListNo(String userid) throws SQLException {
			int wtrvListNo = 0;
			try {
				 conn = ds.getConnection();
				 
				 String sql="select count(*)\n" + 
				 		"from(\n" + 
				 		"select rno, pname, pimage1, optionname\n" + 
				 		"from \n" + 
				 		"(\n" + 
				 		"    select rownum AS rno, pimage1, pname, optionname\n" + 
				 		"    from \n" + 
				 		"    (\n" + 
				 		"        select pimage1, pname, optionname \n" + 
				 		"        from tbl_product A join tbl_proddetail B\n" + 
				 		"        on A.pnum=B.fk_pnum\n" + 
				 		"        where pnum = (select fk_pnum\n" + 
				 		"        from tbl_odrdetail\n" + 
				 		"        where fk_userid = ? and odrdetailno = (select fk_odrdetailno from tbl_review where fk_userid = ? ))\n" + 
				 		"    )C\n" + 
				 		")\n" + 
				 		")";
				 pstmt = conn.prepareStatement(sql);

				 pstmt.setString(1,userid);
				 pstmt.setString(2,userid);
				 
				 rs = pstmt.executeQuery();
				 rs.next();
				 wtrvListNo=rs.getInt(1);
				 
			} finally {
				close();
			}
			return wtrvListNo;
		}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		@Override
		public int getSeq_tbl_order() throws SQLException {
			int seq = 0;
		      
		      try {
		          conn = ds.getConnection();
		          
		          String sql = "select seq_order_odrcode.nextval AS seq \n"+
		        		  "from dual";
		          
		          pstmt = conn.prepareStatement(sql);
		          
		          rs = pstmt.executeQuery();
		          
		          rs.next();
		          
		          seq = rs.getInt("seq");
		          
		      } finally {
		         close();
		      }
		      
		      return seq;
		}
	
	
	
}
