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

	// 아이디 찾기
	String findUserid(String name, String email) throws SQLException;

	// 비밀번호 찾기
	int findPwd(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위해 회원목록 총페이지수 알아오기
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 한 모든 회원 또는 검색한 회원 목록 보여주기
	List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException;



}
