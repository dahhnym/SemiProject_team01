package order.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import cart.model.CartVO;

public interface InterOrderDAO {

    // 장바구니 테이블에서 특정제품을 장바구니에서 비우기 
	int delCart(String cartno) throws SQLException;

	// 로그인한 사용자의 장바구니 목록 조회하기
	List<CartVO> selectProcuctCart(String userid) throws SQLException;

	// 로그인한 사용자의 장바구니에 담긴 주문총액합계 알아오기 
	HashMap<String, String> selectCartSum(String userid) throws SQLException;

    // 주문정보 알아오기
	List<OrderVO> selectOrderInfo(String userid);

}
