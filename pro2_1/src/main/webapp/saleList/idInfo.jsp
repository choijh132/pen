<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO" %>
<%@ page import="productSale.SaleDAO" %>

<%
	String id = (String)request.getParameter("id");
	SaleDAO dao = new SaleDAO();
	
	MemberDTO dto = dao.getUserInfo(id);
	int userPay = dao.getUserPayment(id);
	
%>
	id : <%=dto.getId() %> <br />
	이름 : <%=dto.getName() %> <br /> 
	주소 : <%=dto.getAddress() %> <br />
	e-mail : <%=dto.getEmail() %> <br /> 
	phone : <%=dto.getPhone() %> <br />
	point : <%=dto.getPoint() %> <br />
	총구매금액 : <%=userPay %> <br />

<input type="button" onclick="end()" value="닫기"/>

<script>
	function end(){
		self.close();
	}

</script>