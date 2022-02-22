<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<h1> Customer Service Delete Form </h1>

<jsp:useBean class= "community.CsDTO" id="dto"/>
<jsp:setProperty property = "num" name ="dto"/>

<%
	String pageNum = request.getParameter("pageNum");

%>

<form action = "cs_customerDeletePro.jsp" method ="post">
	<input type ="hidden" name ="num" value = "<%=dto.getNum() %>"/>
	<input type ="hidden" name ="pageNum" value = "<%=pageNum %>"/>
	<input type ="submit" value = "삭제"/>
</form>