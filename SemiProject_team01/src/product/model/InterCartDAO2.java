package product.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterCartDAO2 {

	// 장바구니 등록하기
	int cartAdd(Map<String, String> paraMap) throws SQLException;

	

}
