<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="basket.basketDTO" %>
<%@ page import="basket.basketDAO" %>
<%@ page import="basket.memberDTO" %>
<%@ page import="basket.memberDAO" %>
<%@ page import="java.util.List"%>
<%@ include file="/productList/mainTop.jsp"%> 

<jsp:useBean class="basket.basketDTO" id="dto"/>
<jsp:setProperty property="*" name="dto"/>
<jsp:useBean class="basket.memberDTO" id="memberdto"/>
<jsp:setProperty property="*" name="memberdto"/>

<link href="reset.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet" type="text/css">


<%
	if(id == null){%>
		<script>
			alert("로그인 후 이용하세요");
			window.location='/pro2_1/productList/main.jsp';	
		</script>
	<%}
	memberDAO mdao=new memberDAO();
	memberDTO mdto=new memberDTO();
	mdto = mdao.getClientInfo(id);
	
%>

			
<html>
<body>	
	<div class="wrap">

		<div class="basket_title">
			<p>장바구니</p>
		</div>
	
		<div class="basket_main">
		
	
	<table border="1">
		<tr>
			<th width= 5%>번호</th>
			<th width= 20%>제품명</th>
			<th width= 15%>가격</th>
			<th width= 4%>K</th>
			<th width= 4%>R</th>
			<th width= 4%>B</th>
			<th width= 4%>G</th>
			<th width= 15%>포장</th>
			<th width= 25%>합계</th>
			<th width= 4%>삭제</th>
		</tr>
	
	
<% 

  
   basketDAO dao=new basketDAO();
   List<basketDTO> list=dao.getBasketList(id);
   if(list.size() >= 1 ){
	   
      for(basketDTO bdto : list){%>
      	<tr>
      	 	<td width= 5%><%=bdto.getProductnum()%></td> 
      	 	<td width= 20%><%=bdto.getProductname()%>  </td > 
      	 	<td width= 15%><%=bdto.getProductprice()%>  </td >  
      	 	<td width= 4%><%=bdto.getInkblack()%>  </td > 
      	 	<td width= 4%><%=bdto.getInkred()%>  </td > 
      	 	<td width= 4%><%=bdto.getInkblue()%>  </td > 
      	 	<td width= 4%><%=bdto.getInkgreen()%>  </td > 
      	 	<td width= 15%>+<%=bdto.getPackingprice()%></td>
      		<td width= 25%><%=bdto.getTotalprice()%>  </td >
        	<td width= 4%><input type="button" onclick="delete_(<%=bdto.getBasketnum() %>);" value="X"></td> 
      	</tr>
      <%}%>
   		
<%}%>
		</table>


			</div>


<script>
	function delete_(Basketnum){
		result=confirm("해당 상품을 삭제하시겠습니까?");
		 if(result==true){
			window.location="cartDeletePro.jsp?cartNum="+Basketnum;
		} 
	}

</script>


		<aside class="payment_fixed">
			<div class="all_cost">
				<p>총 결제금액</p>
			</div>
		
		
			<div class="cost_product"> 
    			<div class="cost_product_p">
    				상품금액
    			</div>
    			<div class="cost_product_won">
					<p>
<%
	basketDAO price=new basketDAO();
	int priceint = price.getProductPriceInfo(id);
	%>
	<%=priceint%>		
    	
    				원</p>
    			</div>
  			</div>
  				
  			<div class="cost_delivery">
    			<div class="cost_delivery_p">
    				배송료
    			</div>
    			<div class="cost_delivery_won">
    				<p>
	
<%
	//배송료 3000원, 10000원 이상 주문 시 배송료 무료;
	basketDAO delivery=new basketDAO(); 
	int deliveryprice=delivery.getProductPriceInfo(id);
	if(priceint<10000 & priceint>0){%>
		<%=deliveryprice=+3000%>
	<%}else{%>
		<%=deliveryprice=0%>
	<%}%>
	    
    					원</p>
    				</div>
  			</div>
  				
  			<div class="cost_all">
    			<div class="cost_all_p">총결제금액</div>
    			<div class="cost_all_won">
    				<p>
<%
	basketDAO totalprice=new basketDAO();
	int paytotalprice=totalprice.getProductPriceInfo(id);
	%>
	<%=priceint+deliveryprice%>
		    	
    	
    					원</p>
    			</div>
  			</div>
  	
  			
    		<div class="pay_button">
    			<div class="pay_request">
    				<input type="button" onclick="pay_request()" value="결제하기" />
		
									
<script>
function pay_request(){
	result=confirm("해당 상품이 맞으며, 결제를 진행하시겠습니까?");
		if(result==true){
			window.location="orderForm.jsp";

			}else{
			"self.close()";
			//window.location을 쓰지 않는다.
			//취소의 취소 창을 쓸 때 그냥 창만 닫아버리는 거라서 self.close()
				
		}
	}
		
</script>
    			</div>
    				
    			<div class="pay_cancel">
					<input type="button" onclick="pay_cancel()" value="취소하기" />
	
	
	<script>
		function pay_cancel(){
			result=confirm("결제를 취소하시겠습니까?");
			if(result==true){
				window.location="/pro2_1/productList/main.jsp";

			}else{
				"self.close()";
				//window.location을 쓰지 않는다.
				//취소의 취소 창을 쓸 때 그냥 창만 닫아버리는 거라서 self.close()
				
			}
		}
		
	</script>
		
				</div>
    	
  			</div>
	
			
		</aside>
		
	</div>
</body>
</html>



