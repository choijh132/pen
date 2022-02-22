<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "community.NoticeDAO" %>
<h1> Notice Update Form </h1>

<jsp:useBean class="community.NoticeDTO" id = "dto"/>
<jsp:setProperty property = "noticeNum" name = "dto"/>

<%

	String pageNum = request.getParameter("pageNum");
	NoticeDAO dao = new NoticeDAO();
	dto = dao.getNoticeContent(dto);

%>


<body style="letter-spacing : 2px; font-size:18px; font-family:'돋움'; line-height:200%; font-weight:bold;">
	<br/>
	<br/>
	<div style="padding:0px 0px 0px 100px">
	
		<form action = "noticeUpdatePro.jsp" method = "post" enctype="multipart/form-data">
			<input type = "hidden" name = "noticeNum" value = "<%=dto.getNoticeNum() %>"/>
			<input type = "hidden" name ="pageNum" value = "<%=pageNum %>"/>
				
			제목 : <input type ="text" name ="noticeSubject" value = "<%=dto.getNoticeSubject() %>"/><br/>
			첨부파일 <br/>
			<% if (dto.getNoticeFileName() != null) { %>
				<img src = "http://192.168.0.126:8080/pro2_1/noticeImg/<%=dto.getNoticeFileName() %>"/><br/>
				<input type = "hidden" name = "org" value = "<%=dto.getNoticeFileName() %>"/>
				<input type="file" name ="noticeFileName"/><br/>
			<%} else {%>
				<input type ="file" name ="noticeFileName"/><br/>
			<%} %><br/>
			
			내용<br/>
			<textarea cols="50" rows="10" name ="noticeContent" wrap="hard"><%String Content=dto.getNoticeContent().replace("<br/>","\n");%><%=Content%></textarea>
			<br/>
			
			<input type ="submit" value="수 정" style="font-size:15px; border:true;  border-radius:8px;"/>
			<input type = "button" value = "취 소" style="font-size:15px; border:true;  border-radius:8px;"
			onclick = "history.go(-1)"/>
		</form>
	</div>
</body>




