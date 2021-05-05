package product.model;

import java.sql.SQLException;
import java.util.List;

public interface InterProductdetailDAO2 {

	// 제품의 옵션을 알아오기
	List<String> getOptionByPnum(String pnum) throws SQLException;

}
