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
	String search = request.getParameter("search");
	
	if (pageNum == null) {
	    pageNum = "1";
	}
	
	if (order == null || order=="null" ){
		order = "reviewcount"; //초기순서 - 리뷰순
	}
	
	int trcount=0, totalCount=0;  //trcount -> 제품 줄 나누는 용도
	int pageSize=15; //한 페이지에 상품 출력될 개수
	int pageHeight=0; //페이지 높이 초기화
	int pMin =0, pMax=0; //가격 최소값, 최대값 초기화
	int currentPage = Integer.parseInt(pageNum); //페이지 번호
    int startCount = (currentPage - 1) * pageSize + 1;
    int endCount = currentPage * pageSize;
	
	List<ProductListDTO> list = null;
	ProductListDAO dao = new ProductListDAO();
    
    
    //검색 조건 null 일시 초기화
    if (pageNum == null) {
        pageNum = "1";
    }
    
	if (search == null || search=="null" ){
		search = "";
	}
	
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
    
    totalCount = dao.getTotalCount();
	list = dao.productListAll(order, startCount, endCount, pMin, pMax);
    
	//페이지 높이 설정
	if(list.size()/4 < 1){
		pageHeight = 450;
	} else {
		pageHeight = (list.size()/4)*300+150;
	}
%>

<table border="0" width="1200" >
	<tr>
		<td width="100"></td>
		<td><a href="main.jsp?pageNum=<%=pageNum%>&order=reviewcount&price1=<%=price1%>&price2=<%=price2%>">리뷰순</a></td>
		<td width="20"></td>
		<td><a href="main.jsp?pageNum=<%=pageNum%>&order=salecount&price1=<%=price1%>&price2=<%=price2%>">판매순</a></td>
		<td width="400"></td>
		<td> 가격</td>
		<td>
		<form action="productList.jsp" onsubmit="return priceCheck()">
			<input type="number" id="price1" name="price1" value=<%=price1 %>> - <input type="number" id="price2" name="price2" value=<%=price2 %>>
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
			<% for(ProductListDTO dto : list){ %>
				<% if(trcount >= 5){ %> <!-- 한줄에 출력할 상품 개수 : 5 -->
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
		        <a href="main.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
				<%}
				
				for(int i = startPage ; i <= endPage ; i++){%>
					<a href="main.jsp?pageNum=<%=i %>">[<%=i %>]</a>
				<%}
			    if (endPage < pageCount) {  %>
  				<a href="main.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
				<%}%>
			</td>
		</tr>
		<tr>
			<td style = "background-color:#f2d9d9; height: 30; " align="center" colspan="2" >
				<a href ="/pro2_1/product/companyInfo.jsp" style = "font-weight:bold; font-family:'돋움'; font-size:15px;"> 회사 소개 </a>
			</td>
		</tr>
</table>



