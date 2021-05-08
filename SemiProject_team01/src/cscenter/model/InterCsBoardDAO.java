package cscenter.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterCsBoardDAO {

	// 문의게시글 등록
	int registerBoard(CsBoardVO board) throws SQLException;

	// 글쓰기 폼 페이지가 로딩되면 자동으로 이전 페이지에서 가져온 카테고리 번호를 가지고 미리 select의 value를 지정해주기 위한 메소드
	List<CsBoardVO> GetSmallCategoryList(String fk_bigcateno) throws SQLException;

	// 문의게시판 글 목록 보여주는 메소드(페이징처리)
	List<CsBoardVO> selectBoardByCategory(Map<String, String> paraMap, String fk_bigcateno) throws SQLException;

	// 페이징처리를 위한 총 페이지 수 구하는 메소드
	int getTotalPage(String fk_bigcateno) throws SQLException;

	// 카테고리 이름 가져오는 메소드
	String getBigCategoryName(String fk_bigcateno) throws SQLException;

	// 글번호에 맞는 비밀번호를 입력했는 지 확인하는 메소드
	int checkUserPwd(String userid, String boardpwd) throws SQLException;

	// 작성한 내용 읽어오는 메소드
	CsBoardVO selectBoardDetail(String boardno) throws SQLException;

	// 작성한 문의 게시글 삭제하는 메소드
	int BoardDelete(String boardno) throws SQLException;
	
	// 마이페이지에서 로그인한 사용자가 쓴 글 목록을 불러오는 메소드
	List<CsBoardVO> memberCsBoardView(Map<String, String> paraMap, String fk_bigcateno) throws SQLException;

	// 게시글 수정
	int updateBoard(CsBoardVO board, String fk_userid, String boardno) throws SQLException;

	// 문의 게시판 관리자 답변
	int addComment(BoardAdminCommentVO adcommvo) throws SQLException;

	// 관리자가 작성한 답변 목록 보기
	List<BoardAdminCommentVO> commentList(String boardno) throws SQLException;

	// 관리자가 작성한 답변 삭제
	int reviewDel(String fk_boardno) throws SQLException;

	

}
