<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
		<link href="findForm.css" rel="stylesheet"   type="text/css">
	</head>
	<body>
		<div class = "find-page">
	
			<div class="form">
			    <form action="findidPro.jsp" method="post" >
			    	<div class="input-box">
				 		<input type="text" name="name" placeholder="이름" /> <br />
				 		<input type="text" name="phone" placeholder="휴대폰 번호" /> 
				 	</div>
						<input type="submit" value="아이디찾기"  /> 
				</form>
				<form action="findpwPro.jsp" method="post" >
					<div class="input-box">
					 	<input type="text" name="id" placeholder="id" /> <br />
					 	<input type="text" name="email" placeholder="이메일" /> 
					 </div>
						<input type="submit" value="비밀번호찾기" /> 
				</form>
			</div>
		</div>
	</body>
</html>

 <!--아이디랑 이메일이 데이터베이스랑 일치시 이메일 발송  -->