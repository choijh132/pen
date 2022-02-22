<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="member.MemberDAO" %>
    <%@ page import="member.MemberDTO" %>


<%
	String id = (String)session.getAttribute("id");
	if(id==null){
%>	<script>
	alert("로그인후 사용가능합니다");
	window.location="loginForm.jsp";
</script>	
<% }else{	
	MemberDAO dao = MemberDAO.getInstance();//되는지 안되는지 확인 // 싱글톤 정적필드에저장되있는 dao객체 가져오기// 이렇게 하는 이유? 객체하나로해결되서 
	MemberDTO dto = dao.getUserInfo(id);//사용자 정보 저장
%>
<html>
	<link href="modifyForm.css" rel="stylesheet"   type="text/css">
	<body>
		<div class="form">
			<form action="modifyPro.jsp" method= "post">
			<h3>회원정보 수정</h3>
			<div class="input-box">
				<%=id %><input type="hidden" name="id" value="<%=id%>" /> <br/><br/>
				<input type = "password" Placeholder = "pw" name = "pw" value="<%=dto.getPw()%>"/> <br/><br/>
				<input type = "text" Placeholder = "name" name = "name" value="<%=dto.getName()%>" /> <br/><br/>
				<input type = "text" Placeholder = "address" name = "address" value="<%=dto.getAddress()%>" /> <br/><br/>
				<input type = "text" Placeholder = "email" name = "email" value="<%=dto.getEmail()%>" /> <br/><br/>
				<input type = "text" Placeholder = "phone" name = "phone" value="<%=dto.getPhone()%>" /> <br/><br/>
			</div>
				<input type = "submit" value = "정보수정"	/> <br/>
			
			</form>
		</div>
	</body>
</html>
<%}%>