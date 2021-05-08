package cscenter.model;

public class FaqCategoryVO {
	//부모
	
	// 자주 묻는 질문  카테고리
	private int fcNo; //자.묻 카테고리번호
	private String fcname; // 자.묻 카테고리명
	private String fccode; // 자.묻 카테고리seq
	

	public FaqCategoryVO() { }
	
	public FaqCategoryVO(int fcNo, String fcname, String fccode) {
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
