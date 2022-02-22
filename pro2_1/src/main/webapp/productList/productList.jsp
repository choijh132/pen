<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="productList.ProductListDTO" %>
<%@ page import="productList.ProductListDAO" %>
<%@ page import="java.util.List" %>
<%@ include file="/productList/mainTop.jsp"%> 
<style>
	img.color{width: 15px;}
	table {margin:10 auto; border: 1px; border-coolapse:coolapse;}
</style>
<script>
	function priceCheck(){
		price1 = document.getElementById("price1").value;
		price2 = document.getElementById("price2").value;
		if(price1 > price2){
			alert("가격 검색을 확인해주세요");
			return false;
		}
	}
</script>
<% 
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");

	String category = request.getParameter("category");
	String code = request.getParameter("code");
	String price1 = request.getParameter("price1");
	String price2 = request.getParameter("price2");
	String order = request.getParameter("order");
	
	if (pageNum == null) {
	    pageNum = "1";
	}
	if (order == null || order=="null" ){
		order = "reviewcount";
	}
	if (category == null ){
		category = "null";
	}

	int trcount=0, totalCount=0;
	int pageSize=15;
	int pageHeight=0;
	int pMin =0, pMax=0;
	int currentPage = Integer.parseInt(pageNum);
    int startCount = (currentPage - 1) * pageSize + 1;
    int endCount = currentPage * pageSize;
	
	List<ProductListDTO> list = null;
	ProductListDAO dao = new ProductListDAO();
	
    if(price1 == "" || price1 == null || price1.equals("null")){
    	pMin = dao.getPriceMin();
    } else{
    	pMin = Integer.parseInt(price1);
    }
    
    if(price2 =="" || price2 == null || price2.equals("null")){
    	pMax = dao.getPriceMax();
    } else{
    	pMax = Integer.parseInt(price2);
    }
    
    list = dao.getProductList(category, code , order, pMin, pMax, startCount, endCount);
    
    if(list.size()/4 < 1){
		pageHeight = 450;
	} else {
		pageHeight = (list.size()/4)*300+150;
	}
	totalCount = dao.getProductListCount(category, code , order, pMin, pMax);
%>

<table border="0" width="1200" >
	<tr>
		<td width="100"></td>
		<td><a href="productList.jsp?pageNum=<%=pageNum%>&category=<%=category%>&code=<%=code%>&order=reviewcount&price1=<%=price1%>&price2=<%=price2%>">리뷰순</a></td>
		<td width="20"></td>
		<td><a href="productList.jsp?pageNum=<%=pageNum%>&category=<%=category%>&code=<%=code%>&order=salecount&price1=<%=price1%>&price2=<%=price2%>">판매순</a></td>
		<td width="400"></td>
		<td> 가격</td>
		<td>
		<form action="productList.jsp" onsubmit="return priceCheck()" >
			<input type="number" id="price1" name="price1" value=<%=price1 %>> - <input type="number" id="price2" name="price2" value=<%=price2 %>>
			<input type="hidden" name="paegNum" value=<%=pageNum %>>
			<input type="hidden" name="category" value=<%=category %>>
			<input type="hidden" name="code" value=<%=code %>>
			<input type="hidden" name="order" value=<%=order %>>
			
			 <input type="submit" value="검색">
		</form>
		</td> 
	</tr>
</table>

<table border="0" width="1200"  height=<%=pageHeight %>>
	<tr>
		<td width="100"></td>
		<td valign="top" align="left" >
		<table border="1" align="left">
		<% if( list.size()==0){ %>
			<tr><td>
			<h1>데이터를 찾을 수 없습니다. </h1>
			<a href="main.jsp">첫화면 돌아가기</a>
			</td>
		<%} %>
			<% for(ProductListDTO dto : list){ %>
				<% if(trcount >= 5){ %>
					</tr><tr> <% trcount = 0;} %>
				<td align="center" width="200" height="300" >
				<dl>
				<a href=/pro2_1/content/contentForm.jsp?productNum=<%=dto.getProductNum() %>&pageNum=<%=pageNum %>><img src="http://192.168.0.126:8080/pro2_1/productImg/<%=dto.getProductFileName() %>" width="180" height="150" id="linkImg"/></a>
				</dl>
				<dl>제품명 : <%= dto.getProductName() %></dl>
				<dl>
				<img src="/pro2_1/image/colorImage/black.png" class="color" /> 재고 <%=dto.getProductInkBlackStock() %> /
				<img src="/pro2_1/image/colorImage/red.png" class="color"/> 재고 <%=dto.getProductInkRedStock() %>
				</dl>
				<dl>
				<img src="/pro2_1/image/colorImage/green.png" class="color"/> 재고 <%=dto.getProductInkGreenStock() %> /
				<img src="/pro2_1/image/colorImage/blue.png" class="color" /> 재고 <%=dto.getProductInkBlueStock() %>
				</dl>				
				<dl>가격 : <%=dto.getProductPrice() %></dl>
				</td>
				<% trcount++; %>
				<%} %>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<% int pageCount=0;
				pageCount = totalCount / pageSize + ( totalCount % pageSize == 0 ? 0 : 1);
				int startPage = (int)((currentPage-1)/pageSize)*pageSize+1;
				int pageBlock = 10;
				int endPage = startPage + pageBlock-1;
				
				if(endPage>pageCount) endPage=pageCount;
				
				if (startPage > 10) {    %>
		        <a href="productList.jsp?pageNum=<%= startPage - 10 %>&category=<%=category%>&code=<%=code%>&order=<%=order%>&price1=<%=price1%>&price2=<%=price2%>">[이전]</a>
				<%}
				
				for(int i = startPage ; i <= endPage ; i++){%>
					    <a href="productList.jsp?pageNum=<%=i %>&category=<%=category%>&code=<%=code%>&order=<%=order%>&price1=<%=price1%>&price2=<%=price2%>">[<%=i %>]</a>
				
				<%}
		        if (endPage < pageCount) {  %>
  				<a href="productList.jsp?pageNum=<%= startPage + 10 %>&category=<%=category%>&code=<%=code%>&order=<%=order%>&price1=<%=price1%>&price2=<%=price2%>">[다음]</a>
				<%}%>
			</td> 
		</tr>
		<tr>
			<td style = "background-color:#f2d9d9; height: 30; " align="center" colspan="2" >
				<a href ="/pro2_1/product/companyInfo.jsp" style = "font-weight:bold; font-family:'돋움'; font-size:15px;"> 회사 소개 </a>
			</td>
		</tr>
</table>


