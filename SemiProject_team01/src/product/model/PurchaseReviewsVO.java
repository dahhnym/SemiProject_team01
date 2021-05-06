package product.model;

import member.model.MemberVO;

public class PurchaseReviewsVO {
	
	private int reviewno; 
	private String fk_userid;
	private int pnum; 
	private String rvcontents; 
	private String rvdate;
	
	private MemberVO mvo;
	private ProductVO pvo;
	
	public PurchaseReviewsVO() {}
	
	public PurchaseReviewsVO(int reviewno, String fk_userid, int pnum, String rvcontents, String rvdate,
			MemberVO mvo, ProductVO pvo) {
		this.reviewno = reviewno;
		this.fk_userid = fk_userid;
		this.pnum = pnum;
		this.rvcontents = rvcontents;
		this.rvdate = rvdate;
		this.mvo = mvo;
		this.pvo = pvo;
	}

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

	public int getPnum() {
		return pnum;
	}

	public void setPnum(int pnum) {
		this.pnum = pnum;
	}

	public String getRvcontents() {
		return rvcontents;
	}

	public void setRvcontents(String rvcontents) {
		this.rvcontents = rvcontents;
	}

	public String getRvdate() {
		return rvdate;
	}

	public void setRvdate(String rvdate) {
		this.rvdate = rvdate;
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
	
	
}
