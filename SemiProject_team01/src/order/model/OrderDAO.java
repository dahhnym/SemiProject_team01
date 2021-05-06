package order.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import cart.model.CartVO;
import product.model.ProductVO;


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
		    ds = (DataSource)envContext.lookup("jdbc/myoracle");
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
	
	
	// 로그인한 사용자의 장바구니 목록 조회하기
		@Override
		public List<CartVO> selectProcuctCart(String userid) throws SQLException {
			List<CartVO> cartList = null;
		    /*  
		      try {
		         conn = ds.getConnection();
		         
		         String sql = "select cartnum, A.fk_userid, A.fk_pnum, fk_pdetailnum,\n"+
		        		 "B.pname, B.pimage1, B.saleprice, A.oqty \n"+
		        		 "from tbl_cart A join tbl_product B\n"+
		        		 " on A.fk_pnum = B.pnum\n"+
		        		 "where A.fk_userid = ? \n"+
		        		 " order by cartnum desc";
		         
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, userid);
		         
		         rs = pstmt.executeQuery();
		         
		         int cnt = 0;
		         while(rs.next()) {
		            cnt++;
		            
		            if(cnt==1) {
		               cartList = new ArrayList<>();
		            }
		            
		            int cartnum = rs.getInt("cartnum");
		            String fk_userid = rs.getString("fk_userid");
		            int fk_pnum = rs.getInt("fk_pnum");
		            int fk_pdetailnum = rs.getInt("fk_pdetailnum");
		            String pname = rs.getString("pname");
		            String pimage1 = rs.getString("pimage1");
		            int saleprice = rs.getInt("saleprice");
		            int oqty = rs.getInt("oqty");  // 주문량 
		                        
		            ProductVO prodvo = new ProductVO();
		            prodvo.setPnum(fk_pnum);
		            prodvo.setPname(pname);
		            prodvo.setPimage1(pimage1);
		            prodvo.setSaleprice(saleprice);
		            
		            // **** !!!! 중요함 !!!! **** //
		            prodvo.setTotalPrice(oqty);
		            // **** !!!! 중요함 !!!! **** //
		            
		            CartVO cvo = new CartVO();
		            cvo.setCartnum(cartnum);
		            cvo.setFk_userid(fk_userid);
		            cvo.setFk_pnum(fk_pnum);
		            cvo.setOqty(oqty);
		            cvo.setFk_pdetailnum(fk_pdetailnum);
		            
		            cartList.add(cvo);
		         }// end of while---------------------------------
		                  
		      } finally {
		         close();
		      }
		    */  
		      return cartList;
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


	@Override
	public List<OrderVO> selectOrderInfo(String userid) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
	
	
}
