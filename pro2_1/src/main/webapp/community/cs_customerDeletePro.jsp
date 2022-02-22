<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "community.CsDAO" %>
<%@ page import = "java.io.File" %>
    
<h1> Customer Service Delete Pro </h1>


<jsp:useBean class = "community.CsDTO" id = "dto"/>
<jsp:setProperty property = "num" name = "dto"/>


<%
	String pageNum = request.getParameter("pageNum");
	
	
	CsDAO dao = CsDAO.getInstance();
	String result = dao.CustomerDelete(dto.getNum());
	
	if(result != null){
		String path = request.getRealPath("noticeImg");
		File f = new File (path+"//"+result);
		f.delete();
	}
%>

<script>
	alert("삭제 완료");
	window.location = "cs_customerList.jsp?pageNum=<%=pageNum%>";
</script>