package cscenter.model;

import member.model.MemberVO;

public class CsBoardVO {

	//문의글
	
	private int boardno; //글번호
	private String boardtitle; //글제목
	private String boardcontent; //글내용
	private String boardpwd; //문의글비밀번호
	private String boardregistdate; //작성일자
	private String boardfile; //첨부파일
	private String fk_userid; //작성자
	private String fk_smallcateno; //소분류카테고리번호
	
	private CsBoardSmallCategoryVO cbscvo; //소분류카테고리VO
	private MemberVO mvo; //작성자VO

	public CsBoardVO() {}

	public CsBoardVO(String fk_smallcateno, String boardtitle, String fk_userid, String boardpwd,
			String boardcontent, String boardfile) {
		
		this.boardtitle = boardtitle;
		this.boardcontent = boardcontent;
		this.boardpwd = boardpwd;
		this.boardfile = boardfile;
		this.fk_userid = fk_userid;
		this.fk_smallcateno = fk_smallcateno;
	}
	
	public CsBoardVO(int boardno, String fk_smallcateno, String boardtitle, String fk_userid, String boardpwd,
			String boardcontent, String boardfile) {
		
		this.boardno = boardno;
		this.boardtitle = boardtitle;
		this.boardcontent = boardcontent;
		this.boardpwd = boardpwd;
		this.boardfile = boardfile;
		this.fk_userid = fk_userid;
		this.fk_smallcateno = fk_smallcateno;
	}

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
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
