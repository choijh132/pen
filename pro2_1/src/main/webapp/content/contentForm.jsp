<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "product.ProductDAO" %> 
<%@ page import = "product.ProductDTO" %> 
<%@ page import = "contents.contentsDTO" %> 
<jsp:useBean class="contents.contentsDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />
<%@ page import="java.util.List" %>
<%@ page import="contents.contentsDAO" %>
<%@ page import="contents.ReviewDTO" %>
<%@ include file="/productList/mainTop.jsp"%>
<h2>상품 상세정보</h2>

<% 

	String pageNum = request.getParameter("pageNum");
	String viewStar = request.getParameter("viewStar");
	String proNum = request.getParameter("productNum");
	String reviewPage = request.getParameter("reviewPage");
	if(pageNum == null){  
		pageNum="1";
		
	//System.out.println("viewStar");
	
	}
	if(reviewPage==null || reviewPage.equals("null")) {
		reviewPage="1"; //페이지값 0이면 1로지정 
		
	}
	
	int productNum = Integer.parseInt(proNum);
	contentsDAO dao = new contentsDAO();
	dto= dao.getProductInfo(productNum);

%>
<%

String idv = (String)session.getAttribute("id");
//System.out.println(idv);

%>


<script>
	function priceSum() {
		var sum = 0;
		var blackStockV = document.getElementById("blackStock").value;
		var redStockV = document.getElementById("redStock").value;
		var blueStockV = document.getElementById("blueStock").value;
		var greenStockV = document.getElementById("greenStock").value;
		var price = <%=dto.getProductPrice()%>;

		var optionEx = document.getElementById("optionEx").value;
		

		//주문수량 기입 안할경우 알림창	
		if(blackStockV==""||redStockV==""||blueStockV==""||greenStockV==""){
			alert("초과수량입니다.재고수량을 확인해주세요.(블랙재고수량:<%=dto.getInkBlackStock()%>)");
			return false;
		}
		//재고수량보다 주문수량 오버 기입시 알림창
		if(blackStockV > <%=dto.getInkBlackStock() %>) {
			alert("초과수량입니다.재고수량을 확인해주세요.(블랙재고수량:<%=dto.getInkBlackStock()%>)");
			return false;
		}
		if(redStockV > <%=dto.getInkRedStock()%>) {
			alert("초과수량입니다. 재고수량을 확인해주세요.(레드재고수량:<%=dto.getInkRedStock()%>)");
			return false;
		}
		if(blueStockV > <%=dto.getInkBlueStock() %>) {
			alert("초과수량입니다. 재고수량을 확인해주세요.(블루재고수량:<%=dto.getInkBlueStock()%>)");
			return false;
		}						
		if(greenStockV > <%=dto.getInkGreenStock() %>) {
			alert("초과수량입니다. 재고수량을 확인해주세요.(그린재고수량:<%=dto.getInkGreenStock()%>)");
			return false;
		} 

		var nblackStockV = parseInt(blackStockV);
		var nredStockV = parseInt(redStockV);
		var nblueStockV = parseInt(blueStockV);
		var ngreenStockV = parseInt(greenStockV);
		var noptionEx = parseInt(optionEx);
			
		sum = ((nblackStockV +nredStockV + nblueStockV + ngreenStockV) * price)+noptionEx;
		//sum = 수량 + 옵션 + 가격 합산 
		
		document.getElementById("resultprice").innerHTML=sum;		
		document.getElementById("productPriceSum").value=sum;		
		
		}
	function insertCheck() {
		var optionEx = document.getElementById("optionEx").value;
		var idvv= document.getElementById("idv").value;
		if(optionEx =="NoneValue") {
			alert("포장방법을 선택해주세요.");
			return false;
		}
		if(idvv=="null") {
			alert("로그인 후 사용해주세요.");
			return false;
		}
	} 
