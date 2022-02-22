<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "contents.ReviewDTO" %>
<%@ page import= "contents.contentsDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>


<jsp:useBean class="contents.ReviewDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<%	 
	contentsDAO dao = new contentsDAO();
	int result=dao.insertReview(dto);
	String pageNum= request.getParameter("pageNum");
	String productNum = request.getParameter("productNum");
	

if(result==1) {%> 
<script>
	alert("리뷰 작성 완료.");
	window.location="contentForm.jsp?productNum=<%=productNum%>&pageNum=<%=pageNum%>";
</script>
<%}else{%> 
<script>
	alert("리뷰 오류");
	window.location="contentForm.jsp?productNum=<%=productNum%>&pageNum=<%=pageNum%>";	

</script>

<%} %>
	

	
	
	