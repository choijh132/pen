<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberDTO" %>


<%
 int rst = 0;
 String id = (String)request.getParameter("id");
 MemberDAO dao = MemberDAO.getInstance();
 rst = dao.idCheck(id);
%>
<!DOCTYPE html>
<html>
	<head>
		<title>���̵� �ߺ� Ȯ��</title>
	</head>
	<body>
		<%
		if(rst == 1){
		%>
			����� �� ���� ���̵��Դϴ�.
		<%}else{ %>
			��밡���� ���̵��Դϴ�.
		<!-- ���̵� �������� ���� �� �̹��� -->
		<%} %>
	</body>
</html>