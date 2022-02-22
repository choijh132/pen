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
<style>
td {align-content: center}
</style>
<% 
	//관리자 아닐시 메인페이지이동
	if(!id.equals("admin") || !grade.equals("5")) {
		response.sendRedirect("/pro2_1/productList/main.jsp");
	}
	String pageNum = request.getParameter("pageNum");

	//날짜 함수
	Calendar date = Calendar.getInstance();
	int year = (int)date.get(Calendar.YEAR);
	int month = (int)date.get(Calendar.MONTH)+1;
	int day = (int)date.get(Calendar.DAY_OF_MONTH);
	
	date.set(year,month,0);
	int lastday = date.get(Calendar.DATE);
	
	String date_s = year + "-" + month +  "-01";
	String date_e = year + "-" + month +  "-" + lastday;
	
	if (pageNum == null) {
	    pageNum = "1";
	}

	int pageSize=10;
	int pageHeight=0;
	
	int currentPage = Integer.parseInt(pageNum);
    int startCount = (currentPage - 1) * pageSize + 1;
    int endCount = currentPage * pageSize;

    //금액 , 표기
    int saleResult = 0;
    DecimalFormat formatter = new DecimalFormat("###,###");
    
	List<SaleDTO> list = null;
	List<SaleDTO> productNameList = null;
	
	SaleDAO dao = new SaleDAO();
	
	saleResult = dao.getSaleResult();
    list = dao.getAllSale(startCount, endCount);
    productNameList = dao.getProductName();
    
	pageHeight = list.size()*50+100;
	int totalCount = dao.getTotalCount();
	
	//금액 한글표기
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
		<td>총 판매 금액 : ￦ <%=formatter.format(saleResult) %> [< <%=result %> 원>]</td>
	</tr>
	<tr>
		<td width="100"></td>
		<form action="saleListSearch.jsp" method="get" onsubmit="return dateCheck()">
		
		<td>상품 선택 : <select name="productname" id="productname" onchange="nameSelect()">
			<option value = "all">전체선택</option>
			<option value="input" >직접입력</option>
			<% for(SaleDTO dto : productNameList){ %>
			<option value="<%=dto.getProductName() %>">
			<%=dto.getProductName() %>
			</option>
			<%} %>
		    </select>
		    <input type="text" name="inputP" id="inputP" value="" readonly="readonly" placeholder="직접입력 선택" />
		일자 선택 : <input type="date" value=<%=date_s %> id="date_s" name="date_s"> - 
		<input type="date" value=<%= date_e %> id="date_e" name="date_e">
		<input type="submit" value="검색"/> 
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
				<td width="50">Black</td>
				<td width="50">Red</td>
				<td width="50">Blue</td>
				<td width="50">Green</td>
				<td width="100">총가격</td>
				<td width="100">구매일자</td>
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
		        <a href="saleList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
				<%}
				
				for(int i = startPage ; i <= endPage ; i++){%>
					    <a href="saleList.jsp?pageNum=<%=i %>">[<%=i %>]</a>
				
				<%}
		        if (endPage < pageCount) {  %>
  				<a href="saleList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
				<%}%>
			</td> 
		</tr>
</table>
