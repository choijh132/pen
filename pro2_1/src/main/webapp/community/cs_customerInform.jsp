<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1> Customer Service Inform </h1>


<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	
	int ref = 0;
	String lock = request.getParameter("lock");
	
	
	if(request.getParameter("ref")!=null){
		ref = Integer.parseInt(request.getParameter("ref"));
	}
	
		
%>


<body style="letter-spacing : 2px; font-size:18px; font-family:'돋움'; line-height:200%; font-weight:bold;">
	<form action = "cs_customerPro.jsp" method= "post" enctype="multipart/form-data">
		<div style="padding:0px 0px 0px 100px">	
			<input type="hidden" name="ref" value="<%=ref%>"/>
			<%if(lock!=null){ %>
				<input type="hidden" name="csLock" value="<%=lock%>"/>
			<%} else { %>
				비공개 <input type = "radio" name = "csLock" value ="y" checked/>
				공개 <input type = "radio" name = "csLock" value ="n"/>
			<%} %>
			<br/>
			
			<%=id %><input type ="hidden" name = "writer" value="<%=id %>"/> <br/>
			
			제목 : 
			<%if(ref==0){ //새글일때에는 num이 안넘어온다%> 
		       <input type="text"name="subject">
			<%} else{ //새글이 아닌 답글일 때, num이 넘어왔음으로 새글이 아닌 답글임을 확인%>
			   <input type="text" name="subject" value="[답변]">
			<%}%>
			<br/>
	
			첨부파일 : <input type ="file" name ="fileName"/> <br/>
			
			내용 <br/>
			<textarea cols="50" rows="10" placeholder = "내용을 입력하세요." name ="content" wrap="hard"></textarea>
			<br/>
			
			<input type = "submit" value = "등 록" style="font-size:15px; border:true;  border-radius:8px;"/>
			<input type = "button" value = "취 소" style="font-size:15px; border:true;  border-radius:8px;"
			onclick = "history.go(-1)"/>
		
		</div>
	</form>
</body>







