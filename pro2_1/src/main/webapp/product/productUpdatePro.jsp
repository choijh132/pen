<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %> 
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> 
<%@ page import = "java.io.File" %>
<%@ page import = "product.ProductDAO" %>
<%@ page import = "product.ProductDTO" %>
    
<h1> Product Update Pro </h1>

<% 
	request.setCharacterEncoding("UTF-8"); 

	String path = request.getRealPath("productImg");
	String enc = "UTF-8"; 
	int size = 1024*1024*10; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, size, enc, dp); 

	String pageNum = mr.getParameter("pageNum");
	String productNum = mr.getParameter("productNum");
	
	String productName = mr.getParameter("productName");
	String productBrand = mr.getParameter("productBrand");
	String productLGroup = mr.getParameter("productLGroup");
	String productSGroup = mr.getParameter("productSGroup");
	String productFileName = mr.getFilesystemName("productFileName");
	String productPrice = mr.getParameter("productPrice");
	String productOption = mr.getParameter("productOption");
	String inkBlackStock_s = mr.getParameter("inkBlackStock");
	String inkRedStock_s = mr.getParameter("inkRedStock");
	String inkBlueStock_s = mr.getParameter("inkBlueStock");
	String inkGreenStock_s = mr.getParameter("inkGreenStock");
	
	String org = mr.getParameter("org");
	
	
	
	int inkBlack;
	int inkRed;
	int inkBlue;
	int inkGreen;
	
	int inkBlackStock;
	int inkRedStock;
	int inkBlueStock;
	int inkGreenStock;
	
	if(inkBlackStock_s != null){
		inkBlack =  1;
		inkBlackStock = Integer.parseInt(inkBlackStock_s);
	} else { inkBlack = 0; inkBlackStock= 0;}
	if(inkRedStock_s != null){
		inkRed =  1;
		inkRedStock = Integer.parseInt(inkRedStock_s);
	} else { inkRed = 0; inkRedStock= 0;}
	if(inkBlueStock_s != null ){
		inkBlue =  1;
		inkBlueStock = Integer.parseInt(inkBlueStock_s);
	} else { inkBlue = 0; inkBlueStock= 0;}
	if(inkGreenStock_s != null){
		inkGreen =  1;
		inkGreenStock = Integer.parseInt(inkGreenStock_s);
	} else { inkGreen = 0; inkGreenStock= 0;}

	
	
	ProductDTO dto = new ProductDTO();
	
	dto.setProductNum(Integer.parseInt(productNum));
	dto.setProductName(productName);
	dto.setProductBrand(productBrand);
	dto.setProductLGroup(productLGroup);
	dto.setProductSGroup(productSGroup);
	dto.setProductFileName(productFileName);
	dto.setProductPrice(Integer.parseInt(productPrice));
	dto.setProductOption(productOption);
	dto.setInkBlack(inkBlack);
	dto.setInkBlackStock(inkBlackStock);
	dto.setInkRed(inkRed);
	dto.setInkRedStock(inkRedStock);
	dto.setInkBlue(inkBlue);
	dto.setInkBlueStock(inkBlueStock);
	dto.setInkGreen(inkGreen);
	dto.setInkGreenStock(inkGreenStock);
	

	if(productFileName == null){
		dto.setProductFileName(org);
	} else {
		dto.setProductFileName(productFileName);
	}
	
	ProductDAO dao = new ProductDAO();
	int result = dao.ProductUpdate(dto);
	
	if(result == 1){
		if(productFileName != null && org != null) {
			File f = new File(path+"//"+org);
			f.delete();
		}%>
		
		<script>
			alert("?????? ??????");
			window.location="productContent.jsp?productNum=<%=productNum%>&pageNum=<%=pageNum%>";
		</script>
	<%}

	
%>

