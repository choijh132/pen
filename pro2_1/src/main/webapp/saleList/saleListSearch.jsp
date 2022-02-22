<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="productSale.SaleDTO" %>
<%@ page import="productSale.SaleDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ include file="/productList/mainTop.jsp"%>
<script>
	function dateCheck(){
		date1 = document.getElementById("date_s").value;
		date2 = document.getElementById("date_e").value;
		if(date1 > date2){
			alert("날짜 조건 입력 오류");
			return false;
		}
	}
	
	var popupX = (document.body.offsetWidth / 2) - (500/2);
	var popupY = (window.screen.height /2) - (500/2);
	
	function openUserInfo(v){
		url = "idInfo.jsp?id="+v;
		open(url,"", "width=500,height=500,left="+popupX+",top="+popupY);
	}
	
	function openProductInfo(v){
		url = "productInfo.jsp?productNum="+v;
		open(url,"", "width=500,height=500,left="+popupX+",top="+popupY);
	}
	
	function nameSelect(){
		var prdouctname = document.getElementById("productname").value;
		if(prdouctname=="input"){
			document.getElementById("inputP").value="";
			document.getElementById("inputP").readOnly=false;
		} else if(prdouctname!="input"){
			document.getElementById("inputP").value=prdouctname;
			document.getElementById("inputP").readOnly=true;
		}
	}
</script>

<%
	if(!id.equals("admin") || !grade.equals("5")) {
		response.sendRedirect("/pro2_1/productList/main.jsp");
	}
	
	String pageNum = request.getParameter("pageNum");
	String productName = request.getParameter("productname");
	String inputP = request.getParameter("inputP");
	String date_s = request.getParameter("date_s");
	String date_e = request.getParameter("date_e");
	
	//날짜형식 yyyy-mm-dd -> yyyymmdd
	String regStart = date_s.substring(0,4) + date_s.substring(5,7) + date_s.substring(8,10);
	String regEnd = date_e.substring(0,4) + date_e.substring(5,7) + date_e.substring(8,10);
	
	if (pageNum == null) {
	    pageNum = "1";
	}

	int pageSize=10;
	int pageHeight=0;
	
	int currentPage = Integer.parseInt(pageNum);
    int startCount = (currentPage - 1) * pageSize + 1;
    int endCount = currentPage * pageSize;

    int saleResult = 0;
    DecimalFormat formatter = new DecimalFormat("###,###");
    
	List<SaleDTO> list = null;
	List<SaleDTO> productNameList = null;
	
	SaleDAO dao = new SaleDAO();
	
	saleResult = dao.getSaleResult(inputP,regStart,regEnd);
    list = dao.getSearchSale(inputP,regStart,regEnd, startCount, endCount);
    productNameList = dao.getProductName();
    
	pageHeight = list.size()*50+100;
	int totalCount = dao.getSearchCount(inputP,regStart,regEnd);
	
	String[] han1 = {"","일","이","삼","사","오","육","칠","팔","구"}; 
	String[] han2 = {"","십","백","천"}; 
	String[] han3 = {"","만","억","조","경"};
	
	String strSaleResult = String.valueOf(saleResult);
	StringBuffer result = new StringBuffer(); 
	int len = strSaleResult.length(); 
	int nowInt = 0;
			
	for(int i=len-1 ; i > 0; i--){ 
		nowInt = Integer.parseInt(String.valueOf(strSaleResult.charAt(len - i-1))); 
		if(nowInt > 0){ 
			result.append(han1[nowInt]);// 숫자 
			result.append(han2[i % 4]); // 십,백,천 
			} // 만,억,조,경(4단위) 
		if(i % 4 == 0){ 
			result.append(han3[i / 4 ]); // 천단위 
			result.append(" ");
		} 
	}
%>



