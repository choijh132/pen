<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "community.NoticeDTO" %> 
<%@ page import = "community.NoticeDAO" %>   

<h1 style="font-family:'Arial Black'; letter-spacing:2px;"> Community Notice List </h1>

<%

	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	if(id==null){
		id="";
	}
	int grade;
	
	try{
		grade = (int)session.getAttribute("idGrade");
	}catch(Exception e){
		grade = 0;
	}


	String colum = request.getParameter("colum");
	String search = request.getParameter("search");


	int pageSize = 15;
	
	String pageNum = request.getParameter("pageNum");
	
	 SimpleDateFormat sdf = 
		        new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	
	if(pageNum == null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage-1) * pageSize+1;
	int end = currentPage * pageSize;
	
	NoticeDAO dao = new NoticeDAO();
	
	int count = 0;
	List<NoticeDTO> list = null;
	
	if(search == null){
		count = dao.getNoticeCount();
		if(count > 0){
			list = dao.getNoticeAllList(start, end);
		}
	} else {
		count = dao.getNoticeSearchCount(colum, search);
		if(count > 0){
			list = dao.getNoticeSearchList(colum, search, start, end);
		}
	}
	
	
	
	
%>

<a href="/pro2_1/productList/main.jsp"> 펜매니저 </a>
<br/>
<br/>



<div style="padding: 0px 0px 0px 80px;">
	<%if(grade>4||id.equals("admin")){ %>
		<input type ="button" value ="추가" onclick="window.location='noticeInform.jsp'" style="font-size:15px; border:true;  border-radius:8px;"/>
	<%} %>
	<br/>
	<br/>
	
	<table style="font-family:'돋움'">
		<tr  height = "100" style= "font-size: 18px">
			<th>번호</th> <th>제목</th> <th>조회수</th> <th>작성일자</th>
		</tr>
		
		<% if(count == 0){ %>
			<tr style = "font-size:30px; text-align: center; font-weight:bold; letter-spacing:5px">
				<td colspan = "4"> 
					등록된 게시글이 없습니다. <br/>
					<a href="NoticeList.jsp">목록으로 돌아가기</a>
				</td>
			</tr>
		
		<%} else{ 
			for(NoticeDTO dto:list) {%>
				<tr height = "80" style = "font-size:21px; text-align: center;">
					<td width = "50"> <%=dto.getNoticeNum() %></td>
					<td width = "200"> 
						<a href="noticeContent.jsp?noticeNum=<%=dto.getNoticeNum()%>&pageNum=<%=pageNum%>"><%=dto.getNoticeSubject() %></a> 
					</td>
					<td width = "50"> <%=dto.getReadCount() %></td>
					<td width = "250"> <%=sdf.format(dto.getNoticeReg())%></td>
				</tr>
			<% }
		}
		%>
		
	</table>
</div>





<center>
<%
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		
		int startPage = (currentPage/10) * 10+1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock -1;
			
		if(endPage > pageCount){
			endPage = pageCount;
		}
		if(startPage > 10){%>
			<a href ="noticeList.jsp?pageNum=<%=startPage-10%>">[이전]</a>
		<%}
		
		for(int i = startPage; i <= endPage; i++){%>
			<a href ="noticeList.jsp?pageNum=<%=i%>">[<%=i %>]</a>			
		<%}
		if(endPage<pageCount){%>
			<a href ="noticeList.jsp?pageNum=<%=startPage+10%>">[다음]</a>
		<%}
		
	}
	
%>
</center>

<form action="noticeList.jsp" method="post">
	<select name = "colum">
		<option value = "noticeSubject">제목</option>
		<option value = "noticeContent">내용</option>
	</select>
	<input type ="text" name="search" />
	<input type ="submit" value="검색" style="font-size:15px; border:true;  border-radius:8px;"/>
</form>