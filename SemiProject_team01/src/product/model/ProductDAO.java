package product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.MemberVO;



public class ProductDAO implements InterProductDAO {
	
	private DataSource ds;

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	// 생성자
	public ProductDAO() {
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


 // tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
	@Override
	public List<HashMap<String, String>> getCategory() throws SQLException {
		List<HashMap<String, String>> categoryList = new ArrayList<>(); 
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select cnum, code, cname "  
	                    + " from tbl_category "
	                    + " order by cnum asc ";
	                    
	         pstmt = conn.prepareStatement(sql);
	               
	         rs = pstmt.executeQuery();
	                  
	         while(rs.next()) {
	            HashMap<String, String> map = new HashMap<>();
	            map.put("cnum", rs.getString(1));
	            map.put("code", rs.getString(2));
	            map.put("cname", rs.getString(3));
	            
	            categoryList.add(map);
	         }// end of while(rs.next())----------------------------------
	         
	      } finally {
	         close();
	      }   
	      
	      return categoryList;
	}

	// 스펙 select 해오기
	@Override
	public List<SpecVO> getSpecList() throws SQLException {
		   
		List<SpecVO> specList = new ArrayList<>();
		
		try {
		         conn = ds.getConnection();
		         
		         String sql = " select snum, sname " + 
		                    " from tbl_spec " + 
		                    " order by snum asc ";
		         
		         pstmt = conn.prepareStatement(sql);
		         
		         rs = pstmt.executeQuery();
		         
		         while(rs.next()) {
		            SpecVO spvo = new SpecVO();
		            spvo.setSnum(rs.getInt(1));
		            spvo.setSname(rs.getString(2));
		            
		            specList.add(spvo);
		         }
		                  
		      } finally {
		         close();
		      }
		      
		      return specList;
	}

	      

  

  // 제품번호 채번 해오기
	@Override
	public int getPnumOfProduct() throws SQLException{
		    int pnum = 0;
		    try {
	          String sql = " select seq_tbl_product_pnum.nextval AS PNUM " +
	                     " from dual ";
	                  // seq_tbl_product_pnum: 시퀀스명
	          pstmt = conn.prepareStatement(sql);
	          rs = pstmt.executeQuery();
	                    
	          rs.next();
	          pnum = rs.getInt(1);
	      
	      } finally {
	         close();
	      }
	      
	      return pnum;
	}

	// tbl_product 테이블에 제품정보 insert 하기
	@Override
	public int productInsert(ProductVO pvo) throws SQLException {
		int n=0;
		
		 try {
	          conn = ds.getConnection();
	          

			  String sql = " insert  into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, price, saleprice, fk_snum, pcontent) "+
			               " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			  
			  pstmt= conn.prepareStatement(sql);
			  pstmt.setInt(1, pvo.getPnum());
			  pstmt.setString(2, pvo.getPname());
			  pstmt.setInt(3, pvo.getFk_cnum());
			  pstmt.setString(4, pvo.getPcompany());
			  pstmt.setString(5, pvo.getPimage1());
			  pstmt.setString(6, pvo.getPimage2());
			  pstmt.setInt(7, pvo.getPrice());
			  pstmt.setInt(8, pvo.getSaleprice());
			  pstmt.setInt(9, pvo.getFk_snum());
			  pstmt.setString(10, pvo.getPcontent());
			  
			  n = pstmt.executeUpdate();
	      
	      } finally {
	         close();
	      }
	      
	      return n;
	}

	// 옵션의 수만큼 제품번호에 옵션명, 재고량 insert해주기
	@Override
	public int product_detail_Insert(int pnum, String optionname, int pqty) throws SQLException {
		int k=0;
		
		 try {
	          conn = ds.getConnection();
	          

	          String sql = " insert into tbl_proddetail(pdetailnum,fk_pnum,optionname,pqty) "+
	        		       " values (seq_tbl_proddetail_pdetailnum.nextval,?,?,?) ";
			  
			  pstmt= conn.prepareStatement(sql);
			  pstmt.setInt(1, pnum);
			  pstmt.setString(2,optionname);
			  pstmt.setInt(3, pqty);
			  
			  k = pstmt.executeUpdate();
	      
	      } finally {
	         close();
	      }
	      
	      return k;
	}

