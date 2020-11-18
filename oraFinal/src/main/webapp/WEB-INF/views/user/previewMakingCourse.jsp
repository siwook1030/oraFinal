<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
      * {
      margin: 0px;
      padding: 0px;
   }
   header {
      width: 1000px;
      height: 100px;
      margin-top: 10px;
      font-family: 'NEXON Lv1 Gothic Low OTF';
      border: solid 1px red;
       margin: 0 auto;
   }
   #logo {
       float: left; 
   }
   #top {
      margin: 30px 20px 0px 0;
      font-size: 12px;
      float: right;
      text-align: right;   
   }
   #login {
      font-size: 11px;
      text-align: right;
   }
   /*매인섹션부분css------------ ----------------*/
   section {
    margin: 0 auto;
	   	width: 1000px;
	   	font-family: 'NEXON Lv1 Gothic Low OTF';
	   	border: solid 1px white;
   }
   #detailTitle{
   		margin : 30px 0 30px 0;
   }
   #mainPhoto{
    	height : 400px;
    	border: solid 1px white;
    	word-break:break-all;
   }
   #mpTtitle{
   		background-color: #c8572d; 
   		text-align : center;
    	padding : 20px 0 20px 0;
    	opacity: 0.5;
    	margin-top: 170px;
   }
   #mainPhoto h2{
    	color: white;
    	font-size : 200%;
    	font-weight: bold;
   }
   
   #courseInfo{
   		text-align : center;
   		margin-top : 50px;
   		width: 80%;
   }
   #courseInfo table{
   		margin-left: 100px;
   		border-collapse: collapse;
   }
   #coursePhotoBox{
   	padding: 0 100px 0 100px;
   }
   #coursePhoto{
		width: 30%;
		height : 200px;
		background-size: cover;
		display: inline-table;
		margin: 5px 5px 5px 5px;
		
	}
	#transportS{
		border: solid 1px white;
		width: 70%;
		height: 300px;
		margin-left: 150px;
		margin-top: 50px;
	}
	#transportE{
		border: solid 1px white;
		width: 70%;
		height: 300px;
		margin-left: 150px;
		margin-top: 50px;

	}
	#addInfo{
		border: solid 1px white;
		width: 70%;
		height: 300px;
		margin-left: 150px;
		margin-top: 50px;
	}
	#addInfoTitle{
		font-size: 120%;
		color: gray;
	}
	#foodBox{
		display: inline-table;
		border: solid 1px white;
		width: 30%;
		height: 200px;
		margin: 10px 5px 10px 5px;
		word-break:break-all;
	}
 	
 	#foodBoxName{
 		background-color: black; 
 		padding: 5px 0 5px 0;
   		text-align : center;
    	opacity: 0.5;
    	margin-top: 80px;
    	font-size: 130%;
 	}
 	#foodBoxName span{
 		color: white;
 		
 	}
	
   /*메인섹션 끝css--------------------------*/
   footer {
       width: 1000px;
       height: 150px;
        margin: 30px auto;
       font-family: 'NEXON Lv1 Gothic Low OTF';
       border: solid 1px green;
      }
    #footer_box {
       width: 1000px;
       height: 150px;
       margin: 0 auto;
       text-align: center;
      
    }
    #footer_icon{
       margin: 0 auto;
      
    }
    #address {
       margin: 10px 0 0 0;
       font-size: 11px;
    }

   /*float 초기화 아이디*/
   #clear{
   	clear: both; 
   }
   /*파일업로드관련 css*/
     drag-over { background-color: #ff0; }
	.thumb { width:100px; height:100px; padding:5px; float:left; }
	.thumb > img { width:100%; height: 100%; }
	.thumb > .close { position:absolute; background-color:red; cursor:pointer; }
</style>
    <style>
.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap {position:relative;width:100%;height:500px;}
#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
#category li.on {background: #eee;}
#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
#category li:last-child{margin-right:0;border-right:0;}
#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
#category li .category_bg {background:url("/detailCourseImg/cc.png")no-repeat;}
#category li .hospital {background-position: -10px 0;}
#category li .hotel {background-position: -10px -36px;}
#category li .sights {background-position: -10px -72px;}
#category li .cafe {background-position: -10px -108px;}
#category li .food {background-position: -10px -144px;}
#category li .store {background-position: -10px -180px;}
#category li.on .category_bg {background-position-x:-46px;}
.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.placeinfo .tel {color:#0f7833;}
.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
</style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=services"></script>
<script type="text/javascript">
window.onload = function(){
	
	// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
	const placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
	    contentNode = document.createElement('div'); // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
	let markers = [], // 마커를 담을 배열입니다
	    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
	 
	const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
		center: new kakao.maps.LatLng(37.521512492203875,126.9762782994552),
		level: 7// 지도의 확대 레벨
	    };  
		
	// 지도를 생성합니다    
	const map = new kakao.maps.Map(mapContainer, mapOption); 
	const mapTypeControl = new kakao.maps.MapTypeControl();
	const zoomControl = new kakao.maps.ZoomControl();
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	// 장소 검색 객체를 생성합니다
	const ps = new kakao.maps.services.Places(map); 

	// 지도에 idle 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'idle', searchPlaces);

	// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
	contentNode.className = 'placeinfo_wrap';

	// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
	// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
	addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
	addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

	// 커스텀 오버레이 컨텐츠를 설정합니다
	placeOverlay.setContent(contentNode);  

	// 각 카테고리에 클릭 이벤트를 등록합니다
	addCategoryClickEvent();

	// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
	function addEventHandle(target, type, callback) {
	    if (target.addEventListener) {
	        target.addEventListener(type, callback);
	    } else {
	        target.attachEvent('on' + type, callback);
	    }
	}

	// 카테고리 검색을 요청하는 함수입니다
	function searchPlaces() {
	    if (!currCategory) {
	        return;
	    }		    
	    // 커스텀 오버레이를 숨깁니다 
	    placeOverlay.setMap(null);
	    
		
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true});
	
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
	        displayPlaces(data);
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
	        alert("해당지역에 검색결과가 없습니다");
	        changeCategoryClass();
	        removeMarker();
	        currCategory = '';

	    } else if (status === kakao.maps.services.Status.ERROR) {
	        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
	    	 alert("해당지역에 검색결과가 없습니다");
		     changeCategoryClass();
		     removeMarker();
		     currCategory = '';
	    }
	}

	// 지도에 마커를 표출하는 함수입니다
	function displayPlaces(places) {

	    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
	    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
	    const order = document.getElementById(currCategory).getAttribute('data-order');   

	    for ( let i=0; i<places.length; i++ ) {

	            // 마커를 생성하고 지도에 표시합니다
	            const marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

	            // 마커와 검색결과 항목을 클릭 했을 때
	            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
	            (function(marker, place) {
	                kakao.maps.event.addListener(marker, 'click', function() {
	                    displayPlaceInfo(place);
	                });
	            })(marker, places[i]);
	    }
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, order) {
		const imageSrc = '/detailCourseImg/cc.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });

	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( let i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
	function displayPlaceInfo (place) {
	    let content = '<div class="placeinfo">' +
	                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   

	    if (place.road_address_name) {
	        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
	                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
	    }  
	    else {
	        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
	    }                
	   
	    content += '    <span class="tel">' + place.phone + '</span>' + 
	                '</div>' + 
	                '<div class="after"></div>';

	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
	    placeOverlay.setMap(map);  
	}


	// 각 카테고리에 클릭 이벤트를 등록합니다
	function addCategoryClickEvent() {
		const category = document.getElementById('category'),
	        children = category.children;

	    for (let i=0; i<children.length; i++) {
	        children[i].onclick = onClickCategory;
	    }
	}

	// 카테고리를 클릭했을 때 호출되는 함수입니다
	function onClickCategory() {
		const id = this.id,
	        className = this.className;

	    placeOverlay.setMap(null);

	    if (className === 'on') {
	        currCategory = '';
	        changeCategoryClass();
	        removeMarker();
	    } 
	    else {
	        currCategory = id;
	        changeCategoryClass(this);
	        searchPlaces();
	    }
	}

	// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
	function changeCategoryClass(el) {
		const category = document.getElementById('category'),
	        children = category.children;

	    for (let i=0; i<children.length; i++ ) {
	        children[i].className = '';
	    }

	    if (el) {
	        el.className = 'on';
	    } 
	}
	///////////////////////////////////////
	// 폴리라인 셋할곳
	const cPoly =  new kakao.maps.Polyline({
		    map: map,
		    path:[],
		    strokeWeight: 6,
		    strokeColor: '#FF2400',
		    strokeOpacity: 0.8,
		    strokeStyle: 'solid'
	});

	const courseBounds = new kakao.maps.LatLngBounds(); 
	
	const cJson =${cJson};

	const preStartLatLng = new kakao.maps.LatLng(cJson.c_s_latitude, cJson.c_s_longitude);
	const preArriveLatLng = new kakao.maps.LatLng(cJson.c_e_latitude, cJson.c_e_longitude);
	
	const cLineObj = JSON.parse(cJson.c_line);
	const courseLine = eval(cLineObj.courseLine);
	const altitudeData = eval(cLineObj.altitudeData);
	
	cPoly.setPath(courseLine);
	courseLine.forEach(function(c, i) {
		courseBounds.extend(c);
	});
		
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawAltitude); 
	
	///////--------------------- 고도 차트
	   function drawAltitude() {
        const data = google.visualization.arrayToDataTable(altitudeData);

        const options = {
          title: '자전거코스 고도(m)',
          hAxis: {title: '거리(km)',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };

        const chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
	   
	document.getElementById("cBound").addEventListener("click", function(e) {
		setBound(map, courseBounds);
	});
	function setBound(m,bounds){  // 바운드설정함수
		if(!bounds.isEmpty()){
			m.setBounds(bounds);
		}

	}
	setBound(map, courseBounds); 
	
	////////////////////////////////////////
	const startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
	startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
	startOption = {offset: new kakao.maps.Point(15, 43)}; // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	
	//출발 마커 이미지를 생성합니다
	const startImage = new kakao.maps.MarkerImage(startSrc, startSize, startOption);

	const arriveSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
	arriveSize = new kakao.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
	arriveOption = {offset: new kakao.maps.Point(15, 43)}; // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	
	//도착 마커 이미지를 생성합니다
	const arriveImage = new kakao.maps.MarkerImage(arriveSrc, arriveSize, arriveOption);

	//코스 출발 마커가 표시될 위치입니다 
	const startPosition = preStartLatLng; 
	//코스 출발 마커를 생성합니다
	const startMarker = new kakao.maps.Marker({
			map: map, // 출발 마커가 지도 위에 표시되도록 설정합니다
			position: startPosition,
			image: startImage // 출발 마커이미지를 설정합니다
		});


	//코스 도착 마커가 표시될 위치입니다 
	const arrivePosition = preArriveLatLng;  
	//코스 도착 마커를 생성합니다 
	const arriveMarker = new kakao.maps.Marker({  
			map: map, // 도착 마커가 지도 위에 표시되도록 설정합니다
			position: arrivePosition,
			image: arriveImage // 도착 마커이미지를 설정합니다
		});

	const ptSrc = '/publictransport/blue.png', // 대중교통표시마커  
	ptSize = new kakao.maps.Size(40, 35); // 대중교통표시마커   크기입니다 

	// 대중교통 마커 이미지를 생성합니다
	const ptImage = new kakao.maps.MarkerImage(ptSrc, ptSize);
	
	
	//////////////////////////////////////////////////////////////////// 대중교통출발점 지도

	const PSmapContainer = document.getElementById('PSmap'), // 지도를 표시할 div 
		PSmapOption = { 
	        center: new kakao.maps.LatLng(37.521512492203875,126.9762782994552),
	        level: 6 // 지도의 확대 레벨
	    };
	const PSmap = new kakao.maps.Map(PSmapContainer, PSmapOption); // 지도를 생성합니다
	
	const PEmapContainer = document.getElementById('PEmap'), // 지도를 표시할 div 
		PEmapOption = { 
	        center: new kakao.maps.LatLng(37.521512492203875,126.9762782994552),
	        level: 6 // 지도의 확대 레벨
    	};
	const PEmap = new kakao.maps.Map(PEmapContainer, PEmapOption); // 지도를 생성합니다
	// 대중교통 도착맵 센터 정할곳
	
	//-----------------------
	const psBounds = new kakao.maps.LatLngBounds();;
	const peBounds = new kakao.maps.LatLngBounds();;
	psBounds.extend(preStartLatLng);
	peBounds.extend(preArriveLatLng);
	let ptJson = ${ptJson}
		console.log(ptJson);
		ptJson.forEach(function(pt, i) { //대중교통 출발점 도착점 나누기
			if(pt.code_value == "00201"){  
				const psLine=new kakao.maps.Polyline({
				    map: PSmap,
				    path:[],
				    strokeWeight: 4,
				    strokeColor: '#FF2400',
				    strokeOpacity: 0.7,
				    strokeStyle: 'solid'
				});	

				if(pt.pt_line != null && pt.pt_line != ""){
					const psLineArr = eval(pt.pt_line);
					psLine.setPath(psLineArr);
					psLineArr.forEach(function(ps, i) {
						psBounds.extend(ps);
					});
					
				}
				  
				//출발점 대중교통 마커가 표시될 위치입니다 
				const ptsPosition = new kakao.maps.LatLng(pt.pt_latitude, pt.pt_longitude);  
				// 출발점 대중교통 마커를 생성합니다 
				const ptsMarker = new kakao.maps.Marker({  
				    map: PSmap, // 출발점 대중교통 마커가 지도 위에 표시되도록 설정합니다
				    position: ptsPosition,
				    image: ptImage // 출발점 대중교통 마커이미지를 설정합니다
				});
			}
			else{
				const peLine = new kakao.maps.Polyline({
				    map: PEmap,
				    path: [],
				    strokeWeight: 4,
				    strokeColor: '#FF2400',
				    strokeOpacity: 0.7,
				    strokeStyle: 'solid'
				});

				if(pt.pt_line != null && pt.pt_line != ""){	
					const peLineArr = eval(pt.pt_line);
					peLine.setPath(peLineArr);
					peLineArr.forEach(function(pe, i) {
						peBounds.extend(pe);
					});
				}
				
				//도작점 대중교통 마커가 표시될 위치입니다 
				const ptePosition = new kakao.maps.LatLng(pt.pt_latitude, pt.pt_longitude); 
				// 도착점 대중교통 마커를 생성합니다
				const PEstartMarker = new kakao.maps.Marker({
				    map: PEmap, // 대중교통 마커가 지도 위에 표시되도록 설정합니다
				    position: ptePosition,
				    image: ptImage // 대중교통 마커이미지를 설정합니다
				});
			}				
		})
	setBound(PSmap, psBounds);
	setBound(PEmap, peBounds);
	//출발 마커가 표시될 위치입니다 
	const PSstartPosition = preStartLatLng; 
	// 출발 마커를 생성합니다
	const PSstartMarker = new kakao.maps.Marker({
	    map: PSmap, // 출발 마커가 지도 위에 표시되도록 설정합니다
	    position: PSstartPosition,
	    image: startImage // 출발 마커이미지를 설정합니다
	});
	  
	//도착 마커가 표시될 위치입니다 
	const PEarrivePosition = preArriveLatLng;  
	// 도착 마커를 생성합니다 
	const PEarriveMarker = new kakao.maps.Marker({  
	    map: PEmap, // 도착 마커가 지도 위에 표시되도록 설정합니다
	    position: PEarrivePosition,
	    image: arriveImage // 도착 마커이미지를 설정합니다
	});	

	const tps = document.getElementById("transportS");
	const tpe = document.getElementById("transportE");
	const selectPS = document.getElementById("selectPS");
	const selectPE = document.getElementById("selectPE");
	
	selectPS.addEventListener("change", function(e) {
			setBound(PSmap, psBounds);
			setBound(PEmap, peBounds);

		if(e.target.value == "1"){
			tps.style.visibility="visible";
			tps.style.display="inline-block";
			tpe.style.visibility="hidden";
			tpe.style.display="none";
		}
		else{
			tpe.style.visibility="visible";
			tpe.style.display="inline-block";
			tps.style.visibility="hidden";
			tps.style.display="none";
		}
			selectPS.selectedIndex = 0;
	}, false)
	
	selectPE.addEventListener("change", function(e) {
			setBound(PSmap, psBounds);
			setBound(PEmap, peBounds);
		if( e.target.value == "1"){
			tps.style.visibility="visible";
			tps.style.display="inline-block";
			tpe.style.visibility="hidden";
			tpe.style.display="none";
		}
		else{
			tpe.style.visibility="visible";
			tpe.style.display="inline-block";
			tps.style.visibility="hidden";
			tps.style.display="none";
		}
			selectPE.selectedIndex = 0;
	}, false)
	
	
///////////////////////////////////////////////////////////////////////////////////// 자전거 지도표시
	const mapTypes = { //자전거맵 표시변수
		    bicycle : kakao.maps.MapTypeId.BICYCLE
		};
	document.getElementById("chkBicycle").addEventListener("change", function(e) {
		const check = e.target.checked;
		if(check){
			map.addOverlayMapTypeId(mapTypes.bicycle);
		}
		else{
			map.removeOverlayMapTypeId(mapTypes.bicycle);
		}
	});	


	//----------------------------------------------------------------------------------------------- 무인자전거
	kakao.maps.event.addListener(map, 'idle', removePlaceOveray);

	const redC = '/detailCourseImg/redC.png'; // 따릉이 0개
	const yellowC = '/detailCourseImg/yellowC.png'; // 따릉이 1~4개  
	const greenC = '/detailCourseImg/greenC.png'; // 따릉이 5개 이상  
	const publicC = '/detailCourseImg/greenC.png'; // 서울을 제외한 나머지 공공자전거 마커이미지

	
	const cycleSize = new kakao.maps.Size(8, 8); 
	
	// 따릉 마커 이미지를 생성합니다
	const redImage = new kakao.maps.MarkerImage(redC, cycleSize);
	const yellowImage = new kakao.maps.MarkerImage(yellowC, cycleSize);
	const greenImage = new kakao.maps.MarkerImage(greenC, cycleSize);
	const publicCImage = new kakao.maps.MarkerImage(publicC, cycleSize);

		
	let cycleMakerArr = [];
	publicCycle.addEventListener("change", function(e) {
		const check = e.target.value;
		const cName = (e.target.options[e.target.selectedIndex]).text;
		const cycleUrl = (e.target.options[e.target.selectedIndex]).getAttribute("cycleUrl");
		cycleMakerArr.forEach(function(cm, i) {
			cm.setMap(null);
		})
		placeOverlay.setMap(null);
		cycleMakerArr = [];
		if(check == '0'){  // 아무것도 안함
			return;
		}
		else if(check == '1'){ // 서울
			setSeoulCycle(cName,cycleUrl);
		}
		else if(check == '2'){
			setDajeonCycle(cName,cycleUrl);
		}
		else if(check == '3'){
			setSejongYeosuCycle(cName,cycleUrl);
		}
		else{ // 경기도
			setGgCycle(check,cName,cycleUrl);
		}
	});
	
	function setSeoulCycle(cName,cycleUrl){
		for(let i=1; i<=2001; i+=1000){
			$.ajax({
				url:"http://openapi.seoul.go.kr:8088/6a625562487369773231685a644f53/json/bikeList/"+i+"/"+(i+999),
				success:function(data){
					const cycList = data.rentBikeStatus.row;
					cycList.forEach(function(cyc, i) {
						setCycleMarker(cyc,cName,cycleUrl);
					})
				},
				error: function() {
					alert("서버에러");
				}		
			})
		}
	}
	
	function setCycleMarker(cyc,cName,cycleUrl){
		const parkingCnt = cyc.parkingBikeTotCnt;
		let cImg = greenImage;
		if(parkingCnt == 0){
			cImg = redImage;
		}
		else if(parkingCnt >=1 && parkingCnt <=4){
			cImg = yellowImage;
		}
		
		const cyclePosition = new kakao.maps.LatLng(cyc.stationLatitude, cyc.stationLongitude);  
		// 따릉이 마커를 생성합니다 
		const cycleMarker = new kakao.maps.Marker({  
		    map: map,
		    position: cyclePosition,
		    image: cImg
		});	
		cycleMakerArr.push(cycleMarker);
            kakao.maps.event.addListener(cycleMarker, 'click', function() {
                displaySeoulC(cyc,cName,cycleUrl);
            });
	}
	
	function displaySeoulC (cyc,cName,cycleUrl) {
	    let content = '<div class="placeinfo">' +
	                    '   <a class="title" href="'+cycleUrl+'" target="_blank" title="'+cName+'">'+cName+'</a>';   
	
	    
	        content += '    <span>' + cyc.stationName + '</span>';
	        
	   
	    content += '    <span class="tel">' + "현재 대여가능수 "+cyc.parkingBikeTotCnt + '</span>' + 
	               ' <span class="jibun" >' + "전체 거치대수 "+cyc.rackTotCnt +  '</span>';
	                '</div>' + 
	                '<div class="after"></div>';
	
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(cyc.stationLatitude, cyc.stationLongitude));
	    placeOverlay.setMap(map);  
	}

	function setGgCycle(code,cName,cycleUrl){
		$.ajax({
			url:"https://openapi.gg.go.kr/BICYCL?key=e2d851f8493c448c964a25461359f1f5&pIndex=1&pSize=1000&SIGUN_NM="+code,
			type:"get",
			success:function(data){
				console.log(data);
				const cycList = data.querySelectorAll('row');
				console.log(cycList[0]);
				for(let i=0; i<cycList.length; i++){
					setGgCycleMarker(cycList[i],cName,cycleUrl);
				}
			},
			error:function(){
				alert("에러발생");
			}
		})
	}
	
	function setGgCycleMarker(cyc,cName,cycleUrl){
			const cyclePosition = new kakao.maps.LatLng(cyc.querySelector('REFINE_WGS84_LAT').innerHTML, cyc.querySelector('REFINE_WGS84_LOGT').innerHTML);  
			// 경기도 마커를 생성합니다 
			const cycleMarker = new kakao.maps.Marker({  
			    map: map,
			    position: cyclePosition,
			    image: publicCImage
			});	
			cycleMakerArr.push(cycleMarker);
	            kakao.maps.event.addListener(cycleMarker, 'click', function() {
	            	displayGgC(cyc,cName,cycleUrl);
	            });
	}

	function displayGgC (cyc,cName,cycleUrl) {
	    let content = '<div class="placeinfo">' +
	                    '   <a class="title" href="'+cycleUrl+'" target="_blank" title="'+cName+'">'+cName+'</a>';   
	
	    
	        content += '    <span>' + cyc.querySelector('BICYCL_LEND_PLC_NM_INST_NM').innerHTML + '</span>';
	        
	   
	    content += '    <span class="tel">' + "전체 거치대수 "+cyc.querySelector('STANDS_CNT').innerHTML +  '</span>' + 
	              // ' <span class="jibun" >' + "전체 거치대수 "+place.STANDS_CNT +  '</span>';
	                '</div>' + 
	                '<div class="after"></div>';
	
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(cyc.querySelector('REFINE_WGS84_LAT').innerHTML, cyc.querySelector('REFINE_WGS84_LOGT').innerHTML));
	    placeOverlay.setMap(map);  
	}

	const cycleGeocoder = new kakao.maps.services.Geocoder(); // 대전은 위도경도데이터가 없어 주소로 위경도를 얻어와야함
	
	function setDajeonCycle(cName,cycleUrl){
		$.ajax({
			url:"/publicCycle/dajeonCycle.json",
			type:"get",
			dataType:"JSON",
			success:function(data){
				const cycList = data;
				cycList.forEach(function(cyc, i) {
					setDajeonCycleMarker(cyc,cName,cycleUrl);
				});		
			},
			error:function(){
				alert("에러발생");
			}
		})
	}

		function setDajeonCycleMarker(cyc,cName,cycleUrl){
			cycleGeocoder.addressSearch(cyc.addr, function(result, status) {
			     if (status === kakao.maps.services.Status.OK) {
			        const latLng = new kakao.maps.LatLng(result[0].y, result[0].x);

					const cyclePosition = latLng;
					// 대전 마커를 생성합니다 
					const cycleMarker = new kakao.maps.Marker({  
					    map: map,
					    position: cyclePosition,
					    image: publicCImage
					});	
					cycleMakerArr.push(cycleMarker);
			            kakao.maps.event.addListener(cycleMarker, 'click', function() {
			            	displayDajeonC(cyc,cName,cycleUrl,latLng);
			            });

			    } 
			});    
	
	}

	function displayDajeonC (cyc,cName,cycleUrl,latLng) {
	    let content = '<div class="placeinfo">' +
	                    '   <a class="title" href="'+cycleUrl+'" target="_blank" title="'+cName+'">'+cName+'</a>';   
	
	    
	        content += '    <span>' + cyc.station + '</span>';
	        
	   
	    content += '    <span class="jibun">('+cyc.loc+')</span>' + 
	                '</div>' + 
	                '<div class="after"></div>';
	
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(latLng);
	    placeOverlay.setMap(map);  
	}
		
	function setSejongYeosuCycle(cName,cycleUrl){
		let dataUrl = "";
		if(cName == '세종(어울링)'){
			dataUrl = "/publicCycle/sejongCycle.json";
		}
		else if(cName == '여수(여수랑)'){
			dataUrl = "/publicCycle/yeosuCycle.json"
		}
		$.ajax({
			url:dataUrl,
			type:"get",
			dataType:"JSON",
			success:function(data){
				const cycList = data;
				cycList.forEach(function(cyc, i) {
					setSejongYeosuCycleMarker(cyc,cName,cycleUrl);
				});		
			},
			error:function(){
				alert("에러발생");
			}
		})
	}

	function setSejongYeosuCycleMarker(cyc,cName,cycleUrl){
		const cyclePosition = new kakao.maps.LatLng(cyc.latitude, cyc.longitude);  
		// 경기도 마커를 생성합니다 
		const cycleMarker = new kakao.maps.Marker({  
		    map: map,
		    position: cyclePosition,
		    image: publicCImage
		});	
		cycleMakerArr.push(cycleMarker);
            kakao.maps.event.addListener(cycleMarker, 'click', function() {
            	displaySejongYeosuC(cyc,cName,cycleUrl);
            });
	}

	function displaySejongYeosuC (cyc,cName,cycleUrl) {
	    let content = '<div class="placeinfo">' +
	                    '   <a class="title" href="'+cycleUrl+'" target="_blank" title="'+cName+'">'+cName+'</a>';   
	
	    
	        content += '    <span>' + cyc.station + '</span>';
	        
	   
	    content += '    <span class="jibun">' + cyc.loc+  '</span>' + 
	                '</div>' + 
	                '<div class="after"></div>';
	
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(cyc.latitude, cyc.longitude));
	    placeOverlay.setMap(map);  
	}
