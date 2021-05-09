package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;

public class OrderViewAction extends AbstractController {
 
	
	
	/////////   주문페이지에서 상품리스트 보여주는 곳    /////////
	
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pnum = request.getParameter("pnum");
		String oqty = request.getParameter("oqty");
		String saleprice = request.getParameter("saleprice");
		String pdetailnum = request.getParameter("pdetailnum");
		String optionname = request.getParameter("optionname");
		String pname = request.getParameter("pname");
		String level = request.getParameter("level");
		String pimage = request.getParameter("pimage");
		
		String[] pnumArr = pnum.split(",");
		String[] oqtyArr = oqty.split(",");
		String[] salepriceArr = saleprice.split(",");
		String[] pdetailnumArr = pdetailnum.split(",");
		String[] optionnameArr = optionname.split(",");
		String[] pnameArr = pname.split(",");
		String[] pimageArr = pimage.split(",");
		
		for(int i=0;i<pnumArr.length; i++) {
			System.out.println("~~~~ 확인용 pnum: " + pnumArr[i] + "pname:"+pnameArr[i]+", oqty: " + oqtyArr[i] + ", saleprice: " + salepriceArr[i]);
		}
	
		JSONArray jsArr = new JSONArray();
		int cnt=pnumArr.length;
		int point=0;
		int sum=0; // 가격합
		int totalsum=0; //가격합+배송비
		int delivery =2500;
		 if( pnumArr.length > 0 ) { 
			 for(int i=0;i<pnumArr.length; i++) {

				 JSONObject jsobj = new JSONObject();
				 
				 int totalprice = Integer.parseInt(salepriceArr[i])*Integer.parseInt(oqtyArr[i]);
				 
				  sum+= totalprice; //
				  
					if("1".equals(level)) {
						point=(int) (totalprice*0.01);	
					}
					else if("2".equals(level)) {
						point=(int) (totalprice*0.03);			
					}
					else if("3".equals(level)) {
						point=(int) (totalprice*0.05);			
					}
					

					
					if(cnt == 1 && sum>50000) {
						delivery=0;
						 
					}
					totalsum = totalprice + delivery;//총합
					
				 jsobj.put("pnum", pnumArr[i]);
				 jsobj.put("oqty",oqtyArr[i]);
				 jsobj.put("saleprice",salepriceArr[i]);
				 jsobj.put("pdetailnum",pdetailnumArr[i]);
				 jsobj.put("optionname",optionnameArr[i]);
				 jsobj.put("pname",pnameArr[i]);
				 jsobj.put("totalprice", totalprice); //물건*갯수
				 jsobj.put("point", point);
				 jsobj.put("sum", sum);//물건*갯수들의 합
				 jsobj.put("totalsum", totalsum);//물건*갯수들의 합+배송비
				 jsobj.put("delivery", delivery);
				 jsobj.put("pimage", pimageArr[i]);
				 System.out.println(pimageArr[i]);
				 jsArr.put(jsobj);
				 cnt--;
			 } 
		 }
		 
		 String json = jsArr.toString();
		 System.out.println("json" + json);
		 request.setAttribute("json", json);
		 
		 super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
