<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="basket.basketDTO" %>
<%@ page import="basket.basketDAO" %>
<%@ page import="java.util.List" %>
<link href="reset.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet" type="text/css">

<html>
<body>
	<div id="wrap_3">
	
		<div class="content">
			<div class="ordercomplete_title">
				<p>결제가 완료되었습니다</p>
			</div>
			<div class="ordercomplete_subtitle">
				<p>마이 페이지에서 다시 한 번 확인하세요</p>
			</div>

			<div class="buttons">
				<center>
					<input type="button" onclick="window.location='/pro2_1/member/mypageForm.jsp'" value="마이페이지">	
					<input type="button" onclick="window.location='/pro2_1/productList/main.jsp'" value="홈으로">
				</center>
			</div>
		</div>
	
	
	
	</div>
</body>
</html>