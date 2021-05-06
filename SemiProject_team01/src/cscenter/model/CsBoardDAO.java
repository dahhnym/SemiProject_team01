package cscenter.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;
import util.security.Sha256;

public class CsBoardDAO implements InterCsBoardDAO {
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public CsBoardDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		}catch (NamingException e){
			e.printStackTrace();
		}
	}
	
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
	public int registerBoard(CsBoardVO board) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "insert into tbl_csBoard(boardno, boardtitle, boardcontent, boardpwd, boardfile, fk_userid, fk_smallcateno) "     
							+ "values(seq_csboard_boardno.nextval,?, ?, ?, ?, ?, ?)"; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getBoardtitle());
			pstmt.setString(2, board.getBoardcontent());
			pstmt.setString(3, Sha256.encrypt(board.getBoardpwd())); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. 
			pstmt.setString(4, board.getBoardfile());
			pstmt.setString(5, board.getFk_userid() );
			pstmt.setString(6, board.getFk_smallcateno());
			
	        
	        n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}

	@Override
	public int selectSmallCateCnt(String fk_bigcateno) throws SQLException {
		
		int n = 0;
		try {
			conn = ds.getConnection();
			
			String sql =  " select count(*) "+
								" from tbl_bigcategory JOIN tbl_smallcategory "+
								" ON  bigcateno = fk_bigcateno " +
								" where fk_bigcateno = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_bigcateno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				n = rs.getInt(1);
			}
			
			
		}finally {
			close();
		}
		return n;
	}

	@Override
	public List<CsBoardVO> GetSmallCategoryList(String fk_bigcateno) throws SQLException {
		List<CsBoardVO> boardList = new ArrayList<>();
	      try {
		           conn = ds.getConnection();
		           
		           String sql = " select smallcateno, smallcatename " + 
						           	  " from tbl_smallcategory " + 
						           	  " where fk_bigcateno = ? ";
		           
		           
		           pstmt = conn.prepareStatement(sql);
		           pstmt.setString(1, fk_bigcateno);
		           
		           rs = pstmt.executeQuery();
		           
		           while(rs.next()) {
		        	   CsBoardVO boardvo = new CsBoardVO();
		        	   CsBoardSmallCategoryVO smallvo = new CsBoardSmallCategoryVO();
		        	   
		        	   
		        	   smallvo.setSmallcateno(rs.getInt(1));       	   
		        	   smallvo.setSmallcatename(rs.getString(2));
		        	   boardvo.setCbscvo(smallvo);
		        	   boardList.add(boardvo);
	           }// end of while----------------
	           
	      } finally {
	         close();
	      }
	      return boardList;
	}

	@Override
	public List<CsBoardVO> selectBoardByCategory(Map<String, String> paraMap, String fk_bigcateno) throws SQLException {
		List<CsBoardVO> boardList = new ArrayList<>();
	      
	      try {
	          conn = ds.getConnection();
	          
	          String str = "";
	          
	          if(fk_bigcateno != "0") {
	        	  str = " where fk_bigcateno = ? ";
	          }
	          
	          String sql =  " select boardno, boardtitle, boardcontent, boardregistdate ,boardfile ,boardpwd ,fk_userid ,fk_smallcateno, fk_bigcateno, bigcatename "+
				        		  " from "+
				        		  " ( "+
				        		  "     select rownum as rno, boardno, boardtitle, boardcontent, boardregistdate ,boardfile ,boardpwd ,fk_userid ,fk_smallcateno, fk_bigcateno, bigcatename "+
				        		  "     from "+
				        		  "     ( "+
				        		  "         select boardno, boardtitle, boardcontent, boardregistdate ,boardfile ,boardpwd ,fk_userid ,fk_smallcateno, fk_bigcateno, bigcatename "+
				        		  "         from tbl_csBoard JOIN tbl_smallcategory "+
				        		  "         ON fk_smallcateno = smallcateno "+
				        		  "         JOIN tbl_bigcategory "+
				        		  "         ON fk_bigcateno = bigcateno" +
				        		  str +
				        		  "     )V "+
				        		  " )T "+
				        		  " where rno between ? and ?" +
				        		  " order by boardregistdate desc ";
	          
	          pstmt = conn.prepareStatement(sql);
	          
	          int currentShowPageNo = Integer.parseInt( paraMap.get("currentShowPageNo") );
	          int sizePerPage = 10; // 한 페이지당 화면상에 보여줄 제품의 개수는 10 으로 한다.
	          
	          if(fk_bigcateno != "0") {
	        	  pstmt.setString(1, paraMap.get("fk_bigcateno"));
		          pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
		          pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식 	
	          } else {
	        	  pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
	        	  pstmt.setInt(2, (currentShowPageNo * sizePerPage)); // 공식 
	          
	          }
	         
	          rs = pstmt.executeQuery();
	          
	          while( rs.next() ) {
	             
	             CsBoardVO bvo = new CsBoardVO();
	                                                   
	             
	             bvo.setBoardno(rs.getInt(1));
	             bvo.setBoardtitle(rs.getString(2));
	             bvo.setBoardcontent(rs.getString(3));
	             bvo.setBoardregistdate(rs.getString(4));
	             bvo.setBoardfile(rs.getString(5));
	             bvo.setBoardpwd(rs.getString(6));
	             bvo.setFk_userid(rs.getString(7));
	             bvo.setFk_smallcateno(rs.getString(8));
	             
	             CsBoardSmallCategoryVO smallvo = new CsBoardSmallCategoryVO();
	             smallvo.setFk_bigcateno(rs.getInt(9));
	             bvo.setCbscvo(smallvo);
	             
	             CsBoardBigCategoryVO bigvo = new CsBoardBigCategoryVO();
	             bigvo.setBigcatename(rs.getString(10));
	             smallvo.setCbbcvo(bigvo);
	             
	             
	             boardList.add(bvo);
	             
	          }// end of while-----------------------------------------
	          
	      } finally {
	         close();
	      }      
	      
	      return boardList;
	}

	@Override
	public int getTotalPage(String fk_bigcateno) throws SQLException {
		int totalPage = 0;
	      
	      try {
	         conn = ds.getConnection();
	         String sql = " select ceil(count(*)/10) " + 
				         		" from tbl_csBoard JOIN tbl_smallcategory " + 
				         		" ON fk_smallcateno = smallcateno " + 
				         		" JOIN tbl_bigcategory " + 
				         		" ON fk_bigcateno = bigcateno ";
	         
	          if(fk_bigcateno != "0") {
	        	 sql += " where fk_bigcateno = ? ";
	         }
	         pstmt = conn.prepareStatement(sql);
	         
	         if(fk_bigcateno != "0") {
	        	 pstmt.setString(1, fk_bigcateno);
	         }
	        
	         
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         
	         totalPage = rs.getInt(1);
	         
	      } finally {
	         close();
	      }      
	      
	      return totalPage;
	}

	@Override
	public String getBigCategoryName(String fk_bigcateno) throws SQLException {
		String catename = "";
		
		try {
			conn = ds.getConnection();
			
			String sql = " select bigcatename "
							+ " from tbl_smallcategory JOIN tbl_bigcategory "
							+ " ON fk_bigcateno = bigcateno "
							+ " where fk_bigcateno = ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_bigcateno);
			
			rs = pstmt.executeQuery();
	        rs.next();
	        
	        catename = rs.getString(1);
					
		}finally {
			close();
		}
		
		return catename;
	}

	@Override
	public int checkUserPwd(String boardpwd, String boardno) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select boardno, fk_userid " + 
								" from tbl_csBoard JOIN tbl_member " + 
								" ON fk_userid = userid " + 
								" where boardpwd=? and boardno=? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Sha256.encrypt(boardpwd));
			pstmt.setString(2, boardno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				n = 1;
			}
	        
			
		} finally {
			close();
		}
		
		return n;
	}

	



}
