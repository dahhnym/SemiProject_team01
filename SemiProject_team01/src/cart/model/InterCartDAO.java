package cart.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import product.model.ProductDetailVO;



public interface InterCartDAO {

	// 회원이 담은 장바구니 리스트 보이기(select)
	List<CartVO> cartList(String userid) throws SQLException ; //괄호에 String userid넣어야함

	// 위시리스트 보여주기 (select)
	List<WishListVO> wishList(String userid) throws SQLException;

	// 장바구니에서 개별 상품 삭제하기(delete)
	int deleteCartOne(String userid, String cartnum) throws SQLException;

	// 위시리스트에서 개별 상품 삭제하기(delete)
	int deleteWishOne(String userid, String wnum) throws SQLException;

	// 해당 상품을 장바구니에 삭제(delete)하고 위시리스트에 추가(insert)
	int deleteCartAddWish(Map<String, String> paraMap) throws SQLException;

	// 해당 상품에 대한 옵션 리스트 보이기(select) 1
//	List<String> optionSelect(String fk_pnum) throws SQLException;

	// 해당 상품에 대한 옵션 리스트 보이기(select) 2 
	List<ProductDetailVO> optionSelect(String fk_pnum) throws SQLException;

	// 장바구니 옵션 추가하기(select, insert)
	int addOptionCart(String pdetailnum, String userid,String fk_pnum) throws SQLException;

	// 장바구니 옵션 변경하기(update)
	int changeOptionCart(String oldpdetailnum, String newpdetailnum, String userid) throws SQLException;

	// 위시리스트 옵션 변경하기(update)
	int changeOptionWish(String oldpdetailnum, String newpdetailnum, String userid) throws SQLException;

	// 장바구니 비우기(delete)
	int deleteAllCart(String userid) throws SQLException;

	// 수량 변경하기(update)
	int updateOqty(String userid, String cartnum, String oqty, String fk_pdetailnum) throws SQLException;

	// 해당 상품을 위시리스트에 삭제(delete)하고 장바구니에 추가(insert)
	int deleteWishAddCart(Map<String, String> paraMap) throws SQLException;

	
	
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	
	List<WishListVO> selectPagingMember(Map<String, String> paraMap) throws SQLException;





	

}
