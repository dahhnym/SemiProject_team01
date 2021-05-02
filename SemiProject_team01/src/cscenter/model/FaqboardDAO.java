package cscenter.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

public class FaqboardDAO implements InterFaqboardDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//생성자
	public FaqboardDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		}catch (NamingException e){
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
	   
	   
	   // tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
		// VO 를 사용하지 않고 Map 으로 처리해보겠습니다.
	@Override
	public List<HashMap<String, String>> getFaqCategoryList() throws SQLException{
		
		List<HashMap<String, String>> faqcategoryList = new ArrayList<>(); 
	      
	      try {
				  conn = ds.getConnection();
				  
				  String sql = " select fcNo, fcname, fccode "+
									 " from tbl_faqcategory "+
									 " order by fcNo asc ";
				            
				 pstmt = conn.prepareStatement(sql);
				 
				 rs = pstmt.executeQuery();
				         
				 while(rs.next()) {
					 
				    HashMap<String, String> map = new HashMap<>();
				    map.put("fcNo", rs.getString(1));
					map.put("fcname", rs.getString(2));
					map.put("fccode", rs.getString(3));
				    
					faqcategoryList.add(map);
				 }// end of while(rs.next())----------------------------------
				 
	      } finally {
	         close();
	      }   
	      
	      return faqcategoryList;
	}

	@Override
	public List<FaqboardVO> selectbyfaq(Map<String, String> paraMap) throws SQLException {
		
		List<FaqboardVO> faqList = new ArrayList<>();
	      
	      try {
	           conn = ds.getConnection();
	           
	           String sql = " select fcname,  faqNo, faqtitle, faqcontent, fk_fcNo " + 
	                        	  " from tbl_faq JOIN tbl_faqcategory "
	                           + " ON fk_fcNo = fcNo"
	                           + " where fk_fcNo = ? ";
	           
	           pstmt = conn.prepareStatement(sql);
	           
	           pstmt.setString(1, paraMap.get("fk_fcNo"));
	           
	           rs = pstmt.executeQuery();
	           
	           System.out.println("sfdsf");
	           
	           while(rs.next()) {
	        	   FaqboardVO faqvo = new FaqboardVO();
	        	   faqCategoryVO fcvo = new faqCategoryVO();
	        	   
	        	   fcvo.setFcname(rs.getString(1));
	        	   
	        	   System.out.println("sfsf" + rs.getString(1));
	        	   
	        	   faqvo.setFaqNo(rs.getInt(2));
	        	   faqvo.setFaqtitle(rs.getString(3));
	        	   faqvo.setFaqcontent(rs.getString(4));
	        	   faqvo.setFk_fcNo(rs.getInt(5));
	        	   
	               faqList.add(faqvo);
	           }// end of while----------------
	           
	      } finally {
	         close();
	      }
	      
	      return faqList;
	}

}
