package product.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterWishDAO {

	//위시리스트 추가
	int wishAdd(Map<String, String> paraMap) throws SQLException;

}
