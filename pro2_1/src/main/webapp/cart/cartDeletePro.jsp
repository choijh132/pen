<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="basket.basketDTO" %>
<%@ page import="basket.basketDAO" %>
<%@ page import="java.util.List" %>

<jsp:useBean class="basket.basketDTO" id="dto"/>
<jsp:setProperty property="*" name="dto"/>

  
<% 
	String id = (String)session.getAttribute("id");
	//장바구니 번호(cartNum)를 기준으로 삭제를 실행
	String cartNum=request.getParameter("cartNum");
	
	boolean result;
	int cartNumber=Integer.parseInt(cartNum);
	basketDAO dao=new basketDAO();
	int productnum=dao.getProductnum(cartNumber);
	int inkblack=dao.getInkblack(cartNumber);
	int inkred=dao.getInkred(cartNumber);
	int inkblue=dao.getInkblue(cartNumber);
	int inkgreen=dao.getInkgreen(cartNumber);
	System.out.println(inkblack);
	System.out.println(inkred);
	result=dao.cartDelete(cartNumber,productnum,inkblack,inkred,inkblue,inkgreen);

	
	if(result==true){%>
		<script>
			alert("삭제 되었습니다.");
			window.location='/pro2_1/cart/cartForm.jsp';
		</script>
	<%}else{%>
		<script>
			alert("이미 삭제된 상품입니다.");
			history.go(-1);
		</script>
	<%}%>


