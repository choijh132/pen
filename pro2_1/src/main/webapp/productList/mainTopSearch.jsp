<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
a {text-decoration:none;}
</style>
<!-- 네비 드랍다운 -->
<style>
	ul, li, ol {list-style:none; margin:0; padding:0;}
	
	ul.naviMenu {margin-left:110; }
	ul.naviMenu > li { display:inline-block; width:80px; margin-left:20; padding:5px 10px; background:#eee; border:1px solid #eee; text-align:center; position:relative; }
	ul.naviMenu> li:hover { background:#fff; }

	ul.naviMenu > li ul.submenu { display:none; position:absolute; top:30px; left:0; }
	ul.naviMenu > li:hover ul.submenu { display:block; }
	
	ul.naviMenu > li ul.submenu > li { display:inline-block; width:80px; padding:5px 10px; background:#eee; border:1px solid #eee; text-align:center; }
	ul.naviMenu > li ul.submenu > li:hover { background:#fff; }
	
	
	
	ul.naviMenu > li.com { display:inline-block; width:200px; margin-left:300px; padding:5px 10px; background:#eee; border:1px solid #eee; text-align:center; position:relative; }
	ul.naviMenu> li:hover { background:#fff; }

	ul.naviMenu > li.com ul.submenu { display:none; position:absolute; top:30px; left:0; }
	ul.naviMenu > li:hover ul.submenu { display:block; }
	
	ul.naviMenu > li.com ul.submenu > li { display:inline-block; width:200px; padding:5px 10px; background:#eee; border:1px solid #eee; text-align:center; }
	ul.naviMenu > li ul.submenu > li:hover { background:#fff; }
	
</style>

<body>
<% 
	String id = (String)session.getAttribute("id");
	String grade= String.valueOf(session.getAttribute("idGrade"));
    String productSearch = request.getParameter("search");
    
	int gradeNum=0;
	if(grade.equals(null) || grade.equals("null")){
		gradeNum = 1;
	} else {
		gradeNum = Integer.parseInt(grade);
	}
%>
    <table border="0" width="1200">
	<tr>
		<td rowspan="4" width="60%" height="100"><a href ="/pro2_1/productList/main.jsp">로고 펜마스터</a></td>
	</tr>
	<tr height = "40">
		<% if(id==null){%>
			<td width="100"><a href="/pro2_1/member/loginForm.jsp"> 로그인 </a></td>
			<td width="100"><a href="/pro2_1/member/inputForm.jsp"> 회원가입 </a></td>
		<%} else {%>
			<td width="100"><a href="/pro2_1/member/logout.jsp"> 로그아웃 </a></td>
			<td width="100"><a href="/pro2_1/member/mypageForm.jsp"> 내정보 </a></td>
			<td width="100"><a href="/pro2_1/cart/cartForm.jsp"> 장바구니 </a></td>
		<%} %>
	</tr>
	<% 
		if(gradeNum == 1){%>
		<tr height = "40">
			<td colspan="4" ></td>
		</tr>
		<%} else if(gradeNum==5) {%>
		<tr height = "40">
			<td colspan="2"><a href="/pro2_1/product/productAdminList.jsp">상품관리</a></td>
			<td><a href="/pro2_1/saleList/saleList.jsp">판매조회</a></td>
		</tr>
	<%} %>
	
		<form action="productListSearch.jsp" >
		<tr height = "40">
		<%if(productSearch=="" || productSearch ==null || productSearch.equals("null")){ %>
		<td colspan="3"><input type="text" name="search" size="50" value="" placeholder="제품명검색"></td>
		<%} else{ %>
		<td colspan="3"><input type="text" name="search" size="50" value="<%=productSearch%>"></td>
		<%} %>
		<td><input type="submit" value="검색"></td>
		</tr>
		</form>
</table>
<table border="0" width="1200" bgcolor="gray">
	<tr >
		<td width="1000">
		<div id="navi">
		<ul class="naviMenu">
			<li class="menu1">브랜드별
				<ul class="menu1 submenu">
					<li><a href="productList.jsp?category=productbrand&code=A">A브랜드</a></li>
					<li><a href="productList.jsp?category=productbrand&code=B">B브랜드</a></li>
					<li><a href="productList.jsp?category=productbrand&code=C">C브랜드</a></li>
				</ul>
			</li>
			<li class="menu2">종류별
				<ul class="menu2 submenu">
					<li><a href="productList.jsp?category=productlgroup&code=ballpen">볼펜</a></li>
					<li><a href="productList.jsp?category=productlgroup&code=fountainpen">만년필</a></li>
					<li><a href="productList.jsp?category=productlgroup&code=sharp">샤프</a></li>
					<li><a href="productList.jsp?category=productlgroup&code=pencil">연필</a></li>
				</ul>
			</li>
			<li class="menu3">색상별
				<ul class="menu3 submenu">
					<li><a href="productList.jsp?category=inkblackstock&code=">검정/black</a></li>
					<li><a href="productList.jsp?category=inkredstock&code=">빨강/red</a></li>
					<li><a href="productList.jsp?category=inkgreenstock&code=">초록/green</a></li>
					<li><a href="productList.jsp?category=inkbluestock&code=">파랑/blue</a></li>
				</ul>
			</li>
			<li class="com"> 
			커뮤니티
				<ul class="menu submenu">
					<li><a href="/pro2_1/community/noticeList.jsp">공지사항</a></li>
					<li><a href="/pro2_1/community/cs_customerList.jsp">1:1 문의</a></li>
				</ul>
			</li>
		</ul>
		</div>
		</td>
	</tr>
</table>
</body>
