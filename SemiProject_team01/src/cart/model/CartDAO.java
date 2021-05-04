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
	public List<CartVO> cartList() throws SQLException { //괄호에 String userid넣어야함
		
		List<CartVO> cartList =  new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select C.fk_pnum, P.pimage1,  P.pname, C.oqty, D.optionname, C.cprice, C.fk_pdetailnum, C.cartnum " +
					" from tbl_cart C join tbl_product P "+
					" on C.fk_pnum = P.pnum "+
					" join " +
					" tbl_proddetail D " +
					" on C.fk_pdetailnum = D.pdetailnum "+
					" where C.fk_userid = 'user' " ;
			
			pstmt = conn.prepareStatement(sql);
	//		pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				
				
			
				int fk_pnum = rs.getInt(1);
				String pimage1 = rs.getString(2);
				String pname= rs.getString(3);
				int oqty = rs.getInt(4);
				String optionname = rs.getString(5);
				int cprice = rs.getInt(6);
				int fk_pdetailnum = rs.getInt(7);
				int cartnum=rs.getInt(8);
				
				CartVO cartvo = new CartVO();  
				cartvo.setFk_pnum(fk_pnum);
				cartvo.setOqty(oqty);
				cartvo.setFk_pdetailnum(fk_pdetailnum);
				cartvo.setCprice(cprice);
				cartvo.setTotalPrice(oqty);
				cartvo.setCartnum(cartnum);
				
				ProductVO pvo = new ProductVO();
				pvo.setPimage1(pimage1);
				pvo.setPname(pname);
				
				
				ProductDetailVO pdetailvo = new ProductDetailVO();
				pdetailvo.setOptionname(optionname);
				
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
	public List<WishListVO> wishList() throws SQLException {


		
		List<WishListVO> wishList =  new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select W.fk_pnum, P.pimage1,  P.pname, W.oqty, D.optionname, P.saleprice, W.fk_pdetailnum, W.wnum "+
						 " from tbl_wishlist W join tbl_product P "+
						 " on W.fk_pnum = P.pnum "+
						 " join "+
						 " tbl_proddetail D "+
						 " on W.fk_pdetailnum = D.pdetailnum "+
						 " where W.fk_userid = 'user' ";
			
			pstmt = conn.prepareStatement(sql);
	//		pstmt.setString(1, userid);
			
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
					" where fk_userid = 'user' and cartnum = ? ";
				
			pstmt = conn.prepareStatement(sql);
		//	pstmt.setString(1, userid);
			pstmt.setInt(1, Integer.parseInt(cartnum)); // userid가 들어오면 2로 수정
			
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
						 " where fk_userid = 'user' and wnum = ? ";
				
			pstmt = conn.prepareStatement(sql);
		//	pstmt.setString(1, userid);
			pstmt.setInt(1, Integer.parseInt(wnum)); // userid가 들어오면 2로 수정
			
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
			
			String  sql = " insert into tbl_wishlist(wnum, fk_userid, fk_pnum, oqty , fk_pdetailnum) " + 
					" values (seq_wish_wnum.nextval, 'user', ?, 1, ?)";
       
			pstmt = conn.prepareStatement(sql);
			//	pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(1, paraMap.get("fk_pnum")); // userid가 들어오면 2로 수정
			pstmt.setString(2, paraMap.get("fk_pdetailnum")); // userid가 들어오면 4로 수정
			
			pstmt.executeUpdate();
			
			sql = " delete from tbl_cart "+
						 " where fk_userid='user' and cartnum= ? ";
			pstmt = conn.prepareStatement(sql);
			
		//	pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(1, paraMap.get("cartnum")); // userid가 들어오면 2로 수정
			
			n= pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
				
		return n;
	}
	
	
	
	
	
	
	
	
	

}
