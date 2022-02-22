<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.PaymentDTO" %>
	
<%
	MemberDAO dao = MemberDAO.getInstance();
	String num = request.getParameter("dto");
	int num1 =  Integer.parseInt(num);
	dao.deletepayment(num1);
%>

<script>
	function cancel(){
		 opener.location.reload();
		 self.close();	 
	}
</script>

<!DOCTYPE html>
삭제되었습니다.
<button onclick="cancel();">확인</button>
