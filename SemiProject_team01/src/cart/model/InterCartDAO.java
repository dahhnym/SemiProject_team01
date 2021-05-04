package cart.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;



public interface InterCartDAO {

	// 회원이 담은 장바구니 리스트 보이기(select)
	List<CartVO> cartList() throws SQLException ; //괄호에 String userid넣어야함

	// 위시리스트 보여주기 (select)
	List<WishListVO> wishList() throws SQLException;

	
	// 장바구니에서 개별 상품 삭제하기(delete)
	int deleteCartOne(String userid, String cartnum) throws SQLException;

	// 위시리스트에서 개별 상품 삭제하기(delete)
	int deleteWishOne(String userid, String wnum) throws SQLException;

	// 해당 상품을 장바구니에 삭제(delete)하고 위시리스트에 추가(insert)
	int deleteCartAddWish(Map<String, String> paraMap) throws SQLException;

	

}
