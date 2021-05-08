package order.model;

import member.model.MemberVO;
import product.model.ProductDetailVO;
import product.model.ProductVO;
import review.model.ReviewVO;

public class OrderDetailVO {
	private int odrdetailno; //주문상세일련번호
	private String fk_userid; //회원아이디
	private int fk_pnum; //제품번호
	private int fk_odrcode; //주문코드
	private int fk_pdetailnum; //제품상세번호
	private int odrqty; //주문수량
	private int odrprice; // 주문합계
	private String optionname; //옵션명
	
	private OrderVO ovo;
	private MemberVO mvo;
	private ProductVO pvo;
	private ProductDetailVO pdtvo;
	private ReviewVO rvo;

	

	public ReviewVO getRvo() {
		return rvo;
	}
	public void setRvo(ReviewVO rvo) {
		this.rvo = rvo;
	}
	public OrderVO getOvo() {
		return ovo;
	}
	public void setOvo(OrderVO ovo) {
		this.ovo = ovo;
	}
	public MemberVO getMvo() {
		return mvo;
	}
	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	public ProductVO getPvo() {
		return pvo;
	}
	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}
	public ProductDetailVO getPdtvo() {
		return pdtvo;
	}
	public void setPdtvo(ProductDetailVO pdtvo) {
		this.pdtvo = pdtvo;
	}
	
	public int getOdrdetailno() {
		return odrdetailno;
	}
	public void setOdrdetailno(int odrdetailno) {
		this.odrdetailno = odrdetailno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getFk_pnum() {
		return fk_pnum;
	}
	public void setFk_pnum(int fk_pnum) {
		this.fk_pnum = fk_pnum;
	}
	public int getFk_odrcode() {
		return fk_odrcode;
	}
	public void setFk_odrcode(int fk_odrcode) {
		this.fk_odrcode = fk_odrcode;
	}
	public int getFk_pdetailnum() {
		return fk_pdetailnum;
	}
	public void setFk_pdetailnum(int fk_pdetailnum) {
		this.fk_pdetailnum = fk_pdetailnum;
	}
	public int getOdrqty() {
		return odrqty;
	}
	public void setOdrqty(int odrqty) {
		this.odrqty = odrqty;
	}
	public int getOdrprice() {
		return odrprice;
	}
	public void setOdrprice(int odrprice) {
		this.odrprice = odrprice;
	}
	public String getOptionname() {
		return optionname;
	}
	public void setOptionname(String optionname) {
		this.optionname = optionname;
	}
}
