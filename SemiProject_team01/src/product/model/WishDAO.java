package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class WishDAO implements InterWishDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public WishDAO() {
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

	// 위시리스트 추가
	@Override
	public int wishAdd(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 conn.setAutoCommit(false); // 수동커밋으로 전환
			 
			 String sql = " select wnum "
			 		    + " from tbl_wishlist "
			 		    + " where fk_userid = ? and fk_pnum = ? ";		
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, paraMap.get("userid"));
			 pstmt.setString(2, paraMap.get("pnum"));
			 
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
					// 어떤 제품을 추가로 위시리스트에 넣고자 하는 경우
					 
					 int cartnum =  rs.getInt("cartnum");
					 
					 sql = " update tbl_wishlist set oqty = oqty + 1 "
					 	 + " where cartnum = ? ";
					 
					 pstmt = conn.prepareStatement(sql);
					 pstmt.setInt(1, cartnum);
					 
					 n = pstmt.executeUpdate();
					 
				 }
				 else {
					// 위시리스트에 존재하지 않는 새로운 제품을 넣고자 하는 경우
					
					sql = " insert into tbl_wishlist(wnum, fk_userid, fk_pnum, oqty) "
					    + " values(seq_tbl_cart_wnum.nextval, ?, ?, 1) ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					pstmt.setInt(2, Integer.parseInt(paraMap.get("pnum")));
					
					n = pstmt.executeUpdate();
				 }
			 
			 if(n == 1) {
				 conn.commit();
			 }
		
		} catch(SQLIntegrityConstraintViolationException e) {	 
			conn.rollback();
		} finally {
			close();
		}
		
		return n;
	}

}