</script>	
<table border="1">
	<tr>
		<td>
			<img src="http://192.168.0.126:8080/pro2_1/productImg/<%=dto.getProductFileName() %>"
			 width="340" height="300">
		</td>
		<td>
		<table border="1" style="height:300px; width:400px;">
				<tr align="center">
				<td>상품명</td>
				<td><%=dto.getProductName() %></td>
			</tr>
			<tr align="center">
				<td>판매가격</td>
				<td><%= dto.getProductPrice()%></td>
			</tr>
			<tr align="center">
				<td>옵션</td>
				<td><%= dto.getProductOption()%></td>
			</tr>
		<form action="contentPro.jsp" method="post" onsubmit="return insertCheck()">
			<tr align="center" rowspan="4" >
				<td >색상재고</td>
				<td><table border="1">
					<tr>
						<td>black 재고 <%=dto.getInkBlackStock() %></td>
						<td>주문수량 
						<label>
							<input type="number" id="blackStock" name="blackStock" min="0" max="<%=dto.getInkBlackStock() %>" placeholder="수량 입력">
								</label></td> 
					</tr>
				<tr>
				<td>red 재고 <%=dto.getInkRedStock() %></td>
				<td>주문수량 <label>
							<input type="number" id="redStock" name="redStock" min="0" max="<%=dto.getInkRedStock() %>" placeholder="수량 입력">
						</label></td> 
					</tr>
				<tr>
				<td>blue 재고 <%=dto.getInkBlueStock() %></td>
				<td>주문수량 <label>
						<input type="number" id="blueStock" name="blueStock" min="0" max="<%=dto.getInkBlueStock() %>" placeholder="수량 입력">
						</label></td> 
				</tr>
				<tr>
				<td>green 재고 <%=dto.getInkGreenStock() %></td>
				<td>주문수량 <label>
						<input type="number" id="greenStock" name="greenStock" min="0" max="<%=dto.getInkGreenStock() %>" placeholder="수량 입력">
						</label></td> 
				</tr>
				</table>
				<tr align="center">
					<td>포장</td>
						<td> <select class="option" id="optionEx" name="optionEx" onchange="priceSum()">
							<option value="NoneValue" id="NoneValue_" selected >---선택 옵션입니다.---</option>
							<option value="0" name="none">포장 필요없음</option>
							<option value="2000" name="plus2000">몰스킨 밴딩 케이스(파버카스텔 연필포함)(+2,000원)</option>
							<option value="1000" name="plus1000">리본 포장(+1,000원)</option>
						</select></td>
				</tr>
				<tr align="center">
				<td>최종가격</td>
				<td>
					<label id="resultprice" ></label>
				</td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<input type="hidden" id="idv" name="idv" value=<%=idv %> />
					<input type="hidden" id="productNum" name="productNum" value="<%=dto.getProductNum()%>"/>
					<input type="hidden" name="productName" id="productName" value="<%=dto.getProductName() %>" />			
					<input type="hidden" name="productPrice" id="productPrice" value="<%=dto.getProductPrice() %>" />			
					<input type="hidden" name="productPriceSum" id="productPriceSum"  />			
					<input type="hidden" name="productOption" id="productOption" value="<%=dto.getProductOption() %>" />			
					<input type="hidden" name="inkBlackStock" id="inkBlackStock" value="<%=dto.getInkBlackStock() %>" />			
					<input type="hidden" name="inkBlueStock" id="inkBlueStock" value="<%=dto.getInkBlueStock() %>" />			
					<input type="hidden" name="inkRedStock" id="inkRedStock" value="<%=dto.getInkRedStock() %>" />			
					<input type="hidden" name="inkGreenStock" id="inkGreenStock" value="<%=dto.getInkGreenStock() %>" />			
					<input type="hidden" name="optionEx" id="optionEx" />								
					<input type="submit" value="장바구니" />
				</form>
				</td>
			</tr>
		</table>
	</td>
	</tr>
</table>

<table border="1">
	<tr align="center">
		<td><h2>상품소개</h2></td>
	<tr align="center">
		<td><img src="http://m2m2com.godohosting.com/shop/Images/molskine/mol-size.jpg">
		</td>
	</tr>
</table>			

<table border="1">
	<form action="reviewPro.jsp" method="post" >

		<tr aling="center" >
			<input type="hidden" name="productNum" value="<%=dto.getProductNum() %>" />
			<input type="hidden" name="pageNum" value="<%=pageNum %>" />
			 
			<td>이름</td>
			<td><input type="text" name="name"></td>
			<td>평점</td>
			<td><input type="radio" name="star" value="1">★
				<input type="radio" name="star" value="2">★★
				<input type="radio" name="star" value="3">★★★
				<input type="radio" name="star" value="4">★★★★
				<input type="radio" name="star" value="5" checked>★★★★★
			</td>
		</tr>
		
		<tr>
			<td>내용</td>
			<td><input type="text" name="content"></td>
			<td><input type="submit" value="후기쓰기"></td>
		</tr>
	</form>
</table>
<table border="1"> <!-- 평점글 조회 -->
	<form action="contentForm.jsp" method="get" >
		<tr>
			<th><select name="viewStar">
					<option value="update" selected>최신순</option>
					<option value="9" >별점 높은순</option>
					<option value="0">별점 낮은순</option>
					<option value="1">★</option>
					<option value="2">★★</option>
					<option value="3">★★★</option>
					<option value="4">★★★★</option>
					<option value="5">★★★★★</option>
				
				
			</select>
				<input type="hidden" name="productNum" value="<%=productNum%>" />
				<input type="hidden" name="pageNum" value="<%=pageNum%>" />
				<input type="hidden" name="reviewPage" value="<%=reviewPage%>" />
				
				<input type="submit" value="평점글 조회">
		</th></tr>
	</form>

