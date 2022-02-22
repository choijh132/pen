<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %> 
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> 
<%@ page import = "java.io.File" %>
<%@ page import = "community.CsDTO" %>
<%@ page import = "community.CsDAO" %>

    
    
    
<h1> Customer Service Update Pro </h1>


<%
	request.setCharacterEncoding("UTF-8");

	String path = request.getRealPath("noticeImg");
	String enc = "UTF-8";
	int size = 1024*1024*10;
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, size, enc, dp);
	
	String pageNum = mr.getParameter("pageNum");
	String num = mr.getParameter("num");
	
	String subject = mr.getParameter("subject");
	String fileName = mr.getFilesystemName("fileName");
	
	String changeContent = mr.getParameter("content");
	changeContent = changeContent.replace("\n", "<br/>");
	String content = changeContent;	
	
	String org = mr.getParameter("org");
	
	CsDTO dto = new CsDTO();
	
	dto.setNum(Integer.parseInt(num));
	dto.setSubject(subject);
	dto.setContent(content);
	
	if(fileName == null){
		dto.setFileName(org);
	}else{
		dto.setFileName(fileName);
	}
	
	CsDAO dao = CsDAO.getInstance();
	int result = dao.CustomerUpdate(dto);
	
	if(result == 1){
		if(fileName != null && org != null){
			File f = new File(path+"//"+org);
			f.delete();
		}%>
		
		<script>
			alert("수정 완료");
			window.location ="cs_customerContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
		</script>
	<%}
			
%>











