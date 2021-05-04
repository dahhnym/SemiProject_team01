package cart.model;

import member.model.MemberVO;
import product.model.ProductDetailVO;
import product.model.ProductVO;

public class WishListVO {

	private int wnum; // number not null
	private String fk_userid;// varchar2(20) not null
	private int fk_pnum;// number(8) not null
	private int oqty; //number(4) default 0
	private int fk_pdetailnum;
	
	private MemberVO mvo;
	private ProductVO pvo;
	private ProductDetailVO pdetailvo;
	
	public WishListVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public WishListVO(int wnum, String fk_userid, int fk_pnum, int oqty, int fk_pdetailnum, MemberVO mvo, ProductVO pvo,
			ProductDetailVO pdetailvo) {
		super();
		this.wnum = wnum;
		this.fk_userid = fk_userid;
		this.fk_pnum = fk_pnum;
		this.oqty = oqty;
		this.fk_pdetailnum = fk_pdetailnum;
		this.mvo = mvo;
		this.pvo = pvo;
		this.pdetailvo = pdetailvo;
	}
	public int getWnum() {
		return wnum;
	}
	public void setWnum(int wnum) {
		this.wnum = wnum;
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
	public int getOqty() {
		return oqty;
	}
	public void setOqty(int oqty) {
		this.oqty = oqty;
	}
	public int getFk_pdetailnum() {
		return fk_pdetailnum;
	}
	public void setFk_pdetailnum(int fk_pdetailnum) {
		this.fk_pdetailnum = fk_pdetailnum;
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
	public ProductDetailVO getPdetailvo() {
		return pdetailvo;
	}
	public void setPdetailvo(ProductDetailVO pdetailvo) {
		this.pdetailvo = pdetailvo;
	}
	
}
