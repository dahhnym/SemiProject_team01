package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

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
			String sql = " select userid "
					   + " from tbl_member "
					   + " where userid= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			b=rs.next();

		} finally {
			close();
		}
		
		return b;
	}// end of public boolean idDuplicateCheck(String userid) throws SQLException --------------------------------------

	
	// 회원가입 정보 insert 하기
	@Override
	public int registerMember(MemberVO member) throws SQLException {
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
		
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return n;
	}// end of public int registerMember(MemberVO member) throws SQLException ---------------------------------------------

		
}
