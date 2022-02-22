<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="member.MemberDAO" %>
 <%@ page import="member.PaymentDTO" %>
 <%@ page import = "java.util.List" %>
 <%@ page import = "java.text.SimpleDateFormat" %>
 
<script>
	function openWin(a){
		var url = "mybuylistcancel1.jsp?dto=" + a;
		window.open( url , "get", "height = 100, width = 300");
	} 
</script>

<%!
	int pageSize = 10;
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
	String id = (String)session.getAttribute("id");
	if(id==null){
%>	
<script>
	alert("로그인후 사용가능합니다");
	window.location="loginForm.jsp";
</script>	
<%}else{	
	 
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    int currentPage = Integer.parseInt(pageNum);//문자열 숫자 전환
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;
    List paymentList = null;
    MemberDAO dao = MemberDAO.getInstance();
    // 싱글톤 정적필드에저장되있는 dao객체 가져오기
    count = dao.getPaymentidCount(id);
    if (count > 0) {
    	paymentList = dao.getpaymentlist(id,startRow, endRow);// 뭔값을 대입해도 4개밖에 못가져온다
    }
    
	number=count-(currentPage-1)*pageSize;
%>
 
<!DOCTYPE html>
<html>
	<head>
	<title>쇼핑몰</title>
	</head>
	<body>
	
		<table width="960" cellspacing="0" cellpadding="0" border="0" align="center">
		<tr>
		<td colspan=2 align=center>
		<table border=0 cellspacing=1 cellpadding=0 width=80%>
			<tr>
				<td align=right colspan=10 height=25 colspan=2 style=font-family:Tahoma;font-size:8pt;></td>
			</tr>
			<tr align=center height=20>
				<td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>주문날짜</td>
				<td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>주문번호</td>
				<td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>주문상품</td>
				<td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>상품가격</td>
				<td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>주문취소</td>
			</tr>
			
			<% if(count == 0){%>
			<tr align=center height=20>
			<td colspan="5" style=font-family:Tahoma;font-size:8pt;font-weight:bold;>주문내역이없습니다</td>
			</tr>
				<% }
				else{
		        for (int i = 0 ; i < paymentList.size() ; i++) {
		        	PaymentDTO dto = (PaymentDTO)paymentList.get(i);
		        	// == 과 equal의차이 ==는 주소값비교 equal은 내용비교 
		        			
			%>
			
			<tr>
				<td style="background-color:#F0F0F0; height:1px;" colspan=6>
			</tr>
			
			<tr align=center height=20>
				<td style=font-family:Tahoma;font-size:7pt;><%=simpleDateFormat.format(dto.getReg())%></td>
				<td style=font-family:Tahoma;font-size:8pt;><%=dto.getPaymentnum()%></td>
				<td style=font-family:Tahoma;font-size:8pt;><%=dto.getProductname()%></td>
				<td style=font-family:Tahoma;font-size:8pt;><%=dto.getProductprice()%></td>
				<td style=font-family:Tahoma;font-size:8pt;><button onclick="openWin(<%=dto.getPaymentnum()%>);">취소</button></td>
			</tr>
				
			<%		
		      }} %>
			
			<tr>
				<td style="background-color:#F0F0F0; height:1px;" colspan=6>
			</tr>
			
		</table>
		
		<%
		    if (count > 0) {
		        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
				 
		        int startPage = (int)(currentPage/10)*10+1;
				int pageBlock=10;
		        int endPage = startPage + pageBlock-1;
		        if (endPage > pageCount) endPage = pageCount;
		        
		        if (startPage > 10) {    %>
		        <a href="mybuylistForm.jsp?pageNum=<%= startPage - 10 %>">[이전]</a><!-- 페이지마다 달라지는 이유 -->
		<%      }
		        for (int i = startPage ; i <= endPage ; i++) {  %>
		        <a href="mybuylistForm.jsp?pageNum=<%= i %>">[<%= i %>]</a>
		<%
		        }
		        if (endPage < pageCount) {  %>
		        <a href="mybuylistForm.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
		<%
		        }
		    }
		%>
		
					
		
	</body>
</html>
<%}%>