	// 추가 제품 이미지만큼 이미지 테이블에 insert 하기
	@Override
	public int product_imagefile_Insert(int pnum, String attachFileName) throws SQLException {
		int m = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_product_imagefile(imgfileno, fk_pnum, imgfilename) "+ 
	                    " values(seqImgfileno.nextval, ?, ?) ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setInt(1, pnum);
	         pstmt.setString(2, attachFileName);
	         
	         m = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return m;   
	}
	
	// 신상품 select 해오기
		@Override
		public List<product.model.ProductVO> selectNEWonly(Map<String, String> paraMap) throws SQLException {
			List<ProductVO> prodList = new ArrayList<>();
		      
		      try {
		          conn = ds.getConnection();
		          
		          String sql = "select pnum, pname, pimage1, price, saleprice\n"+
		        		  		"from\n"+
		        		  		"(\n"+
		        		  		"select row_number() over(order by pnum asc) AS RNO \n"+
		        		  		"      , pnum, pname, pcompany, pimage1, price, saleprice, S.sname\n"+
		        		  		" from tbl_product P \n"+
		        		  		" JOIN tbl_category C \n"+
		        		  		" ON P.fk_cnum = C.cnum \n"+
		        		  		" JOIN tbl_spec S \n"+
		        		  		" ON P.fk_snum = S.snum\n"+
		        		  		" where S.sname = ? \n"+
		        		  		") V\n"+
		        		  		"where RNO between ? and ?\n"+
		        		  		"order by pnum desc";
		          
		          pstmt = conn.prepareStatement(sql);
		          pstmt.setString(1, paraMap.get("sname"));
		          pstmt.setString(2, paraMap.get("start"));
		          pstmt.setString(3, paraMap.get("end"));
		          
		          rs = pstmt.executeQuery();
		          
		          while( rs.next() ) {
		             
		             ProductVO pvo = new ProductVO();
		             
		             pvo.setPnum(rs.getInt(1));     // 제품번호
		             pvo.setPname(rs.getString(2)); // 제품명
		             pvo.setPimage1(rs.getString(3));   // 제품이미지1   이미지파일명
		             pvo.setPrice(rs.getInt(4));        // 제품 정가
		             pvo.setSaleprice(rs.getInt(5));    // 제품 판매가
		               
		             
		             prodList.add(pvo);
		          }// end of while-----------------------------------------
		          
		      } finally {
		         close();
		      }      
		      
		      return prodList;
		}
		
		
		// *** 페이징 처리를 한 모든  또는 검색한 회원 목록 보여주기 *** //
		@Override
		public List<ProductVO> selectPagingReview(Map<String, String> paraMap) throws SQLException {
			
			List<ProductVO> ReviewList = new ArrayList<>();
			
			try {
				 conn = ds.getConnection();
				 
				 String sql = "select rno, pname, pimage1, optionname\n" + 
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
				 		"        where fk_userid = ? and odrdetailno != (select fk_odrdetailno from tbl_review where fk_userid = ?))\n" + 
				 		"    )C\n" + 
				 		")\n" + 
				 		" where fk_userid = 'user' and odrdetailno != (select fk_odrdetailno from tbl_review where fk_userid = 'user'))\n" ; 
				 	//	"where rno between ? and ?";
				 
				 
				 int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				 int sizePerPage = 	Integer.parseInt(paraMap.get("sizePerPage"));	 
				 
				 pstmt = conn.prepareStatement(sql);
				 
				 pstmt.setString(1, paraMap.get("userid") );
				 pstmt.setString(2, paraMap.get("userid") );
				
		//		 pstmt.setInt(3, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ); // 공식
		//		 pstmt.setInt(4, (currentShowPageNo * sizePerPage) ); // 공식 	 
				 			 
				 rs = pstmt.executeQuery();
				 
				 while(rs.next()) {
					 
					 ProductVO pvo = new ProductVO();
					 pvo.setPname(rs.getString(1));
					 pvo.setPname(rs.getString(2));
					 pvo.setPname(rs.getString(3));
					 
					 ReviewList.add(pvo);
				 }// end of while(rs.next())---------------------------------------
				
			} finally {
				close();
			}
			
			return ReviewList;
		}
  
