package basket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class basketDAO {
	
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;

		//장바구니의 합계 나타내기
		public int getProductPriceInfo(String id){
			int result=0;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement("select sum(totalprice) from basket where id=?");
				pstmt.setString(1, id);
			
				rs=pstmt.executeQuery();
				while(rs.next()) {
					result=rs.getInt(1);
				}
			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
			}
			return result;
		}
	

	
		//장바구니 내역 지우기, 재고 업데이트하기
		public boolean cartDelete(int cartNum, int productnum, int inkblack, int inkred, int inkblue, int inkgreen) {   
			boolean result=false;
			try {
				conn=OracleDB.getConnection();
				pstmt=conn.prepareStatement("delete from basket where basketnum=?");
				pstmt.setInt(1, cartNum);
				rs=pstmt.executeQuery();
			
				pstmt=conn.prepareStatement("update product set inkblackstock=inkblackstock+?, inkredstock=inkredstock+?, inkbluestock=inkbluestock+?, inkgreenstock=inkgreenstock+? where productnum=?");
				pstmt.setInt(1, inkblack);
				pstmt.setInt(2, inkred);
				pstmt.setInt(3, inkblue);
				pstmt.setInt(4, inkgreen);
				pstmt.setInt(5, productnum);
				pstmt.executeQuery();
			
				if(rs.next()) {
					result=true;
				}
			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
			}
			return result;
		}
	
		//장바구니 내역 가져오기
		public List<basketDTO> getBasketList(String id) {
			List<basketDTO> list = null;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement("select * from basket where id=?");
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				list = new ArrayList();
				
				while(rs.next()) {
					basketDTO dto = new basketDTO();
					
					dto.setBasketnum(rs.getInt("basketnum"));
					dto.setId(rs.getString("id"));
					dto.setProductnum(rs.getInt("productnum"));
					dto.setProductname(rs.getString("productname"));
					dto.setProductprice(rs.getInt("productprice"));
					dto.setPackingprice(rs.getInt("packingprice"));
					dto.setTotalprice(rs.getInt("totalprice"));
					dto.setInkblack(rs.getInt("inkblack"));
					dto.setInkred(rs.getInt("inkred"));
					dto.setInkblue(rs.getInt("inkblue"));
					dto.setInkgreen(rs.getInt("inkgreen"));
					dto.setReg(rs.getString("reg"));
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
		
	
		//장바구니 번호	
		public int getProductnum(int cartNum){
			int result=0;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement("select * from basket where basketnum=?");
				pstmt.setInt(1, cartNum);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt("productnum");
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
			}
			return result;
		}
		
		//잉크검정
		public int getInkblack(int cartNum){
			int result=0;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement("select * from basket where basketnum=?");
				pstmt.setInt(1, cartNum);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt("inkblack");
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
			}
			return result;
		}
		
		//잉크빨강
		public int getInkred(int cartNum){
			int result=0;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement("select * from basket where basketnum=?");
				pstmt.setInt(1, cartNum);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt("inkred");
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
			}
			return result;
		}
		
		//잉크파랑
		public int getInkblue(int cartNum){
			int result=0;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement("select * from basket where basketnum=?");
				pstmt.setInt(1, cartNum);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt("inkblue");
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
			}
			return result;
		}
		
		//잉크초록
		public int getInkgreen(int cartNum){
			int result=0;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement("select * from basket where basketnum=?");
				pstmt.setInt(1, cartNum);
				
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt("inkgreen");
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
			}
			return result;
		}
	
	
}

