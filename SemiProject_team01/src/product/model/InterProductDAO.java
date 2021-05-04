package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {

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

	// 페이징처리를 위해서 주문상세 내역에 대한 총 페이지 개수 알아오기(select)
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;


}
