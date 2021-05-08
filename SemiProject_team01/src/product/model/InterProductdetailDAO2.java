package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterProductdetailDAO2 {

	// 제품의 옵션을 알아오기
	List<HashMap<String,String>> getOptionByPnum(String pnum) throws SQLException;
	
	// ajax 제품의 이름, 가격 등 알아오기
	List<ProductDetailVO> GetSmallCategoryList(String pnum) throws SQLException;


}
