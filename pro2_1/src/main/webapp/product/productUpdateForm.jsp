<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "product.ProductDAO" %>
    
    
<h1> Product Update Form </h1>


<jsp:useBean class="product.ProductDTO" id ="dto"/>
<jsp:setProperty property = "productNum" name ="dto"/>


<%
	
	String pageNum = request.getParameter("pageNum");
	ProductDAO dao = new ProductDAO();
	dto = dao.getProductAdminContent(dto);
	
	
%>

<Script>
	function productKindChange(e){
		var ballpen = ["삼색", "단색", "캐릭터"];
		var fountainpen = ["켈리그라피", "선물용"];
		var sharp = ["캐릭터", "0.5mm", "0.7mm"];
		var pencil = ["어린이용","캐릭터","미술용"];
		var sel = ["대분류를 먼저 선택하세요"];
		var target = document.getElementById("productSGroup");
	
		
		if(e.value == "ballpen") var e = ballpen;
		else if(e.value == "fountainpen") var e = fountainpen;
		else if(e.value == "pencil") var e = pencil;
		else if(e.value == "sharp") var e = sharp;
		else if(e.value == "") var e = sel;
		
		target.options.length = 0;
		
		for (x in e){
			var opt = document.createElement("option");
			opt.value = e[x];
			opt.innerHTML = e[x];
			target.appendChild(opt);
		}
	}


</Script>



<body style="letter-spacing : 2px; font-size:18px; font-family:'돋움'; line-height:200%; font-weight:bold;">
	<br/>
	<br/>
	<div style="padding:0px 0px 0px 100px">
		
		<form action="productUpdatePro.jsp" method = "post" enctype = "multipart/form-data">
			<input type ="hidden" name = "productNum" value = "<%=dto.getProductNum() %>"/>
			<input type ="hidden" name = "pageNum" value = "<%=pageNum %>"/>
			
			상품 이미지 <br/>
			<%if(dto.getProductFileName() != null) {%>
				<img src="http://localhost:8080/pro2_1/productImg/<%=dto.getProductFileName() %>"/>
				<input type = "hidden" name = "org" value ="<%=dto.getProductFileName()%>"/> <%} 
			else {%>
				<img src="inkColorImg/noImg.png"width="300" height="300"/><%} %><br/>
				<input type = "file" name = "productFileName"/><br/>
			
			<br/>
			상품명 : <input type = "text" name = "productName" value = "<%=dto.getProductName() %>"/><br/>
			<br/>
			상품가격 : <input type = "number" name = "productPrice" value = "<%=dto.getProductPrice() %>"/><br/>
			<br/>
			
			브랜드명 : 
			<select class = "Brand" name="productBrand">
					<option value = "<%=dto.getProductBrand() %>"> <%=dto.getProductBrand() %> </option>
					<option value = "A"> A </option>
					<option value = "B"> B </option>
					<option value = "C"> C </option>
			</select>
			
			<div class = "productGroup_l">
				<label for ="LGroup">상품 대분류&nbsp;&nbsp;</label>
				<select class= "Group" name ="productLGroup" onchange="productKindChange(this)">
					<option valeu = "<%=dto.getProductBrand() %>"> <%=dto.getProductLGroup() %> </option>
					<option value = "ballpen">볼펜</option>
					<option value = "fountainpen">만년필</option>
					<option value = "sharp">샤프</option>
					<option value = "pencil">연필</option>
				</select>
			</div>
			
			<div class ="productGroup_s" >
				<label for ="SGroup">상품 소분류&nbsp;&nbsp;</label>
				<select class = "Group" id="productSGroup" name="productSGroup">
					<option value = "<%=dto.getProductSGroup()%>"><%=dto.getProductSGroup()%></option>
				</select>
			</div>
			<br/>
			
			상품옵션 : <label style ="color:red"><b>[<%=dto.getProductOption() %>]</b></label><br/>
				
				<label style="font-weight=normal">
					 물방울
					 <%String radioV = "dot";
					 if(radioV.equals(dto.getProductOption())){%>
					 <input type= "radio" name = "productOption" value = "dot" checked="checked"/>
					 <%} else{ %>
					 <input type= "radio" name = "productOption" value = "dot"/><%} %>
					 
					 줄무늬
					 <%radioV = "stripe";
					 if(radioV.equals(dto.getProductOption())){%>
					 <input type= "radio" name = "productOption" value = "stripe" checked="checked"/>
					 <%} else{ %>
					 <input type= "radio" name = "productOption" value = "stripe"/><%} %>
					 
					 단색
					 <%radioV = "solid";
					 if(radioV.equals(dto.getProductOption())){%>
					 <input type= "radio" name = "productOption" value = "solid" checked="checked"/>
					 <%} else{ %>
					 <input type= "radio" name = "productOption" value = "solid"/><%} %>
				</label>
			
			<br/>
			
			
			잉크색상 <br/>
			
			<img src="inkColorImg/blackCircleIcon.png" width="10" height="10">
			<label style ="color:black"> Black </label>
			<input type = "number" name = "inkBlackStock" value ="<%=dto.getInkBlackStock()%>"/> <br/>
			
			<img src="inkColorImg/RedCircleIcon.png" width="10" height="10">
			<label style ="color:red"> Red </label>
			<input type = "number" name = "inkRedStock" value ="<%=dto.getInkRedStock()%>"/> <br/>
			
			<img src="inkColorImg/blueCircleIcon.png" width="10" height="10">
			<label style ="color:blue"> Blue </label>
			<input type = "number" name = "inkBlueStock" value ="<%=dto.getInkBlueStock()%>"/> <br/>
			
			<img src="inkColorImg/GreenCircleIcon.png" width="10" height="10">
			<label style ="color:green"> Green </label>
			<input type = "number" name = "inkGreenStock" value ="<%=dto.getInkGreenStock()%>"/> <br/>
			
			<br/>
			<br/>
			
			<input type = "submit" value ="수 정" style="font-size:15px; border:true;  border-radius:8px;"/>
			<input type = "button" value = "취 소" style="font-size:15px; border:true;  border-radius:8px;"
				onclick = "history.go(-1)"/>
		</form>
	</div>
</body>