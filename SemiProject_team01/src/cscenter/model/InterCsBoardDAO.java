package cscenter.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterCsBoardDAO {

	int registerBoard(CsBoardVO board) throws SQLException;

	int selectSmallCateCnt(String fk_bigcateno) throws SQLException;

	List<CsBoardVO> GetSmallCategoryList(String fk_bigcateno) throws SQLException;

}
