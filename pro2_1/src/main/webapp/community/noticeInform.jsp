<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1>Community Notice Inform</h1>

<body style="letter-spacing : 2px; font-size:18px; font-family:'돋움'; line-height:200%; font-weight:bold;">
	<div style="padding:0px 0px 0px 100px">
		<form action = "noticePro.jsp" method = "post" enctype="multipart/form-data">
			
			제목 : <input type ="text" name ="noticeSubject"/><br/>
			첨부파일 : <input type = "file" name = "noticeFileName"/><br/>
			
			내용<br/>
			<textarea cols="50" rows="10" placeholder = "내용을 입력하세요." name ="noticeContent" wrap="hard"></textarea>
			
			<input type ="submit" value="등 록" style="font-size:15px; border:true;  border-radius:8px;" />
			<input type = "button" value = "취 소" onclick="history.go(-1)" style="font-size:15px; border:true;  border-radius:8px;"/>
		</form>
	</div>
</body>





