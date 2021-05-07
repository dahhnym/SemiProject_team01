package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductdetailDAO2 implements InterProductdetailDAO2 {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public ProductdetailDAO2() {
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
	public List<HashMap<String,String>> getOptionByPnum(String pnum) throws SQLException {
		List<HashMap<String,String>> option = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select optionname, pdetailnum "+
				         " from tbl_proddetail "+
				         " where fk_pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("optionname", rs.getString(1));
				map.put("pdetailnum", rs.getString(2));
				option.add(map);
			}
			
		} finally {
			close();
		}
		
		return option;
	}

	

}
