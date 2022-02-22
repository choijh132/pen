<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1> Notice Delete Form </h1>

<jsp:useBean class = "community.NoticeDTO" id = "dto"/>
<jsp:setProperty property = "noticeNum" name = "dto"/>

<%
	String pageNum = request.getParameter("pageNum");

%>

<form action = "noticeDeletePro.jsp" method = "post">
	<input type ="hidden" name ="noticeNum" value = "<%=dto.getNoticeNum() %>"/>
	<input type = "hidden" name ="pageNum" value = "<%=pageNum %>"/>
	<input type ="submit" value ="삭 제"/>
	<input type = "button" value = "취 소" style="font-size:15px; border:true;  border-radius:8px;"
		onclick = "history.go(-1)"/>
</form>