<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = (String)session.getAttribute("id");
	if(id==null){
%>	
<script>
	alert("로그인후 사용가능합니다");
	window.location="loginForm.jsp";
</script>	
<% }else{%>

<html>
	<link href="deleteForm.css" rel="stylesheet"   type="text/css">
	<body>
		<div class="form">
			<form action = "deletePro.jsp" method = "post" >
				<div class="input-box">
					<input type = "hidden" name = "id" value="<%=id %>"/>
				pw  <input type = "password" name = "pw"><br/>
	
				</div>
					<input type = "submit" value = "탈퇴"/>
			</form>
		</div>
	</body>
</html>
<%}%>