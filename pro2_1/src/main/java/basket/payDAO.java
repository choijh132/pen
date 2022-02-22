package basket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class payDAO {
	
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	//결제 내역에 추가, 결제가 되면 장바구니에서 결제된 내역 지우기, 결제 완료 되면 재고 카운트+1
	public int paymentDB(basketDTO dto, memberDTO mdto, String id){
		int result=0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("insert into payment values(paynum_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
					+ " ?, ?, sysdate)");
			pstmt.setInt(1, dto.getBasketnum());
			pstmt.setInt(2, dto.getProductnum());
			pstmt.setString(3, dto.getProductname());
			pstmt.setInt(4, dto.getProductprice());
			pstmt.setInt(5, dto.getPackingprice());
			pstmt.setInt(6, dto.getTotalprice());
			pstmt.setInt(7, dto.getInkblack());
			pstmt.setInt(8, dto.getInkred());
			pstmt.setInt(9, dto.getInkblue());
			pstmt.setInt(10, dto.getInkgreen());
			pstmt.setString(11, id);
			pstmt.setString(12, mdto.getAddress());
			pstmt.setString(13, mdto.getPhone());
			
			rs=pstmt.executeQuery(); 
			
			
			pstmt = conn.prepareStatement("delete from basket where id=? and productnum=?");
			pstmt.setString(1, id);
			pstmt.setInt(2, dto.getProductnum());
			
			rs=pstmt.executeQuery(); 
			

			pstmt = conn.prepareStatement("update product set salecount=salecount+1 where productnum=?");
			pstmt.setInt(1, dto.getProductnum());
			
			rs=pstmt.executeQuery(); 
			
			if(rs.next()) {
				result=1;
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
