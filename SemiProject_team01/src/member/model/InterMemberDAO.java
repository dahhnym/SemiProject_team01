package member.model;

import java.sql.SQLException;

public interface InterMemberDAO {

	// 아이디 중복검사
	boolean idDuplicateCheck(String userid) throws SQLException;

	// 회원가입 정보 insert 하기
	int registerMember(MemberVO member) throws SQLException;

}
