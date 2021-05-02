package member.model;

public class MemberVO {

	private String userid;             // 회원아이디
	private String pwd;                // 비밀번호 (SHA-256 암호화 대상)
	private String name;               // 회원명
	private String email;              // 이메일 (AES-256 암호화/복호화 대상)
	private String mobile;             // 연락처 (AES-256 암호화/복호화 대상) 
	private String postcode;           // 우편번호
	private String address;            // 주소
	private String detailaddress;      // 상세주소
	private String extraaddress;       // 참고항목
	private String gender;             // 성별   남자:1  / 여자:2
	private String birthday;           // 생년월일 
	private int totalpurchase;         // 누적구매금액 
	private String level;              // 등급 (tbl_memberlevel 참조)  
	private int point;                 // 포인트 
	private String registerday;        // 가입일자 
	private String lastpwdchangedate;  // 마지막으로 암호를 변경한 날짜, 6개월 기준 변경대상 
	private String status;                // 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
	private String idle;                  // 휴면유무         0: 활동중  /  1 : 휴면중 
	                                   // 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정 
	private String adagreements;	   // 마케팅 동의여부   동의:1  / 비동의:0
	
	
	
	private int pwdCycleMonth;	   // 비밀번호 변경된 마지막 날짜와 로그인시 날짜의 차이 개월수

	/////////////////////////////////////////////////////////////////////////////////////
	public MemberVO() {}
	
	
	public MemberVO(String userid, String pwd, String name, String email, String mobile, String postcode,
			String address, String detailaddress, String extraaddress, String gender, String birthday, String adagreements) {
		
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.gender = gender;
		this.birthday = birthday;
		this.adagreements = adagreements;
	}

	///////////////////////////////////////////////////////////////////////////////////
	
	
	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getMobile() {
		return mobile;
	}


	public void setMobile(String mobile) {
		this.mobile = mobile;
	}


	public String getPostcode() {
		return postcode;
	}


	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getDetailaddress() {
		return detailaddress;
	}


	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}


	public String getExtraaddress() {
		return extraaddress;
	}


	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getBirthday() {
		return birthday;
	}


	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}


	public int getTotalpurchase() {
		return totalpurchase;
	}


	public void setTotalpurchase(int totalpurchase) {
		this.totalpurchase = totalpurchase;
	}


	public String getLevel() {
		return level;
	}


	public void setLevel(String level) {
		this.level = level;
	}


	public int getPoint() {
		return point;
	}


	public void setPoint(int point) {
		this.point = point;
	}


	public String getRegisterday() {
		return registerday;
	}


	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}


	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}


	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getIdle() {
		return idle;
	}


	public void setIdle(String idle) {
		this.idle = idle;
	}


	public String getAdagreements() {
		return adagreements;
	}


	public void setAdagreements(String adagreements) {
		this.adagreements = adagreements;
	}


	///////////////////////////////////////////////////////////////////////////////////////////
	
	
	public int getPwdCycleMonth() {
		return pwdCycleMonth;
	}


	public void setPwdCycleMonth(int pwdCycleMonth) {
		this.pwdCycleMonth = pwdCycleMonth;
	}

	
}