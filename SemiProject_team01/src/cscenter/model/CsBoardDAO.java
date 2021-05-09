package cscenter.model;


import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;

import member.model.MemberVO;
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
		
		String cateno = board.getFk_smallcateno();
		String str = "";
		
		try {
			conn = ds.getConnection();
			
			String sql = "select smallcatename " + 
								"from tbl_smallcategory JOIN tbl_bigcategory " + 
								"ON fk_bigcateno = bigcateno" +
							    " where smallcateno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			if(cateno == null) {
				pstmt.setString(1,"6");
			}else {
				pstmt.setString(1,cateno);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if("없음".equals(rs.getString(1))) {
					str = "";
				}else {
					str = "["+rs.getString(1)+"]";
				}
			}
			
			
			sql = "insert into tbl_csBoard(boardno, boardtitle, boardcontent, boardpwd, boardfile, fk_userid, fk_smallcateno) "     
							+ "values(seq_csboard_boardno.nextval,?, ?, ?, ?, ?, ?)"; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, str + board.getBoardtitle());
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
	   public List<CsBoardVO> GetSmallCategoryList(String fk_bigcateno) throws SQLException {
	      List<CsBoardVO> boardList = new ArrayList<>();
	         try {
	                 conn = ds.getConnection();
	                 
	                 //System.out.println("뿌엥" + fk_bigcateno);
	                 
	                 String sql = " select smallcateno, smallcatename, bigcatename " + 
	                                  " from tbl_smallcategory JOIN tbl_bigcategory " +
	                                  " ON fk_bigcateno = bigcateno ";
	                                  
	                 if(fk_bigcateno != "") {
	                    sql += " where fk_bigcateno = ? ";
	                 }
	                 
	                 pstmt = conn.prepareStatement(sql);
	                 
	                 if(fk_bigcateno != "0") {
	                    pstmt.setString(1, fk_bigcateno);
	                 }  
	                 
	                 
	                 rs = pstmt.executeQuery();
	                 
	                 while(rs.next()) {
	                    CsBoardVO boardvo = new CsBoardVO();
	                    CsBoardSmallCategoryVO smallvo = new CsBoardSmallCategoryVO();
	                    CsBoardBigCategoryVO bigvo = new CsBoardBigCategoryVO();
	                    
	                    smallvo.setSmallcateno(rs.getInt(1));             
	                    smallvo.setSmallcatename(rs.getString(2));
	                    bigvo.setBigcatename(rs.getString(3));
	                    
	                    smallvo.setCbbcvo(bigvo);
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
	          
	          if(fk_bigcateno != "") {
	        	  str = " where fk_bigcateno = ? ";
	          }
	          
	          
	          String sql =   " select boardno, boardtitle, boardcontent, boardregistdate ,boardfile ,boardpwd ,fk_userid ,fk_smallcateno,fk_bigcateno, bigcatename, name " + 
						      		" from " + 
						      		" ( " + 
						      		"     select rownum as rno, boardno, boardtitle, boardcontent, boardregistdate ,boardfile ,boardpwd ,fk_userid ,fk_smallcateno,fk_bigcateno, bigcatename, name " + 
						      		"     from " + 
						      		"     ( " + 
						      		"         select boardno, boardtitle, boardcontent, boardregistdate ,boardfile ,boardpwd ,fk_userid ,fk_smallcateno,fk_bigcateno, bigcatename, name " + 
						      		"         from tbl_csBoard JOIN tbl_smallcategory " + 
						      		"         ON fk_smallcateno = smallcateno " + 
						      		"         JOIN tbl_bigcategory " + 
						      		"         ON fk_bigcateno = bigcateno " + 
						      		"         JOIN tbl_member " + 
						      		"         ON fk_userid = userid " + str + " order by boardregistdate desc  " +
						      		"     )V " + 
						      		" )T " + 
						      		" where rno between ? and ?";
	          
	          
	          pstmt = conn.prepareStatement(sql);
	          
	          int currentShowPageNo = Integer.parseInt( paraMap.get("currentShowPageNo") );
	          int sizePerPage = 10; // 한 페이지당 화면상에 보여줄 제품의 개수는 10 으로 한다.
	          
	          if(fk_bigcateno != "") {
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
	             
	             MemberVO mvo = new MemberVO();
		         mvo.setName(rs.getString(11));
		         bvo.setMvo(mvo);
		         
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
	         
	          if(fk_bigcateno != "") {
	        	 sql += " where fk_bigcateno = ? ";
	         }
	         pstmt = conn.prepareStatement(sql);
	         
	         if(fk_bigcateno != "") {
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
	                     + " ON fk_bigcateno = bigcateno ";
	         
	         if(fk_bigcateno !="") {
	            sql += " where fk_bigcateno = ? ";
	         }
	         pstmt = conn.prepareStatement(sql);
	         
	         if(fk_bigcateno != "") {
	            pstmt.setString(1, fk_bigcateno);
	         }
	         
	         rs = pstmt.executeQuery();
	           if(rs.next()) {
	              catename = rs.getString(1);
	           }
	           
	           
	               
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

	@Override
	public CsBoardVO selectBoardDetail(String boardno) throws SQLException {
		CsBoardVO bvo = null;
		CsBoardSmallCategoryVO svo = null;
		CsBoardBigCategoryVO bcvo = null;
		MemberVO mvo = null;
	      try {
	          
	          conn = ds.getConnection();
	          String sql =    " select boardno, boardtitle, boardcontent, boardfile, fk_smallcateno,fk_bigcateno, smallcatename, bigcatename ,name, fk_userid  " + 
					          		" from tbl_csBoard JOIN tbl_smallcategory " + 
					          		" ON fk_smallcateno = smallcateno " + 
					          		" JOIN tbl_bigcategory " + 
					          		" ON fk_bigcateno = bigcateno " + 
					          		" JOIN tbl_member " + 
					          		" ON fk_userid = userid " + 
					          		" where boardno = ? ";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, boardno);
	          
	          rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				bvo = new CsBoardVO();
				
				bvo.setBoardno(rs.getInt(1));
	            bvo.setBoardtitle(rs.getString(2));
	            bvo.setBoardcontent(rs.getString(3));
	            bvo.setBoardfile(rs.getString(4));
	            bvo.setFk_smallcateno(rs.getString(5));
	            
	            svo = new CsBoardSmallCategoryVO();
	            svo.setFk_bigcateno(rs.getInt(6));
	            svo.setSmallcatename(rs.getString(7));
	            
	            bcvo = new CsBoardBigCategoryVO();
	            bcvo.setBigcatename(rs.getString(8));
	            
	            mvo = new MemberVO();
	            mvo.setName(rs.getString(9));
	            
	            bvo.setFk_userid(rs.getString(10));
	            
	            svo.setCbbcvo(bcvo);
	            bvo.setCbscvo(svo);
	            bvo.setMvo(mvo);
			}
			
		} finally {
			close();
		}
		
		return bvo;
	}

	@Override
	public int BoardDelete(String boardno) throws SQLException {
		int n = 0;
		
	      try {
	         conn = ds.getConnection();
	         String sql = " delete from tbl_csBoard where boardno = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, boardno); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
	         
	         n = pstmt.executeUpdate();
	      } finally {
	         close();
	      }
	   
	      
	      return n;
	}
	
	@Override
	   public List<CsBoardVO> memberCsBoardView(Map<String, String> paraMap, String fk_bigcateno) throws SQLException {
	      List<CsBoardVO> boardList = new ArrayList<>();
	         
	         try {
	             conn = ds.getConnection();
	             
	             String sql =  " select boardno, boardtitle, boardcontent, boardregistdate ,boardfile ,boardpwd , fk_smallcateno, fk_bigcateno, bigcatename "+
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
	                            "     )V "+
	                            " )T "+
	                            " where fk_userid =? and rno between ? and ? ";
	             
	             pstmt = conn.prepareStatement(sql);
	             
	             int currentShowPageNo = Integer.parseInt( paraMap.get("currentShowPageNo") );
	             int sizePerPage = 10; // 한 페이지당 화면상에 보여줄 제품의 개수는 10 으로 한다.
	             
	             pstmt.setString(1, paraMap.get("userid"));
	             pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
	             pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식 

	             rs = pstmt.executeQuery();
	             
	             while( rs.next() ) {
	                
	                CsBoardVO bvo = new CsBoardVO();
	                                                      
	                
	                bvo.setBoardno(rs.getInt(1));
	                bvo.setBoardtitle(rs.getString(2));
	                bvo.setBoardcontent(rs.getString(3));
	                bvo.setBoardregistdate(rs.getString(4));
	                bvo.setBoardfile(rs.getString(5));
	                bvo.setBoardpwd(rs.getString(6));
	                bvo.setFk_smallcateno(rs.getString(7));
	                
	                CsBoardSmallCategoryVO smallvo = new CsBoardSmallCategoryVO();
	                smallvo.setFk_bigcateno(rs.getInt(8));
	                bvo.setCbscvo(smallvo);
	                
	                CsBoardBigCategoryVO bigvo = new CsBoardBigCategoryVO();
	                bigvo.setBigcatename(rs.getString(9));
	                smallvo.setCbbcvo(bigvo);
	                
	                
	                boardList.add(bvo);
	                
	             }// end of while-----------------------------------------
	             
	         } finally {
	            close();
	         }      
	         
	         return boardList;
	   }

	@Override
	public int updateBoard(CsBoardVO board, String fk_userid, String boardno) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "update tbl_csBoard set "
						   + "                      boardtitle = ? "
						   + "                    , fk_userid = ? " 
						   + "                    , boardpwd = ? "
						   + "                    , boardcontent = ? "
						   + "                    , boardfile = ? "
						   + "                    , fk_smallcateno = ? "
					   + " where fk_userid = ? and boardno = ?"; 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board.getBoardtitle());
			pstmt.setString(2, board.getFk_userid());
			pstmt.setString(3, Sha256.encrypt(board.getBoardpwd()));
			pstmt.setString(4, board.getBoardcontent());
			pstmt.setString(5, board.getBoardfile());
			pstmt.setString(6, board.getFk_smallcateno());
			pstmt.setString(7, fk_userid);
			pstmt.setString(8, boardno);
						
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;	
	}

	@Override
	public int addComment(BoardAdminCommentVO adcommvo) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_boardcomment(bcommentno, bcontent, fk_boardno) "
					   		+ " values(seq_bcommentno.nextval, ?, ?) ";
					   
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adcommvo.getBcontent());
			pstmt.setInt(2, adcommvo.getFk_boardno());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;		
	}

	@Override
	public List<BoardAdminCommentVO> commentList(String boardno) throws SQLException {
		List<BoardAdminCommentVO> commentList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =	 " select bcommentno, bcontent, fk_boardno, to_char(commDate, 'yyyy-mm-dd hh24:mi:ss') AS commDate " + 
							     " from tbl_boardcomment " +
							     " where fk_boardno = ? " ;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardno);
			
			rs = pstmt.executeQuery();
								
			while(rs.next()) {
				
				int bcommentno = rs.getInt("bcommentno");
				String bcontent = rs.getString("bcontent");
				int fk_boardno = rs.getInt("fk_boardno");
				String commDate = rs.getString("commDate");
				
				BoardAdminCommentVO adcommvo = new BoardAdminCommentVO();
				adcommvo.setBcommentno(bcommentno);
				adcommvo.setBcontent(bcontent);
				adcommvo.setFk_boardno(fk_boardno);
				adcommvo.setCommDate(commDate);
				
				commentList.add(adcommvo);
			}
			
		} finally {
			close();
		}		
		
		return commentList;		
	}

	@Override
	public int reviewDel(String fk_boardno) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_boardcomment "
					   + " where fk_boardno = ? ";
					   
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_boardno);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;		
	}



}
