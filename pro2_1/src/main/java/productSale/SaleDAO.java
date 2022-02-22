package productSale;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracleDB.OracleDB;
import member.MemberDTO;
import product.ProductDTO;

public class SaleDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	//전체 판매내역
	public List<SaleDTO> getAllSale(int start, int end) {
		List<SaleDTO> list = null;
		try {
			conn =OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from (select paymentnum, basketnum, productnum, productname, productprice, packingprice, totalprice, inkblack, inkred, inkblue, inkgreen, id, address, phone, reg , rownum rn  from (select * from payment order by reg desc)) where rn >= ? and rn <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<SaleDTO>();
			
			while(rs.next()) {
				SaleDTO dto = new SaleDTO();
				dto.setPaymentNum(rs.getInt("PaymentNum"));
				dto.setBasketNum(rs.getInt("BasketNum"));
				dto.setProductNum(rs.getInt("ProductNum"));
				dto.setProductName(rs.getString("productname"));
				dto.setProductPrice(rs.getInt("productprice"));
				dto.setPackingPrice(rs.getInt("PackingPrice"));
				dto.setTotalPrice(rs.getInt("TotalPrice"));
				dto.setInkBlack(rs.getInt("inkblack"));
				dto.setInkRed(rs.getInt("inkred"));
				dto.setInkBlue(rs.getInt("inkblue"));
				dto.setInkGreen(rs.getInt("inkgreen"));
				dto.setId(rs.getString("id"));
				dto.setAddress(rs.getString("Address"));
				dto.setPhone(rs.getString("phone"));
				dto.setReg(rs.getString("reg"));
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
	
	public List<SaleDTO> getProductName() {
		List<SaleDTO> list = null;
		try {
			conn =OracleDB.getConnection();
			pstmt = conn.prepareStatement("select distinct productname from payment");
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<SaleDTO>();
			
			while(rs.next()) {
				SaleDTO dto = new SaleDTO();
				dto.setProductName(rs.getString("productname"));
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
	
	//제품 및 날자 검색
	public List<SaleDTO> getSearchSale(String productName, String regStart, String regEnd, int start, int end) {
		List<SaleDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			if(productName.equals("all")) {
				productName = "";
			}
			pstmt = conn.prepareStatement("select * from (select paymentnum, basketnum, productnum, productname, productprice, packingprice, totalprice, inkblack, inkred, inkblue, inkgreen, id, address, phone, reg , rownum rn from (select * from payment where productname like'%"+productName+"%' and reg between  TO_DATE('"+regStart+" 00:00:00', 'YYYY-MM-DD HH24:MI:SS') and to_date('"+regEnd+" 23:59:59', 'YYYY-MM-DD HH24:MI:SS')order by reg desc ))where rn >= ? and rn <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<SaleDTO>();
			
			while(rs.next()) {
				SaleDTO dto = new SaleDTO();
				dto.setPaymentNum(rs.getInt("PaymentNum"));
				dto.setBasketNum(rs.getInt("BasketNum"));
				dto.setProductNum(rs.getInt("ProductNum"));
				dto.setProductName(rs.getString("productname"));
				dto.setProductPrice(rs.getInt("productprice"));
				dto.setPackingPrice(rs.getInt("PackingPrice"));
				dto.setTotalPrice(rs.getInt("TotalPrice"));
				dto.setInkBlack(rs.getInt("inkblack"));
				dto.setInkRed(rs.getInt("inkred"));
				dto.setInkBlue(rs.getInt("inkblue"));
				dto.setInkGreen(rs.getInt("inkgreen"));
				dto.setId(rs.getString("id"));
				dto.setAddress(rs.getString("Address"));
				dto.setPhone(rs.getString("phone"));
				dto.setReg(rs.getString("reg"));
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
	
	//총 판매금액
	public int getSaleResult() {
		int saleResult = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from payment");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				saleResult += rs.getInt("totalprice");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return saleResult;
	}
	
	//해당 날자 금액
	public int getSaleResult(String productName, String regStart, String regEnd) {
		int saleResult = 0;
		try {
			conn = OracleDB.getConnection();
			if(productName.equals("all")) {
				productName = "";
			}
			pstmt = conn.prepareStatement("select * from payment where productname like'%"+productName+"%' and reg >= to_date(?,'yyyy-mm-dd') and reg <= to_date(?,'yyyy-mm-dd')+1");
			pstmt.setString(1, regStart);
			pstmt.setString(2, regEnd);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				saleResult += rs.getInt("totalprice");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return saleResult;
	}
	
	//총 판매내역 개수
	public int getTotalCount() {
		int count = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from payment");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return count;
	}
	
	//검색된 판매내역 개수
	public int getSearchCount(String productName, String regStart, String regEnd) {
		int count = 0;
		if(productName.equals("all")) {
			productName = "";
		}
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from payment where productname like'%"+productName+"%' and reg >= to_date(?,'yyyy-mm-dd') and reg <= to_date(?,'yyyy-mm-dd')+1 ");
			pstmt.setString(1, regStart);
			pstmt.setString(2, regEnd);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return count;
	}
	
	//회원정보 조회
	public MemberDTO getUserInfo(String id) {
		MemberDTO dto =null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from MEMBERDB where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setAddress(rs.getString("address"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setPoint(rs.getString("point"));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return dto;
	}
	
	//회원별 구매금액
	public int getUserPayment(String id) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select m.id, sum(totalprice) from memberdb m, payment p where m.id=p.id and m.id=? group by m.id");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(2);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return result;
	}
	
	//제품정보 조회
	public ProductDTO getProductInfo(String productNum) {
		int proNum = Integer.parseInt(productNum);
		ProductDTO dto =null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from product where productnum=?");
			pstmt.setInt(1, proNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ProductDTO();
				dto.setProductNum(rs.getInt("productNum"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductOption(rs.getString("productOption"));
				dto.setInkBlackStock(rs.getInt("inkBlackStock"));
				dto.setInkRedStock(rs.getInt("inkRedStock"));
				dto.setInkBlueStock(rs.getInt("inkBlueStock"));
				dto.setInkGreenStock(rs.getInt("inkGreenStock"));
				dto.setReviewCount(rs.getInt("reviewCount"));
				dto.setSaleCount(rs.getInt("saleCount"));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException s) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException s) {}}
			if (conn != null) {	try {conn.close();} catch (SQLException s) {}}
		}
		return dto;
	}
}
