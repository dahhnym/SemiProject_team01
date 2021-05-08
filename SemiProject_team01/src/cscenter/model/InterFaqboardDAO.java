package cscenter.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterFaqboardDAO {
	
	// 고객센터 메인에서 보여질 자주묻는 질문 카테고리이름 불러오는 메소드
	List<HashMap<String, String>> getFaqCategoryList() throws SQLException;

	// 선택한 탭의 내용을 보여주는 메소드
	List<FaqboardVO> selectbyfaq(Map<String, String> paraMap) throws SQLException;

	// 페이징처리를 위한 총 페이지 수 구하는 메소드
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	// 자주묻는 질문 전체보기 페이징 처리
	List<FaqboardVO> selectPagingFaq(Map<String, String> paraMap) throws SQLException;

}
