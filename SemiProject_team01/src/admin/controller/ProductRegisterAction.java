package admin.controller;


import java.io.IOException;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import product.model.*;


public class ProductRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method=request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			HttpSession session = request.getSession();
		//	System.out.println(session);
			InterProductDAO pdao= new ProductDAO();
			
			// 카테고리 리스트 select 해오기
			List<HashMap<String,String>> categoryList = pdao.getCategory();
			
			request.setAttribute("categoryList", categoryList);
			
			// 스펙 리스트 select 해오기
			List<SpecVO> specList = pdao.getSpecList();
			request.setAttribute("specList", specList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/productRegister.jsp");
		
		
		}
		else {
			
			MultipartRequest mtrequest = null;
			HttpSession session = request.getSession();
            
            ServletContext svlCtx = session.getServletContext();
            String imagesDir = svlCtx.getRealPath("/images");
            		
		
			System.out.println(session);
			
			
			  try {
	            	mtrequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
	            }catch(IOException e) {
	            	request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
	                request.setAttribute("loc", request.getContextPath()+"/shop/admin/productRegister.up"); 
	                
	                super.setViewPage("/WEB-INF/msg.jsp");
	                return; // 종료
	            }
			
			// tbl_prodcut 테이블에 해당하는 변수  
			String fk_cnum= mtrequest.getParameter("fk_cnum");
			String pname=mtrequest.getParameter("pname");
			String pcompany=mtrequest.getParameter("pcompany");
			String price=mtrequest.getParameter("price");
			String saleprice=mtrequest.getParameter("saleprice");
			String fk_snum=mtrequest.getParameter("fk_snum");
			String pimage1 = mtrequest.getFilesystemName("pimage1");
			String pimage2 = mtrequest.getFilesystemName("pimage2");
			String pcontent=mtrequest.getParameter("pcontent");
			
			pcontent= pcontent.replaceAll("<", "&lt;");
	        pcontent= pcontent.replaceAll(">", "&gt;");
	            // pcontent에 < 를 작성하면 &lt;", >를 작성하면 &gt;로 모두 변경해준다.
	            
	            // 입력한 내용에서 엔터는 <br>로 변환시키기
	        pcontent=pcontent.replaceAll("\r\n", "<br>");
			
	         
	         // tbl_prodcutdetail 테이블에 해당하는 변수 
			
	        
	         InterProductDAO pdao = new ProductDAO();
	            
	         int pnum = pdao.getPnumOfProduct();// 

	         ProductVO pvo = new ProductVO();
	            
            pvo.setPnum(pnum);
            pvo.setFk_cnum(Integer.parseInt(fk_cnum));
            pvo.setPname(pname);
            pvo.setPcompany(pcompany);
            pvo.setPimage1(pimage1);
            pvo.setPimage2(pimage2);
            pvo.setPrice(Integer.parseInt(price));
            pvo.setSaleprice(Integer.parseInt(saleprice));
            pvo.setFk_snum(Integer.parseInt(fk_snum));
            pvo.setPcontent(pcontent);
           
            // tbl_product 테이블에 제품정보 insert 하기
            int n= pdao.productInsert(pvo);
            
            System.out.println("확인용:"+n);    
			
            
            // 제품 상세테이블 insert 하기
            int k=1;
	        String[] optionnameArr = mtrequest.getParameterValues("optionname");
			String[] pqtyArr= mtrequest.getParameterValues("pqty");
			
			if(optionnameArr.length==pqtyArr.length) {
				int len = optionnameArr.length;
				for(int i=0;i<len;i++) {
					String optionname = optionnameArr[i];
					String str_pqty=pqtyArr[i];
					int pqty=Integer.parseInt(str_pqty);
					
					k = pdao.product_detail_Insert(pnum,optionname,pqty);
					if(k==0) break;
				}
			}
            
      
            // === 추가이미지파일이 있다라면 tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기  ===
			 int m=1;
	            String str_attachCount = mtrequest.getParameter("attachCount");
	           	// str_attachCount 이 추가이미지 파일의 개수이다. 추가이미지파일:0개 일 때 "" 또는 "0" ~ "10" 이 들어온다.
	           
	           int attachCount=0;
	           
	           if(!"".equals(str_attachCount)) {
	        	   //최소 1개부터 들어온다.
	        	   attachCount =Integer.parseInt(str_attachCount);
	           }
	           
	           // 첨부파일의 파일명 알아오기
	           for(int i=0;i<attachCount;i++) {
	        	   String attachFileName =mtrequest.getFilesystemName("attach"+i);
	        	   
	        	   m = pdao.product_imagefile_Insert(pnum,attachFileName);
	        	   // 첨부 파일을 추가 하고 싶을때는 이미지첨부테이블에 있듯이 제품번호와 디스크에 올라간 파일이름이 필요하다.
	        	   // pnum 은 위에서 채번해온 제품번호이다.
	        	   
	        	   if(m==0) break; // 추가 이미지를 넣다가 실패하면 for문을 빠져나와라
	           } // end of for-----
              
              
           String message ="";
           String loc="";
           
           if(n*k*m==1) { // n은 제품등록(제품테이블에 insert완료)된 값 * m은 추가이미지(추가이미지 테이블에 insert 완료)등록 된 값
	              message = "제품등록 성공!!";
	              loc = request.getContextPath()+"/shop/admin/productRegister.to";
	       }
           else {
              message = "제품등록 실패!!";
              loc = request.getContextPath()+"/shop/admin/productRegister.to";
           }
	           
	           request.setAttribute("message", message);
	           request.setAttribute("loc", loc);
	           
	           super.setViewPage("/WEB-INF/msg.jsp");
           
  
	       
			
			
	           
			
		}
		
	}

}
