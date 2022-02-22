<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="basket.basketDTO" %>
<%@ page import="basket.basketDAO" %>
<%@ page import="basket.memberDTO" %>
<%@ page import="basket.memberDAO" %>
<%@ page import="java.util.List" %>
<%@ include file="/productList/mainTop.jsp"%> 

<link href="reset.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet" type="text/css">
<jsp:useBean class="basket.memberDTO" id="memberdto"/>
<jsp:setProperty property="*" name="memberdto"/>

  <!-- jQuery -->
  	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
  	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>


<%
	memberDAO mdao=new memberDAO();
	memberDTO mdto=new memberDTO();
	mdto=mdao.getClientInfo(id);
%>


<html>
<body>
	
<form action="orderPro.jsp" method="post" name="form" >
	
	<div class="wrap_2">
		<div class="orderlist_title">
			<p>주문서</p>
		</div>
		
		<div class="orderlist_main">
			<div class="client">
				<div class="client_info">
					<div class="client_title">
						<p>주문고객정보</p>
					</div>
			
					<div class="client_name_and_phone">
						<div class="client_name">
							<p>성함</p>
							<input type="text" name="name" size="8" value="<%=mdto.getName()%>"/>
						</div>
				
						<div class="client_phone">
							<p>연락처</p>
							<input type="text" name="phone" size="15" value="<%=mdto.getPhone()%>"/>	
						</div>
					</div>
			
					<div class="client_email">
						<p>이메일 주소</p>
						<input type="text" id="receiveremail" name="receiveremail" size="12"/>
						@
						<input type="text" id="receiveremailsite" name="receiveremailsite" size="20"/>
					</div>
				</div>
		
		
				<div class="destination_info">
					<div class="destination_title">
						<p>배송지 정보</p>
					</div>
			
					<div class="receiver_name_and_phone">
						<div class="receiver_name">
							<p>받으시는 분</p>
								<input type="text" id="receivername" name="receivername" size="8" value="<%=mdto.getName()%>" />
						</div>
			
						<div class="receiver_phone">
							<p>연락처</p>
								<input type="text" id="receiverphone" name="receiverphone" size="15" value="<%=mdto.getPhone()%>"/>
						</div>
					</div>
			
					<div class="address">
						<p>주소</p>
							<input type="text" id="receiveraddress" name="receiveraddress" size="50" value="" disabled/><br />
							<input type="text" id="receiverdetailaddress" name="receiverdetailaddress" size="20" value="" disabled/>
							<input type="button" onclick="window.open('postalCode.jsp')" value="우편번호찾기" />
					</div>
		
			
					<div class="message">
						<p>배송 메시지</p>
						<select id="selbox" name="selbox">
							<option value="message1">부재시 경비실에 맡겨주세요.</option>
							<option value="message2">배송 시작 전 문자 남겨주세요.</option>
							<option value="message3">현관문 앞에 놓아주세요.</option>
						</select> 

					</div>
			
				</div>
		
	
					<div class="product_info">
						<div class="product_info_title">
							<p>상품 내역</p>
						</div>
		
						<table border="1">
							<tr>
								<th width= 5%>번호</th>
								<th width= 20%>제품명</th>
								<th width= 15%>가격</th>
								<th width= 4%>K</th>
								<th width= 4%>R</th>
								<th width= 4%>B</th>
								<th width= 4%>G</th>
								<th width= 10%>포장</th>
								<th width= 20%>합계</th>
							</tr>
		

<% 
   String productname="";
   String basketnum="";
   basketDAO dao=new basketDAO();
   List<basketDTO> list=dao.getBasketList(id);
   if(list.size() >= 1 ){
	   
      for(basketDTO bdto : list){
      productname=bdto.getProductname();
      basketnum=basketnum + "," + bdto.getBasketnum();
      %>
      	<tr>
      	 	<td width= 5%><%=bdto.getProductnum()%>  </td > 
      	 	<td width= 20%><%=bdto.getProductname()%>  </td > 
      	 	<td width= 15%><%=bdto.getProductprice()%>  </td >  
      	 	<td width= 4%><%=bdto.getInkblack()%>  </td > 
      	 	<td width= 4%><%=bdto.getInkred()%>  </td > 
      	 	<td width= 4%><%=bdto.getInkblue()%>  </td > 
      	 	<td width= 4%><%=bdto.getInkgreen()%>  </td > 
      	 	<td width= 15%>+<%=bdto.getPackingprice()%></td>
      		<td width= 15%><%=bdto.getTotalprice()%>  </td >
      	</tr>
      <%}%>
   		
<%}%>
						</table>

					</div>	
			</div>
	

  			<aside class="payment_fixed">
				<div class="all_cost">
					<p>총 결제금액</p>
				</div>
		
		
				<div class="cost_product"> 
    				<div class="cost_product_p">
    					<p>상품금액</p>
    				</div>
    				<div class="cost_product_won">
						<p>
<%
	basketDAO price=new basketDAO();
	int priceint=price.getProductPriceInfo(id);
	%>
	<%=priceint%>
    	
    					원</p>
    				</div>
  				</div>
  				
  				<div class="cost_delivery">
    				<div class="cost_delivery_p">
    					<p>배송료</p>
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
    				<div class="cost_all_p">
    					<p>총결제금액</p>
    				</div>
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
  	
<script>
	var IMP = window.IMP; 
    IMP.init("imp24884645"); 
</script>	

<script>
	function requestPay() {
		//var name= document.getElementById("receivername").value;
		  IMP.request_pay({
		    pg: "html5_inicis",
		    pay_method: "card",
		    merchant_uid: "<%=basketnum%>",
		    name: "<%=productname%>",
		    amount: "<%=priceint+deliveryprice%>",
		    buyer_email: document.getElementById("receiveremail").value+"@"+document.getElementById("receiveremailsite").value,
		    buyer_name: document.getElementById("receivername").value,
		    buyer_tel: document.getElementById("receiverphone").value,
		    buyer_addr: document.getElementById("receiveraddress").value+document.getElementById("receiverdetailaddress").value,
		    buyer_postcode: "01181"
		 }, function (rsp) { 
		    	console.log(rsp);
		    	 if (rsp.success) {
		              console.log("성공");
		              window.location='orderPro.jsp';
		        } else {
		              console.log("실패");
		      		  aleft("결제 실패 다시 확인해주세요");
		          }
		      });
		    }
</script>	
 	
    			<div class="pay_button">
    				<div class="pay_request">
    					<input type="button" onclick="requestPay()" value="결제하기" />
  	
    				</div>
    				
    				<div class="pay_cancel">
						<input type="button" onclick="pay_cancel()" value="취소하기" />
	
<script>
	function pay_cancel(){
		result=confirm("결제를 취소하시겠습니까?");
		if(result==true){
			document.form.submit("결제가 취소되었습니다.");
			window.location=("cartForm.jsp");

		}else{
			"self.close()";	
		}
	}
		
</script>
					</div>
    	
  				</div>
	
			</aside>
		</div>	

	</div>		
</form>
  
  

</body>
</html>