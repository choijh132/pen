<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "community.CsDAO" %>


<h1> Customer Service Update Form </h1>

<jsp:useBean class = "community.CsDTO" id = "dto"/>
<jsp:setProperty property = "num" name ="dto"/>

<%
	String pageNum = request.getParameter("pageNum");
	CsDAO dao = CsDAO.getInstance();
	int num = dto.getNum();
	dto = dao.getCsContent(num);

%>
<body style="letter-spacing : 2px; font-size:18px; font-family:'돋움'; line-height:200%; font-weight:bold;">
	<br/>
	<br/>
	<div style="padding:0px 0px 0px 100px">
		<form action ="cs_customerUpdatePro.jsp" method = "post" enctype ="multipart/form-data">
			<input type = "hidden" name = "num" value = "<%=num %>"/>
			<input type = "hidden" name = "pageNum" value = "<%=pageNum %>"/>
			
			제목 : <input type = "text" name ="subject" value ="<%=dto.getSubject() %>"/><br/>
			
			첨부파일 <br/>
			<% if(dto.getFileName() != null){ %>
				<img src = "http://192.168.0.126:8080/pro2_1/noticeImg/<%=dto.getFileName() %>"/><br/>
				<input type = "hidden" name = "org" value = "<%=dto.getFileName() %>"/>
				<input type = "file" name = "fileName"/><br/>
			<%} else { %>
				<input type ="file" name ="fileName"/><br/>
			<%} %>
			
			내용<br/>
			<textarea cols = "50" rows ="10" name = "content" wrap ="hard"><%String Content = dto.getContent().replace("<br/>","\n");%><%=Content%></textarea>
			<br/>
			<input type = "submit" value = "수 정" style="font-size:15px; border:true;  border-radius:8px;"/>
			<input type = "button" value = "취 소" style="font-size:15px; border:true;  border-radius:8px;"
			onclick = "history.go(-1)"/>
		</form>
	</div>
</body>








