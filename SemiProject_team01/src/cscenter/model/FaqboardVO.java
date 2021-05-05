package cscenter.model;

public class FaqboardVO {
	//자식
	private int faqNo;
	private String faqtitle;
	private String faqcontent;
	private int fk_fcNo;
	
	//부모 클래스
	private FaqCategoryVO fcvo;
	
	public FaqCategoryVO getFcvo() {
		return fcvo;
	}

	public void setFcvo(FaqCategoryVO fcvo) {
		this.fcvo = fcvo;
	}

	public int getFaqNo() {
		return faqNo;
	}
	
	public void setFaqNo(int faqNo) {
		this.faqNo = faqNo;
	}
	
	public String getFaqtitle() {
		return faqtitle;
	}
	
	public void setFaqtitle(String faqtitle) {
		this.faqtitle = faqtitle;
	}
	
	public String getFaqcontent() {
		return faqcontent;
	}
	
	public void setFaqcontent(String faqcontent) {
		this.faqcontent = faqcontent;
	}
	
	public int getFk_fcNo() {
		return fk_fcNo;
	}
	
	public void setFk_fcNo(int fk_fcNo) {
		this.fk_fcNo = fk_fcNo;
	}
	
	
}
