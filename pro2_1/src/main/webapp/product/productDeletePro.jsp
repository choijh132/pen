<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "product.ProductDAO" %>
<%@ page import = "java.io.File" %>
    
<h1> Product Delete Pro </h1>

<jsp:useBean class="product.ProductDTO" id = "dto"/>
<jsp:setProperty property = "productNum" name ="dto"/>

<%

	String pageNum = request.getParameter("pageNum");
	
	ProductDAO dao = new ProductDAO();
	String result = dao.ProductDelete(dto.getProductNum());
	
	if(result != null) {
		String path = request.getRealPath("productImg");
		File f = new File(path+"//"+result);
		f.delete();
	}
%>

<script>
	alert("삭제 완료");
	window.location="productAdminList.jsp?pageNum=<%=pageNum%>";
</script>