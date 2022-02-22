<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="member.MemberDAO" %>
 <%@ page import="member.PaymentDTO" %>
 <%@ page import="member.MemberDTO" %>
 <%@ page import = "java.util.List" %>
 <%@ page import = "java.text.SimpleDateFormat" %>
 



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
	int point = 0;
    int currentPage = Integer.parseInt(pageNum);//문자열 숫자 전환
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;

    List paymentList = null;
    List paymentList1 = null;
    MemberDAO dao = MemberDAO.getInstance(); // 싱글톤 정적필드에저장되있는 dao객체 가져오기
    int idcount = dao.getPaymentidCount(id);
    
    count = dao.getPaymentidCount(id);
   
    
    if (count > 0) {
    	paymentList1 = dao.getpaymentlist(id,0,count);
    	paymentList = dao.getpaymentlist(id,startRow,endRow);//startrow부터 endrow까지
    }

	number=count-(currentPage-1)*pageSize;
	
%>


<html>
<head>
<title>적립금</title>
</head>
<body>
<table width="960" cellspacing="0" cellpadding="0" border="0" align="center">

<tr>
<td colspan=2 align=center>
<table border=0 cellspacing=1 cellpadding=0 width=80%>
	<tr>
	<td align=right colspan=10 height=25 colspan=2 style=font-family:Tahoma;font-size:8pt;>
	</td>
	</tr>
	<tr align=center height=20>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>적립일</td>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>주문번호</td>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>주문상품</td>
	  <td style=font-family:Tahoma;font-size:8pt;font-weight:bold;>적립금</td>
	 
	
	 
	</tr>
	 
	<%   if(count == 0){%>
	<tr align=center height=20>
	<td colspan="5" style=font-family:Tahoma;font-size:8pt;font-weight:bold;>주문내역이없습니다</td>
	</tr>
	<% }
		else{
	
		for (int k = 0 ; k <  paymentList1.size() ; k++) {
		 PaymentDTO dto1 = (PaymentDTO)paymentList1.get(k);
		 
		 if(id.equals(dto1.getId())){
		 point += dto1.getTotalprice()/100;
		 
		 }
		 dao.pointUpdate(point, id);
	 	}
	
	 
        for (int i = 0 ; i < paymentList.size() ; i++) {
        	
          PaymentDTO dto = (PaymentDTO)paymentList.get(i);
         
          if(id.equals(dto.getId())){// == 과 equal의차이 ==는 주소값비교 equal은 내용비교 
        	
        	  
%>
	
	<tr>
		<td style="background-color:#F0F0F0; height:1px;" colspan=6>
	</tr>
	
	<tr align=center height=20>
	

	<td style=font-family:Tahoma;font-size:7pt;><%=simpleDateFormat.format(dto.getReg())%></td>
	<td style=font-family:Tahoma;font-size:8pt;><%=dto.getPaymentnum()%></td>
	<td style=font-family:Tahoma;font-size:8pt;><%=dto.getProductname()%></td>
	<td style=font-family:Tahoma;font-size:8pt;><%=dto.getTotalprice()/100%></td><!-- dto.getProductprice()/100 -->
	
	  
   	

	</tr>
	
	
	<%	}	
      	}
		}
	%>
	<tr align=center height=20>
	  <td colspan="5" style=font-family:Tahoma;font-size:8pt;font-weight:bold;>누적 적립금</td>
	 
	</tr>
	<tr align=center height=20>
	  <td colspan="5" style=font-family:Tahoma;font-size:16pt;><%=point%></td>
	</tr>
	<tr>
		<td style="background-color:#F0F0F0; height:1px; " colspan=6>
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
        <a href="pointForm.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="pointForm.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="pointForm.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>

			

</body>
</html>
<%}%>
