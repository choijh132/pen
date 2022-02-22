<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberDAO" %>    
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean class="member.MemberDTO" id="dto" />
<!--특정한 자바빈 파일을 사용한다고 명시할 때 사용  useBean 액션태그는 [ 클래스 빈이름 = new 클래스();] 와 동일한 의미를 갖는다. 즉, id 속성은 객체명, class 속성명은 클래스(패키지 포함 기술)를 의미하며 import가 포함되어 있다 -->
<jsp:setProperty property="*" name="dto"/>
<!-- useBean 액션태그로 생성한 자바빈 객체에 대해서 프로퍼티(필드)에 값을 설정하는 역할 , property 속성에 * 를 사용하면 프로퍼티와 동일한 이름의 파라미터를 이용하여 setter 메서드를 생성한 모든 프로퍼티(필드)에 대해 값을 설정  -->
<!-- id와 name 같게 -->
<%
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.memberUpdate(dto);
	if(result == 1){%>
		<script>
			alert("수정됨");
			window.location='/pro2_1/productList/main.jsp';
		</script>	
	<%}else{%>
		<script>
			alert("잘못된입력을확인하세요 확인하세요");
			history.go(-1);
		</script>	
<%}%>

