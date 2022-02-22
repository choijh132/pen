<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<% 
	response.setStatus(HttpServletResponse.SC_OK);
	//페이지가 정상적으로 응답하는 페이지임을 지정
	
	//404 - 서버와 통신할 수 있지만 요청한 바를 찾을 수 없음.
%>

<html>

	<head>
		<title>404에러 페이지</title>
	</head>
	
	<body>
		<h1>404 ERROR</h1>
		<div style = "font-size:18; font-family:'돋움'; line-height:200%; letter-spacing : 2px;" >
		 	요청하신 페이지는 존재하지 않습니다.<br/>
		 	<a href= "history.go(-1)">이전페이지로 돌아가기</a> <br />
		 	<a href= "/pro2_1/productList/main.jsp">메인페이지 돌아가기</a>
		 </div>
	</body>

</html>