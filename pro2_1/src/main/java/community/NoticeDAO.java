package community;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import product.OracleDB;

public class NoticeDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	//DB에 공지를 입력
	public int NoticeInsert (NoticeDTO dto) {
		int result = 0;
		
		try {
			conn = product.OracleDB.getConnection();
			pstmt = conn.prepareStatement("insert into Notice values(Notice_seq.nextval, sysdate, 0, ?, ?, ?)");
			
			pstmt.setString(1, dto.getNoticeSubject());
			pstmt.setString(2, dto.getNoticeFileName());
			pstmt.setString(3, dto.getNoticeContent());
			
			
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
	
	
	//DB내의 저장된 공지를 수정
	public int NoticeUpdate(NoticeDTO dto) {
		int result = 0;
		
		try {
			conn = product.OracleDB.getConnection();
			String sql =" update notice set noticeReg = sysdate, noticeSubject = ? , noticeFileName=?, noticeContent = ? where noticeNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getNoticeSubject());
			pstmt.setString(2, dto.getNoticeFileName());
			pstmt.setString(3, dto.getNoticeContent());
			
			pstmt.setInt(4, dto.getNoticeNum());
			
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
	
	
	//DB내에 저장된 공지를 삭제
	public String NoticeDelete (int noticeNum){
		String result = null;
		
		try {
			conn = product.OracleDB.getConnection();
			
			pstmt = conn.prepareStatement("select noticeFileName from notice where noticeNum = ? ");
			pstmt.setInt(1, noticeNum);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("noticeFileName");
				//아 이거 noticeFileName 받아서 저장된 파일 지우기
			} 
			
			pstmt = conn.prepareStatement("delete from notice where noticeNum = ? ");
			pstmt.setInt(1, noticeNum);
			
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
	
	
	//DB에 저장된 모든 공지글의 정보를 일부 가져오기(목록에 출력할 일부, 페이지에 출력할만큼의 크기)
	public List<NoticeDTO> getNoticeAllList(int start, int end){
		List<NoticeDTO> list = null;
		
		try {
			conn = product.OracleDB.getConnection();
			
			String sql = "select * from "
					+ " (select noticeNum, readCount, noticeSubject, noticeReg, rownum r from "
					+ " (select * from Notice order by noticeNum desc)) "
					+ "	where r >= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList();
			
			while(rs.next()) {
				NoticeDTO dto  = new NoticeDTO();
				dto.setNoticeNum(rs.getInt("noticeNum"));
				dto.setNoticeSubject(rs.getString("noticeSubject"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setNoticeReg(rs.getTimestamp("noticeReg"));
				
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
		}return list;
		
	}
	
	
	//DB내의 모든 공지글의 갯수를 세기
	public int getNoticeCount() {
		int result = 0;
		
		try {
			conn = product.OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from Notice");
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
	
	
	//DB에 저장된 공지글의 조회수를 +1로 수정 (조회수 상승)
	public void NoticeReadCountUp(NoticeDTO dto) {
		try {
			conn = OracleDB.getConnection();
			String sql = "update Notice set readCount = readCount+1 where noticeNum=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNoticeNum());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
		}
		
	}
	
	//DB내에 저장된 공지글의 정보를 출력
	public NoticeDTO getNoticeContent(NoticeDTO dto) {
		try {
			conn = product.OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from Notice where noticeNum=? ");
			pstmt.setInt(1, dto.getNoticeNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNoticeNum(rs.getInt("noticeNum"));
				dto.setNoticeReg(rs.getTimestamp("noticeReg"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setNoticeFileName(rs.getString("noticeFileName"));
				dto.setNoticeSubject(rs.getString("noticeSubject"));
				dto.setNoticeContent(rs.getString("noticeContent"));
				
			}
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
		}
		
		return dto;
	}
	
	
	//DB내의 저장된 공지글 중 검색결과가 일치하는 공지글의 갯수를 세기
	public int getNoticeSearchCount(String colum, String search) {
		int result = 0;
		try {
			conn = product.OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from notice where "+colum+" like '%"+search+"%' ");
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
	
	
	//DB에 저장된 모든 공지글 중 검색결과가 일치하는 공지글의 정보를 일부 가져오기(목록에 출력할 일부, 페이지에 출력할만큼의 크기)
	public List<NoticeDTO> getNoticeSearchList(String colum, String search, int start, int end){
		List<NoticeDTO> list = null;
		
		try {
			conn=product.OracleDB.getConnection();
			String sql = "select * from "
					+ " (select noticeNum, readCount, noticeSubject, noticeReg, rownum r from "
					+ " (select * from notice where "+colum+" like '%"+search+"%' order by noticeNum desc)) "
					+ " where r >= ? and r <= ? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			
			list = new ArrayList();
			
			while(rs.next()) {
				NoticeDTO dto  = new NoticeDTO();
				dto.setNoticeNum(rs.getInt("noticeNum"));
				dto.setNoticeSubject(rs.getString("noticeSubject"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setNoticeReg(rs.getTimestamp("noticeReg"));
				
				list.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
		}return list;
	}

}
