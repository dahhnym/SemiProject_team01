package cart.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


import product.model.*;

public class CartDAO implements InterCartDAO {


	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public CartDAO() {
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

	
	   
	@Override
	public List<CartVO> cartList(String userid) throws SQLException { //괄호에 String userid넣어야함
		
		List<CartVO> cartList =  new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select C.fk_pnum, P.pimage1,  P.pname, C.oqty, D.optionname, P.saleprice, C.fk_pdetailnum, C.cartnum, D.pqty " +
					" from tbl_cart C join tbl_product P "+
					" on C.fk_pnum = P.pnum "+
					" join " +
					" tbl_proddetail D " +
					" on C.fk_pdetailnum = D.pdetailnum "+
					" where C.fk_userid = ? " +
					" order by C.cartnum desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				
				
			
				int fk_pnum = rs.getInt(1);
				String pimage1 = rs.getString(2);
				String pname= rs.getString(3);
				int oqty = rs.getInt(4);
				String optionname = rs.getString(5);
				int saleprice = rs.getInt(6);
				int fk_pdetailnum = rs.getInt(7);
				int cartnum=rs.getInt(8);
				int pqty=rs.getInt(9);
				
				CartVO cartvo = new CartVO();  
				cartvo.setFk_pnum(fk_pnum);
				cartvo.setOqty(oqty);
				cartvo.setFk_pdetailnum(fk_pdetailnum);
		//		cartvo.setTotalPrice(oqty);
				cartvo.setCartnum(cartnum);
				
				ProductVO pvo = new ProductVO();
				pvo.setPimage1(pimage1);
				pvo.setPname(pname);
				pvo.setSaleprice(saleprice);
				
				ProductDetailVO pdetailvo = new ProductDetailVO();
				pdetailvo.setOptionname(optionname);
				pdetailvo.setPqty(pqty);
				
				cartvo.setPvo(pvo);
				cartvo.setPdetailvo(pdetailvo);
				
				cartList.add(cartvo);
			}
		
		}finally {
			close();
		}
		
