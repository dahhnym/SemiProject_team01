package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {


	// Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
	List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException;

	List<HashMap<String, String>> getCategory() throws SQLException;
	
	int totalPspecCount(String fk_snum) throws SQLException;

	// 카테고리 select 해오기
	List<HashMap<String, String>> getCategory() throws SQLException;

	// 스펙 select 해오기
	List<SpecVO> getSpecList() throws SQLException;

	// 제품번호 채번 해오기
	int getPnumOfProduct() throws SQLException;

	// tbl_product 테이블에 제품정보 insert 하기
	int productInsert(ProductVO pvo) throws SQLException;

	// 옵션의 수만큼 tbl_productdetail에 insert 하기
	int product_detail_Insert(int pnum, String optionname, int pqty) throws SQLException;

	// 추가 제품 이미지만큼 이미지 테이블에 insert 하기
	int product_imagefile_Insert(int pnum, String attachFileName) throws SQLException;



}
