<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "community.NoticeDAO" %>
<%@ page import = "java.io.File" %>
    
<h1> Notice Delete Pro </h1>

<jsp:useBean class ="community.NoticeDTO" id = "dto"/>
<jsp:setProperty property = "noticeNum" name ="dto"/>


<%
	String pageNum = request.getParameter("pageNum");

	NoticeDAO dao = new NoticeDAO();
	String result = dao.NoticeDelete(dto.getNoticeNum());
	
	if(result != null){
		String path = request.getRealPath("noticeImg");
		File f = new File(path+"//"+result);
		f.delete();
	}

%>

<script>
	alert("삭제 완료");
	window.location = "noticeList.jsp?pageNum=<%=pageNum%>";
</script>