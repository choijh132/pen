<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1> Company Information </h1>
<br/>
<br/>

<a href="/pro2_1/productList/main.jsp"> 펜매니저 </a>
<br/>
<br/>



<section style=" padding : 0px 0px 0px 60px;">
	
	<label style = "font-size:15px; font-family:'굴림'; font-weight:bold; line-height:180%;">
		
		* 회사명 : penManager(펜매니저)<br/>
		* 사업자등록번호 : 111-11-11111<br/>
		* 통신판매업 : 제 0000 - 서울관악 - 0000호<br/>
		* 대표전화 : (02)000-0000, 팩스(02)000-0000<br/>
		* 주소: 서울특별시 관악구 남부순환로 1820 에그옐로우 14층 <br/>
		* 사업분야 : 필기구 쇼핑몰 운영<br/>
		* 웹사이트 : xxx.xxxxxxx.xxx<br/>
	
	</label>
</section>

<center>
	<br/>
	<br/>
	<div id="map" style="width:600px;height:400px;"></div>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e5ff97b1553dc6375f3c1eb6c0549b8f&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), 
		        level: 2 // 지도의 확대 레벨
		    };  
		
		
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('서울특별시 관악구 남부순환로 1820 에그옐로우 14층', function(result, status) {
		
		   
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		       
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		       
		        var infowindow = new kakao.maps.InfoWindow({
	            	content: '<div style="width:150px;text-align:center;padding:6px 0;">pen Manager</div>'

		        });
		        infowindow.open(map, marker);
		
		        
		        map.setCenter(coords);
		    } 
		});    
	</script>
	<br/>
	<br/>
</center>