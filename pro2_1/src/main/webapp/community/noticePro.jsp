<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %> 
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> 
<%@ page import = "community.NoticeDTO" %>
<%@ page import = "community.NoticeDAO" %>


    
<h1> Community Notice Pro </h1>


<%
	request.setCharacterEncoding("UTF-8"); //한국어
	String path = request.getRealPath("noticeImg"); //상품이미지 폴더
	//System.out.println(path);
	String enc = "UTF-8"; 
	int size = 1024*1024*10; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, size, enc, dp); 
	//mr == parameter

	String noticeSubject = mr.getParameter("noticeSubject");
	String noticeFileName = mr.getFilesystemName("noticeFileName");
	String changeContent = mr.getParameter("noticeContent");
	
	changeContent = changeContent.replace("\n", "<br/>");

	
	String noticeContent = changeContent;
	
	NoticeDTO dto = new NoticeDTO();
	
	dto.setNoticeSubject(noticeSubject);
	dto.setNoticeFileName(noticeFileName);
	dto.setNoticeContent(noticeContent);
	
	
	NoticeDAO dao = new NoticeDAO();
	int result = dao.NoticeInsert(dto);
	
	if(result == 1){
		%>
		<script>
			alert("등록 완료");
			window.location="noticeList.jsp";
		</script>
	<%}else {%>
		<script>
			alert("등록 실패");
		</script>
	<%}
	
%>