<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>


<jsp:useBean class="member.MemberDTO" id="dto" />
<jsp:setProperty property="*" name="dto"/>

<%
	MemberDAO dao = MemberDAO.getInstance();
	boolean result = dao.adminloginCheck(dto);
	
	
	if(result == true  ){//세션에 id값전달
		session.setAttribute("id", dto.getId());
		session.setAttribute("idGrade", 5);
		response.sendRedirect("/pro2_1/productList/main.jsp");
	}else{%>
		<script>
			alert("아이디/비밀번호를 확인하세요");
			history.go(-1);
		</script>	
<%}%>


