package member.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterMemberDAO {

	// 아이디 중복검사
	boolean idDuplicateCheck(String userid) throws SQLException;

	// 회원가입 정보 insert 하기
	int registerMember(MemberVO member) throws SQLException;

	// 로그인하기
	MemberVO loginConfirm(Map<String, String> paraMap) throws SQLException;



}
