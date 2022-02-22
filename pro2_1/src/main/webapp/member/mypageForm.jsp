<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <h1>mypage.jsp</h1>
<%
	String id = (String)session.getAttribute("id");

	if(id == null){%>
	<a href="loginForm.jsp" >로그인</a>
	<a href="inputForm.jsp" >회원가입</a>
	<a href="findForm.jsp" >아이디찾기</a>
<%}else{%>
		
	<input type="button" value="주문내역" onclick=" window.location='mybuylistForm.jsp' " />
	<input type="button" value="적립금" onclick=" window.location='pointForm.jsp' " />
	<input type="button" value="탈퇴"    onclick=" window.location='deleteForm.jsp' " />
	<input type="button" value="정보수정"    onclick=" window.location='modifyForm.jsp' " />
			
<%}%>
  
 