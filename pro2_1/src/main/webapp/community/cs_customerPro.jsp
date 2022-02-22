<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %> 
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> 
<%@ page import = "community.CsDTO" %>
<%@ page import = "community.CsDAO" %>

<h1> Customer Service Pro </h1>


<% 
	request.setCharacterEncoding("UTF-8");
	String path = request.getRealPath("noticeImg");

	String enc = "UTF-8";
	int size = 1024*1024*10; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, size, enc, dp); 
	
	String ref = mr.getParameter("ref");
	String writer = mr.getParameter("writer");
	String subject = mr.getParameter("subject");
	String fileName = mr.getFilesystemName("fileName");
	String changeContent = mr.getParameter("content");
	String csLock = mr.getParameter("csLock");
	
	changeContent = changeContent.replace("\n", "<br/>");

	String content = changeContent;
	
	
	CsDTO dto = new CsDTO();

	dto.setRef(Integer.parseInt(ref));
	
	dto.setWriter(writer);
	dto.setSubject(subject);
	dto.setFileName(fileName);
	dto.setContent(content);
	dto.setCsLock(csLock);
	
	
	CsDAO dao = CsDAO.getInstance();
	int result = dao.insertCs(dto);
	

	if(result == 1){
		%>
		<script>
			alert("등록 완료");
			window.location="cs_customerList.jsp";
		</script>
	<%}else {%>
		<script>
			alert("등록 실패");
			history.go(-1);
		</script>
	<%}
	
%>



