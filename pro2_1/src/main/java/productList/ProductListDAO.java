package productList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracleDB.OracleDB;



public class ProductListDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//상품 전체 리스트 호출
	public List<ProductListDTO> productListAll(String order, int startCount, int endCount, int pMin, int pMax) {
		List<ProductListDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			
			pstmt = conn.prepareStatement("select * from (select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from (select * from product  where productprice >= ? and productprice <= ? order by "+order+" desc))where rn >= ? and rn <= ?");
			//기본출력
			pstmt.setInt(1, pMin);
			pstmt.setInt(2, pMax);
			pstmt.setInt(3, startCount);
			pstmt.setInt(4, endCount);
			rs = pstmt.executeQuery();
			
			list = new ArrayList<ProductListDTO>();
			while (rs.next()) {
				ProductListDTO dto = new ProductListDTO();
				dto.setProductNum(rs.getInt("productnum"));
				dto.setProductName(rs.getString("productname"));
				dto.setProductPrice(rs.getInt("productprice"));
				dto.setProductFileName(rs.getString("productfilename"));
				dto.setProductInkBlackStock(rs.getInt("inkblackstock"));
				dto.setProductInkBlueStock(rs.getInt("inkbluestock"));
				dto.setProductInkRedStock(rs.getInt("inkredstock"));
				dto.setProductInkGreenStock(rs.getInt("inkgreenstock"));
				dto.setReviewCount(rs.getInt("reviewcount"));
				dto.setSaleCount(rs.getInt("salecount"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return list;
	}
	
	//카테고리에 따른 상품 리스트 호출
	public List<ProductListDTO> getProductList(String category, String code, String order, int pMin, int pMax, int startCount, int endCount) {
		List<ProductListDTO> list = null;
		String sql = "";
		try {
			
			conn = OracleDB.getConnection();
			if(category.equals("productbrand") || category.equals("productlgroup")) {
				//카테고리 브랜드 or 종류별 출력
				sql = "select * from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productprice >= ? and productprice <= ? order by "+order+" desc)where "+category+" like ?) where  rn >=? and rn <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
				pstmt.setString(3, code);
				pstmt.setInt(4, startCount);
				pstmt.setInt(5, endCount);
			} else if(category.substring(0,3).equals("ink")) {
				//카테고리 색상 기준출력
				sql = "select * from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productprice >= ? and productprice <= ? order by "+order+" desc)where "+category+" >= 1) where  rn >=? and rn <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
				pstmt.setInt(3, startCount);
				pstmt.setInt(4, endCount);
			} else {
				//카테고리 선택 없이 리뷰, 판매순 출력
				sql = "select * from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productprice >= ? and productprice <= ? order by "+order+" desc)) where  rn >=? and rn <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
				pstmt.setInt(3, startCount);
				pstmt.setInt(4, endCount);
			}
			rs = pstmt.executeQuery();
			list = new ArrayList<ProductListDTO>();
			while (rs.next()) {
				ProductListDTO dto = new ProductListDTO();
				dto.setProductNum(rs.getInt("productnum"));
				dto.setProductName(rs.getString("productname"));
				dto.setProductFileName(rs.getString("productfilename"));
				dto.setProductPrice(rs.getInt("productprice"));
				dto.setProductInkBlackStock(rs.getInt("inkblackstock"));
				dto.setProductInkBlueStock(rs.getInt("inkbluestock"));
				dto.setProductInkRedStock(rs.getInt("inkredstock"));
				dto.setProductInkGreenStock(rs.getInt("inkgreenstock"));
				dto.setReviewCount(rs.getInt("reviewcount"));
				dto.setSaleCount(rs.getInt("salecount"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return list;
	}
	
	//상품명 검색 리스트 호출
	public List<ProductListDTO> getProductListSearch(String category, String code, String order, int pMin, int pMax, int startCount, int endCount, String search) {
		List<ProductListDTO> list = null;
		String sql = "";
		try {
			conn = OracleDB.getConnection();
			if( category == null || category.equals("null")) {
				//카테고리 X, 한글 검색 출력
				sql = "select * from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productname like '%"+search+"%' and productprice >= ? and productprice <= ? order by "+order+" desc)) where  rn >=? and rn <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
				pstmt.setInt(3, startCount);
				pstmt.setInt(4, endCount);
			} else if(category.substring(0,3).equals("ink")) {
				//카테고리 색상 기준출력
				sql = "select * from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productname like '%"+search+"%' and productprice >= ? and productprice <= ? order by "+order+" desc)where "+category+" >= 1) where  rn >=? and rn <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
				pstmt.setInt(3, startCount);
				pstmt.setInt(4, endCount);
			} else {
				//한글 검색 출력
				sql = "select * from "
					    + "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
					    + "(select * from product where productname like '%"+search+"%' and productprice >= ? and productprice <= ? order by "+order+" desc)where "+category+" like ?) where  rn >=? and rn <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
				pstmt.setString(3, code);
				pstmt.setInt(4, startCount);
				pstmt.setInt(5, endCount);
			}
			
			rs = pstmt.executeQuery();
			list = new ArrayList<ProductListDTO>();
			while (rs.next()) {
				ProductListDTO dto = new ProductListDTO();
				dto.setProductNum(rs.getInt("productnum"));
				dto.setProductName(rs.getString("productname"));
				dto.setProductFileName(rs.getString("productfilename"));
				dto.setProductPrice(rs.getInt("productprice"));
				dto.setProductInkBlackStock(rs.getInt("inkblackstock"));
				dto.setProductInkBlueStock(rs.getInt("inkbluestock"));
				dto.setProductInkRedStock(rs.getInt("inkredstock"));
				dto.setProductInkGreenStock(rs.getInt("inkgreenstock"));
				dto.setReviewCount(rs.getInt("reviewcount"));
				dto.setSaleCount(rs.getInt("salecount"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return list;
	}
	
	//상품 전체 개수 호출
	public int getTotalCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from product");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return x;
	}
	
	
	public int getProductListCount(String category, String code, String order, int pMin, int pMax) {
		String sql = "";
		int x = 0;
		try {
			conn = OracleDB.getConnection();
			if(category.equals("productbrand") || category.equals("productlgroup")) {
				//카테고리 브랜드 or 종류별 출력
				sql = "select count(*) from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productprice >= ? and productprice <= ? order by "+order+" desc)where "+category+" like ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
				pstmt.setString(3, code);
			} else if(category.substring(0,3).equals("ink")) {
				//카테고리 색상 기준출력
				sql = "select count(*) from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productprice >= ? and productprice <= ? order by "+order+" desc)where "+category+" >= 1)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
			} else {
				//카테고리 선택 없이 리뷰, 판매순 출력
				sql = "select count(*) from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productprice >= ? and productprice <= ? order by "+order+" desc))";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return x;
	}
	
	public int getProductListSearchCount(String category, String code, String order, int pMin, int pMax, String search) {
		String sql = "";
		int x = 0;
		try {
			conn = OracleDB.getConnection();
			if(category==null) {
				category="null";
			}
			if(code==null) {
				code="null";
			}
			
			if(category.equals("productbrand") || category.equals("productlgroup")) {
				//카테고리 브랜드 or 종류별 출력
				sql = "select count(*) from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productname like '%"+search+"%' and productprice >= ? and productprice <= ? order by "+order+" desc)where "+category+" like ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
				pstmt.setString(3, code);
			} else if(category.substring(0,3).equals("ink")) {
				//카테고리 색상 기준출력
				sql = "select count(*) from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productname like '%"+search+"%' and productprice >= ? and productprice <= ? order by "+order+" desc)where "+category+" >= 1)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
			} else {
				//카테고리 선택 없이 리뷰, 판매순 출력
				sql = "select count(*) from "
						+ "(select productnum, productname, productfilename, productprice, productoption, inkblackstock, inkredstock, inkbluestock, inkgreenstock, reviewcount, salecount, rownum rn from "
						+ "(select * from product where productname like '%"+search+"%' and productprice >= ? and productprice <= ? order by "+order+" desc))";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pMin);
				pstmt.setInt(2, pMax);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return x;
	}
	
	//상품 최대가격
	public int getPriceMax() {
		int priceMax = 0;
		try {
			conn = OracleDB.getConnection();

			pstmt = conn.prepareStatement("select max(productprice) from product");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				priceMax=rs.getInt(1);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return priceMax;
	}
	
	
	//상품 최소가격
	public int getPriceMin() {
		int priceMin = 0;
		try {
			conn = OracleDB.getConnection();

			pstmt = conn.prepareStatement("select min(productprice) from product");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				priceMin=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return priceMin;
	}
	
}
