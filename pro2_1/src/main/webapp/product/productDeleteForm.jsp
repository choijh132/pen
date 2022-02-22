<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<h1> Product Delete Form </h1>

<jsp:useBean class="product.ProductDTO" id ="dto"/>
<jsp:setProperty property = "productNum" name ="dto"/>

<%
	String pageNum = request.getParameter("pageNum");
	
%>

<form action ="productDeletePro.jsp" method ="post">
	<input type ="hidden" name ="productNum" value ="<%=dto.getProductNum() %>"/>
	<input type ="hidden" name ="pageNum" value="<%=pageNum %>"/>
	<input type ="submit" value ="삭 제" style="font-size:15px; border:true;  border-radius:8px;"/>
	<input type = "button" value = "취 소" style="font-size:15px; border:true;  border-radius:8px;"
		onclick = "history.go(-1)"/>
</form>