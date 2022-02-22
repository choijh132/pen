package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import product.ProductDTO;
import product.OracleDB;

public class ProductDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	
	//DB에 상품을 입력
	public int ProductInsert (ProductDTO dto) {
		int result = 0;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("insert into Product values(product_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 0)");
			pstmt.setString(1, dto.getProductName());
			pstmt.setString(2, dto.getProductBrand());
			pstmt.setString(3, dto.getProductLGroup());
			pstmt.setString(4, dto.getProductSGroup());
			pstmt.setString(5, dto.getProductFileName());
			pstmt.setInt(6, dto.getProductPrice());
			pstmt.setString(7, dto.getProductOption());
			pstmt.setInt(8, dto.getInkBlack());
			pstmt.setInt(9, dto.getInkBlackStock());
			pstmt.setInt(10, dto.getInkRed());
			pstmt.setInt(11, dto.getInkRedStock());
			pstmt.setInt(12, dto.getInkBlue());
			pstmt.setInt(13, dto.getInkBlueStock());
			pstmt.setInt(14, dto.getInkGreen());
			pstmt.setInt(15, dto.getInkGreenStock());
			
			
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	
	//DB내의 상품을 삭제
	public String ProductDelete (int productNum) { 
		String result = null;
		try {
			conn = OracleDB.getConnection();
			
			pstmt = conn.prepareStatement("select productFileName from product where productNum = ? ");
			pstmt.setInt(1, productNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("productFileName");
			}
			
			
			pstmt = conn.prepareStatement("delete from product where productNum = ?");
			pstmt.setInt(1, productNum);
	

			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		
		return result;
		
	}
	
	
	
	//DB내의 상품을 수정
	public int ProductUpdate(ProductDTO dto) {
		
		int result = 0;
		
		try {
			conn = OracleDB.getConnection();
			String sql = " update product set productName=?, productBrand=?, productLGroup=?, productSGroup=?, productFileName=?, "
					+ " productPrice=?, productOption=?, inkBlack=?, inkBlackStock=?, inkRed=?, inkRedStock=?, "
					+ " inkBlue=?, inkBlueStock=?, inkGreen=?, inkGreenStock=? where productNum=? ";
			pstmt = conn.prepareStatement(sql); 
			
			pstmt.setString(1, dto.getProductName());
			pstmt.setString(2, dto.getProductBrand());
			pstmt.setString(3, dto.getProductLGroup());
			pstmt.setString(4, dto.getProductSGroup());
			pstmt.setString(5, dto.getProductFileName());
			pstmt.setInt(6, dto.getProductPrice());
			pstmt.setString(7, dto.getProductOption());
			pstmt.setInt(8, dto.getInkBlack());
			pstmt.setInt(9, dto.getInkBlackStock());
			pstmt.setInt(10, dto.getInkRed());
			pstmt.setInt(11, dto.getInkRedStock());
			pstmt.setInt(12, dto.getInkBlue());
			pstmt.setInt(13, dto.getInkBlueStock());
			pstmt.setInt(14, dto.getInkGreen());
			pstmt.setInt(15, dto.getInkGreenStock());
			pstmt.setInt(16, dto.getProductNum());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}

	
	//DB내의 저장된 모든 상품의 갯수를 세기
	public int getProductCount() {
		int result = 0;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from product");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
				//getInt는 1번째 값을 가져온다. 라는 의미이다. (1개의 값)
			}
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();} catch(SQLException s) {}}
		}
		
		return result;
	}
	
	
	//DB에 저장된 모든 상품의 정보를 일부 가져오기(목록에 출력할 일부, 페이지에 출력할만큼의 크기)
	public List<ProductDTO> getProductAllList(int start, int end){
		List<ProductDTO> list = null;
		
		try {
			
			conn = OracleDB.getConnection();
			
			String sql = "select * from "
					+ " (select productNum,productBrand,productName,productLGroup,productSGroup,productFileName,productPrice,productOption, rownum r from "
					+ " (select * from product order by productNum desc)) "
					+ " where r >= ? and r <=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			
			list = new ArrayList();
			
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();

				
				dto.setProductNum(rs.getInt("productNum"));
				dto.setProductBrand(rs.getString("productBrand"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductLGroup(rs.getString("productLGroup"));
				dto.setProductSGroup(rs.getString("productSGroup"));
				dto.setProductFileName(rs.getString("productFileName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductOption(rs.getString("productOption"));

				
				
				
				list.add(dto);
				
			}
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
			
		}return list;
	}
	
	
	//DB내에 저장된 상품의 정보들을 출력
	public ProductDTO getProductAdminContent(ProductDTO dto) {
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from product where productNum=?");
			pstmt.setInt(1, dto.getProductNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto.setProductNum(rs.getInt("productNum"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductBrand(rs.getString("productBrand"));
				dto.setProductLGroup(rs.getString("productLGroup"));
				dto.setProductSGroup(rs.getString("productSGroup"));
				dto.setProductFileName(rs.getString("productFileName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductOption(rs.getString("productOption"));
				dto.setInkBlack(rs.getInt("inkBlack"));
				dto.setInkBlackStock(rs.getInt("inkBlackStock"));
				dto.setInkRed(rs.getInt("inkRed"));
				dto.setInkRedStock(rs.getInt("inkRedStock"));
				dto.setInkBlue(rs.getInt("inkBlue"));
				dto.setInkBlueStock(rs.getInt("inkBlueStock"));
				dto.setInkGreen(rs.getInt("inkGreen"));
				dto.setInkGreenStock(rs.getInt("inkGreenStock"));
				dto.setReviewCount(rs.getInt("reviewCount"));
				dto.setSaleCount(rs.getInt("saleCount"));
				
				
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		
		
		
		return dto;
		
	}
	
	
	//DB내에 저장된 상품 중 검색결과에 일치하는 상품들의 갯수를 세기
	public int getProductSearchCount(String colum, String search) {
		int result = 0;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from product where "+colum+" like '%"+search+"%'");
			
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
		}return result;
	}
	
	
	//DB에 저장된 모든 상품 중 검색결과가 맞는 상품의 일부 가져오기(목록에 출력할 일부, 페이지에 출력할만큼의 크기)
	public List<ProductDTO> getProductSearchList (String colum, String search, int start, int end){
		List<ProductDTO> list = null;
		
		try {
			conn = OracleDB.getConnection();
			String sql = "select * from "
					+ " ( select productNum,productBrand,productName,productLGroup,productSGroup,productFileName,productPrice,productOption, rownum r from "
					+ " ( select * from Product where "+colum+" like '%"+search+"%' order by ProductNum desc)) "
					+ " where r >= ? and r <= ? ";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs=pstmt.executeQuery();
			
			list = new ArrayList();
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();

				
				dto.setProductNum(rs.getInt("productNum"));
				dto.setProductBrand(rs.getString("productBrand"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductLGroup(rs.getString("productLGroup"));
				dto.setProductSGroup(rs.getString("productSGroup"));
				dto.setProductFileName(rs.getString("productFileName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductOption(rs.getString("productOption"));

				list.add(dto);
				
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}return list;
	}
	

}
