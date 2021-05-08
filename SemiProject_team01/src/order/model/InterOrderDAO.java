package order.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cart.model.CartVO;
import member.model.MemberVO;
import product.model.ProductVO;

public interface InterOrderDAO {

    // 장바구니 테이블에서 특정제품을 장바구니에서 비우기 
	int delCart(String cartno) throws SQLException;

	// 로그인한 사용자의 주문 목록 조회하기
	List<OrderDetailVO> selectProductOrder(String userid) throws SQLException;

	// 로그인한 사용자의 장바구니에 담긴 주문총액합계 알아오기 
	HashMap<String, String> selectCartSum(String userid) throws SQLException;

    // 주문정보 알아오기
	OrderVO selectOrderInfo(int odrcode) throws SQLException;

	// 주문테이블 update
	int orderAdd(Map<String, Object> paraMap) throws SQLException;

	//주문코드 알아오기
	int getOdrcode(String userid) throws SQLException;

	//cartnum 알아오기
	int getCartnum(String userid) throws SQLException;

	// 주문 내역 리스트 가져오기
	List<OrderDetailVO> orderList(String userid) throws SQLException;

	// 한 주문에 대한 리스트 가져오기
	public List<OrderDetailVO> orderList(String userid, int odrcode) throws SQLException;
	
	// 보류중인 리뷰 보여주기
	public List<OrderDetailVO> pendingReview(String userid) throws SQLException;
	
	// 보류중인 리뷰 갯수 세오기
	public int pdrvListNo(String userid) throws SQLException;
	
	// 작성한 리뷰 리스트보여주기
	public List<OrderDetailVO> writtenReview(String userid) throws SQLException ;

	// 작성한 리뷰 갯수 세오기
	public int wtrvListNo(String userid) throws SQLException ;

		

}
