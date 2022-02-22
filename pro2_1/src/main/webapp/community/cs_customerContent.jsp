<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "community.CsDAO" %>
<%@ page import = "community.CsDTO" %>
<%@ page import = "java.text.SimpleDateFormat" %>

    
    
<h1> Customer Service Content </h1>

<%
	String id = (String)session.getAttribute("id");
	if(id == null){
		id = "";
	}


	int grade ;
	
	try{
		grade = (int)session.getAttribute("idGrade");
	}catch(Exception e){
		grade = 0;
	}

	
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	
	CsDAO dao = CsDAO.getInstance();
	CsDTO dto = dao.getCsContent(num);
	
	CsDTO dtos = dao.getAdminContent(num);
	

	int ref = dto.getRef();

%>

<a href="/pro2_1/productList/main.jsp"> 펜마스터 </a>
<br/>
<br/>

<% 
	if("y".equals(dto.getCsLock())) { //잠금 확인
		if(id.equals(dto.getWriter()) || grade>4 ||id.equals("admin")){ //아이디와 관리자등급확인%>

		<body style="letter-spacing : 2px; font-size:18px; font-family:'돋움'; line-height:200%; font-weight:bold; padding:5px 5px 5px 80px;">
		
			<div align="center" >
				<label style="font-size:16px; font-color:#D9D9D9;">
					<% if("y".equals(dto.getCsLock())) {%>
							<img height = "15px" width ="15px" src = "http://192.168.0.126:8080/pro2_1/community/img/lockicon.png"/>
					<%} %>
					제목 : <b style ="font-color:black;"><%=dto.getSubject()%></b> <br/>
					작성일자 : <b style ="font-color:black;"><%=sdf.format(dto.getCsDate()) %></b> <br/>
					작성자 : <b style ="font-color:black;"><%=dto.getWriter()%></b> <br/>
				</label>
				
				첨부파일 <br/>
				
				<% if (dto.getFileName() != null){%>
				<img src = "http://192.168.0.126:8080/pro2_1/noticeImg/<%=dto.getFileName()%>"/>
				<%} %>
				
				<br/>
				내용<br/>
				
				<section style= "width:500; height:300; " align="left" >
					<%=dto.getContent() %>
				</section>
				<br/>
				
				<%if (dtos != null) {%>
					<div style="font-size:12px; font-color:#D9D9D9;" >
						<label>답변</label>
						 ┖━ <% if("y".equals(dtos.getCsLock()))  {%>
								<img height = "15px" width ="15px" src = "http://192.168.0.126:8080/pro2_1/community/img/lockicon.png"/>
							<%} %>
						 <a href="cs_customerContent.jsp?num=<%=dtos.getNum() %>&pageNum=<%=pageNum %>">　<%=dtos.getSubject() %>　</a>
					</div>
					<br/>
				
				<%} 
				
				
					
					if(ref != 0) { 
						if(grade>4||id.equals("admin")){%>
							
							<input type = "button" value ="답변 수정" style="font-size:15px; border:true;  border-radius:8px;"
							onclick ="document.location.href = 'cs_customerUpdateForm.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>'">
							<input type = "button" value ="답변 삭제" style="font-size:15px; border:true;  border-radius:8px;"
							onclick ="document.location.href = 'cs_customerDeleteForm.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>'">
						<%} 
				} 
					if(id.equals(dto.getWriter()) || grade>4||id.equals("admin")) { %>
					
						<input type = "button" value ="글 수정" style="font-size:15px; border:true;  border-radius:8px;"
						onclick ="document.location.href = 'cs_customerUpdateForm.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>'">
						<input type = "button" value ="글 삭제" style="font-size:15px; border:true;  border-radius:8px;"
						onclick ="document.location.href = 'cs_customerDeleteForm.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>'">
				
				<%} 
				
					
				if(ref == 0 && grade>4 ||id.equals("admin")){%>
					
					<input type = "button" value ="답변 작성" style="font-size:15px; border:true;  border-radius:8px;"
					onclick = "document.location.href='cs_customerInform.jsp?ref=<%=dto.getNum() %>&lock=<%=dto.getCsLock() %>'">
			
			<% }
					
		}
		 else { //잠금이 된 글이지만 읽을 권한이 없음(관리자등급X, 아이디와 작성자 일치X)%> 
		
			<script>
			alert("읽을 권한이 없습니다.");
			history.go(-1);
			</script>
		<%}
		
	} else { //잠금이 되지 않았을 때%>
		
		<body style="letter-spacing : 2px; font-size:18px; font-family:'돋움'; line-height:200%; font-weight:bold; padding:5px 5px 5px 80px;">
		
		<div align="center" >
			<label style="font-size:16px; font-color:#D9D9D9;">
				<% if("y".equals(dto.getCsLock())) {%>
						<img height = "15px" width ="15px" src = "http://192.168.0.126:8080/pro2_1/community/img/lockicon.png"/>
				<%} %>
				제목 : <b style ="font-color:black;"><%=dto.getSubject()%></b> <br/>
				작성일자 : <b style ="font-color:black;"><%=sdf.format(dto.getCsDate()) %></b> <br/>
				작성자 : <b style ="font-color:black;"><%=dto.getWriter()%></b> <br/>
			</label>
			
			첨부파일 <br/>
			
			<% if (dto.getFileName() != null){%>
			<img src = "http://192.168.0.126:8080/pro2_1/noticeImg/<%=dto.getFileName()%>"/>
			<%} %>
			
			<br/>
			내용<br/>
			
			<section style= "width:500; height:300; " align="left" >
				<%=dto.getContent() %>
			</section>
			<br/>
			
			<%if (dtos != null) {%>
				<div style="font-size:12px; font-color:#D9D9D9;" >
					<label>답변</label>
					 ┖━ <% if("y".equals(dtos.getCsLock()))  {%>
							<img height = "15px" width ="15px" src = "http://192.168.0.126:8080/pro2_1/community/img/lockicon.png"/>
						<%} %>
					 <a href="cs_customerContent.jsp?num=<%=dtos.getNum() %>&pageNum=<%=pageNum %>">　<%=dtos.getSubject() %>　</a>
				</div>
				<br/>
			
			<%} 
			
			
				
				if(ref != 0) { 
					if(grade>4){%>
						
						<input type = "button" value ="답변 수정" style="font-size:15px; border:true;  border-radius:8px;"
						onclick ="document.location.href = 'cs_customerUpdateForm.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>'">
						<input type = "button" value ="답변 삭제" style="font-size:15px; border:true;  border-radius:8px;"
						onclick ="document.location.href = 'cs_customerDeleteForm.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>'">
					<%} 
			} 
				if(id.equals(dto.getWriter()) || grade>4) { %>
				
					<input type = "button" value ="글 수정" style="font-size:15px; border:true;  border-radius:8px;"
					onclick ="document.location.href = 'cs_customerUpdateForm.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>'">
					<input type = "button" value ="글 삭제" style="font-size:15px; border:true;  border-radius:8px;"
					onclick ="document.location.href = 'cs_customerDeleteForm.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum%>'">
			
			<%} 
			
				
			if(ref == 0 && grade>4){%>
				
				<input type = "button" value ="답변 작성" style="font-size:15px; border:true;  border-radius:8px;"
				onclick = "document.location.href='cs_customerInform.jsp?ref=<%=dto.getNum() %>&lock=<%=dto.getCsLock() %>'">
		
		<% }
		
		
	}
		
		

	%>
	</div>
</body>

