package cscenter.model;

public class faqCategoryVO {
	private int fcNo;
	private String fcname;
	private String fccode;
	

	public faqCategoryVO() { }
	
	public faqCategoryVO(int fcNo, String fcname) {
		this.fcNo = fcNo;
		this.fcname = fcname;
		this.fccode = fccode;
	}
	
	public int getFcNo() {
		return fcNo;
	}
	
	public void setFcNo(int fcNo) {
		this.fcNo = fcNo;
	}
	
	public String getFcname() {
		return fcname;
	}
	
	public void setFcname(String fcname) {
		this.fcname = fcname;
	}
	

	public String getFccode() {
		return fccode;
	}

	public void setFccode(String fccode) {
		this.fccode = fccode;
	}
}
