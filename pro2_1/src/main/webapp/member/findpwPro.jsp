<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="member.SMTPAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page import="member.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean class="member.MemberDTO" id="dto" />
<jsp:setProperty property="*" name="dto"/>

<%
request.setCharacterEncoding("utf-8");

MemberDAO dao = MemberDAO.getInstance();
boolean result = dao.pwfind1(dto);


if(result == true){
	String subject ="펜마스터입니다";
	String from = "penmaster";
	String to = dto.getEmail();
	String Pw =dto.getPw();;
	Properties p = new Properties(); // 정보를 담을 객체
 
	p.put("mail.smtp.host","smtp.gmail.com"); 
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true"); 
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");

 
	try{
    	Authenticator auth = new SMTPAuthenticator();
    	Session ses = Session.getInstance(p, auth);
    	 
    	ses.setDebug(true);
    	MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체  
	
    	msg.setSubject(subject); //  제목 
	
   		
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);	
	
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람 
		
		msg.setContent("귀하의 비밀번호는"+Pw+"입니다", "text/html;charset=UTF-8"); // 내용
		Transport.send(msg); // 전송   

		} catch(Exception e){
		    e.printStackTrace();
		    return;
		} %>
	<script>
	alert("비밀번호가 이메일로 전송되었습니다");
	window.location='loginForm.jsp';
	</script>
<%} else {%> 

	<script>
	alert("전송 실패되었습니다 다시 확인해 주세요");
	window.location='findForm.jsp';
	</script>

<%}%>