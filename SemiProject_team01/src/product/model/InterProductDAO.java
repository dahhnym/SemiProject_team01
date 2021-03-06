package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import member.model.MemberVO;

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

	// 신상품 select 해오기
	List<ProductVO> selectNEWonly(Map<String, String> paraMap) throws SQLException;

	// 페이징처리를 위해서 주문상세 내역에 대한 총 페이지 개수 알아오기(select) -실패
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 한 채로 리뷰작성할 수 있는 주문 내역 보여주기 -실패
	List<ProductVO> selectPagingReview(Map<String, String> paraMap) throws SQLException;

	// 페이징처리를 위해서 전 제품에 대한 총페이지 개수 알아오기(select) 
	int selectProdTotalPage(Map<String, String> paraMap) throws SQLException;

	// 제품 목록 출력하기 위해 제품 테이블에서 select 해오기
	List<ProductVO> getProductInfo(Map<String, String> paraMap) throws SQLException;

	// 제품 카테고리 별로 불러오기
	List<ProductVO> selectCateonly(Map<String, String> paraMap) throws SQLException;
	
	// 페이지바를 만들기 위해서 특정카테고리의 제품개수에 대한 총페이지수 알아오기(select)
	int getTotalPage(String cnum) throws SQLException;

	// 특정 제품 스펙의 카테고리별 제품 select 해오기
	List<ProductVO> selectByBothSpecCateg(Map<String, String> paraMap) throws SQLException;

	// 홈, 제품상세페이지에 신상품 이미지 슬라이드 출력을 위해 신상품 select 해오기
	List<ProductVO> selectBESTonly(Map<String, String> paraMap) throws SQLException;

	
}
