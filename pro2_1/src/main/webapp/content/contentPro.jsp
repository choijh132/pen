<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="product.ProductDTO" %>
<%@ page import="product.ProductDAO" %>
<%@ page import="contents.contentsDAO" %>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean class="contents.contentsDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<%

String id = (String) session.getAttribute("id");
String productNum = request.getParameter("productNum");
String productName = request.getParameter("productName");
String priceSum = request.getParameter("productPriceSum");
String inkK = request.getParameter("blackStock");
String inkR = request.getParameter("redStock");
String inkB = request.getParameter("blueStock");
String inkG = request.getParameter("greenStock");
String packingprice = request.getParameter("optionEx");



contentsDAO dao = new contentsDAO();
int result = dao.inputCart(dto, id, priceSum, inkK, inkR, inkB, inkG, packingprice);

if(result==1) {
%> <script>
	move = confirm("장바구니 페이지로 이동하시겠습니까?");
	if(move==true){
		window.location="/pro2_1/cart/cartForm.jsp";
	} else{
		window.location="contentForm.jsp?productNum=<%=productNum%>";
	}

</script><%}else{
%> <script>
	alert("비회원은 구매 불가입니다. 로그인 바랍니다.");
	window.location="/pro2_1/productList/main.jsp";	

</script>

<%} %>
