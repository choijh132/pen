<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>idfind.jsp</h1>
<%
	String name = (String)session.getAttribute("id");	
%>
<h2>아이디 : [<%=name%>] </h2>
