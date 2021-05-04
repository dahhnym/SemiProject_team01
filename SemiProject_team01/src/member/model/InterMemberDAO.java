package member.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterMemberDAO {

	// 아이디 중복검사
	boolean idDuplicateCheck(String userid) throws SQLException;

	// 회원가입 정보 insert 하기
	int registerMember(MemberVO member, String clientip) throws SQLException;

	// 로그인하기
	MemberVO loginConfirm(Map<String, String> paraMap) throws SQLException;

	// 비밀번호 변경하기
	int changePwd(String userid, String newPwd) throws SQLException;

	// 휴면상태 변경하기
	int changeIdle(String userid) throws SQLException;



}
