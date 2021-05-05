package cart.model;

import member.model.MemberVO;
import product.model.*;

public class CartVO {

	
	
	private int cartnum ; // 장바구니고유번호
	private String fk_userid;// 회원아이디
	private int fk_pnum; // 제품번호(
	private int oqty; //수량
	private int fk_pdetailnum; // 제품 상세번호 
	private int cprice; // 장바구니 가격
	
	private MemberVO mvo;
	private ProductVO pvo;
	private ProductDetailVO pdetailvo;
	
	
	// 장바구니에 담긴 총 판매가를 파악해야한다.
	private int totalPrice; 
	
	public CartVO() {
			
		}
	
	
	public CartVO(int cartnum, String fk_userid, int fk_pnum, int oqty, int fk_pdetailnum, ProductVO pvo,
			ProductDetailVO pdetailvo) {
		
		this.cartnum = cartnum;
		this.fk_userid = fk_userid;
		this.fk_pnum = fk_pnum;
		this.oqty = oqty;
		this.fk_pdetailnum = fk_pdetailnum;
		this.pvo = pvo;
		this.pdetailvo = pdetailvo;
	}


	public int getCartnum() {
		return cartnum;
	}


	public void setCartnum(int cartnum) {
		this.cartnum = cartnum;
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


	public MemberVO getMvo() {
		return mvo;
	}


	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	
	/*
	
	// *** 제품의 총판매가(실제판매가 * 주문량) 구해오기 ***
		public void setTotalPrice(int oqty) {   
			// int oqty 이 주문량이다.
		
			totalPrice = pvo.getSaleprice()* oqty; // 판매당시의 제품판매가 * 주문량
			
		}
		
		public int getTotalPrice() {
			return totalPrice;
		}

*/
		public int getCprice() {
			return cprice;
		}


		public void setCprice(int cprice) {
			this.cprice = cprice;
		}
	
	
	
	
	
}
