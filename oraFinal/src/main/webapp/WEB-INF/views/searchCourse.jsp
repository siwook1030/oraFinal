<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>오늘의라이딩</title>
<style type="text/css">
   
   /*매인섹션부분css------------ ----------------*/
   section {
	   	width: 1000px;
	   	margin: 0 auto;
	   	font-family: 'NEXON Lv1 Gothic Low OTF';
	   	text-align: center;
	   /*	border: solid 1px red;*/
   }

   #searchCourse{
   		/*border: solid 1px red;*/
   		margin-top: 20px;
   		
   }
   #searchListBox{
   		
   		visibility: hidden;
   		display: none;
   }
    #searchTitle{
   	/*border : solid 1px red;*/
   	border-bottom : solid 1px gray;
   	font-size : 140%;
   	text-align : center;
   	width : 40%;
   	padding-bottom : 5px;
   	color: gray;
   	margin-top : 20px;
   	margin-left: auto; 
   	margin-right: auto;
   }
   #searchList{
   /*	border: solid 1px red;*/
   	width: 100%;
   }
	#courseBox{
		width: 30%;
		border: solid 1px gray;
		display: inline-table;
		margin: 13px 13px 13px 13px;
		font-size: 90%;
	}
	#topRow{
		height: 40px;
		text-align: left;
		font-size: 110%;
	}
	#coursePhoto{
		background-size: cover;
		height: 200px;
	}
	#courseName{
		font-size: 120%;
	}
 	#courseSummary{
 	
 	}
 	#searchWord{
 		font-weight: bold;
 		font-size: 110%;
 	}
 	
 	#courseArray span{
 		cursor: pointer; 
 		cursor: hand;
 	}
 	.selectedArray{
 		font-weight: bold;
 		font-size: 120%;
 		text-decoration: underline;
 	}
 	
 	.notSelectedArray{
 		color: gray;
 	}
   /*메인섹션 끝css--------------------------*/
 
      a {
   	text-decoration: none;
   	color: black;
   }

   /* 두루누비 따온 소스*/
   [data-toggle="buttons"] .btn.btn-line.btn-success {
    background-color: #eee;
    border-color: #eee;
    color: #666;
    margin-right: 8px;
}
[data-toggle="buttons"] .btn.btn-line.btn-success.active {
    background-color: #fff;
    border-color: #1553A3;
    color: #1553A3;
    font-weight: 700;
}
[data-toggle="buttons"]>.btn input[type="radio"], [data-toggle="buttons"]>.btn input[type="checkbox"], [data-toggle="buttons"]>.btn-group>.btn input[type="radio"], [data-toggle="buttons"]>.btn-group>.btn input[type="checkbox"] {
    position: absolute;
    clip: rect(0, 0, 0, 0);
    pointer-events: none;
}
input[type="radio"], input[type="checkbox"] {
    margin: 4px 0 0;
    margin-top: 1px \9;
    line-height: normal;
}
input[type="checkbox"], input[type="radio"] {
    box-sizing: border-box;
    padding: 0;
}
input, button, select, textarea {
    font-family: inherit;
    font-size: inherit;
    line-height: inherit;
}
/*카카오 맵css*/

.tracker {
    position: absolute;
    margin: -35px 0 0 -30px;
    display: none;
    cursor: pointer;
    z-index: 3;
}

.icon {
    position: absolute;
    left: 6px;
    top: 9px;
    width: 48px;
    height: 48px;
   /*background-image: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/sign-info-48.png);*/
    background-image: url('/courseMarkerImg/trackIcon.png');
    background-size: cover;
}

.balloon {
    position: absolute;
    width: 60px;
    height: 60px;
    background-image: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/balloon.png);
    -ms-transform-origin: 50% 34px;
    -webkit-transform-origin: 50% 34px;
    transform-origin: 50% 34px;
}

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

