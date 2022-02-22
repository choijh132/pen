<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%request.setCharacterEncoding("utf-8"); %>
<h1>findidPro.jsp</h1>

<jsp:useBean class="member.MemberDTO" id="dto" />
<jsp:setProperty property="*" name="dto"/>

<%
	MemberDAO dao = MemberDAO.getInstance();
	boolean result = dao.idfind(dto);//getInstance()맞게쓴건지확인
	
	if(result == true ){
		session.setAttribute("id", dto.getId());
		response.sendRedirect("idfind.jsp");
	}else{%>
		<script>
			alert("이름/핸드폰번호를 확인하세요");
		</script>	
<%}%>


