<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "community.CsDAO" %>
<%@ page import = "community.CsDTO" %>


<h1> Customer Service List </h1>

<%
	request.setCharacterEncoding("UTF-8");

	int listNum = 0;//각 페이지마다 게시글의 순서를 1~10번까지 보여준다.
	
	String colum = request.getParameter("colum");
	String search = request.getParameter("search");
	
	String id = (String)session.getAttribute("id");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");

	if(pageNum == null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage-1) * pageSize +1;
	int end = currentPage * pageSize;
	
	CsDAO dao = CsDAO.getInstance();
	
	
	int count = 0;
	List<CsDTO> list = null;
	
	
	if(search == null){
		count = dao.getCsCount();
		if(count > 0){
			list = dao.getCsAllList(start, end);
		}
	} else {
		count = dao.getCsSearchCount(colum, search);
		if(count > 0){
			list = dao.getCsSearchList(colum, search, start, end);
		}
	}

%>

<a href="/pro2_1/productList/main.jsp"> 펜매니저 </a>
<br/>
<br/>

<div style="padding: 0px 0px 0px 80px;">
	
	<%if(id != null){ %>
		<input type ="button" value ="문의작성" onclick ="window.location='cs_customerInform.jsp'"  style="font-size:15px; border:true;  border-radius:8px;"/>
		<br/>
		<br/>
	<%} %>
	
	<table>
		<tr>
			<th><img src = "img/icon.png" width="50" height="16"/></th><th width = "80">작성자</th> <th width = "180">제목</th> <th width ="130">작성일자</th>
		</tr>
		
		<%if(count == 0){ %>
			<tr>
				<td colspan = "5"> 
					등록된 게시글이 없습니다. <br/>
					<a href="cs_customerList.jsp">목록으로 돌아가기</a>
				</td>
			</tr>
		<%} else{
			
			for(CsDTO dto : list){ %>
			
				<tr height = "80" style = "font-size:15px; text-align: center;">
					<td width = "20"><%=listNum +=1 %></td>
					<td width = "80"><%=dto.getWriter() %></td>
					
					<td width = "250">
					
						<%if(dto.getRe_lev() > 0) { %>
							<a>┖━　</a>
						<%} 
						
						if("y".equals(dto.getCsLock())) {%>
							<img height = "15px" width ="15px" src = "http://192.168.0.126:8080/pro2_1/community/img/lockicon.png"/>
						<%} %>
						<a href = "cs_customerContent.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum %>"><%=dto.getSubject() %></a>
						
					</td>
						
					<td width = "120"><%=sdf.format(dto.getCsDate()) %></td>
				</tr>
		<%		}
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
				<a href ="cs_customerList.jsp?pageNum=<%=startPage-10%>">[이전]</a>
			<%}
			
			for(int i = startPage; i <= endPage; i++){%>
				<a href ="cs_customerList.jsp?pageNum=<%=i%>">[<%=i %>]</a>			
			<%}
			if(endPage<pageCount){%>
				<a href ="cs_customerList.jsp?pageNum=<%=startPage+10%>">[다음]</a>
			<%}
			
		}
		
	%>
</center>
<br/>
<br/>

<form action="cs_customerList.jsp" method="post">
	<select name = "colum">
		<option value = "writer">작성자</option>
		<option value = "subject">제목</option>
		<option value = "content">내용</option>
	</select>
	<input type ="text" name="search" />
	<input type ="submit" value="검색" style="font-size:15px; border:true;  border-radius:8px;"/>
</form>