.map_wrap {position:relative;width:100%;height:500px;font-size: 80%;}
.title {font-weight:bold;display:block;}
.hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
#centerAddr {display:block;margin-top:2px;font-weight: normal;}
.bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=services"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
//////////
window.onload = function(){

	const myLat = document.getElementById("lat");
	const myLon  = document.getElementById("lon");
	const myLatitude =  document.getElementById("latitude");
	const myLongitude =  document.getElementById("longitude");
/*	
document.getElementById('distanceAll').checked = true;
document.getElementById("timeAll").setAttribute("checked", true);
document.getElementById("timeAll").checked=true;
//document.getElementsByName("view").checked = true;
/*
$("#distance input:first").prop("checked", true);
$("#time input:first").prop("checked", true);
$("#view input").prop("checked", false);
/**
 * 지도 영역 외부에 존재하는 마커를 추적하는 기능을 가진 객체입니다.
 * 클리핑 알고리즘을 사용하여 tracker의 좌표를 구하고 있습니다.
 */
function MarkerTracker(map, target) {
    // 클리핑을 위한 outcode
  const OUTCODE = {
        INSIDE: 0, // 0b0000
        TOP: 8, //0b1000
        RIGHT: 2, // 0b0010
        BOTTOM: 4, // 0b0100
        LEFT: 1 // 0b0001
    };
  
    // viewport 영역을 구하기 위한 buffer값
    // target의 크기가 60x60 이므로 
    // 여기서는 지도 bounds에서 상하좌우 30px의 여분을 가진 bounds를 구하기 위해 사용합니다.
    const BOUNDS_BUFFER = 30;
    
    // 클리핑 알고리즘으로 tracker의 좌표를 구하기 위한 buffer값
    // 지도 bounds를 기준으로 상하좌우 buffer값 만큼 축소한 내부 사각형을 구하게 됩니다.
    // 그리고 그 사각형으로 target위치와 지도 중심 사이의 선을 클리핑 합니다.
    // 여기서는 tracker의 크기를 고려하여 40px로 잡습니다.
    const CLIP_BUFFER = 40;

    // trakcer 엘리먼트
    const tracker = document.createElement('div');
    tracker.className = 'tracker';

    // 내부 아이콘
    const icon = document.createElement('div');
    icon.className = 'icon';

    // 외부에 있는 target의 위치에 따라 회전하는 말풍선 모양의 엘리먼트
    const balloon = document.createElement('div');
    balloon.className = 'balloon';

    tracker.appendChild(balloon);
    tracker.appendChild(icon);

    map.getNode().appendChild(tracker);

    // traker를 클릭하면 target의 위치를 지도 중심으로 지정합니다.
    tracker.onclick = function() {
        map.setCenter(target.getPosition());
        setVisible(false);
    };

    // target의 위치를 추적하는 함수
    function tracking() {
    	const proj = map.getProjection();
        
        // 지도의 영역을 구합니다.
        const bounds = map.getBounds();
        
        // 지도의 영역을 기준으로 확장된 영역을 구합니다.
        const extBounds = extendBounds(bounds, proj);

        // target이 확장된 영역에 속하는지 판단하고
        if (extBounds.contain(target.getPosition())) {
            // 속하면 tracker를 숨깁니다.
            setVisible(false);
        } else {
            // target이 영역 밖에 있으면 계산을 시작합니다.
            

            // 지도 bounds를 기준으로 클리핑할 top, right, bottom, left를 재계산합니다.
            //
            //  +-------------------------+
            //  | Map Bounds              |
            //  |   +-----------------+   |
            //  |   | Clipping Rect   |   |
            //  |   |                 |   |
            //  |   |        *       (A)  |     A
            //  |   |                 |   |
            //  |   |                 |   |
            //  |   +----(B)---------(C)  |
            //  |                         |
            //  +-------------------------+
            //
            //        B
            //
            //                                       C
            // * 은 지도의 중심,
            // A, B, C가 TooltipMarker의 위치,
            // (A), (B), (C)는 각 TooltipMarker에 대응하는 tracker입니다.
            // 지도 중심과 각 TooltipMarker를 연결하는 선분이 있다고 가정할 때,
            // 그 선분과 Clipping Rect와 만나는 지점의 좌표를 구해서
            // tracker의 위치(top, left)값을 지정해주려고 합니다.
            // tracker 자체의 크기가 있기 때문에 원래 지도 영역보다 안쪽의 가상 영역을 그려
            // 클리핑된 지점을 tracker의 위치로 사용합니다.
            // 실제 tracker의 position은 화면 좌표가 될 것이므로 
            // 계산을 위해 좌표 변환 메소드를 사용하여 모두 화면 좌표로 변환시킵니다.
            
            // TooltipMarker의 위치
            const pos = proj.containerPointFromCoords(target.getPosition());
            
            // 지도 중심의 위치
            const center = proj.containerPointFromCoords(map.getCenter());

            // 현재 보이는 지도의 영역의 남서쪽 화면 좌표
            const sw = proj.containerPointFromCoords(bounds.getSouthWest());
            
            // 현재 보이는 지도의 영역의 북동쪽 화면 좌표
            const ne = proj.containerPointFromCoords(bounds.getNorthEast());
            
            // 클리핑할 가상의 내부 영역을 만듭니다.
            const top = ne.y + CLIP_BUFFER;
            const right = ne.x - CLIP_BUFFER;
            const bottom = sw.y - CLIP_BUFFER;
            const left = sw.x + CLIP_BUFFER;

            // 계산된 모든 좌표를 클리핑 로직에 넣어 좌표를 얻습니다.
            const clipPosition = getClipPosition(top, right, bottom, left, center, pos);
            
            // 클리핑된 좌표를 tracker의 위치로 사용합니다.
            tracker.style.top = clipPosition.y + 'px';
            tracker.style.left = clipPosition.x + 'px';

            // 말풍선의 회전각을 얻습니다.
            const angle = getAngle(center, pos);
            
            // 회전각을 CSS transform을 사용하여 지정합니다.
            // 브라우저 종류에따라 표현되지 않을 수도 있습니다.
            // https://caniuse.com/#feat=transforms2d
            balloon.style.cssText +=
                '-ms-transform: rotate(' + angle + 'deg);' +
                '-webkit-transform: rotate(' + angle + 'deg);' +
                'transform: rotate(' + angle + 'deg);';

            // target이 영역 밖에 있을 경우 tracker를 노출합니다.
            setVisible(true);
        }
    }

    // 상하좌우로 BOUNDS_BUFFER(30px)만큼 bounds를 확장 하는 함수
    //
    //  +-----------------------------+
    //  |              ^              |
    //  |              |              |
    //  |     +-----------------+     |
    //  |     |                 |     |
    //  |     |                 |     |
    //  |  <- |    Map Bounds   | ->  |
    //  |     |                 |     |
    //  |     |                 |     |
    //  |     +-----------------+     |
    //  |              |              |
    //  |              v              |
    //  +-----------------------------+
    //  
    // 여기서는 TooltipMaker가 완전히 안보이게 되는 시점의 영역을 구하기 위해서 사용됩니다.
    // TooltipMarker는 60x60 의 크기를 가지고 있기 때문에 
    // 지도에서 완전히 사라지려면 지도 영역을 상하좌우 30px만큼 더 드래그해야 합니다.
    // 이 함수는 현재 보이는 지도 bounds에서 상하좌우 30px만큼 확장한 bounds를 리턴합니다.
    // 이 확장된 영역은 TooltipMarker가 화면에서 보이는지를 판단하는 영역으로 사용됩니다.
    function extendBounds(bounds, proj) {
        // 주어진 bounds는 지도 좌표 정보로 표현되어 있습니다.
        // 이것을 BOUNDS_BUFFER 픽셀 만큼 확장하기 위해서는
        // 픽셀 단위인 화면 좌표로 변환해야 합니다.
        const sw = proj.pointFromCoords(bounds.getSouthWest());
        const ne = proj.pointFromCoords(bounds.getNorthEast());

        // 확장을 위해 각 좌표에 BOUNDS_BUFFER가 가진 수치만큼 더하거나 빼줍니다.
        sw.x -= BOUNDS_BUFFER;
        sw.y += BOUNDS_BUFFER;

        ne.x += BOUNDS_BUFFER;
        ne.y -= BOUNDS_BUFFER;

        // 그리고나서 다시 지도 좌표로 변환한 extBounds를 리턴합니다.
        // extBounds는 기존의 bounds에서 상하좌우 30px만큼 확장된 영역 객체입니다.  
        return new kakao.maps.LatLngBounds(
                        proj.coordsFromPoint(sw),proj.coordsFromPoint(ne));
        
    }


    // Cohen–Sutherland clipping algorithm
    // 자세한 내용은 아래 위키에서...
    // https://en.wikipedia.org/wiki/Cohen%E2%80%93Sutherland_algorithm
    function getClipPosition(top, right, bottom, left, inner, outer) {
        function calcOutcode(x, y) {
        	let outcode = OUTCODE.INSIDE;

            if (x < left) {
                outcode |= OUTCODE.LEFT;
            } else if (x > right) {
                outcode |= OUTCODE.RIGHT;
            }

            if (y < top) {
                outcode |= OUTCODE.TOP;
            } else if (y > bottom) {
                outcode |= OUTCODE.BOTTOM;
            }

            return outcode;
        }

        let ix = inner.x;
        let iy = inner.y;
        let ox = outer.x;
        let oy = outer.y;

        let code = calcOutcode(ox, oy);

        while(true) {
            if (!code) {
                break;
            }

            if (code & OUTCODE.TOP) {
                ox = ox + (ix - ox) / (iy - oy) * (top - oy);
                oy = top;
            } else if (code & OUTCODE.RIGHT) {
                oy = oy + (iy - oy) / (ix - ox) * (right - ox);        
                ox = right;
            } else if (code & OUTCODE.BOTTOM) {
                ox = ox + (ix - ox) / (iy - oy) * (bottom - oy);
                oy = bottom;
            } else if (code & OUTCODE.LEFT) {
                oy = oy + (iy - oy) / (ix - ox) * (left - ox);     
                ox = left;
            }

            code = calcOutcode(ox, oy);
        }

        return {x: ox, y: oy};
    }

    // 말풍선의 회전각을 구하기 위한 함수
    // 말풍선의 anchor가 TooltipMarker가 있는 방향을 바라보도록 회전시킬 각을 구합니다.
    function getAngle(center, target) {
        const dx = target.x - center.x;
        const dy = center.y - target.y ;
        const deg = Math.atan2( dy , dx ) * 180 / Math.PI; 

        return ((-deg + 360) % 360 | 0) + 90;
    }
    
    // tracker의 보임/숨김을 지정하는 함수
    function setVisible(visible) {
        tracker.style.display = visible ? 'block' : 'none';
    }
    
    // Map 객체의 'zoom_start' 이벤트 핸들러
    function hideTracker() {
        setVisible(false);
    }
    
    // target의 추적을 실행합니다.
    this.run = function() {
        kakao.maps.event.addListener(map, 'zoom_start', hideTracker);
        kakao.maps.event.addListener(map, 'zoom_changed', tracking);
        kakao.maps.event.addListener(map, 'center_changed', tracking);
        tracking();
    };
    
    // target의 추적을 중지합니다.
    this.stop = function() {
        kakao.maps.event.removeListener(map, 'zoom_start', hideTracker);
        kakao.maps.event.removeListener(map, 'zoom_changed', tracking);
        kakao.maps.event.removeListener(map, 'center_changed', tracking);
        setVisible(false);
    };
}

///////////////////////-------------------------------------------------------------------------------------------------
	const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.53814589110931, 126.98135334065803), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	const map = new kakao.maps.Map(mapContainer, mapOption); 
	const mapTypeControl = new kakao.maps.MapTypeControl();
	const zoomControl = new kakao.maps.ZoomControl();
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	// 주소-좌표 변환 객체를 생성합니다
	const geocoder = new kakao.maps.services.Geocoder();
	//현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
	searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	
	const startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
	startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
	startLocOption = {offset: new kakao.maps.Point(15, 43)}; // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	
	//출발 마커 이미지를 생성합니다
	const startMarkerImage = new kakao.maps.MarkerImage(startSrc, startSize, startLocOption);
	
	const startMarker = new kakao.maps.Marker({image:startMarkerImage}), // 클릭한 위치를 표시할 마커입니다
	    startInfowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
  const nowLocSrc = '/searchCourseImg/myLoc.gif', // 현위치 마커이미지의 주소입니다    
		nowLocSize = new kakao.maps.Size(15, 15); // 현위치 마커이미지의 크기입니다

	//현위치 마커의 이미지정보를 가지고 있는 현위치 마커이미지를 생성합니다
	const nowLocImage = new kakao.maps.MarkerImage(nowLocSrc, nowLocSize);   

	function nowLocDisplay(){   
		if (navigator.geolocation) {	    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		      const lat = position.coords.latitude, // 위도
		            lon = position.coords.longitude; // 경도
		            
		            myLat.value = lat; 
		            myLon.value= lon;
		            myLatitude.value = lat; 
		            myLongitude.value = lon; 
		            
		      const locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		            message = '<div style="padding:2px 0 0 25px;">라이더 현위치</div>'; // 인포윈도우에 표시될 내용입니다
		        
		        // 마커와 인포윈도우를 표시합니다
		        displayMarker(locPosition, message);
		            
		      });
		    
		} 
		else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		    
		  const locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
		        message = '현위치를 찾을 수 없습니다'
		        
		    displayMarker(locPosition, message);
		}
	}
	nowLocDisplay();


	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker(locPosition, message) {
	
	    // 마커를 생성합니다
	  const marker = new kakao.maps.Marker({  
	        map: map, 
	        position: locPosition,
	        image: nowLocImage
	    }); 
	    
	  const iwContent = message, // 인포윈도우에 표시할 내용
	        iwRemoveable = true;
	
	    // 인포윈도우를 생성합니다
	  const infowindow = new kakao.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    // 인포윈도우를 마커위에 표시합니다 
	    infowindow.open(map, marker);
	    
	    // 지도 중심좌표를 접속위치로 변경합니다
	    map.setCenter(locPosition);      
	}        



	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
	    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            let detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
	            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
	            
	            let content = '<div class="bAddr">' +
	                            '<span class="title">출발점</span>' + 
	                            detailAddr + 
	                        '</div>';
	            const latlng = mouseEvent.latLng;
		   
		          myLatitude.value = latlng.getLat(); //위도경도 값 가져오는거당
		          myLongitude.value = latlng.getLng();
	            // 마커를 클릭한 위치에 표시합니다 
	            startMarker.setPosition(mouseEvent.latLng);
	            startMarker.setMap(map);

	            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
	           // startInfowindow.setContent(content);
	           // startInfowindow.open(map, startMarker);
	        }   
	    });
	});

	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'idle', function() {
	    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	    courseInfoDel();
	});

	function searchAddrFromCoords(coords, callback) {
	    // 좌표로 행정동 주소 정보를 요청합니다
	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	}
	
	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}
	
	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	function displayCenterInfo(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	    	const infoDiv = document.getElementById('centerAddr');
	
	        for(let i = 0; i < result.length; i++) {
	            // 행정동의 region_type 값은 'H' 이므로
	            if (result[i].region_type === 'H') {
	                infoDiv.innerHTML = result[i].address_name;
	                break;
	            }
	        }
	    }    
	}

	document.getElementById("nowLoc").onclick=myNowLoc;
	
	function myNowLoc(){
		const lat = myLat.value;
		const lon = myLon.value;
		if(lat != "0" && lon != "0"){
			const locPosition = new kakao.maps.LatLng(lat, lon);
			 myLatitude.value= lat;
			 myLongitude.value = lon;

			 map.setCenter(locPosition); 
			 startInfowindow.open(null);
			 startMarker.setMap(null);
		}
		else{
			alert("현위치를 찾을 수 없습니다");
		}
	}

