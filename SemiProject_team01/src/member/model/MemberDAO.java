package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;
import util.security.*;


public class MemberDAO implements InterMemberDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes; // 클래스의 객체가 인스턴스이기 때문에 메소드가 필요하다.
	
	// 생성자
	public MemberDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semioracle");
			
			aes = new AES256(SecretMyKey.KEY);
			// SecretMyKey.KEY은 우리가 만든 비밀키이다.
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
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
	
    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    
	// 아이디 중복체크   
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = " select userid from tbl_member where userid= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			b=rs.next();

		} finally {
			close();
		}
		
		return b;
	}// end of public boolean idDuplicateCheck(String userid) throws SQLException --------------------------------------------
	
	
	// 회원가입하기
	@Override
	public int registerMember(MemberVO member, String clientip) throws SQLException {
		int n=0;
		
		try {
			conn = ds.getConnection();

			String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday, adagreements) "  + 
					     " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, Sha256.encrypt(member.getPwd())); // 암호 단방향 암호화
			pstmt.setString(3, member.getName());
			pstmt.setString(4, aes.encrypt(member.getEmail())); // 이메일 양방향 암호화
			pstmt.setString(5, aes.encrypt(member.getMobile())); // 휴대폰 번호 양방향 암호화
			pstmt.setString(6, member.getPostcode());
	        pstmt.setString(7, member.getAddress());
	        pstmt.setString(8, member.getDetailaddress());
	        pstmt.setString(9, member.getExtraaddress());
	        pstmt.setString(10, member.getGender());
	        pstmt.setString(11, member.getBirthday());
	        pstmt.setString(12, member.getAdagreements());
	        
	        n = pstmt.executeUpdate();
	        
	        if(n!=0) {
	        	sql = " insert into tbl_loginhistory(fk_userid, clientip) "	
	        	    + " values(?,?) ";
	        	
	        	pstmt = conn.prepareStatement(sql);			
				pstmt.setString(1, member.getUserid());
				pstmt.setString(2, clientip); 
				pstmt.executeUpdate();
	        }
		
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return n;
	}// end of public int registerMember(MemberVO member) throws SQLException ---------------------------------------------

	
	// 로그인하기
	@Override
	public MemberVO loginConfirm(Map<String, String> paraMap) throws SQLException {

		MemberVO loginuser = null;
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid, name, point, fk_memberlevel, trunc((sysdate-lastpwdchangedate)/60), idle, email, mobile, address, detailaddress, extraaddress, postcode "
					   + " from tbl_member where userid=? and pwd=? ";
			
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd"))); // 암호 단방향 암호화
			
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {	// 아이디와 비밀번호가 있다면,
	        	
	        	sql = " insert into tbl_loginhistory(fk_userid, clientip) "	
	        	    + " values(?,?) ";
	        	
	        	pstmt = conn.prepareStatement(sql);			
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("clientip")); 
				n = pstmt.executeUpdate();
				
				if(n!=0) { // 그리고 로그인 기록 남겼다면,
					
					loginuser = new MemberVO();
					
		        	loginuser.setUserid(paraMap.get("userid"));
		        	loginuser.setPwd(paraMap.get("pwd"));
		        	loginuser.setName(rs.getString(2));
		        	loginuser.setPoint(rs.getInt(3));
		        	loginuser.setLevel(rs.getString(4));
		        	loginuser.setPwdCycleMonth(rs.getInt(5));
		        	loginuser.setIdle(rs.getString(6));
		        	loginuser.setEmail(aes.decrypt(rs.getString(7)));
		        	loginuser.setMobile(aes.decrypt(rs.getString(8)));
		        	loginuser.setAddress(rs.getString(9));
		        	loginuser.setDetailaddress(rs.getString(10));
		        	loginuser.setExtraaddress(rs.getString(11));
		        	loginuser.setPostcode(rs.getString(12));
		    		
				}
	        } 
	        
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return loginuser;
	}// public MemberVO registerMember(String userid, String pwd) ------------------------------------------------------------

	
	// 비밀번호 변경하기
	@Override
	public int changePwd(String userid, String newPwd) throws SQLException {
		int n=0;

		try {
			conn = ds.getConnection();

			String sql = " update tbl_member set pwd=?, lastpwdchangedate=sysdate " +
						 " where userid=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Sha256.encrypt(newPwd)); 
			pstmt.setString(2, userid);
			
	        n = pstmt.executeUpdate();

		} finally {
			close();
		}
		
		return n;
	}// end of public int changePwd(String newPwd) throws SQLException ------------------------------------------------------

	
	// 휴면상태 변경하기
	@Override
	public int changeIdle(String userid) throws SQLException {
		int n=0;
		
		try {
			conn = ds.getConnection();

			String sql = " update tbl_member set idle=0 where userid=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
	        n = pstmt.executeUpdate();

		} finally {
			close();
		}
		
		return n;
	}// end of public int changeIdle(String userid) throws SQLException ----------------------------------------------------

	
	// 아이디 찾기
	@Override
	public String findUserid(String name, String email) throws SQLException {
		String userid = "";
		
		try {
			conn = ds.getConnection();
			String sql = " select userid from tbl_member where name=? and email=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, aes.encrypt(email));
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userid = rs.getString(1);
			}
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return userid;
	}

	
	// 회원계정 존재여부 확인하기
	@Override
	public int checkAccount(Map<String, String> paraMap) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid from tbl_member where name=? and userid=? and email=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("name"));
			pstmt.setString(2, paraMap.get("userid"));
			pstmt.setString(3, aes.encrypt(paraMap.get("email")));
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				n=1;
			}
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return n;
	}

	// 페이징 처리를 위해 회원목록 총페이지수 알아오기
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {

		int totalPage = 0;
		
		try {
			conn = ds.getConnection();

			String sql = " select ceil( count(*)/? ) "
					   + " from tbl_member"
					   + " where userid != 'admin'";
			
			// ======검색어가 있는경우 시작 =========== 
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");

			if("email".equals(colname)) {
				//검색 대상이 email인 경우
				searchWord = aes.encrypt(searchWord);
			}
			
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
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();	
		} finally {
			close();
		}
		
		
		return totalPage;
	
	}

	// 페이징 처리를 한 모든 회원 또는 검색한 회원 목록 보여주기
	@Override
	public List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException {
		List<MemberVO> memberList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();

			String sql = "select userid, name, mobile, memberlevel, idle, status\n"+
						 "from\n"+
						 "(\n"+
						 "    select rownum as rno, userid, name, mobile, memberlevel, idle, status\n"+
						 "    from\n"+
						 "    (\n"+
						 "    select userid, name, mobile, fk_memberlevel as memberlevel, idle, status\n"+
						 "    from tbl_member\n"+
						 "    where userid != 'admin' ";
			
			// ======검색어가 있는경우 시작 =========== 
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");

			if("email".equals(colname)) {
				//검색 대상이 email인 경우
				searchWord = aes.encrypt(searchWord);
			}
			
			if( searchWord != null && !searchWord.trim().isEmpty()) {
			// 검색어를 아예 안 쓰거나 공백(space)만 입력한 것이 아닌 검색어를 입력한 경우
				sql += " and "+colname+" like '%'||?||'%' ";
				// 위치홀더는 데이터값에만 사용됨. 테이블명이나 컬럼명에는 위치홀더를 사용할 수 없다.
			}
			// ======검색어가 있는경우 끝 ===========
			
			sql += "    order by registerday\n"+
				   "    ) V\n"+
				   ") T\n"+
				   "where rno between ? and ?";
			
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);

			
			if( searchWord != null && !searchWord.trim().isEmpty()) {
				// 검색어를 아예 안 쓰거나 공백(space)만 입력한 것이 아닌 검색어를 입력한 경우
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			} else {
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			}
			

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				MemberVO mvo = new MemberVO();
				mvo.setUserid(rs.getString(1));
				mvo.setName(rs.getString(2));
				mvo.setMobile(aes.decrypt(rs.getString(3))); //복호화
				mvo.setLevel(rs.getString(4));
				mvo.setIdle(rs.getString(5));
				mvo.setStatus(rs.getString(6));
				
				memberList.add(mvo);
				
			}//end of while(rs.next())------------------------------------------------
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return memberList;
	}

	
	// 임시비밀번호로 DB 저장하기
	@Override
	public int saveRndPwd(String rndPwd, String userid) throws SQLException {
		int n=0;
		
		try {
			conn = ds.getConnection();

			String sql = " update tbl_member set pwd=? where userid=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Sha256.encrypt(rndPwd));
			pstmt.setString(2, userid);
			
	        n = pstmt.executeUpdate();

		} finally {
			close();
		}
		
		return n;
	}
	
	
	// 멤버수정하기
	@Override
	public int altMemberInfo(MemberVO member) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	// 수정한 유저 session에 저장하기
	@Override
	public MemberVO getLoginuser(MemberVO member) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


		
}
