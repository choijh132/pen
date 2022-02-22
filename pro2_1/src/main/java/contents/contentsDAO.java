package contents;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class contentsDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
		
	public contentsDTO getProductInfo(int productNum) { //상품 소스 호출
		contentsDTO dto= null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from product where productNum=?");
			pstmt.setInt(1, productNum);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				dto= new contentsDTO();
				dto.setProductNum(rs.getInt("productNum"));
				dto.setProductPrice(rs.getInt("productprice"));
				dto.setProductOption(rs.getString("productoption"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductFileName(rs.getString("productfilename"));
				dto.setInkBlackStock(rs.getInt("inkblackstock"));
				dto.setInkRedStock(rs.getInt("inkredstock"));
				dto.setInkBlueStock(rs.getInt("inkbluestock"));
				dto.setInkGreenStock(rs.getInt("inkgreenstock"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s ) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s ) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s ) {}}
		}
		return dto;
	}
		
		
	  
    public List<contentsDTO> getProduct(){ //상품 db불러오기
       List<contentsDTO> list=null;
       try {
          conn = OracleDB.getConnection();
          pstmt = conn.prepareStatement("select productname, productnum, productbrand, "
                + "productlgroup, productsgroup, productfilename, "
                + "productprice, productoption, inkblack, inkred, inkblue, inkgreen from product where productnum=25");
          
          rs = pstmt.executeQuery();
          list = new ArrayList();
          while(rs.next()) {
        	  contentsDTO dto = new contentsDTO();
             dto.setProductName(rs.getString("productname"));
             dto.setProductNum(rs.getInt("productnum"));
             dto.setProductBrand(rs.getString("productbrand"));
             dto.setProductLGroup(rs.getString("productlgroup"));
             dto.setProductSGroup(rs.getString("productsgroup"));
             dto.setProductFileName(rs.getString("productfilename"));
             dto.setProductPrice(rs.getInt("productprice"));
             dto.setProductOption(rs.getString("productoption"));
             dto.setInkBlack(rs.getInt("inkblack"));
             dto.setInkRed(rs.getInt("inkred"));
             dto.setInkBlue(rs.getInt("inkblue"));
             dto.setInkGreen(rs.getInt("inkgreen"));
             list.add(dto);	
          }
          
       }catch(Exception e) {
          e.printStackTrace();
       }finally {
          if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
          if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
          if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
       }
       return list;
    }
    
    public int inputCart(contentsDTO dto,String id, String totalpice, String inkK, String inkR, String inkB, String inkG, String packingprice ) { //장바구니 소스 보내기 
    	//장바구니 등록 메소드 /장바구니 등록후 재고값 -값 시퀀스 
    	int result =0;
		try {
			conn=OracleDB.getConnection();
			int totalpicen = Integer.parseInt(totalpice);
			int inkblack = Integer.parseInt(inkK);
			int inkred = Integer.parseInt(inkR);
			int inkblue = Integer.parseInt(inkB);
			int inkgreen = Integer.parseInt(inkG);
			int packingpricex = Integer.parseInt(packingprice);
			
			pstmt=conn.prepareStatement("insert into basket values(basket_seq.nextval,?,?,?,?,?,?,?,?,?,?,sysdate)");
			pstmt.setString(1, id);
			pstmt.setInt(2, dto.getProductNum());
			pstmt.setString(3, dto.getProductName()) ;
			pstmt.setInt(4, dto.getProductPrice());
			pstmt.setInt(5, packingpricex);
			pstmt.setInt(6, totalpicen);
			pstmt.setInt(7, inkblack);
			pstmt.setInt(8, inkred);
			pstmt.setInt(9, inkblue);
			pstmt.setInt(10, inkgreen);
			
			rs = pstmt.executeQuery();
			//실행
			
			pstmt=conn.prepareStatement("update product SET inkblackstock=inkblackstock-?,inkredstock=inkredstock-?,inkbluestock=inkbluestock-?,inkgreenstock=inkgreenstock-?  where productnum=?");
			pstmt.setInt(1, inkblack);
			pstmt.setInt(2, inkred);
			pstmt.setInt(3, inkblue);
			pstmt.setInt(4, inkgreen);
			pstmt.setInt(5, dto.getProductNum());
			
			pstmt.executeUpdate();	
			//실행된 갯수 
			
			if(rs.next()) {
				result = 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
			
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s ) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s ) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s ) {}}
		}
		return result;
    }
    
    public List<ReviewDTO> getReviewBoard(String ProductNum, int start, int end) { //제품번호 기준으로 리뷰 메소드
    	List<ReviewDTO> list =null;
    	try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from ( select name, content, star, reg, rownum rn from (select * from review where productnum=? order by reg desc)) where rn >=? and rn <=?");
			pstmt.setString(1, ProductNum); //추가 입력 
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
		
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setStar(rs.getInt("star"));
				dto.setProductNum(rs.getInt("productnum"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}

	public int insertReview(ReviewDTO dto) { //리뷰 업로드 메소드 & 업로드시 리뷰카운트 +1 증가
		int a = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("insert into review values(?,?,?,?,sysdate)");
			pstmt.setInt(1, dto.getProductNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getStar());
			
			rs = pstmt.executeQuery();
			pstmt = conn.prepareStatement("update product SET reviewcount=reviewcount+1 where productNum =?");
			pstmt.setInt(1, dto.getProductNum());
						
			pstmt.executeUpdate();

			
			
			if(rs.next()) {
				a = 1;
			}
			
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return a;
		
	}
	
	
	 public List<ReviewDTO> listReview(int productNum, int start, int end){ //상품 페이지(where productNum=?) 내 리뷰글 불러오기
	       List<ReviewDTO> list=null;
	       try {
	          conn = OracleDB.getConnection();
	          pstmt = conn.prepareStatement("select * from (select name, content, star, reg ,rownum rn from (select * from review where productnum=? order by reg desc)) where rn >=? and rn <=?");
	          pstmt.setInt(1, productNum);
	          pstmt.setInt(2, start);
	          pstmt.setInt(3, end);
	          
	          
	          
	          rs = pstmt.executeQuery();
	          list = new ArrayList();
	          while(rs.next()) {
	        	  ReviewDTO dto = new ReviewDTO();
	        	 dto.setName(rs.getString("name"));
	             dto.setContent(rs.getString("content"));
	             dto.setStar(rs.getInt("star"));
	             dto.setReg(rs.getString("reg"));
	             list.add(dto);	
	          }
	          
	       }catch(Exception e) {
	          e.printStackTrace();
	       }finally {
	          if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
	          if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
	          if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
	       }
	       return list;
	    }
	 
	 public List<ReviewDTO> listReviewH(int productNum, String viewStar,int start, int end){ //리뷰 별점선택후 리뷰글 조회
	       List<ReviewDTO> list=null;
	       
	       int viewStar1 = Integer.parseInt(viewStar);
	       
	       try {
	          conn = OracleDB.getConnection();
	          if(viewStar1==9) {
	        	  pstmt = conn.prepareStatement("select * from (select name, content, star, reg, rownum rn from (select * from review where productNum=? order by star desc)) where rn >=? and rn <=?");
		          pstmt.setInt(1, productNum);
		          pstmt.setInt(2, start);
		          pstmt.setInt(3, end);
		         	  
	          }else if(viewStar1==0) {
	        	  pstmt = conn.prepareStatement("select * from (select name, content, star, reg, rownum rn  from (select * from review where productNum=? order by star asc)) where rn >=? and rn <=?");
		          pstmt.setInt(1, productNum);
		          pstmt.setInt(2, start);
		          pstmt.setInt(3, end);	  
	          }else {
	          pstmt = conn.prepareStatement("select * from (select name, content, star, reg, rownum rn  from (select * from review where productNum=? and star=?)) where rn >=? and rn <=?");
	          pstmt.setInt(1, productNum);
	          pstmt.setInt(2, viewStar1);
	          pstmt.setInt(3, start);
	          pstmt.setInt(4, end);
	          }

	          rs = pstmt.executeQuery();
	          list = new ArrayList();
	          while(rs.next()) {
	        	  ReviewDTO dto = new ReviewDTO();
	        	 dto.setName(rs.getString("name"));
	             dto.setContent(rs.getString("content"));
	             dto.setStar(rs.getInt("star"));
	             dto.setReg(rs.getString("reg"));
	             
	             list.add(dto);	
	          }
	          
	       }catch(Exception e) {
	          e.printStackTrace();
	       }finally {
	          if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
	          if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
	          if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
	       }
	       return list;
	 }
	 public int getCount() { //리뷰 카운트 조회 
			int result = 0;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement("select count(*) from review");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn != null) {try {conn.close();}catch(SQLException s) {}}
			}
			return result;
		}    
	       
	 public int getCount(String viewStar) {
			int result = 0;
			int viewStarn = Integer.parseInt(viewStar);
			try {
				conn = OracleDB.getConnection();
				if( viewStarn >= 1 && viewStarn <= 5) {
					pstmt = conn.prepareStatement("select count(*) from review where star=?");
					pstmt.setInt(1, viewStarn);
				} else {
					pstmt = conn.prepareStatement("select count(*) from review");
				}
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn != null) {try {conn.close();}catch(SQLException s) {}}
			}
			return result;
		}    
	}
