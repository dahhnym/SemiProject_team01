package cscenter.model;

public class CsBoardVO {

	private int boardno;
	private String boardtitle;
	private String boardcontent;
	private String boardpwd;
	private String boardregistdate;
	private String boardfile;
	private String fk_userid;
	private String fk_smallcateno;
	
	private CsBoardSmallCategoryVO cbscvo;
	
	
	public CsBoardVO() {}

	public CsBoardVO(String fk_smallcateno, String boardtitle, String fk_userid, String boardpwd,
			String boardcontent, String boardfile) {
		
		this.boardtitle = boardtitle;
		this.boardcontent = boardcontent;
		this.boardpwd = boardpwd;
		this.boardfile = boardfile;
		this.fk_userid = fk_userid;
		this.fk_smallcateno = fk_smallcateno;
		this.cbscvo = cbscvo;
	}


	public CsBoardSmallCategoryVO getCbscvo() {
		return cbscvo;
	}

	public void setCbscvo(CsBoardSmallCategoryVO cbscvo) {
		this.cbscvo = cbscvo;
	}

	public int getBoardno() {
		return boardno;
	}
	
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	
	public String getBoardtitle() {
		return boardtitle;
	}
	
	public void setBoardtitle(String boardtitle) {
		this.boardtitle = boardtitle;
	}
	
	public String getBoardcontent() {
		return boardcontent;
	}
	
	public void setBoardcontent(String boardcontent) {
		this.boardcontent = boardcontent;
	}
	
	public String getBoardregistdate() {
		return boardregistdate;
	}
	public void setBoardregistdate(String boardregistdate) {
		this.boardregistdate = boardregistdate;
	}
	
	public String getBoardfile() {
		return boardfile;
	}
	
	public void setBoardfile(String boardfile) {
		this.boardfile = boardfile;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public String getFk_smallcateno() {
		return fk_smallcateno;
	}
	
	public void setFk_smallcateno(String fk_smallcateno) {
		this.fk_smallcateno = fk_smallcateno;
	}
	
	public String getBoardpwd() {
		return boardpwd;
	}

	public void setBoardpwd(String boardpwd) {
		this.boardpwd = boardpwd;
	}
	
}
