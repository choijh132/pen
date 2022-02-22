<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	response.setStatus(HttpServletResponse.SC_OK);
	//페이지가 정상적으로 응답하는 페이지임을 지정
	
	//500-내부 서버 오류
%>

<html>

	<head>
		<title>500에러 페이지</title>
	</head>
	
	<body>
		<h1>500 ERROR</h1>
		<div style = "font-size:18; font-family:'돋움'; line-height:200%; letter-spacing : 2px;"">
			서비스 사용에 불편을 끼쳐드려서 대단히 죄송합니다.<br/>
	  	 	빠른시간내에 문제를 처리하겠습니다.<br/>
	  	 	<a href= "history.go(-1)">이전페이지로 돌아가기</a> <br />
	  	 	<a href= "/pro2_1/productList/main.jsp">메인페이지 돌아가기</a>
  	 	</div>
	</body>

</html>