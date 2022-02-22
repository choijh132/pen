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
		<title>아이디 중복 확인</title>
	</head>
	<body>
		<%
		if(rst == 1){
		%>
			사용할 수 없는 아이디입니다.
		<%}else{ %>
			사용가능한 아이디입니다.
		<!-- 아이디가 존재하지 않을 때 이미지 -->
		<%} %>
	</body>
</html>