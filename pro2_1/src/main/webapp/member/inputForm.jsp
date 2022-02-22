<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberDTO" %>
<jsp:useBean class="member.MemberDTO" id="dto" />
<jsp:setProperty property="*" name="dto"/>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.ArrayList" %>

<script>
function idcheck(){
	var idcheck = /^(?=.*?[a-z])(?=.*?[0-9]).{8,20}$/;
	id = document.getElementsByName("id")[0].value;
	if(id.length<1 || id==null){
		alert("중복체크할 아이디를 입력하십시오");
		return false;
	}else if(false == idcheck.test(id)) {//test() 해당문자열이 포함되면 true반환
		alert('id는 8~20자, 숫자/소문자를 모두 포함해야 합니다.');
		return false;
	}
	var url = "idCheck.jsp?id=" + id;
	window.open(url, "get", "height = 100, width = 300");
	} 
//셀렉트문으로 디비에 아이디값 가져와서 비교
function check(){//유효성검사 위에서 return false를 반환 
	idv = document.getElementsByName("id")[0].value;
	pwv = document.getElementsByName("pw")[0].value;
	namev = document.getElementsByName("name")[0].value;
	addressv = document.getElementsByName("address")[0].value;
	emailv = document.getElementsByName("email")[0].value;//시간남으면 input 두개합쳐서 @따로 입력되도록
	phonev = document.getElementsByName("phone")[0].value;//시간남으면 phone 숫자만
	var idcheck = /^(?=.*?[a-z])(?=.*?[0-9]).{8,20}$/;
	var pwcheck = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,20}$/;
	var phonecheck = /^01([0-9])-?([0-9]{3,4})-?([0-9]{4})$/;
	var url = "idCheck.jsp?id=" + idv;
	if(idv==""){
		alert("아이디를입력하세요");
		return false;	
	}else if(false == idcheck.test(idv)) {//test() 해당문자열이 포함되면 true반환
		alert('id는 8~20자, 숫자/소문자를 모두 포함해야 합니다.');
		return false;
	}
	
	window.open(url, "get", "height = 180, width = 300");
	
	
	
	if(pwv==""){
		alert("비밀번호를입력하세요");
		return false;
	}else if(false === pwcheck.test(pwv)) {
		alert('비밀번호는 8~20자, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.');
		return false;
	}
	if(namev==""){
		alert("이름를입력하세요");
		return false;	
	}
	if(addressv==""){
		alert("주소를입력하세요");
		return false;	
	}
	if(emailv==""){
		alert("이메일를입력하세요");
		return false;	
	}
	if(phonev==""){
		alert("번호를입력하세요");
		return false;	
	}else if(!phonecheck.test(phonev)) {
		
		alert('양식에 맞게 입력해주세요');
		return false;
	}
	
	
	
	
}	
</script>


    
 <!DOCTYPE html>
<html>
<link href="inputForm.css" rel="stylesheet"   type="text/css">
    <head>
        <meta charset="UTF-8">
    </head>
	<body>
		<div class = "input-page">
		<div class="form">
			<form action="inputPro.jsp" method = "post" onsubmit="return check();">  
			 <h3>회원정보 입력</h3>
			
				<div id="content"><!--나중에css처리 -->
	
		    		<div class="input-box">
						<input type = "text" Placeholder = "id(8~20자 숫자/소문자)" id ="id" name= "id" class="int"  maxlength="20"  size="15" value="">	
		    		</div>
		    			<input type="button" value="중복확인" onclick="idcheck()" >
		    			<input type="hidden" name="idDuplication" value="idUncheck">
		    		<br/>
		    		<div class="input-box">
						<input type = "password" Placeholder = "pw(8~20자 숫자/대문자/소문자/특수문자)" id ="pw" name= "pw" class="int" maxlength="20" size="15" value="">
		    		</div>
		    		<br/>
		    		<div class="input-box">
							<input type = "text" Placeholder = "name" id ="name" name= "name" class="int" maxlength="20" size="15" value="">
		    		</div>
		    		<br/>
		    		<div class="input-box"> 
							<input type = "text" Placeholder = "address" id ="address" name= "address" class="int" maxlength=50 size="15" value="">
		    		</div>
		    		<br/>
		    		<div class="input-box">  	
							<input type = "text" Placeholder = "email" id ="email" name= "email" class="int" maxlength="40" size="15" value="">
		    		</div>
		    		<br/>
		    		<div class="input-box">
							<input type = "text" Placeholder = "phone ex)010-123-4567" id ="phone" name= "phone" class="int" maxlength="20" size="15" value="">	
		    		</div>
		    		<br/>
		    		
						 <input type="submit" value="가입하기" /> 
				
		   	 	</div>
		   </form>
	</div>
	</div>
</body>
</html>
	   