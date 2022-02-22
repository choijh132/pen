package basket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracleDB.OracleDB;


public class memberDAO {

	//선언문 3개. 써줘야 오류가 나지 않는다.
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	//1103(로그인된 회원 정보에서 이름, 핸드폰, 주소 그대로 꺼내오기. 정재님 영역)
		public memberDTO getClientInfo(String id){
			   //메소드 타입
			memberDTO dto = null;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement("select name, phone, address from memberdb where id=?");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new memberDTO();
					dto.setName(rs.getString("name"));
					dto.setPhone(rs.getString("phone"));
					dto.setAddress(rs.getString("address"));
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs !=null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt !=null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn !=null) {try {rs.close();}catch(SQLException s) {}}
			}
			return dto;
		}
		
		
		

}
