<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "product.ProductDTO"%>
<%@ page import = "product.ProductDAO"%>
<%@ page import = "java.util.List" %>
<h1 style="font-family:'Arial Black'; letter-spacing:2px;"> Product Admin List </h1>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("id");
	
	String grade= String.valueOf(session.getAttribute("idGrade"));
	
	int gradeNum=0;
	if(grade.equals(null) || grade.equals("null")){
		gradeNum = 1;
	} else {
		gradeNum = Integer.parseInt(grade);
	}
	
	/*
	if(!id.equals("admin") || gradeNum != 5) {
		System.out.println("sadf");
		response.sendRedirect("/pro2_1/productList/main.jsp");
	}
	*/

	String colum = request.getParameter("colum");
	String search = request.getParameter("search");


	int pageSize = 10; 

	String pageNum = request.getParameter("pageNum");

	
	if(pageNum == null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage-1) * pageSize+1;
	int end = currentPage * pageSize;

	ProductDAO dao = new ProductDAO();
	
	//초기화
	int count = 0;
	List<ProductDTO> list = null;

	if(search == null){
		count = dao.getProductCount(); 
		if(count > 0){
			list =  dao.getProductAllList(start, end);
		}
	} else{
		count = dao.getProductSearchCount(colum, search);
		if(count > 0){
			list = dao.getProductSearchList(colum, search, start, end);
		}
	}
%>



<br/>
<br/>

<a href="/pro2_1/productList/main.jsp"> 펜매니저 </a>
<br/>
<br/>


<div style="padding: 0px 0px 0px 80px;">
	<input type ="button" value ="상품 추가" onclick="window.location='productInform.jsp'" style="font-size:15px; border:true;  border-radius:8px;"/>
	<br/>
	<br/>
	 	
	 	<form action="productAdminList.jsp" method="post">
			<select name = "colum">
				<option value = "productName">상품이름</option>
				<option value = "productBrand">상품브랜드</option>
				<option value = "productNum">상품번호</option>
			</select>
			<input type ="text" name="search" />
			<input type ="submit" value="검색"/>
		</form> 
		
	 
	<table width="70%" style="font-family:'돋움'">
		<tr height = "100" style= "font-size: 12px">
			<th>상품번호</th> <th>브랜드명</th> <th>상품이름</th>  <th>분류</th>  <th>가격</th> <th>이미지 </th>
		</tr>
		
		<% if (count == 0){%>
			<tr style = "font-size:30px; text-align: center; font-weight:bold; letter-spacing:5px" >
				<td colspan = "6"> 
					등록된 상품이 없습니다. <br/>
					<a href="productAdminList.jsp">목록으로 새로고침</a>
				</td>
			</tr>
		<% }else{
			
			for( ProductDTO dto : list ){
			%>
			
			<tr height = "80" style = "font-size:21px">
				
				<td width ="30"><%=dto.getProductNum()%></td>
				<td width = "30"><%=dto.getProductBrand() %></td>
				<td width ="130"><a href = "productContent.jsp?productNum=<%=dto.getProductNum()%>&pageNum=<%=pageNum%>"><%=dto.getProductName() %></a></td>
				<td width ="80" ><%=dto.getProductLGroup()%> : <%=dto.getProductSGroup() %></td>
				<td width ="80"><%=dto.getProductPrice() %></td>
			
				<td width ="230">
					<%if(dto.getProductFileName() == null) {%>
						<a href = "productContent.jsp?productNum=<%=dto.getProductNum()%>&pageNum=<%=pageNum%>">
							<img src="inkColorImg/noImg.png" width="100" height="100">
						</a>
					<%} else{%> 
						<a href = "productContent.jsp?productNum=<%=dto.getProductNum()%>&pageNum=<%=pageNum%>">
							<img src="http://192.168.0.126:8080/pro2_1/productImg/<%=dto.getProductFileName() %>" width="100" height="100">
						</a>
					<%} %>
				</td>
				
			</tr>
			<%}
		
		}
		%>
	</table>

</div>

<center>
	<%
		
		if(count > 0){
			
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1) ;
			
			//System.out.println(pageCount); //콘솔창에 나오는 숫자로 값을 확인한다.
			
			
			int startPage = (currentPage/10) * 10+1;
			int pageBlock = 10; //옮겨질 목록페이지 번호가 몇번까지 나올지에 대한 크기
			int endPage = startPage + pageBlock -1;
			
				if (endPage > pageCount){
					endPage = pageCount;
				}
			
			
				if(startPage>10){%>
					<a href="productAdminList.jsp?pageNum=<%=startPage-10%>">[이전]</a>
					
				<%}
			
			
				for(int i = startPage ; i<= endPage; i++){ %>
				
					 <a href = "productAdminList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
				
				<%}
			
			if(endPage < pageCount){%>
			<a href ="productAdminList.jsp?pageNum=<%=startPage +10%>">[다음]</a>
		<%}
		}
	%>
</center>
<br/>
<br/>






