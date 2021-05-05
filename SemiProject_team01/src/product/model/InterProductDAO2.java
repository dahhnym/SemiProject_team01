package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO2 {

	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기
	ProductVO2 selectOneProductByCnum(String pnum) throws SQLException;

	// 제품번호를 가지고서 해당 제품의 추가된 이미지 정보를 조회해오기 
	List<String> getImagesByPnum(String pnum) throws SQLException;

	// 제품 후기 쓰기
	int addComment(PurchaseReviewsVO reviewsvo) throws SQLException;

	// 제품 후기 불러오기
	List<PurchaseReviewsVO> commentList(String fk_pnum) throws SQLException;

	// 제품 후기 삭제
	int reviewDel(String review_seq) throws SQLException;

	// 제품 목록 보여주기
	int totalPspecCount(String fk_snum) throws SQLException;

	// 제품 스펙이름 불러오기
	List<ProductVO2> selectBySpecName(Map<String, String> paraMap) throws SQLException;

	

}
