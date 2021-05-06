package product.model;

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

import member.model.MemberVO;




public class ProductDAO2 implements InterProductDAO2 {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public ProductDAO2() {
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
	

	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기
	@Override
	public ProductVO2 selectOneProductByCnum(String pnum) throws SQLException {
		
		ProductVO2 pvo2 = null;
		
		try {
			 conn = ds.getConnection(); 
			 
			 String sql = " select S.sname, pnum, pname, pcompany, price, saleprice, pcontent, pimage1, pimage2 "+
					      " from "+
					      " ( "+
					      "  select fk_snum, pnum, pname, pcompany, price, saleprice, pcontent, pimage1, pimage2 "+
					      "  from tbl_product "+
					      "  where pnum = ? "+
					      " ) P JOIN tbl_spec S "+
					      " ON P.fk_snum = S.snum ";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, pnum);
			 
			 rs = pstmt.executeQuery();
			 
			 try {
				if(rs.next()) {
					 
					 String sname = rs.getString(1);     // "HIT", "NEW", "BEST" 값을 가짐 
					 int    npnum = rs.getInt(2);        // 제품번호
					 String pname = rs.getString(3);     // 제품명
					 String pcompany = rs.getString(4);  // 제조회사명
					 int    price = rs.getInt(5);        // 제품 정가
					 int    saleprice = rs.getInt(6);    // 제품 판매가
					 String pcontent = rs.getString(7);  // 제품설명
					 String pimage1 = rs.getString(8);  // 제품이미지1
					 String pimage2 = rs.getString(9);  // 제품이미지2
					 
					 pvo2 = new ProductVO2(); 
					 
					 SpecVO spvo = new SpecVO();
					 spvo.setSname(sname);
					 
					 pvo2.setSpvo(spvo);
					 pvo2.setPnum(npnum);
					 pvo2.setPname(pname);
					 pvo2.setPcompany(pcompany);
					 pvo2.setPrice(price);
					 pvo2.setSaleprice(saleprice);
					 pvo2.setPcontent(pcontent);
					 pvo2.setPimage1(pimage1);
					 pvo2.setPimage2(pimage2);
					 
				 }
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			 
		} finally {
			close();
		}
		
		return pvo2;	
	}

	// 제품번호를 가지고서 해당 제품의 추가된 이미지 정보를 조회해오기
	@Override
	public List<String> getImagesByPnum(String pnum) throws SQLException {
		
		List<String> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select imgfilename "+
				         " from tbl_product_imagefile "+
				         " where fk_pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String imgfilename = rs.getString(1); // 이미지파일명 
				imgList.add(imgfilename); 
			}
			
		} finally {
			close();
		}
		
		return imgList;
	}


	// 제품 후기 쓰기
	@Override
	public int addComment(PurchaseReviewsVO reviewsvo) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_review(reviewno, fk_userid, pnum, rvcontent, rvdate) "
					   + " values(seq_reviewno.nextval, ?, ?, ?, default) ";
					   
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reviewsvo.getFk_userid());
			pstmt.setInt(2, reviewsvo.getPnum());
			pstmt.setString(3, reviewsvo.getRvcontents());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;		
	}

	// 제품 후기 불러오기
	@Override
	public List<PurchaseReviewsVO> commentList(String fk_pnum) throws SQLException {
		
		List<PurchaseReviewsVO> commentList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select reviewno, fk_userid, name, pnum, rvcontent, to_char(rvdate, 'yyyy-mm-dd hh24:mi:ss') AS rvdate " + 
					     " from tbl_review R join tbl_member M " + 
					     " on R.fk_userid = M.userid " + 
					     " where R.pnum = ? " + 
					     " order by reviewno desc "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_pnum);
			
			rs = pstmt.executeQuery();
								
			while(rs.next()) {
				String rvcontent = rs.getString("rvcontent");
				String name = rs.getString("name");
				String rvdate = rs.getString("rvdate");
				String fk_userid = rs.getString("fk_userid");
				int reviewno = rs.getInt("reviewno");
												
				PurchaseReviewsVO reviewvo = new PurchaseReviewsVO();
				reviewvo.setRvcontents(rvcontent);
				
				MemberVO mvo = new MemberVO();
				mvo.setName(name);
				
				reviewvo.setMvo(mvo);
				reviewvo.setRvdate(rvdate);
				reviewvo.setFk_userid(fk_userid);
				reviewvo.setReviewno(reviewno);
				
				commentList.add(reviewvo);
			}
			
		} finally {
			close();
		}		
		
		return commentList;
	}

	// 제품 후기 삭제
	@Override
	public int reviewDel(String review_seq) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_review "
					   + " where reniewno = ? ";
					   
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, review_seq);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}


	// 제품 목록 보여주기
	@Override
	public int totalPspecCount(String fk_snum) throws SQLException {
		
		int totalCount = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = "select count(*) "+
					      "from tbl_product "+
					      "where fk_snum = ? ";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, fk_snum);
			 
			 rs = pstmt.executeQuery();
			 
			 rs.next();
			 
			 totalCount = rs.getInt(1);
			 
		} finally {
			close();
		}		
		
		return totalCount;	
	}

	// 제품 스펙이름 불러오기
	@Override
	public List<ProductVO2> selectBySpecName(Map<String, String> paraMap) throws SQLException {
		
		List<ProductVO2> prodList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = "select pnum, pname, code, pcompany, pimage1, pimage2, price, saleprice, sname, pcontent "+
					      "from  "+
					      "( "+
					      "  select row_number() over(order by pnum desc) AS RNO "+
					      "       , pnum, pname, C.code, pcompany, pimage1, pimage2, price, saleprice, S.sname, pcontent "+
					      " from tbl_product P "+
					      " JOIN tbl_category C "+
					      " ON P.fk_cnum = C.cnum "+
					      " JOIN tbl_spec S "+
					      " ON P.fk_snum = S.snum "+
					      " where S.sname = ? "+
					      " ) V "+
					      "where RNO between ? and ? ";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, paraMap.get("sname"));
			 pstmt.setString(2, paraMap.get("start"));
			 pstmt.setString(3, paraMap.get("end"));
			 
			 rs = pstmt.executeQuery();
			 
			 while( rs.next() ) {
				 
				 ProductVO2 pvo = new ProductVO2();
				 
				 pvo.setPnum(rs.getInt(1));     // 제품번호
				 pvo.setPname(rs.getString(2)); // 제품명
				 
				 CategoryVO categvo = new CategoryVO(); 
				 categvo.setCode(rs.getString(3)); 
				 
				 pvo.setCategvo(categvo);           // 카테고리코드 
				 pvo.setPcompany(rs.getString(4));  // 제조회사명
				 pvo.setPimage1(rs.getString(5));   // 제품이미지1   이미지파일명
				 pvo.setPimage2(rs.getString(6));   // 제품이미지2   이미지파일명
				 pvo.setPrice(rs.getInt(7));        // 제품 정가
				 pvo.setSaleprice(rs.getInt(8));    // 제품 판매가(할인해서 팔 것이므로)
					
				 SpecVO spvo = new SpecVO(); 
				 spvo.setSname(rs.getString(9)); 
				 
				 pvo.setSpvo(spvo); // 스펙 
					
				 pvo.setPcontent(rs.getString(10));	  // 제품설명                                        
				 
				 prodList.add(pvo);
			 }// end of while-----------------------------------------
			 
		} finally {
			close();
		}		
		
		return prodList;		
	}

	


	

}
