<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberDAO" %>    
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean class="member.MemberDTO" id="dto" />
<jsp:setProperty property="*" name="dto"/>
<%
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.memberDelete(dto);
	if(result == 1){%>
		<script>
			alert("삭제됨");
			window.location='loginForm.jsp';
		</script>	
<%}else{%>
		<script>
			alert("잘못된입력을확인하세요 확인하세요");
			window.location='loginForm.jsp';
		</script>	
<%}%>