</table>

<table border="1">
	<tr align="center">
		<th width="80">이름 </th><th width="140">내용</th><th width="140">평점</th><th width="80">날짜</th>
<%
	//페이지 설정
	int pageSize =10;
	
	int currentPage = Integer.parseInt(reviewPage);
	int start = (currentPage-1) * pageSize +1;
	int end = currentPage * pageSize;
			
	int count =0;
				
%>
<%
	

if(viewStar == null || viewStar == "null"){
    viewStar = "update";
 }
 List<ReviewDTO> list = null;
 
 contentsDAO dao1 = new contentsDAO(); //객체생성
 
 if(viewStar.equals("update") || viewStar=="update" ) { //별값이 있으면  
    list=dao1.listReview(productNum, start, end); //값이 없으면 등록순으로 조회   
    count=dao1.getCount();
 }else{
    list=dao1.listReviewH(productNum, viewStar, start , end ); //별값으로 조회
    count=dao1.getCount(viewStar);
 }










/* 	List<ReviewDTO> list = null;
	
	if(viewStar != null) {
		list=dao.listReviewH(productNum, viewStar, start, end);
		count=dao.getCount(viewStar);
		
	}else{
		list=dao.listReview(productNum, start, end);
		count=dao.getCount();
		
	} */
	if(list.size()==0){


/* contentsDAO dao1 = new contentsDAO(); //객체생성
	if(viewStar!=null) { //별값이 있으면  
		list=dao1.listReviewH(productNum, viewStar, start , end ); //별값으로 조회
		count=dao1.getCount(viewStar);
	}else{
		list=dao1.listReview(productNum, start, end); //값이 없으면 등록순으로 조회	
		count=dao1.getCount();
	}
	if(list.size()==0) { //글이 없으면  
		*/	%> <tr>
			<td colspan="4">글이 없음</td>
		</tr>
	<%}else{ 
		for(ReviewDTO dto1 : list) { %>
		<tr>
			<td><%=dto1.getName() %></td>
			<td><%=dto1.getContent() %></td>
			<% if( dto1.getStar()==1){ %><td>★</td>
			<%}else if (dto1.getStar()==2){ %><td>★★</td>
			<%}else if(dto1.getStar()==3){%><td>★★★</td>
			<%}else if (dto1.getStar()==4){ %> <td>★★★★</td>
			<%} else{%><td>★★★★★</td>	
			<%} %>
			
			<td><%=dto1.getReg() %></td>
		</tr>
	<%}%>
	<% }%>
	<tr>
		<td colspan="4" align="center">
<%-- <%if(viewStar==null || viewStar.equals("null")) {
	viewStar="";
}
%>  --%>

 <% 
	//페이지 출력 카운트 조건
	if(count > 0 ){ //글수가 1개 이상일 경우
		int pageCount =  count / pageSize + 
				(count % pageSize == 0 ? 0 : 1);
		//count에서 pageSize를 나눈 나머지값이 0이면 0 아니면 1
		
		int startPage = (currentPage / 10) * 10 +1; //시작 페이지 
		int pageBlock = 10; //다섯개까지 출력
		int endPage = startPage + pageBlock-1;
		
		if(endPage > pageCount ) {
			endPage = pageCount;
		}
		
	 	if(startPage > 10 ) { %>
			<a href="contentForm.jsp?pageNum=<%=pageNum %>&reviewPage=<%=startPage-10%>&productNum=<%=productNum%>&viewStar=<%=viewStar%>">[이전]</a>
		<%}
		
		for(int i = startPage ; i <= endPage ; i++) {
			%> <a href="contentForm.jsp?pageNum=<%=pageNum %>&reviewPage=<%=i %>&productNum=<%=productNum%>&viewStar=<%=viewStar%>">[<%=i %>] </a>
			
		<%}
		if(endPage < pageCount ) { %>
		<a href="contentForm.jsp?pageNum=<%=pageNum %>&reviewPage=<%=startPage+10%>&productNum=<%=productNum%>&viewStar=<%=viewStar%>">[다음]</a>
	<%}
	}
%>		 
		</td>
	</tr>
</table>	
<input type="button" value="상품문의" onclick="window.location='/pro2_1/community/cs_customerList.jsp'" />
<input type="button" value="메인페이지 이동" onclick="window.location=window.location='/pro2_1/productList/main.jsp'" />

