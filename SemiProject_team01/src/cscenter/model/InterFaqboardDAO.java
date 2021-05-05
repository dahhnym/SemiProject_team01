package cscenter.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterFaqboardDAO {
	
	// 메인페이지에 보여지는 상품이미지파일명을 모두 조회(select)하는 메소드 
	// DTO(Data Transfer Object) == VO(Value Object)
	List<HashMap<String, String>> getFaqCategoryList() throws SQLException;

	List<FaqboardVO> selectbyfaq(Map<String, String> paraMap) throws SQLException;

	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	List<FaqboardVO> selectPagingFaq(Map<String, String> paraMap) throws SQLException;

	List<HashMap<String, String>> getBoardCategoryList() throws SQLException;

}