<table border="0" width="1200"  height=<%=pageHeight %>>
	<tr>
		<td width="100"></td>
		<td>총 판매 금액 : ￦ <%=formatter.format(saleResult) %> [< <%=result %>  원>] (검색제품 : <%=inputP%> / 일자 : <%=date_s %> ~ <%=date_e %>)</td>
	</tr>
	<tr>
		<td width="100"></td>
		<form action="saleListSearch.jsp" method="get" onsubmit="return dateCheck()" >
		
		<td>상품 선택 : <select name="productname" name="productname" id="productname" onchange="nameSelect()" >
			<option value = "all" >전체선택</option>
			<% if(productName.equals("input")){%>
				<option value="input" selected="selected">직접입력</option>
			<%} else{%>
				<option value="input">직접입력</option>
			<%} %>
			<% for(SaleDTO dto : productNameList){ %>
				<%if(inputP.equals(dto.getProductName())) {%>
					<option selected="selected">
					<%=dto.getProductName() %>
					</option>
				<%} else{%>
					<option >
					<%=dto.getProductName() %>
					</option>
			<%}}%>
		    </select>
		    <% if(productName.equals("input")){%>
			    <input type="text" name="inputP" id="inputP" value="<%=inputP%>" />
			<%} else{%>
			    <input type="text" name="inputP" id="inputP" value="<%=inputP%>" readonly="readonly" />
			<%} %>
		일자 선택 : <input type="date" value=<%=date_s %> id="date_s" name="date_s"> - 
		<input type="date" value=<%= date_e %> id="date_e" name="date_e">
		<input type="submit" value="검색"/> 
		<a href="saleList.jsp"><input type="button" value="초기화"></a>
		</form>
		</td>
	</tr>
	<tr>
		<td></td>
		<td valign="top" align="left" >
		
		<table border="1">
			<tr align="center">
				<td width="50">판매번호</td>
				<td width="100">구매자 id</td>
				<td width="200">제품</td>
				<td width="100">제품가격</td>
				<td width="100">포장가격</td>
				<td width="100">inkBlack</td>
				<td width="100">inkRed</td>
				<td width="100">inkBlue</td>
				<td width="100">inkGreen</td>
				<td width="100">구매가격</td>
				<td width="200">구매일자</td>
			</tr>
<%-- 		<% if( list.size()==0){ %>
			<tr><td>
			<h1>판매된 정보가 없습니다.. </h1>
			<a href="main.jsp">첫화면 돌아가기</a>
			</td>
		<%} %> --%>
			<% for(SaleDTO dto : list){ %>
			<tr align="center">
				<td height="40"><%=dto.getPaymentNum() %></td>
				<td><a href="#openUserInfo()" onclick="openUserInfo('<%=dto.getId() %>');return false;"><%=dto.getId() %></a></td>
				<td><a href="#openProductInfo()" onclick="openProductInfo('<%=dto.getProductNum() %>');return false;"><%=dto.getProductName() %></a></td>
				<td><%=dto.getProductPrice() %></td>
				<td><%=dto.getPackingPrice() %></td>
				<td><%=dto.getInkBlack() %></td>
				<td><%=dto.getInkRed() %></td>
				<td><%=dto.getInkBlue() %></td>
				<td><%=dto.getInkGreen() %></td>
				<td><%=dto.getTotalPrice() %></td>
				<td><%=dto.getReg().substring(0,10) %></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<% int pageCount=0;
				pageCount = totalCount / pageSize + ( totalCount % pageSize == 0 ? 0 : 1);
				int startPage = (int)((currentPage-1)/pageSize)*pageSize+1;
				int pageBlock = 10;
				int endPage = startPage + 9;
				
				if(endPage>pageCount) endPage=pageCount;
				
				if (startPage > 10) {    %>
		        <a href="saleListSearch.jsp?pageNum=<%= startPage - 10 %>&productname=<%=productName %>&inputP=<%=inputP%>&date_s=<%=date_s%>&date_e=<%=date_e%>">[이전]</a>
				<%}
				
				for(int i = startPage ; i <= endPage ; i++){%>
					    <a href="saleListSearch.jsp?pageNum=<%=i %>&productname=<%=productName %>&inputP=<%=inputP%>&date_s=<%=date_s%>&date_e=<%=date_e%>">[<%=i %>]</a>
				
				<%}
		        if (endPage < pageCount) {  %>
  				<a href="saleListSearch.jsp?pageNum=<%= startPage + 10 %>&productname=<%=productName %>&inputP=<%=inputP%>&date_s=<%=date_s%>&date_e=<%=date_e%>">[다음]</a>
				<%}%>
			</td>
		</tr> 
</table>
