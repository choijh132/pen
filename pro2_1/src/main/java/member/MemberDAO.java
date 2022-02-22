package member;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
    
 	private static MemberDAO instance = new MemberDAO();
    
    public static MemberDAO getInstance() {return instance; }
    
    private MemberDAO() {}
    
    private Connection getConnection() throws Exception {
    	Class.forName("oracle.jdbc.driver.OracleDriver"); 
		String url = "jdbc:oracle:thin:@masternull.iptime.org:1521:orcl";
		String user ="team02";
		String pw = "team02";
		Connection conn = DriverManager.getConnection(url,user,pw);  //오라클 디비 연결 부분
		return conn;
    }
 
    public void insertMember(MemberDTO member) //회원가입
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
                	"insert into MEMBERDB values (?,?,?,?,?,?,'0','1')"); //?순서대로 테이블에 집어넣음
                pstmt.setString(1, member.getId());
                pstmt.setString(2, member.getPw());
                pstmt.setString(3, member.getName());
                pstmt.setString(4, member.getAddress());
                pstmt.setString(5, member.getEmail());
                pstmt.setString(6, member.getPhone());
                
    			
                pstmt.executeUpdate();//1.수행결과로 Int 타입의 값을 반환합니다.
                //2. SELECT 구문을 제외한 다른 구문을 수행할 때 사용되는 함수입니다. 변경된 레코드(행)의 수를 리턴
            
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        
    }
    public int idCheck(String id){//id중복확인
    	  int rst = 0;
    	  Connection conn = null;
    	  PreparedStatement pstmt = null;
    	  ResultSet rs = null;
    	  try{
    	   conn = getConnection();
    	   String sql = "select * from memberdb where id=?";
    	   pstmt = conn.prepareStatement(sql);
    	   pstmt.setString(1, id);
    	   rs = pstmt.executeQuery();
    	   if(rs.next()){
    	    rst = 1;
    	   }
    	  }catch(Exception e){
    	   e.printStackTrace();
    	  }finally{
    			if(rs!=null) {try {rs.close();}catch(SQLException s) {}}
      			if(pstmt!=null) {try {pstmt.close();}catch(SQLException s) {}}
      			if(conn!=null) {try {conn.close();}catch(SQLException s) {}}
    	  }
    	  return rst;
    	 }
    
    
    
    public boolean loginCheck(MemberDTO dto) {//로그인
		boolean result = false;
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from MEMBERDB where id=? and pw=? and not grade=9" );
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
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
    
    public boolean deletepayment(int dto) {//주문내역삭제
		boolean result = false;
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("delete from payment where paymentnum = ?");
			pstmt.setInt(1, dto);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
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
    
    public boolean adminloginCheck(MemberDTO dto) {//관리자로그인
  		boolean result = false;
  		Connection conn = null;
          PreparedStatement pstmt = null;
  		ResultSet rs= null;
  		try {
  			conn = getConnection();
  			pstmt = conn.prepareStatement("select * from MEMBERDB where id=? and pw=? and grade=5");
  			pstmt.setString(1, dto.getId());
  			pstmt.setString(2, dto.getPw());
  			rs = pstmt.executeQuery();
  			if(rs.next()) {
  				result = true;
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
    
    
    public MemberDTO getUserInfo(String id) {//회원수정전 정보 불러오기
    	MemberDTO dto =null;
    	Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = getConnection();
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
    
    public int memberUpdate(MemberDTO dto) {//회원정보수정
		int result = 0;
	   	Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update MEMBERDB set pw=?, name=?, address=?, email=?, phone=? where id =?");
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getAddress());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getPhone());
			pstmt.setString(6, dto.getId());
	
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
    
    public int memberDelete(MemberDTO dto) {//회원삭제
		int result = 0;
	   	Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
		//날짜처리부분
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update MEMBERDB set id=?, grade=9 where id =?");
			pstmt.setString(1, dto.getId()+format.format(now));
			pstmt.setString(2, dto.getId());
	
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
   
    
    public boolean idfind(MemberDTO dto) {//id찾기
		boolean result = false;
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from MEMBERDB where name=? and phone=? and not grade=9");
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPhone());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				result = true;
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
    public boolean pwfind1(MemberDTO dto) {//비밀번호찾기
		boolean result = false;
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select email,pw from MEMBERDB where id=? and email=? and not grade=9");
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getEmail());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setEmail(rs.getString("email"));
				dto.setPw(rs.getString("pw"));
				result = true;
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
   
    
    
    public int getPaymentCount() throws Exception {// 주문내역 갯수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from payment");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x; 
	}
    
    public int getPaymentidCount(String id) throws Exception {// 적립금 갯수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from payment where id = ?");
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			
			if (rs.next()) {
				
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x; 
	}
    
    public List getpaymentlist(String id,int start, int end) throws Exception {//주문내역
    	
    	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List paymentList=null;
		try {
			conn = getConnection();
			
			String sql = "	select paymentnum,basketnum,productnum,productname,productprice,packingprice,totalprice,inkblack,inkred,inkblue,inkgreen,id,address,phone,reg,r"
					+ "							from (select paymentnum,basketnum,productnum,productname,productprice,packingprice,totalprice,inkblack,inkred,inkblue,inkgreen,id,address,phone,reg,rownum r"
					+ "							from (select paymentnum,basketnum,productnum,productname,productprice,packingprice,totalprice,inkblack,inkred,inkblue,inkgreen,id,address,phone,reg from payment where id = ? order by reg desc)"
					+ "							 ) where r >= ? and r <= ? ";
			
			pstmt = conn.prepareStatement(sql);
	
		
					
					pstmt.setString(1, id); 
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);

					rs = pstmt.executeQuery();
					if (rs.next()) {
						paymentList = new ArrayList(end); 
						do{ 
							PaymentDTO dto= new PaymentDTO();
							
							dto.setPaymentnum(rs.getInt("paymentnum"));
							dto.setBasketnum(rs.getInt("basketnum"));
							dto.setProductnum(rs.getInt("productnum"));
							dto.setProductname(rs.getString("productname"));
							dto.setProductprice(rs.getInt("productprice"));
							dto.setPackingprice(rs.getInt("packingprice"));
							dto.setTotalprice(rs.getInt("totalprice"));
							dto.setInkblack(rs.getInt("inkblack"));
							dto.setInkred(rs.getInt("inkred"));
							dto.setInkblue(rs.getInt("inkblue"));
							dto.setInkgreen(rs.getInt("inkgreen"));
							dto.setId(rs.getString("id"));
							dto.setAddress(rs.getString("address"));
							dto.setPhone(rs.getString("phone"));
							dto.setReg(rs.getTimestamp("reg"));
							paymentList.add(dto);
						}while(rs.next());
					}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}

		
		return paymentList;
	}
    
    public int pointUpdate(int point, String id) {//적립금
		int result = 0;
	   	Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update MEMBERDB set point=? where id =?");
			pstmt.setInt(1, point);
			pstmt.setString(2, id);
			
	
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
 }