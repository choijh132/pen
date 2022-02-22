<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>
function check(){//유효성검사 위에서 return false를 반환 
	idv = document.getElementsByName("id")[0].value;
	pwv = document.getElementsByName("pw")[0].value;
	if(idv==""){
		alert("아이디를입력하세요");
		return false;
			
		
	}
	if(pwv==""){
		alert("비밀번호를입력하세요");
		return false;
			
		
	}
}	
</script>


<html>
	<head>	
		<link href="adminloginForm.css" rel="stylesheet"   type="text/css">
	</head>
	<body>
		<div class = "login-page">
		<div class="form">
				<h1>ADMIN</h1>
				<h2>LOGIN</h2>		
				<form action="adminloginPro.jsp"  method="post" class="login-form" onsubmit="return check();">
					<div class="input-box">
						<input type="text" name="id" placeholder="아이디" />   <br />
					</div>
					<div class="input-box">	
						<input type="password" name="pw" placeholder="비밀번호" /> 
					</div>
						 <input type="submit" value="로그인" /><br />
				
				</form>
		
				
		</div>
		</div>
	</body>
</html>