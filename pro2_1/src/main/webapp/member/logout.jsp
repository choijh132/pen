<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>logout.jsp</h1>

<%
	//세션삭제
	session.removeAttribute("id");
	session.invalidate();

	response.sendRedirect("/pro2_1/productList/main.jsp");
%>