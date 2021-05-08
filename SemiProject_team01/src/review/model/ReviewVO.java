package review.model;

import member.model.MemberVO;
import order.model.OrderDetailVO;
import product.model.ProductVO;

public class ReviewVO {
	private int reviewno;
	private String fk_userid;
	private int fk_odrdetailno;
	private int pnum;
	private String rvcontent;
	private String rvdate;
	private int stars;

	private ProductVO pvo;
	private OrderDetailVO odtvo;
	private MemberVO mvo;
	
	public int getReviewno() {
		return reviewno;
	}
	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getFk_odrdetailno() {
		return fk_odrdetailno;
	}
	public void setFk_odrdetailno(int fk_odrdetailno) {
		this.fk_odrdetailno = fk_odrdetailno;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getRvcontent() {
		return rvcontent;
	}
	public void setRvcontent(String rvcontent) {
		this.rvcontent = rvcontent;
	}
	public String getRvdate() {
		return rvdate;
	}
	public void setRvdate(String rvdate) {
		this.rvdate = rvdate;
	}
	public int getStars() {
		return stars;
	}
	public void setStars(int stars) {
		this.stars = stars;
	}
	public ProductVO getPvo() {
		return pvo;
	}
	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}
	public OrderDetailVO getOdtvo() {
		return odtvo;
	}
	public void setOdtvo(OrderDetailVO odtvo) {
		this.odtvo = odtvo;
	}
	public MemberVO getMvo() {
		return mvo;
	}
	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	
}
