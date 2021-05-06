package cscenter.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterCsBoardDAO {

	int registerBoard(CsBoardVO board) throws SQLException;

	int selectSmallCateCnt(String fk_bigcateno) throws SQLException;

	List<CsBoardVO> GetSmallCategoryList(String fk_bigcateno) throws SQLException;

	List<CsBoardVO> selectBoardByCategory(Map<String, String> paraMap, String fk_bigcateno) throws SQLException;

	int getTotalPage(String fk_bigcateno) throws SQLException;

	String getBigCategoryName(String fk_bigcateno) throws SQLException;

	int checkUserPwd(String userid, String boardpwd) throws SQLException;

}
