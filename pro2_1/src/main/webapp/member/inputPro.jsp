<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberDTO" %>


<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="member" class="member.MemberDTO">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
    
	MemberDAO m = MemberDAO.getInstance();
String id = (String)request.getParameter("id");
int rst = 0;
rst = m.idCheck(id);	

if(rst == 1){%>
<script>
	alert("가입실패");
	window.location='inputForm.jsp';
	</script>	
<%}else{ 
m.insertMember(member);
%>
<script>
	alert("가입되었습니다");
	window.location='loginForm.jsp';
	</script>	

<%} %>