//////////////////////////////////////////////////// 코스마커표시기능	
	const placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
    contentNode = document.createElement('div'); // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 

	// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
	contentNode.className = 'placeinfo_wrap';

	// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
	// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
	addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
	addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

	// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
	function addEventHandle(target, type, callback) {
	    if (target.addEventListener) {
	        target.addEventListener(type, callback);
	    } else {
	        target.attachEvent('on' + type, callback);
	    }
	}
	
	// 커스텀 오버레이 컨텐츠를 설정합니다
	placeOverlay.setContent(contentNode); 
//----------------------검색된 코스 만드는 곳 ------
	const courseArrSpan = document.querySelectorAll("#courseArray span"); // 정렬버튼 스판

	let courseMarkerArr = [];  //검색된 코스 마커를 담을 배열
	let courseTrackerArr = [];  //검색된 코스 트랙커를 담을 배열
	const courseSize = new kakao.maps.Size(32, 32); 
	const searchList = document.getElementById("searchList");
	const courseNum = document.getElementById("courseNum");
	const courseNumSpan1 = document.createElement("span");
	courseNumSpan1.style.fontSize="18px";
	courseNumSpan1.style.fontWeight="bold";
	const courseNumSpan2 = document.createElement("span");
	courseNumSpan2.style.fontSize="14px";
	courseNumSpan2.innerHTML = "개 코스가 검색되었습니다";

	let scList = [];
	let currArray = 0;
	const search = document.getElementById("search");
	const spinner = document.getElementById("spinner");
	const searchWord = document.getElementById("searchWord");
	const searchListBox = document.getElementById("searchListBox");

	
	search.addEventListener("click", function(e) {
		
		const latitude = myLatitude.value.trim();
		const longitude = myLongitude.value.trim();	
		const distance = document.querySelector("#distance :checked").value;		
		const time = document.querySelector("#time :checked").value;
		
		const view = [];
		const viewChecked = document.querySelectorAll("#view :checked");
		console.log(viewChecked);
		viewChecked.forEach(function(v) {
			view.push(v.value);
		})

		console.log( "위도 : "+latitude);
		console.log( "경도 : "+longitude);
		console.log( "거리 : "+distance);
		console.log( "시간 : "+time);
		console.log( "풍경 : "+view);

		$.ajax({
			url:"/searchCourse",
			type:"POST",
			data:{
				"latitude":latitude,
				"longitude":longitude,
				"latitude":latitude,
				"distance":distance,
				"time":time,			
				"view":view,			
			},
			beforeSend:function(){
				search.setAttribute("disabled", true);
				spinner.className="spinner-border spinner-border-sm";
				searchWord.innerHTML=" 검색중..";
			},
			success:function(data){
				currArray = 0;
				searchList.innerHTML="";
				courseNum.innerHTML="";
				removeMarker();
				courseMarkerArr = [];
				courseTrackerArr = [];
				
				scList = data;	
				scList.forEach(function(c, i) {
					setCourseMarker(i,c);
					setCourseBox(c);
				})
		
				map.setLevel(7);
				map.setCenter(new kakao.maps.LatLng(latitude, longitude));
				searchListBox.style.visibility="visible";
				searchListBox.style.display="inline";
				courseNumSpan1.innerHTML = scList.length;
				courseNum.append(courseNumSpan1,courseNumSpan2);

				toggleArray(courseArrSpan[0]); // 검색이되면 정확도순을 항상 첫어레이로 설정한다
				if(scList.length == 0){
					courseArray.style.visibility = "hidden";
				}
				else{
					courseArray.style.visibility = "visible";
				}
			},
			error:function(){
				alert("에러발생");
			},
			complete:function(){
				search.removeAttribute("disabled");
				spinner.className="";
				searchWord.innerHTML='<img src="/searchCourseImg/search.png" width="24px" height="24px">검색';
			} 
		})
	}, false)
	
	
	function toggleArray(target){  // 정렬버튼 토글함수
		courseArrSpan.forEach(function(span, i){
		span.className = "notSelectedArray";
	});
		target.className = "selectedArray";
	}
	courseArrSpan.forEach(function(el, i) {
		 
		el.addEventListener("click", function(e) {
		const val = e.target.getAttribute("val");
			if(val == currArray){
				return;
			}
			searchList.innerHTML = "";
			currArray = val;
			toggleArray(e.target);
			if(val == 0){
				scList.forEach(function(c, i, array) {
					setCourseBox(c);
				})
			}
			else{
				arrayCourse(val);
			}	
			
		}, false)
	})
	
	function arrayCourse(val){
		const scArr =  scList.slice();
		let preArr;
		let nextArr;
		
		
		for(let i=0; i<scArr.length; i++){
			for(let j=i+1; j<scArr.length; j++){
				if(val == 1){
					preArr = scArr[i].userDis;
					nextArr = scArr[j].userDis;
				}
				else if(val == 2){
					preArr = scArr[i].c_distance;
					nextArr = scArr[j].c_distance;
				}
				else if(val == 3){
					preArr = scArr[i].c_time;
					nextArr = scArr[j].c_time;
				}
						
				if(preArr > nextArr){
					const temp = scArr[i];
					scArr[i] = scArr[j];
					scArr[j] = temp;
				}
			}
		}
		scArr.forEach(function(c, i, array) {
			setCourseBox(c);
		})
	}
	
	function removeMarker(){
		courseMarkerArr.forEach(function(c, i, array) {
			c.setMap(null);
			courseTrackerArr[i].stop();
		})
	}

	function setCourseMarker(i, c){

		let courseMarkerSrc = '/courseMarkerImg/cMarker.png';  
		if(i <=2){
			courseMarkerSrc = '/courseMarkerImg/cMarker'+(i+1)+'.png';
		}
		const coursePosition = new kakao.maps.LatLng(c.c_s_latitude, c.c_s_longitude);

		const courseMarkerImage = new kakao.maps.MarkerImage(courseMarkerSrc, courseSize);	
		const courseMarker = new kakao.maps.Marker({  
		    map: map,
		    position: coursePosition,
		    image: courseMarkerImage
		});	
		const markerTracker = new MarkerTracker(map, courseMarker);
		markerTracker.run();
		
		courseMarkerArr.push(courseMarker);
		courseTrackerArr.push(markerTracker);
		
		
        kakao.maps.event.addListener(courseMarker, 'click', function() {
            displayC(c);
        });
	}
	
	function displayC (c) {
		let courseTime;
		const hour = parseInt(c.c_time/60);
		const mi = c.c_time%60;
		if(hour >= 1){
			courseTime = hour+'시간'+mi+'분';
		}
		else{
			courseTime = mi+'분';
		}
		const diff = c.c_difficulty;
		let diffContent;
		if(diff == 1){
			diffContent = '쉬움';
		}
		else if(diff == 2){
			diffContent = '보통';
		}
		else if(diff == 3){
			diffContent = '어려움';
		}
		else if(diff == 4){
			diffContent = '매우어려움';
		}
     let content = '<div class="placeinfo">' +
     				'   <a class="title" href="/detailCourse?c_no='+c.c_no+'" target="_blank" title="' + c.c_name + '">' + c.c_name + '</a>';   
	
	    content += '    <span title="' + c.nickName + '">' + "made by "+c.nickName + '</span>';
	             
	    content += '    <span class="tel">'+ c.c_loc + " "+c.c_distance +"km "+courseTime+ " "+diffContent+'</span>' + 
	                '</div>' + 
	                '<div class="after"></div>';
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(c.c_s_latitude, c.c_s_longitude));
	    placeOverlay.setMap(map);  
	}

	function setCourseBox(c){
		const courseBox = document.createElement("div");
		courseBox.setAttribute("id", "courseBox");

		let courseTime;
		const hour = parseInt(c.c_time/60);
		const mi = c.c_time%60;
		if(hour >= 1){
			courseTime = hour+'시간 '+mi+'분';
		}
		else{
			courseTime = mi+'분';
		}
		
		let courseContent = '<div id="topRow"><span>'+c.c_loc+'</span><div style="text-align: right;">';
		
		c.c_views.forEach(function(v, i) {
			courseContent += '<img src="/courseViewImg/'+v+'.png">';
		});
		
		courseContent += '</div></div><div>made by '+c.nickName+'</div>';
		
		courseContent += '<a href="/detailCourse?c_no='+c.c_no+'" target="_blank">';
		
		if(c.c_photo.length != 0){
			console.log(c.c_photo[0]);
			courseContent += '<div id="coursePhoto" style="background-image: url('+c.c_photo[0].cp_path+'/'+c.c_photo[0].cp_name+');"></div></a>';
		}
		else{
			courseContent += '<div id="coursePhoto" style="background-image: url(/coursePhoto/nullcPhoto.png);"></div></a>';
		}
		
		courseContent += '<div id="courseName"><strong>'+c.c_name+'</strong></div>';
		
		courseContent += '<div id="courseSummary"><img src="/searchCourseImg/distance.png"><span>'+c.c_distance+'</span><span>km</span>';
		
		courseContent += '<img src="/searchCourseImg/time.png"><span>'+courseTime+'</span>';
		
		courseContent += '<img src="/searchCourseImg/difficulty.png">';
		
		const diff = c.c_difficulty;
		if(diff == 1){
			courseContent += '<span style="color:#88bea6;">쉬움</span>';
		}
		else if(diff == 2){
			courseContent += '<span style="color: #eccb6a;">보통</span>';
		}
		else if(diff == 3){
			courseContent += '<span style="color: #c8572d;">어려움</span>';
		}
		else if(diff == 4){
			courseContent += '<span style="color:red;">매우어려움</span>';
		}
		
		courseContent += '<br><img src="/searchCourseImg/userDis.png"><span>'+c.userDis+'</span><span>km</span></div>';
		
		courseBox.innerHTML = courseContent;
		searchList.append(courseBox);

	}
	
	function courseInfoDel(){
		placeOverlay.setMap(null);
	}

	const mapTypes = { //자전거맵 표시변수
		    bicycle : kakao.maps.MapTypeId.BICYCLE
		};

	const chkBicycle = document.getElementById("chkBicycle");
	chkBicycle.addEventListener("change", function(e) {
		const check = e.target.checked;
		if(check){
			map.addOverlayMapTypeId(mapTypes.bicycle);
		}
		else{
			map.removeOverlayMapTypeId(mapTypes.bicycle);
		}
	}, false)

	
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


}
</script>
</head>
<body>
<jsp:include page="header.jsp"/>
      <div id="clear"></div>
  	<section>
  	 	<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <div class="hAddr">
        <span class="title">지도중심기준 주소</span>
        <span id="centerAddr"></span>
    </div>
