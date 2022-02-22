package community;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CsDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	String sql = "";
	int groupNum = 0;
	
	private static CsDAO instance = new CsDAO();
	
	public static CsDAO getInstance() {
		return instance;
	}
	private CsDAO() {}
	
	
	
	//고객문의글 DB에 입력
	public int insertCs(CsDTO dto) throws Exception { 

		int result =0;
		int ref = dto.getRef();
		int re_lev;
		sql = "";
		
		try {
			
			conn = product.OracleDB.getConnection();
			
			if(ref != 0) { //groupNum 맞춰주기
				re_lev = 1;
				sql = " select groupNum from customerService where num = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getRef());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					groupNum = rs.getInt("groupNum");
				}
			}
			else { //groupNum 최고값 가져오기(서버 새로시작할때마다 초기화된거 수습하기)
				re_lev = 0;
				sql = " select max(groupNum) from customerService ";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					groupNum = rs.getInt(1);
				}
				
				groupNum = groupNum + 1;
			}
				
			
			
			sql = "insert into customerService values(cs_seq.NextVal, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getFileName());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, groupNum);
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_lev);
			pstmt.setString(8, dto.getCsLock());
			
			result = pstmt.executeUpdate();

			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
		}
		
		return result;
		
		
	}
	
	
	//DB에 저장된 고객문의글을 찾아서 출력
	public CsDTO getCsContent(int num) throws Exception {
		
			CsDTO dto = null;
		
		try {
			conn = product.OracleDB.getConnection();
			pstmt = conn.prepareStatement( " select * from customerService where num = ? ");
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				dto = new CsDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setFileName(rs.getString("fileName"));
				dto.setContent(rs.getString("content"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_lev(rs.getInt("re_lev"));
				dto.setCsLock(rs.getString("csLock"));
				dto.setCsDate(rs.getTimestamp("csDate"));
			}
			
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return dto;
		
		
	}
	
	
	//DB에 저장된 총 고객문의글의 갯수를 세기
	public int getCsCount(){ 
		int result = 0;
		
		try {
			conn = product.OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from customerService");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}

			
		}catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	
	
	//DB에 저장된 모든 고객문의글의 정보를 일부 가져오기(목록에 출력할 일부, 페이지에 출력할만큼의 크기)
	public List<CsDTO> getCsAllList (int start, int end){
		
		List<CsDTO> list = null;
		sql = "";
		
		try {
			conn = product.OracleDB.getConnection();
			sql = "select num, writer, subject, fileName, content, groupNum, ref, re_lev, csLock, csDate, r from "
					+ "( select num, writer, subject, fileName, content, groupNum, ref, re_lev, csLock, csDate, rownum r from "
					+ "( select num, writer, subject, fileName, content, groupNum, ref, re_lev, csLock, csDate "
					+ "from customerservice order by groupnum desc, re_lev asc) "
					+ "order by groupNum desc, re_lev asc) where r >= ?  and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList(end);
				do {
					CsDTO dto = new CsDTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setFileName(rs.getString("fileName"));
					dto.setContent(rs.getString("content"));
					dto.setGroupNum(rs.getInt("groupNum"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_lev(rs.getInt("re_lev"));
					dto.setCsLock(rs.getString("csLock"));
					dto.setCsDate(rs.getTimestamp("csDate"));
					list.add(dto);
					
				} while(rs.next());
				
			}
			
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return list;
		
	}
	
	//DB에 저장된 고객문의글을 찾아서 삭제
	public String CustomerDelete(int num) {
		String result = null;
		
		try {
			conn = product.OracleDB.getConnection();
			pstmt = conn.prepareStatement("select fileName from CustomerService where num = ? ");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("fileName");
			}
			
			
			pstmt = conn.prepareStatement("delete from customerService where num = ? ");
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();} catch(SQLException s) {}}
		}
		
		return result;
	}
	
	
	//DB에 저장된 고객문의글을 찾아서 수정
	public int CustomerUpdate(CsDTO dto) {
		int result = 0;

		
		try {
			
			conn = product.OracleDB.getConnection();
			String sql = " update customerService set subject = ?, fileName = ?, content = ?, csDate = sysdate where num = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getFileName());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getNum());
			
			result = pstmt.executeUpdate();	
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	
	}
	
	
	//DB에 저장된 모든 고객문의글 중 검색결과가 일치하는 정보를 일부 가져오기(목록에 출력할 일부, 페이지에 출력할만큼의 크기)
	public List<CsDTO> getCsSearchList(String colum, String search, int start, int end){
		List<CsDTO> list = null;
		
		try {
			conn = product.OracleDB.getConnection();
			sql = "select * from "
					+ "(select num, writer, subject, content, filename, groupnum, ref, re_lev, csLock, CsDate, rownum r from "
					+ "(select * from customerservice where "+colum+" like '%"+search+"%' order by groupnum desc, re_lev asc)) "
					+ "where r >= ? and r <= ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList();
			
			while(rs.next()) {
				CsDTO dto = new CsDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setFileName(rs.getString("fileName"));
				dto.setContent(rs.getString("content"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_lev(rs.getInt("re_lev"));
				dto.setCsLock(rs.getString("csLock"));
				dto.setCsDate(rs.getTimestamp("csDate"));
				list.add(dto);
			}
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
	
	//DB에 저장된 모든 고객문의글 중 검색결과에 일치하는 고객문의글의 갯수를 세기
	public int getCsSearchCount(String colum, String search) {
		int result = 0;
		
		try {
			conn = product.OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from customerservice where "+colum+" like '%"+search+"%'");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	
	//DB에 저장된 일반 고객문의글에 대한 관리자의 답글을 보여주기
	public CsDTO getAdminContent(int num) {
		
			CsDTO dto = null;
		try {
			conn = product.OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from customerService where ref = ? ");
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new CsDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setCsDate(rs.getTimestamp("csDate"));
				dto.setCsLock(rs.getString("csLock"));
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
		}
		return dto;
	}
	
	
}
