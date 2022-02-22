<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO" %>
<%@ page import="product.ProductDTO" %>
<%@ page import="productSale.SaleDAO" %>

<%
	String productNum = (String)request.getParameter("productNum");
	SaleDAO dao = new SaleDAO();
	
	ProductDTO dto = dao.getProductInfo(productNum);
	/* int userPay = dao.getUserPayment(id); */
	
%>
	제품번호 : <%=dto.getProductNum() %> <br />
	제품명 : <%=dto.getProductName() %> <br />
	제품가격 : <%=dto.getProductPrice() %> <br /><br />
	black 재고 : <%=dto.getInkBlackStock() %> <br />
	red 재고 : <%=dto.getInkRedStock() %> <br />
	blue 재고 : <%=dto.getInkBlueStock() %> <br />
	green 재고 : <%=dto.getInkGreenStock() %> <br /><br />
	
	리뷰수 : <%=dto.getReviewCount() %> <br />
	구매수 : <%=dto.getSaleCount() %> <br />

<input type="button" onclick="end()" value="닫기"/>

<script>
	function end(){
		self.close();
	}

</script>