  // 페이징처리를 위해서 주문상세 내역에 대한 총 페이지 개수 알아오기(select)
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {

		int totalPage = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql ="select odrdetailno " + 
			 			"from tbl_odrdetail " + 
			 			"where fk_userid = ? and odrdetailno != (select fk_odrdetailno from tbl_review where fk_userid = ?)";
			 
			 			
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, paraMap.get("userid") );
			 pstmt.setString(2, paraMap.get("userid") );
			 
			 rs = pstmt.executeQuery();
			 
			 rs.next();
			 
			 totalPage = rs.getInt(1);
		} catch (SQLException e){
			System.out.println("뭐임");
		} finally {
			close();
		}
		
		return totalPage;
	}


	// 보류중인 리뷰 보여주기
	@Override
	public List<ProductVO> pendingReview(String userid) throws SQLException {
		
		List<ProductVO> pdrvList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = "select rno, pname, pimage1, optionname\n" + 
			 		"from " + 
			 		"(" + 
			 		"    select rownum AS rno, pimage1, pname, optionname\n" + 
			 		"    from \n" + 
			 		"    (\n" + 
			 		"        select pimage1, pname, optionname \n" + 
			 		"        from tbl_product A join tbl_proddetail B\n" + 
			 		"        on A.pnum=B.fk_pnum\n" + 
			 		"        where pnum = (select fk_pnum\n" + 
			 		"        from tbl_odrdetail\n" + 
			 		"        where fk_userid = ? and odrdetailno != (select fk_odrdetailno from tbl_review where fk_userid = ?))\n" + 
			 		"    )C\n" + 
			 		")\n";
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1,userid);
			 pstmt.setString(2,userid);
			
			 rs = pstmt.executeQuery();
			 
			 
			 
			 while(rs.next()) {
				 
				 ProductVO pvo = new ProductVO();
				 pvo.setPname(rs.getString(1));
				 pvo.setPimage1(rs.getString(2));
				 
				 pdrvList.add(pvo);
			 }// end of while(rs.next())---------------------------------------

			 
		} finally {
			close();
		}
		
		return pdrvList;
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

	// 작성한 리뷰 보여주기
		@Override
		public List<ProductVO> writtenReview(String userid) throws SQLException {
			
			List<ProductVO> wtrvList = new ArrayList<>();
			
			try {
				 conn = ds.getConnection();
				 
				 String sql = "select rno, pname, pimage1, optionname\n" + 
				 		"from " + 
				 		"(" + 
				 		"    select rownum AS rno, pimage1, pname, optionname\n" + 
				 		"    from \n" + 
				 		"    (\n" + 
				 		"        select pimage1, pname, optionname \n" + 
				 		"        from tbl_product A join tbl_proddetail B\n" + 
				 		"        on A.pnum=B.fk_pnum\n" + 
				 		"        where pnum = (select fk_pnum\n" + 
				 		"        from tbl_odrdetail\n" + 
				 		"        where fk_userid = ? and odrdetailno = (select fk_odrdetailno from tbl_review where fk_userid = ?))\n" + 
				 		"    )C\n" + 
				 		")\n";
				 pstmt = conn.prepareStatement(sql);
				 
				 pstmt.setString(1,userid);
				 pstmt.setString(2,userid);
				
				 rs = pstmt.executeQuery();
				 
				 
				 
				 while(rs.next()) {
					 
					 ProductVO pvo = new ProductVO();
					 pvo.setPname(rs.getString(1));
					 pvo.setPimage1(rs.getString(2));
					 
					 wtrvList.add(pvo);
				 }// end of while(rs.next())---------------------------------------

				 
			} finally {
				close();
			}
			
			return wtrvList;
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

		// 페이징처리를 위해서 전 제품에 대한 총페이지 개수 알아오기(select) 
		@Override
		public int selectProdTotalPage(Map<String, String> paraMap) throws SQLException {
			int totalPage = 0;
			
			try {
				conn = ds.getConnection();

				String sql = " select ceil( count(*)/? ) "
						   + " from tbl_product";
				
				// ======검색어가 있는경우 시작 =========== 
				String colname = paraMap.get("searchType");
				String searchWord = paraMap.get("searchWord");

				
				if( searchWord != null && !searchWord.trim().isEmpty()) {
				// 검색어를 아예 안 쓰거나 공백(space)만 입력한 것이 아닌 검색어를 입력한 경우
					sql += " and "+colname+" like '%'||?||'%' ";
					// 위치홀더는 데이터값에만 사용됨. 테이블명이나 컬럼명에는 위치홀더를 사용할 수 없다.
				}
				// ======검색어가 있는경우 끝 ===========
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("sizePerPage"));

				if( searchWord != null && !searchWord.trim().isEmpty()) {
					// 검색어를 아예 안 쓰거나 공백(space)만 입력한 것이 아닌 검색어를 입력한 경우
					pstmt.setString(2, searchWord);
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

		// 제품 목록 출력하기 위해 제품 테이블에서 select 해오기
		@Override
		public List<ProductVO> getProductInfo(Map<String, String> paraMap) throws SQLException {
			
			List<ProductVO> prodList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();

				String sql = "select pnum, cname, sname, pname, pcompany, price, saleprice, pqty, saleqty\n"+
							 "from\n"+
							 "(\n"+
							 "select row_number() over(order by pnum asc) AS RNO \n"+
							 "      , pnum, cname, sname, pname, pcompany, price, saleprice\n"+
							 " from tbl_product P \n"+
							 " JOIN tbl_spec S \n"+
							 " ON P.fk_snum = S.snum\n"+
							 " JOIN tbl_category C\n"+
							 " ON P.fk_cnum=C.cnum\n"+
							 ") V\n"+
							 "JOIN\n"+
							 "(\n"+
							 "select fk_pnum, sum(pqty) as pqty, sum(saleqty) as saleqty\n"+
							 "from tbl_proddetail\n"+
							 "group by fk_pnum\n"+
							 ") D\n"+
							 "ON V.pnum = D.fk_pnum\n"+
							 "where RNO between ? and ?\n"+
							 "order by pnum desc";
				
				/*
				// ======검색어가 있는경우 시작 =========== 
				String colname = paraMap.get("searchType");
				String searchWord = paraMap.get("searchWord");

				
				if( searchWord != null && !searchWord.trim().isEmpty()) {
				// 검색어를 아예 안 쓰거나 공백(space)만 입력한 것이 아닌 검색어를 입력한 경우
					sql += " and "+colname+" like '%'||?||'%' ";
					// 위치홀더는 데이터값에만 사용됨. 테이블명이나 컬럼명에는 위치홀더를 사용할 수 없다.
				}
				// ======검색어가 있는경우 끝 ===========
				
				sql += "    order by registerday desc\n"+
					   "    ) V\n"+
					   ") T\n"+
					   "where rno between ? and ?";
				*/
				
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
				
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
				/*
				if( searchWord != null && !searchWord.trim().isEmpty()) {
					// 검색어를 아예 안 쓰거나 공백(space)만 입력한 것이 아닌 검색어를 입력한 경우
					pstmt.setString(1, searchWord);
					pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
					pstmt.setInt(3, (currentShowPageNo * sizePerPage));
				} else {
					pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
					pstmt.setInt(2, (currentShowPageNo * sizePerPage));
				}
				*/

				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					ProductVO pvo = new ProductVO();
					pvo.setPnum(rs.getInt(1));
					
					CategoryVO categvo = new CategoryVO();
					categvo.setCname(rs.getString(2));
					pvo.setCategvo(categvo);
					
					SpecVO spvo = new SpecVO();
					spvo.setSname(rs.getString(3));
					pvo.setSpvo(spvo);
					
					pvo.setPname(rs.getString(4));
					pvo.setPcompany(rs.getString(5));
					pvo.setPrice(rs.getInt(6));
					pvo.setSaleprice(rs.getInt(7));
					pvo.setPqty(rs.getInt(8));
					pvo.setSaleqty(rs.getInt(9));
					
					prodList.add(pvo);
					
				}//end of while(rs.next())------------------------------------------------
				
			} finally {
				close();
			}
			
			return prodList;
		
		
		}

}