// ----------------------------------------------------------------------------------------무인자전거 위치 끝
	
	function removePlaceOveray(){
		placeOverlay.setMap(null);
	}

	//------------------------ 사진 세팅
	const uploadFilesName = ${uploadFilesName};
	console.log(uploadFilesName);
	if(uploadFilesName != undefined && uploadFilesName.length != 0){
		document.getElementById("mainPhoto").style.backgroundImage = "url(/previewPhoto/"+uploadFilesName[0]+")";
		let cPhotoStr = "";
		uploadFilesName.forEach(function(fname, i) {
			cPhotoStr += '<div id="coursePhoto" style="background-image: url(/previewPhoto/'+fname+')"></div>';
		})
		document.getElementById("coursePhotoBox").innerHTML = cPhotoStr;
		
	}
	
	
	// ---------------------------------
	tpe.style.display="none";  // 교통도착점 지도 뭉개짐을 방지하기위해 다 구성완료 후 감춰준다
}
 </script>
</head>
<body>
  	<section>
  		<div id="detailTitle">
  		<font style="font-size: 130%;  color: orange;" >미리보기</font>
  		</div>
  		 <div id="mainPhoto" style="background-image: url(/coursePhoto/nullcPhoto.png); background-size: cover;">
  		 <div style="text-align: right;">made by ${c.nickName}</div>
  		 <div id="mpTtitle"><h2>${c.c_name }</h2></div>
  		</div>
  		<div id="courseInfo">
  			<table  width="800px">
  				<thead>
  					<tr>
	  					<td style="border-bottom: solid 1px black;">위치</td>
	  					<td style="border-bottom: solid 1px black;">거리</td>
	  					<td style="border-bottom: solid 1px black;">소요시간</td>
	  					<td style="border-bottom: solid 1px black;">난이도</td>
	  					<td style="border-bottom: solid 1px black;">풍경</td>
  					</tr>
  				</thead>
  				<tbody>
  					<tr>
	  					<td>${c.c_loc }</td>
	  					<td>${c.c_distance }km</td>
	  					<td>
	  					<c:if test="${c.c_time/60 >= 1 }">
	  						<fmt:formatNumber value="${c.c_time/60}" pattern="0" />시간
	  					</c:if> ${c.c_time%60}분</td>
	  					<td>
	  					<c:if test="${c.c_difficulty ==1 }"><span style="color: #88bea6;">쉬움</span><br></c:if>
	  					<c:if test="${c.c_difficulty ==2 }"><span style="color: #eccb6a;">보통</span><br></c:if>
	  					<c:if test="${c.c_difficulty ==3 }"><span style="color: #c8572d;">어려움</span><br></c:if>
	  					<c:if test="${c.c_difficulty ==4 }"><span style="color: red;">매우 어려움</span><br></c:if>
	  					</td>
	  					<td>
	  					<c:forEach var="v" items="${c.c_views }">
	  						<img src="/courseViewImg/${v}.png">&nbsp;
	  					</c:forEach>		
	  					</td>
  					</tr>
  				</tbody>
  			</table>
  		</div>
  		<div id="detailMap" style="text-align: center; margin: 20px 0 60px 0;">
  		<div class="map_wrap">
  		<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
  		 <ul id="category">
  		 <li id="HP8" data-order="0"> 
            <span class="category_bg hospital"></span>
            병원
        </li>  
        <li id="AD5" data-order="1"> 
            <span class="category_bg hotel"></span>
           숙박
        </li>  
        <li id="AT4" data-order="2"> 
            <span class="category_bg sights"></span>
            관광명소
        </li>  
        <li id="CE7" data-order="3"> 
            <span class="category_bg cafe"></span>
            카페
        </li>
        <li id="FD6" data-order="4"> 
            <span class="category_bg food"></span>
            음식점
        </li>
        <li id="CS2" data-order="5"> 
            <span class="category_bg store"></span>
            편의점
        </li>              
    </ul>
  		</div>
  		<div id="chart_div" style="width: 100%; height: 300px;"></div>
  			<div style="text-align: left;">
  		<input type="checkbox" id="chkBicycle" /> 자전거도로 정보 보기 <button id="cBound">경로 한눈에 보기</button>
  		</div>
  	<div style="text-align: left;">
  			무인자전거 대여소 
  			<select id="publicCycle">
  				<option value="0">--무인자전거 위치--</option>
  				<option value="1" cycleUrl="https://www.bikeseoul.com/" >서울(따릉이)</option>
  				<option value="고양시" cycleUrl="https://www.fifteenlife.com/mobile/index.jsp">고양(피프틴)</option>
  				<option value="과천시" cycleUrl="https://www.gccity.go.kr/main/main.do">과천(과천)</option>
  				<option value="부천시" cycleUrl="https://bike.bucheon.go.kr/site/homepage/menu/viewMenu?menuid=154001003003">부천(부천)</option>
  				<option value="수원시" cycleUrl="http://www.suwon.go.kr/web/bike/index.do">수원(반디클)</option>
  				<option value="시흥시" cycleUrl="https://bike.siheung.go.kr/siheung/">시흥(시흥)</option>
  				<option value="안산시" cycleUrl="http://www.pedalro.kr/index.do">안산(페달로)</option>
  				<option value="2" cycleUrl="http://m.tashu.or.kr/m/mainAction.do?process=mainPage" >대전(타슈)</option>
  				<option value="3" cycleUrl="https://www.sejongbike.kr/mainPageAction.do?process=mainPage" >세종(어울링)</option>
  				<option value="3" cycleUrl="https://bike.yeosu.go.kr/status.do?process=userStatusView" >여수(여수랑)</option>
  			</select>
  		</div>
  		</div>
  		
  		<div id="courseWords" style="padding-left: 50px; padding-right: 100px; margin-bottom: 50px;">
			<div id="courseWordsTitle" style="margin-bottom: 20px; font-size: 110%;">
				<span style="text-decoration: underline;">&nbsp;&nbsp;${c.c_name } 코스만의&nbsp;&nbsp;'<span style="color: #eccb6a;font-weight: bold;">갬</span><span style="color: #c8572d; font-weight: bold; ">성</span>' 포인트&nbsp;&nbsp;&nbsp;</span>
			</div>
			<div id="courseWordsContent" style="font-size: 90%; white-space:pre;">${c.c_words }</div>
  		</div>
  		<div id="coursePhotoBox">
  		</div>
  		<div id="transportS">
  			<div style="border-bottom: solid 1px gray;" id="addInfoTitle"><img src="/detailCourseImg/subway.png">교통편</div>
  			<div style="width: 100%; border: solid 1px gray; font-size: 80%; margin-top: 10px;">
  				<div style="float: left;  border: solid 1px gray; height: 230px; width: 30%; text-align: center;">
  				<br>
  				<select name="startend" id="selectPS" >
  					<option value="1">출발점</option>
  					<option value="2">도착점</option>
  				</select>
  				<br><br>
  				<strong>${c.c_s_locname }</strong>
  				<br><br>
  				<c:if test="${ptList != null }">
  				<c:forEach var="t" items="${ptList }">
  					<c:if test="${t.code_value=='00201' }">
  						<img src="/publictransport/${t.pt_img}">&nbsp;${t.pt_station } ▷▷ 출발점<br>
  						<img src="/detailCourseImg/disArrow.png"> ${t.pt_distance }km&nbsp;
  						<img src="/detailCourseImg/run.png"><fmt:formatNumber value="${t.pt_distance/5*60+1 }" pattern=".0" />분&nbsp;&nbsp;
  						<img src="/detailCourseImg/bicycle.png">&nbsp;<fmt:formatNumber value="${t.pt_distance/20*60+1 }" pattern=".0" />분
  						<br><br>
  					</c:if>
  				</c:forEach>
  				</c:if>
  				</div>
  				<div id="PSmap" style=" border: solid 1px black; height: 230px;width: 1px%;">
  				</div>
  			</div>
  		</div>
  	
  		<div id="transportE">
  			<div style="border-bottom: solid 1px gray;" id="addInfoTitle"><img src="/detailCourseImg/subway.png">교통편</div>
  			<div style="width: 100%; border: solid 1px gray; font-size: 80%;margin-top: 10px;">
  				<div style="float: left;  border: solid 1px gray; height: 230px; width: 30%; text-align: center;">
  				<br>
  				<select name="startend"  id="selectPE">	
  					<option value="2">도착점</option>
  					<option value="1">출발점</option>
  				</select>
  				<br><br>
  				<strong>${c.c_e_locname }</strong>
  				<br><br>
  				<c:if test="${ptList != null }">
  				<c:forEach var="t" items="${ptList }">
  					<c:if test="${t.code_value=='00202' }">
  						도착점 ▷▷ <img src="/publictransport/${t.pt_img }">&nbsp;${t.pt_station }<br>
  						<img src="/detailCourseImg/disArrow.png"> ${t.pt_distance }km&nbsp;	
  						<img src="/detailCourseImg/run.png"><fmt:formatNumber value="${t.pt_distance/5*60+1 }" pattern=".0" />분&nbsp;&nbsp;
  						<img src="/detailCourseImg/bicycle.png">&nbsp;<fmt:formatNumber value="${t.pt_distance/20*60+1 }" pattern=".0" />분
  						<br><br>
  					</c:if>
  				</c:forEach>
  				</c:if>
  				</div>
  				<div id="PEmap" style=" border: solid 1px black; height: 230px;width: 1px%;">
  				</div>
  			</div>
  		</div>
  		<div id="addInfo">
  			<div style="border-bottom: solid 1px gray;" id="addInfoTitle"><img src="/detailCourseImg/review.png">후기</div>
  		</div>
  	</section>
  	
</body>
</html>