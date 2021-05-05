package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



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
  
  // 페이징처리를 위해서 주문상세 내역에 대한 총 페이지 개수 알아오기(select)
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {

		int totalPage = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql ="select odrdetailno " + 
			 			"from tbl_odrdetail " + 
			 			"where fk_userid = '?' and odrdetailno != (select fk_odrdetailno from tbl_review where fk_userid = '?')";
			 
			 			
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, paraMap.get("loginuser") );
			 pstmt.setString(2, paraMap.get("loginuser") );
			 
			 rs = pstmt.executeQuery();
			 
			 rs.next();
			 
			 totalPage = rs.getInt(1);
		
		} finally {
			close();
		}
		
		return totalPage;
	}
  
  
  

}

