<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %> 
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> 
<%@ page import = "java.io.File" %>
<%@ page import = "community.NoticeDAO" %>
<%@ page import = "community.NoticeDTO" %>
    
<h1> Notice Update Pro </h1>


<%
	request.setCharacterEncoding("UTF-8");

	String path = request.getRealPath("noticeImg");
	String enc = "UTF-8";
	int size = 1024*1024*10;
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, size, enc, dp);
	
	String pageNum = mr.getParameter("pageNum");
	String noticeNum = mr.getParameter("noticeNum");
	
	String noticeSubject = mr.getParameter("noticeSubject");
	String noticeFileName = mr.getFilesystemName("noticeFileName");
	String changeContent = mr.getParameter("noticeContent");
	

	changeContent = changeContent.replace("\n", "<br/>");

	
	String noticeContent = changeContent;
	
	String org = mr.getParameter("org");
	
	
	
	NoticeDTO dto = new NoticeDTO();
	
	dto.setNoticeNum(Integer.parseInt(noticeNum));
	dto.setNoticeSubject(noticeSubject);
	dto.setNoticeContent(noticeContent);
	
	if(noticeFileName == null){
		dto.setNoticeFileName(org);
	} else{
		dto.setNoticeFileName(noticeFileName);
	}
	
	NoticeDAO dao = new NoticeDAO();
	int result = dao.NoticeUpdate(dto);
	
	if(result == 1){
		if(noticeFileName != null && org !=null){
			File f = new File(path + "//"+org);
			f.delete();
		}%>
		
		<Script>
			alert("수정 완료");
			window.location = "noticeContent.jsp?noticeNum=<%=noticeNum%>&pageNum=<%=pageNum%>";
		</Script>
	<%}


%>