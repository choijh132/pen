<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="basket.basketDAO" %>
<%@ page import="basket.basketDTO" %>

<%@ page import="basket.payDAO" %>
<%@ page import="basket.payDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="basket.memberDTO" %>
<%@ page import="basket.memberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %> 

<!-- 배송 정보 -->
		  
<% 
   String id = (String)session.getAttribute("id");
   int result = 0;
   basketDAO dao = new basketDAO();
   memberDAO mdao = new memberDAO();
   memberDTO mdto = new memberDTO();
   mdto=mdao.getClientInfo(id);
   List<basketDTO> list=dao.getBasketList(id);
   
   payDAO pdao=new payDAO();
   
   if(list.size() >= 1 ){
	   
      for(basketDTO bdto : list){
      	result = pdao.paymentDB(bdto,mdto,id);
      	
      }
     }
	if(result==1){
		response.sendRedirect("orderCompleteForm.jsp");
	}else{
		
	}
   
   %>
   
   
   




    