</div>
	<div><strong>원하는 위치를 클릭하여 출발점을 정하세요!</strong>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="nowLoc"  onclick="myNowLoc()" value="현위치"></div>
	<div style="text-align: left;">
  		<input type="checkbox" id="chkBicycle" /> 자전거도로 정보 보기
  		</div>
			<input type="hidden" name="lat" value="0" id="lat">
  			<input type="hidden" name="lon" value="0" id="lon">
  		<div id="searchCourse" style="text-align: left;">
	  	<form action="searchCourse" method="post">
  			<input type="hidden" name="latitude" id="latitude" value="37.53814589110931">
  			<input type="hidden" name="longitude" id="longitude" value="126.98135334065803">
 
  			 <div class="btn-group btn-group-toggle" data-toggle="buttons" id="distance" >
					&nbsp;거리&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="btn btn-success btn-line btn-small active" >
							<input type="radio" id="distanceAll" name="distance" value="0" checked> 전체
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="radio" id="distance1" name="distance"  value="10" > 0-10km
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="radio" id="distance2" name="distance"  value="30" > 10-30km
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="radio" id="distance3" name="distance"  value="50" > 30-50km
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="radio" id="distance4" name="distance"  value="1000" > 50km 이상
						</label>
					</div>
					<div class="btn-group btn-group-toggle" data-toggle="buttons" id="view">
						&nbsp;풍경&nbsp;&nbsp;&nbsp; 
						<label class="btn btn-success btn-line btn-small">
							<input type="checkbox" id="viewAll" name="view"  value="강" > 강
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="checkbox" id="view1" name="view" value="산" > 산
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="checkbox" id="view2" name="view" value="명소" > 명소
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="checkbox" id="view3" name="view"  value="바다" > 바다
						</label>
					</div><br><br>
					<div class="btn-group btn-group-toggle" data-toggle="buttons" id="time">
						&nbsp;소요시간&nbsp;&nbsp;<label class="btn btn-success btn-line btn-small active">
							<input type="radio" id="timeAll" name="time" id="time" value="0" checked> 전체
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="radio" id="time1" name="time"  value="60" > 1시간 미만
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="radio" id="time2" name="time"  value="120" > 1-2시간
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="radio" id="time3" name="time"  value="180" > 2-3시간
						</label>
						<label class="btn btn-success btn-line btn-small">
							<input type="radio" id="time4" name="time"  value="1000" > 3시간 이상
						</label>
					</div>			
					<br>
  		</form>
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
  			<div class="container" style="text-align: center; margin-top: 10px;">
  			<button type="button" id="search" class="btn btn-info btn-line">
	  			<span id="spinner"></span>
	  			<span id="searchWord"><img src="/searchCourseImg/search.png" width="24px" height="24px">검색</span>
  			</button>
  			  </div>
  		</div>
  		<div id="searchListBox" >
  		<div id="searchTitle">
  		Course<span style="font: italic bold 1.5em/1em Georgia,serif; font-size:10px; color: gray;">&nbsp;&nbsp;&nbsp; for you</span>
  		</div>
  		<div id="courseNum" style="text-align: left;">
  		
  		</div>
  		<div id="courseArray" style="text-align: left;">
  			<span val="0" class="selectedArray">정확도순</span> <span val="1" class="notSelectedArray">거리순</span> <span val="2" class="notSelectedArray">코스거리</span> <span val="3" class="notSelectedArray">소요시간</span>
  		</div>
  		<div id="searchList" style="text-align: left;">
  		
  		</div>
  		</div>
  	</section>
  	
  	<div id="clear"></div>
  	<jsp:include page="footer.jsp"/>
</body>
</html>