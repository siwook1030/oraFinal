<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
*{
	margin: 0px;
	padding: 0px;
}
#foodBox{
	border: solid 1px red;
	width: 800px;
	height: 500px;
}
#foodInfo{
	border: solid 1px red;
	float:left;
	height: 250px;
	width: 250px;
}
#foodInfo table{
	height: 200px;
	width: 100%;
	padding-left : 2px;
	border-spacing: 10px 0 10px 0;
	font-size: 80%;
}
#map{
	border: solid 1px red;
	width: 545px;
}
#foodPhoto{
	border: solid 1px red;
	height: 250px;
	background-image: url("img/bike.png");
	background-repeat: repeat;
}
#foodPhotoBox{
	border: solid 1px red;
	height: 200px;
	width: 230px;
	display: inline-table;
	
}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=services"></script>
<script>
window.onload = function(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	var foodSrc = '/detailFoodImg/foodLoc.png', // 음식점 마커이미지의 주소입니다    
		foodSize = new kakao.maps.Size(30, 25); // 음식점 마커이미지의 크기입니다 

	//음식점 마커 이미지를 생성합니다
	var foodImage = new kakao.maps.MarkerImage(foodSrc, foodSize);
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${f.food_addr}', function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            image:foodImage
	        });
	
	        // 인포윈도우로 음식점에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="padding:5px 0 5px 0;width:150px;text-align: center;font-weight: bold;">${f.food_name}</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	}); 
	
	var startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
		startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
		startOption = { 
		offset: new kakao.maps.Point(15, 43) // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
		};
	//출발 마커 이미지를 생성합니다
	var startImage = new kakao.maps.MarkerImage(startSrc, startSize, startOption);
	
	var arriveSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
		arriveSize = new kakao.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
		arriveOption = { 
		offset: new kakao.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
		};
	//도착 마커 이미지를 생성합니다
	var arriveImage = new kakao.maps.MarkerImage(arriveSrc, arriveSize, arriveOption);
	
	//코스 출발 마커가 표시될 위치입니다 
	var startPosition = new kakao.maps.LatLng(${c.c_s_latitude}, ${c.c_s_longitude}); 
	//코스 출발 마커를 생성합니다
	var startMarker = new kakao.maps.Marker({
			map: map, // 출발 마커가 지도 위에 표시되도록 설정합니다
			position: startPosition,
			image: startImage // 출발 마커이미지를 설정합니다
		});


	//코스 도착 마커가 표시될 위치입니다 
	var arrivePosition = new kakao.maps.LatLng(${c.c_e_latitude}, ${c.c_e_longitude});  
	//코스 도착 마커를 생성합니다 
	var arriveMarker = new kakao.maps.Marker({  
			map: map, // 도착 마커가 지도 위에 표시되도록 설정합니다
			position: arrivePosition,
			image: arriveImage // 도착 마커이미지를 설정합니다
		});
	
	new kakao.maps.Polyline({    //코스라인을 그립니다
	    map: map,
	    path: eval(${c.c_line}),
	    strokeWeight: 5,
	    strokeColor: '#FF2400',
	    strokeOpacity: 0.9,
	    strokeStyle: 'solid'
	});

}
</script>
</head>
<body>
<div id="foodBox">
<div id="foodInfo">
<table>
	<tr><td style="text-align: center;"><h1>${f.food_name }</h1></td></tr>
	<tr><td><img src="/detailFoodImg/foodtag.png"> ${f.food_tag }</td></tr>
	<tr><td><img src="/detailFoodImg/foodtel.png"> ${f.food_tel }</td></tr>
	<tr><td><img src="/detailFoodImg/foodaddr.png"> ${f.food_addr }</td></tr>
	<tr><td><img src="/detailFoodImg/foodtime.png"> ${f.food_bhours }</td></tr>
</table>
</div>
<div id="map" style="height:250px;"></div>
<div id="foodPhoto">
	<c:forEach  var="fp" items="${f.food_photo }">
		<a href="/food/${fp.fp_name}" target="_blank"><div id="foodPhotoBox" style="background-image: url('/food/${fp.fp_name}'); background-size: cover;"></div></a>
	</c:forEach>
</div>
</div>
</body>
</html>