		return cartList;
		
	}

	
	
	// 위시리스트 보여주기 (select)
	@Override
	public List<WishListVO> wishList(String userid) throws SQLException {


		
		List<WishListVO> wishList =  new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select W.fk_pnum, P.pimage1,  P.pname, W.oqty, D.optionname, P.saleprice, W.fk_pdetailnum, W.wnum "+
						 " from tbl_wishlist W join tbl_product P "+
						 " on W.fk_pnum = P.pnum "+
						 " join "+
						 " tbl_proddetail D "+
						 " on W.fk_pdetailnum = D.pdetailnum "+
						 " where W.fk_userid = ? "+
						 " order by W.wnum desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				
				int fk_pnum = rs.getInt(1);
				String pimage1 = rs.getString(2);
				String pname= rs.getString(3);
				int oqty = rs.getInt(4);
				String optionname = rs.getString(5);
				int saleprice = rs.getInt(6);
				int fk_pdetailnum = rs.getInt(7);
				int wnum = rs.getInt(8);
				
				WishListVO wvo = new WishListVO();  
				wvo.setFk_pnum(fk_pnum);
				wvo.setOqty(oqty);
				wvo.setFk_pdetailnum(fk_pdetailnum);
				wvo.setWnum(wnum);
				
				ProductVO pvo = new ProductVO();
				pvo.setPimage1(pimage1);
				pvo.setPname(pname);
				pvo.setSaleprice(saleprice);
				
				ProductDetailVO pdetailvo = new ProductDetailVO();
				pdetailvo.setOptionname(optionname);
				
				wvo.setPvo(pvo);
				wvo.setPdetailvo(pdetailvo);
				
				wishList.add(wvo);
			}
		
		}finally {
			close();
		}
		
		return wishList;
	}

	
	// 장바구니에서 개별 상품 삭제하기
	@Override
	public int deleteCartOne(String userid, String cartnum) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_cart " +
					" where fk_userid = ? and cartnum = ? ";
				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, Integer.parseInt(cartnum)); // userid가 들어오면 2로 수정
			
			n = pstmt.executeUpdate();
		}finally {
			close();
		}
		
		return n;			
		
	}

	// 위시리스트 개별 삭제
	@Override
	public int deleteWishOne(String userid, String wnum) throws SQLException{
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_wishlist " +
						 " where fk_userid = ? and wnum = ? ";
				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, Integer.parseInt(wnum)); // userid가 들어오면 2로 수정
			
			n = pstmt.executeUpdate();
		
		}finally {
			close();
		}
		
		return n;	
	}



	// 해당 상품을 장바구니에 삭제(delete)하고 위시리스트에 추가(insert)
	@Override
	public int deleteCartAddWish(Map<String, String> paraMap) throws SQLException {
		int n=0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select wnum, fk_userid, fk_pnum, oqty , fk_pdetailnum "+
			             " from tbl_wishlist "+
					     " where fk_userid = ? and fk_pdetailnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("fk_pdetailnum"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				n=0;
			}	
			else {
				sql = " insert into tbl_wishlist(wnum, fk_userid, fk_pnum, oqty , fk_pdetailnum) " + 
						" values (seq_wish_wnum.nextval, ? , ?, 1, ?)";
	       
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("fk_pnum")); // userid가 들어오면 2로 수정
				pstmt.setString(3, paraMap.get("fk_pdetailnum")); // userid가 들어오면 4로 수정
				
				pstmt.executeUpdate();
				
				sql = " delete from tbl_cart "+
							 " where fk_userid= ? and cartnum= ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("cartnum")); // userid가 들어오면 2로 수정
				
				n= pstmt.executeUpdate();
			}
			
		} finally {
			close();
		}
				
		return n;
	}

	
	
	// 해당 상품에 대한 옵션 리스트 보이기(select) 
	@Override
	public List<ProductDetailVO> optionSelect(String fk_pnum) throws SQLException{

		List<ProductDetailVO> optionList =  new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select D.optionname, D.pdetailnum, D.pqty  "+
						 " from tbl_proddetail D  "+
						 " join "+
						 " tbl_product P "+
						 " on D.fk_pnum = P.pnum "+
						 " where D.fk_pnum= ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_pnum);
		
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				
				ProductDetailVO pdvo = new ProductDetailVO();
				
				pdvo.setOptionname(rs.getString(1));
				pdvo.setPdetailnum((rs.getInt(2)));
				pdvo.setPqty(rs.getInt(3));
				optionList.add(pdvo);
			}
		
		}finally {
			close();
		}
		
		return optionList;
	}

	
	// 옵션 추가하기
	@Override
	public int addOptionCart(String pdetailnum, String userid,String fk_pnum) throws SQLException {
		int n=0;
		
		try {
			conn = ds.getConnection();
		
			String sql = " select C.cartnum , D.pqty " + 
						" from tbl_cart C join tbl_proddetail D " + 
						" on C.fk_pdetailnum = D.pdetailnum " + 
						" where C.fk_userid = ? and C.fk_pdetailnum= ? ";

			pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userid);
	        pstmt.setString(2, pdetailnum);
	          
	        rs = pstmt.executeQuery();
			
	        if(rs.next()) {
	        	// 원래 있던 제품을 제품을 장바구니에 추가로 넣을 때
	        	 int cartnum = rs.getInt(1); 
	        	
	        	sql= " update tbl_cart set oqty = oqty + 1 " 
	        		+" where cartnum = ? " +
		        	 " and 0< (select D.pqty " + 
					 "            from tbl_proddetail D " + 
					 "            where  D.pdetailnum = ? )";
	        	pstmt = conn.prepareStatement(sql);
	        	pstmt.setInt(1, cartnum);
	        	pstmt.setInt(2, Integer.parseInt(pdetailnum));
	        	
	        	n = pstmt.executeUpdate();
	        	
	        }
	        
	        else{
	        	// 장바구니에 존재하지 않는 새로운 제품을 넣고자 하는 경우
	        	sql = " select pqty " + 
					  " from tbl_proddetail " +  
					  " where pdetailnum= ? ";
	        	// 제품 수량알아오기
				pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1, Integer.parseInt(pdetailnum));
	          
		        rs = pstmt.executeQuery();
			
		        if(rs.next()) {
		        int pqty = rs.getInt(1);
	        	if(pqty==0) {
	        		n=0; // 제품 수량이 0이면 결과값 0주기
	        	}
	        	else {
		        	sql = " insert into tbl_cart(cartnum, fk_userid, fk_pnum, oqty,fk_pdetailnum) "
		                    + " values(seq_cart_num.nextval, ?, ?, 1, ?) ";
		        
		        	pstmt = conn.prepareStatement(sql);
		        	pstmt.setString(1, userid);
		        	pstmt.setInt(2,Integer.parseInt(fk_pnum));
		        	pstmt.setInt(3, Integer.parseInt(pdetailnum));
		        
		        	n = pstmt.executeUpdate();
	        	}
	        }
	        }
		}finally {
			close();
		}
		
		return n;
	}

	
	// 장바구니 옵션 변경하기(update)
	@Override
	public int changeOptionCart(String oldpdetailnum, String newpdetailnum, String userid) throws SQLException {
		
		int n=0;
	
		try {
			conn = ds.getConnection();
			

			String sql = " select pqty " + 
					  " from tbl_proddetail " +  
					  " where pdetailnum= ? ";

			pstmt = conn.prepareStatement(sql);
		    pstmt.setInt(1, Integer.parseInt(newpdetailnum));
	    
	        rs = pstmt.executeQuery();
        	
	        if(rs.next()) {
	        	// 어떤 제품을 장바구니에 추가로 넣을 때
	      
	        	int pqty=rs.getInt(1);
	        	
	        	if(pqty==0) {
	        		n=-1;
	        	}
	        	else {
		        	
	        		sql = " select C.cartnum , D.pqty " + 
							" from tbl_cart C join tbl_proddetail D " + 
							" on C.fk_pdetailnum = D.pdetailnum " + 
							" where C.fk_userid = ? and C.fk_pdetailnum= ? ";

							pstmt = conn.prepareStatement(sql);
					        pstmt.setString(1, userid);
					        pstmt.setString(2, newpdetailnum);
					        
					        rs = pstmt.executeQuery();
					        
					        if(rs.next()) {
					        	n=0;
					        }
					        else {
		        	// 장바구니에 존재하지 않는 새로운 제품을 넣고자 하는 경우
					        	sql = " update tbl_cart set fk_pdetailnum = ? "
					                    + " where fk_userid = ? and fk_pdetailnum = ? ";
					        
					        	pstmt = conn.prepareStatement(sql);
					        	pstmt.setInt(1, Integer.parseInt(newpdetailnum));
					        	pstmt.setString(2, userid);
					        	pstmt.setInt(3,Integer.parseInt(oldpdetailnum));
				        	
					        
					        	n = pstmt.executeUpdate();
					        }
	        	}
	        }
		}finally {
			close();
		}
		
		return n;
	}

	
	// 위시리스트 옵션 변경하기(update)
	@Override
	public int changeOptionWish(String oldpdetailnum, String newpdetailnum, String userid) throws SQLException{
		
		int n=0;
		
		try {
			conn = ds.getConnection();
			

			String sql = " select pqty " + 
					  " from tbl_proddetail " +  
					  " where pdetailnum= ? ";

			pstmt = conn.prepareStatement(sql);
		    pstmt.setInt(1, Integer.parseInt(newpdetailnum));
	    
	        rs = pstmt.executeQuery();
        	
	        if(rs.next()) {
	        	// 어떤 제품을 장바구니에 추가로 넣을 때
	      
	        	int pqty=rs.getInt(1);
	        	

	        	if(pqty==0) {
	        		n=-1;
	        	}
	        	else {
		        	
	        		sql = " select W.wnum , D.pqty " + 
							" from tbl_wishlist W join tbl_proddetail D " + 
							" on W.fk_pdetailnum = D.pdetailnum " + 
							" where W.fk_userid = ? and W.fk_pdetailnum= ? ";

							pstmt = conn.prepareStatement(sql);
					        pstmt.setString(1, userid);
					        pstmt.setString(2, newpdetailnum);
					        
					        rs = pstmt.executeQuery();
					        
					        if(rs.next()) {
					        	n=0;
					        }
					        else {
		        	// 장바구니에 존재하지 않는 새로운 제품을 넣고자 하는 경우
					        	sql = " update tbl_wishlist set fk_pdetailnum = ? "
					                    + " where fk_userid = ? and fk_pdetailnum = ? ";
					        
					        	pstmt = conn.prepareStatement(sql);
					        	pstmt.setInt(1, Integer.parseInt(newpdetailnum));
					        	pstmt.setString(2, userid);
					        	pstmt.setInt(3,Integer.parseInt(oldpdetailnum));
				        	
					        
					        	n = pstmt.executeUpdate();
			
					        }
	        	}
	        	}
		}finally {
			close();
		}
		
		return n;
	}

	
	// 장바구니 비우기
	@Override
	public int deleteAllCart(String userid) throws SQLException{
		
		int n=0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_cart "+
			             " where fk_userid = ?";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			n = pstmt.executeUpdate();
			
		}finally {
			close();
		}
		
		return n;
		
	}

	
	// 수량 변경하기
	@Override
	public int updateOqty(String userid, String cartnum, String oqty, String fk_pdetailnum) throws SQLException {

		int n=0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_cart C set oqty = ? " + 
						 " where fk_userid = ? and cartnum = ? " + 
						 " and ? <= (select D.pqty " + 
						 "            from tbl_proddetail D " + 
						 "            where  D.pdetailnum = ? )";
				
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(oqty));
			pstmt.setString(2, userid);
			pstmt.setInt(3, Integer.parseInt(cartnum));
			pstmt.setInt(4, Integer.parseInt(oqty));
			pstmt.setInt(5, Integer.parseInt(fk_pdetailnum));
			
			n = pstmt.executeUpdate();
			
		}finally {
			close();
		}
		
		return n;
	}

	
	// 해당 상품을 위시리스트에 삭제(delete)하고 장바구니에 추가(insert)
	@Override
	public int deleteWishAddCart(Map<String, String> paraMap) throws SQLException {
		
		int n=0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cartnum, fk_userid, fk_pnum, oqty , fk_pdetailnum "+
			             " from tbl_cart "+
					     " where fk_userid = ? and fk_pdetailnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("fk_pdetailnum"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				n=0;
			}	
			else {
				sql = " insert into tbl_cart(cartnum, fk_userid, fk_pnum, oqty , fk_pdetailnum) " + 
						" values (seq_cart_num.nextval, ? , ?, 1, ?)";
	       
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("fk_pnum")); 
				pstmt.setString(3, paraMap.get("fk_pdetailnum")); 
				
				pstmt.executeUpdate();
				
				sql = " delete from tbl_wishlist "+
							 " where fk_userid= ? and wnum= ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("wnum")); 
				
				n= pstmt.executeUpdate();
			}
			
		} finally {
			close();
		}
				
		return n;
	}

	
	
	// 페이징처리를 위해서 회원의 위시리스트 총페이지 개수 알아오기(select)  
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
		
		
			int totalPage=0;
			
			try {
				conn=ds.getConnection();
				
				String sql = " select ceil(count(*) / ?) "
						   + " from tbl_wishlist"
						   + " where fk_userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("sizePerPage"));
				pstmt.setString(2, paraMap.get("userid"));
				
				
				rs = pstmt.executeQuery();
				rs.next();
				
				totalPage = rs.getInt(1);
		
			} finally {
				close();
			}
			return totalPage;
		

	}

	
	@Override
	public List<WishListVO> selectPagingMember(Map<String, String> paraMap) throws SQLException {

			List<WishListVO> wishPageList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql =" select W.fk_pnum, P.pimage1,  P.pname, W.oqty, D.optionname, P.saleprice, W.fk_pdetailnum, W.wnum " + 
						"from(" + 
						"    select rno, wnum, fk_userid, fk_pnum, oqty,fk_pdetailnum " + 
						"    from( " + 
						"        select rownum as rno, wnum, fk_userid, fk_pnum, oqty,fk_pdetailnum " + 
						"        from " + 
						"        (select wnum, fk_userid, fk_pnum, oqty,fk_pdetailnum  " + 
						"        from tbl_wishlist " + 
						"        where fk_userid = ?  " + 
						"        order by wnum desc " + 
						"        )V " + 
						"    )T " + 
						"    )W join tbl_product P " + 
						" on W.fk_pnum = P.pnum  " + 
						" join  " + 
						" tbl_proddetail D  " + 
						" on W.fk_pdetailnum = D.pdetailnum  " + 
						" where rno between ? and ? ";
				
				
			
				//	(currentShowPageNo * sizePerPage) - (sizePerPage - 1) and (currentShowPageNo * sizePerPage)
				
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
				
				pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, paraMap.get("userid"));
					pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
					pstmt.setInt(3, (currentShowPageNo * sizePerPage));
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					int fk_pnum = rs.getInt(1);
					String pimage1 = rs.getString(2);
					String pname= rs.getString(3);
					int oqty = rs.getInt(4);
					String optionname = rs.getString(5);
					int saleprice = rs.getInt(6);
					int fk_pdetailnum = rs.getInt(7);
					int wnum = rs.getInt(8);
					
					WishListVO wvo = new WishListVO();  
					wvo.setFk_pnum(fk_pnum);
					wvo.setOqty(oqty);
					wvo.setFk_pdetailnum(fk_pdetailnum);
					wvo.setWnum(wnum);
					
					ProductVO pvo = new ProductVO();
					pvo.setPimage1(pimage1);
					pvo.setPname(pname);
					pvo.setSaleprice(saleprice);
					
					ProductDetailVO pdetailvo = new ProductDetailVO();
					pdetailvo.setOptionname(optionname);
					
					wvo.setPvo(pvo);
					wvo.setPdetailvo(pdetailvo);
					
					wishPageList.add(wvo);
				}
				
		
			} finally {
				close();
			}

			return wishPageList;
		}

	
	// 주문번호 채번하기
	@Override
	public int getSeq_tbl_order() throws SQLException {
		int seq = 0;
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select seq_order_odrcode.nextval AS seq "
	                   + " from dual";
	          
	          pstmt = conn.prepareStatement(sql);
	          
	          rs = pstmt.executeQuery();
	          
	          rs.next();
	          
	          seq = rs.getInt("seq");
	          
	      } finally {
	         close();
	      }
	      
	      return seq;
	}

	
	// 선택된 상품 주문 테이블에 insert 
	@Override
	public int orderAdd(Map<String, Object> paraMap) throws SQLException {
		int isSuccess = 0;
	    int n1=0, n2=0;
	     
	    try {
	    	conn = ds.getConnection();
	          
	        conn.setAutoCommit(false); // 수동 커밋
	        
	     // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
	        String sql = " insert into tbl_order(odrcode, fk_userid, totalcost) "
                    + " values(to_number(?), ?, ?) ";
       
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, (String) paraMap.get("odrcode")); 
	        pstmt.setString(2, (String)paraMap.get("userid"));
	        pstmt.setInt(3, Integer.parseInt((String)paraMap.get("sumtotalPrice")));
	        
	    //    System.out.println("주문번호: "+(String) paraMap.get("odrcode"));
	        n1 = pstmt.executeUpdate();
	    
	        System.out.println("확인용 :"+n1);
	     // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
	        if(n1 == 1) {
	        	
	        	String[] pnumArr = (String[]) paraMap.get("pnumArr");
				String[] oqtyArr = (String[]) paraMap.get("oqtyArr");
				String[] pdetailnumArr = (String[]) paraMap.get("pdetailnumArr");
				String[] totalPriceArr = (String[]) paraMap.get("totalPriceArr");
				String[] optionnameArr = (String[]) paraMap.get("optionnameArr");
	            
	            
	            int cnt = 0;
	            
	      //      System.out.println("pnumArr: "+pnumArr.length);
	           
	            for(int i=0; i<pnumArr.length; i++) {
	               sql = " insert into tbl_odrdetail(odrdetailno,fk_userid , fk_pnum, fk_odrcode , fk_pdetailnum, odrqty , odrprice, optionname) "  
	                  + " values(seq_orderdetail_odetailno.nextval, ?, to_number(?), to_number(?), to_number(?), to_number(?) , to_number(?), ?) ";
	               
	                pstmt = conn.prepareStatement(sql);
	                
	                pstmt.setString(1, (String)paraMap.get("userid"));
	                pstmt.setString(2, pnumArr[i]);
	                pstmt.setString(3, (String)paraMap.get("odrcode"));
	                pstmt.setString(4, pdetailnumArr[i]);
	                pstmt.setString(5, oqtyArr[i]);
	                pstmt.setString(6, totalPriceArr[i]);
	                pstmt.setString(7, optionnameArr[i]);

	      
	                pstmt.executeUpdate();
	                cnt++;
	                
	                System.out.println(cnt);
	            }// end of for----------------------
	            
	            	if(cnt == pnumArr.length) {
		               n2=1;
		            }
		        

	            
	         }// end of if---------------------------          
	            
	        if(n1*n2>0) {
	        	conn.commit();
	        	isSuccess = 1;
	        	  System.out.println("n1*n2: "+(n1*n2));
	        }
	   
	    }catch (SQLException e) {
	    	conn.rollback();
            isSuccess = 0;
	    
	    }finally {
			close();
		}
	    return isSuccess;
	    
	}

	
	
	// 장바구니, 위시리스트 한개씩 insert
	@Override
	public int orderOneAdd(Map<String, String> paraMap) throws SQLException {

		int isSuccess = 0;
	    int n1=0, n2=0;
	     
	    try {
	    	conn = ds.getConnection();
	          
	        conn.setAutoCommit(false); // 수동 커밋
	        
	     // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
	        String sql = " insert into tbl_order(odrcode, fk_userid, totalcost) "
                    + " values(to_number(?), ?, to_number(?) )";
       
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, paraMap.get("odrcode")); 
	        pstmt.setString(2, paraMap.get("userid"));
	        pstmt.setString(3, paraMap.get("totalPrice"));
	        
	        System.out.println("주문번호: "+ paraMap.get("odrcode"));
	        System.out.println("아이디: "+paraMap.get("userid"));
	        System.out.println("금액: "+paraMap.get("totalPrice"));
	        
	        n1 = pstmt.executeUpdate();
	    
	
	        
	     // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
	        if(n1 == 1) {
	 
	               sql = " insert into tbl_odrdetail(odrdetailno,fk_userid , fk_pnum, fk_odrcode , fk_pdetailnum, odrqty , odrprice, optionname) "  
	                  + " values(seq_orderdetail_odetailno.nextval, ?, to_number(?), to_number(?), to_number(?), to_number(?) , to_number(?), ?) ";
	               
	                pstmt = conn.prepareStatement(sql);
	                
	                pstmt.setString(1, paraMap.get("userid"));
	                pstmt.setString(2, paraMap.get("pnum"));
	                pstmt.setString(3, paraMap.get("odrcode"));
	                pstmt.setString(4, paraMap.get("pdetailnum"));
	                pstmt.setString(5, paraMap.get("oqty"));
	                pstmt.setString(6, paraMap.get("totalPrice"));
	                pstmt.setString(7, paraMap.get("optionname"));
	                
	        
	                n2 = pstmt.executeUpdate();
	            
	         }// end of if---------------------------          
	            
	        if(n1*n2>0) {
	        	conn.commit();
	        	isSuccess = 1;
	        	  System.out.println("n1*n2: "+(n1*n2));
	        }
	   
	    }catch (SQLException e) {
	    	conn.rollback();
            isSuccess = 0;
	    
	    }finally {
			close();
		}
	    return isSuccess;
	    
	}



}
