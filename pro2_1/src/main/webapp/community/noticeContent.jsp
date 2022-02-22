<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "community.NoticeDAO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
    
    
<h1> Community Notice Content </h1>


<jsp:useBean class="community.NoticeDTO" id="dto"/>
<jsp:setProperty property =  "noticeNum" name ="dto"/>

<%
	String id = (String)session.getAttribute("id");
	if(id == null){
		id = "";
	}
	
	int grade;
	
	try{
		grade = (int)session.getAttribute("idGrade");
	}catch(Exception e){
		grade = 0;
	}


	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	
	NoticeDAO dao = new NoticeDAO();
	dao.NoticeReadCountUp(dto);
	dto = dao.getNoticeContent(dto);


%>

<a href="/pro2_1/productList/main.jsp"> 펜마스터 </a>
<br/>
<br/>



<body style="letter-spacing : 2px; font-size:18px; font-family:'돋움'; line-height:200%; font-weight:bold; padding:5px 5px 5px 80px;">


<br/>
<br/>
	<div align="center" >
		<label style="font-size:20px; font-weight:bold;">
			<label style="font-size:10px; font-color:#D9D9D9;" ><%=dto.getNoticeNum() %></label>
			<%=dto.getNoticeSubject() %>
			<br/>
			<label style="font-size:10px; font-color:#D9D9D9;" > 조회수 <%=dto.getReadCount() %> </label>
			<br/>
			<%=sdf.format(dto.getNoticeReg())%>
			<br/>
		</label>
		
		<% if(dto.getNoticeFileName() != null){ %>
			<img src = "http://192.168.0.126:8080/pro2_1/noticeImg/<%=dto.getNoticeFileName() %>"/>
		<%} %>
		
		<br/>
		<br/>
		
		<section style= "width:500; height:300; " align="left" >
			<%=dto.getNoticeContent() %>
		</section>

		<% if(grade>4 || "admin".equals(id)) {%>
		
			<input type = "button" value="수정" style="font-size:15px; border:true;  border-radius:8px;"
			onclick="window.location='noticeUpdateForm.jsp?noticeNum=<%=dto.getNoticeNum()%>&pageNum=<%=pageNum%>'"/>
			<input type = "button" value="삭제" style="font-size:15px; border:true;  border-radius:8px;"
			onclick="window.location='noticeDeleteForm.jsp?noticeNum=<%=dto.getNoticeNum()%>&pageNum=<%=pageNum%>'"/>
				
		<%} %>
		
		<input type = "button" value="목록" style="font-size:15px; border:true;  border-radius:8px;"
		onclick="window.location='noticeList.jsp?pageNum=<%=pageNum %>'"/>
	</div>
</body>