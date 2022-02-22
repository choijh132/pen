<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1> Product Inform </h1>

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
		<form action = "productPro.jsp" method = "post" enctype="multipart/form-data">
			
			상품이름 : <input type = "text" name ="productName"/><br/><br/>
			브랜드명 : <select class = "Brand" name="productBrand">
				<option value = ""> 브랜드를 선택하세요 </option>
				<option value = "A"> A </option>
				<option value = "B"> B </option>
				<option value = "C"> C </option>
			</select>
			
			<br/>
			<br/>
			
			<div class = "productGroup_l">
				<label for ="LGroup">상품 대분류&nbsp;&nbsp;</label>
				<select class= "Group" name ="productLGroup" onchange="productKindChange(this)" style="font-size:16px;">
					<option value = ""> 대분류를 선택하세요 </option>
					<option value = "ballpen">볼펜</option>
					<option value = "fountainpen">만년필</option>
					<option value = "sharp">샤프</option>
					<option value = "pencil">연필</option>
				</select>
			</div>
			
			<br/>
			
			<div class ="productGroup_s">
				<label for ="SGroup">상품 소분류&nbsp;&nbsp;</label>
				<select class = "Group" id="productSGroup" name="productSGroup" style="font-size:16px;">
					<option>소분류를 선택하세요</option>
				</select>
			</div>
			
			<br/>
			
			상품이미지 : <input type ="file" name ="productFileName" height="20"/> <br/><br/>
			상품가격 : <input type= "number" name ="productPrice" value="0"/><br/><br/>
			상품옵션 : 	
				<label style="font-weight:normal;">
					물방울<input type= "radio" name = "productOption" value = "dot" checked/>
					줄무늬<input type= "radio" name = "productOption" value = "stripe"/>
					단색<input type= "radio" name = "productOption" value = "solid"/>
				</label>
			<br/><br/>
			
			잉크색상 <br/><br/>
			
			<img src="inkColorImg/blackCircleIcon.png" width="10">
			<label style ="color:black"> Black&nbsp; </label>
			<input type = "number" name = "inkBlackStock" value="0"/> <br/>
			
			<img src="inkColorImg/RedCircleIcon.png" width="10">
			<label style ="color:red"> Red&nbsp;&nbsp;&nbsp; </label>
			<input type = "number" name = "inkRedStock"  value="0"/> <br/>
			
			<img src="inkColorImg/blueCircleIcon.png" width="10">
			<label style ="color:blue"> Blue&nbsp;&nbsp;  </label>
			<input type = "number" name = "inkBlueStock"  value="0"/> <br/>
			
			<img src="inkColorImg/GreenCircleIcon.png" width="10">
			<label style ="color:green"> Green </label>
			<input type = "number" name = "inkGreenStock" value="0"/> <br/>
			
			<br>
			<br>
			
			<input type = "submit" value = "상품 등록" style="font-size:15px; border:true;  border-radius:8px;" />
			<input type = "button" value = "취 소" onclick="history.go(-1)" style="font-size:15px; border:true;  border-radius:8px;"/>
		</form>
	</div>
</body>







