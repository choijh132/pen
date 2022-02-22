<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "product.ProductDAO" %>
    
    
<h1 style="font-family:'Arial Black'"> Product Content </h1>


<jsp:useBean class="product.ProductDTO" id = "dto"/>
<jsp:setProperty property = "productNum" name = "dto"/>

<%

	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	
	ProductDAO dao = new ProductDAO();
	
	dto = dao.getProductAdminContent(dto);
	
%>


<body style="letter-spacing : 2px; font-size:18px; font-family:'돋움'; line-height:200%; font-weight:bold; padding:5px 5px 5px 80px;">
	<div align="center">
		<label style="font-size:25px; font-weight:bold;">
			<%=dto.getProductName()%>
		</label>
		<br/>
		<label style="font-size:13px; font-weight:normal;">상품 이미지 </label><br/>
		
		<%if(dto.getProductFileName() == null) {%>
			<img src="inkColorImg/noImg.png">
		<%} else{%> 
			<img src="http://192.168.0.126:8080/pro2_1/productImg/<%=dto.getProductFileName() %>" width="300" height="300">
		<%}%>
		<br/>
	</div>
	
	<section style="padding:5px 5px 5px 100px;">
		
		상품 번호 : <%=dto.getProductNum()%><br/>
		상품명 : <%=dto.getProductName()%><br/>
		브랜드명 :  <%=dto.getProductBrand() %><br/>
		<%=dto.getProductLGroup()%> : <%=dto.getProductSGroup()%> <br/>
		상품 가격 : <%=dto.getProductPrice() %><br/>
		상품 옵션 : <%=dto.getProductOption() %><br/>
		
		잉크 컬러 | 재고 <br/>
		
		<% if(dto.getInkBlack() > 0) {%>
			<img src="inkColorImg/blackCircleIcon.png" width="10" height="10">
			<%=dto.getInkBlackStock() %> <br/>
		<%} 
		 if(dto.getInkRed() > 0) {%>
			<img src="inkColorImg/RedCircleIcon.png" width="10" height="10">
			<%=dto.getInkRedStock() %> <br/>
		<%} 
		 if(dto.getInkBlue() > 0) {%>
			<img src="inkColorImg/blueCircleIcon.png" width="10" height="10">
			<%=dto.getInkBlueStock() %> <br/>
		<%} 
		 if(dto.getInkGreen() > 0) {%>
			<img src="inkColorImg/GreenCircleIcon.png" width="10" height="10">
			<%=dto.getInkGreenStock() %> <br/>
		<%} %>
		<br/>
		
		리뷰건수 : <%=dto.getReviewCount() %><br/>
		판매건수 : <%=dto.getSaleCount() %><br/>
		
		<br/>
		
		<input type = "button" value="수정" style="font-size:15px; border:true;  border-radius:8px;"
		onclick="window.location='productUpdateForm.jsp?productNum=<%=dto.getProductNum()%>&pageNum=<%=pageNum%>'"/>
		<input type = "button" value="삭제" style="font-size:15px; border:true;  border-radius:8px;"
		onclick="window.location='productDeleteForm.jsp?productNum=<%=dto.getProductNum()%>&pageNum=<%=pageNum%>'"/>
		<input type = "button" value="목록" style="font-size:15px; border:true;  border-radius:8px;"
		onclick="window.location='productAdminList.jsp?pageNum=<%=pageNum %>'"/>
		

	</section>
</body>
