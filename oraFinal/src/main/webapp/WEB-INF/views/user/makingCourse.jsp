<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    margin: 10px auto;
      font-family: 'NEXON Lv1 Gothic Low OTF';
      border: solid 1px red;
   }
   #logo {
       float: left; 
   }
   #top {
      margin: 30px 20px 0 0;
      font-size: 12px;
      float: right;
      text-align: right;   
   }
   #login {
      font-size: 11px;
      text-align: right;
   }
 /*매인섹션 시작----------------  */
 section {
 	  margin: 0 auto;
 	  width: 1000px;
 }
 #cTitle{
	font-size: 140%;
}

 /*매인섹션 끝 ------------------*/
   footer {
       width: 1000px;
       margin: 30px auto;
       height: 150px;
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

   #undo.disabled, #redo.disabled {background-color:#ddd;color:#9e9e9e;}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=drawing,services"></script>
<script>
$(function(){
	$("#startC").click(function() {
		selectOverlay('MARKER');
	});
	$("#arriveC").click(function() {
		selectOverlay2('MARKER');
	});
	$("#polyC").click(function() {
		selectOverlay3('POLYLINE');
	});
	$("#backPolyC").click(function() {
		back();
	});
	$("#frontPolyC").click(function() {
		front();
	});
	$("#infoC").click(function() {
		getInfo();
	});
	$("#chkBicycle").click(function() {
		setOverlayMapTypeId(map);
	});
//////////////////////////////////////// 코스끝
	$("#publicTranportPS").click(function() {
		selectOverlayPS('MARKER');
	});
	$("#polyPS").click(function() {
		selectOverlayPS('POLYLINE');
	});
	$("#backPolyPS").click(function() {
		backPS();
	});
	$("#frontPolyPS").click(function() {
		frontPS();
	});
	$("#infoPS").click(function() {
		getInfoPS();
	});
	$("#chkBicyclePS").click(function() {
		setOverlayMapTypeId(mapPS);
	});
//////////////////////////////////////////// 대중교통 출발점 끝
	$("#publicTranportPE").click(function() {
		selectOverlayPE('MARKER');
	});
	$("#polyPE").click(function() {
		selectOverlayPE('POLYLINE');
	});
	$("#backPolyPE").click(function() {
		backPE();
	});
	$("#frontPolyPE").click(function() {
		frontPE();
	});
	$("#infoPE").click(function() {
		getInfoPE();
	});
	$("#chkBicyclePE").click(function() {
		setOverlayMapTypeId(mapPE);
	});
//////////////////////////////////////////////대중교통 도착점 끝
	var title =  document.getElementById("title");
	var slat =  document.getElementById("slat");
	var slon =  document.getElementById("slon");
	var sLoc =  document.getElementById("sLoc");
	
	var elat =  document.getElementById("elat");
	var elon =  document.getElementById("elon");
	var eLoc =  document.getElementById("eLoc");
	var words = document.getElementById("words");
	var mapLevel =  document.getElementById("mapLevel");
	var firstView =  document.getElementById("firstView");
	var secondView =  document.getElementById("secondView");
	var dis =  document.getElementById("dis");
	var time =  document.getElementById("time");
	var diff =  document.getElementById("diff");
	var line =  document.getElementById("line");
	var fixC =  document.getElementById("fixC"); // 수정시 가져오기필요문구 나타낼스판
////////////////////////////////////////////////////
	var latPS = document.getElementById("latPS");
	var lonPS = document.getElementById("lonPS");
	var sPT = document.getElementById("sPT");
	var sPTStation = document.getElementById("sPTStation");
	var disPS = document.getElementById("disPS");
	var linePS = document.getElementById("linePS");
	var fixPS = document.getElementById("fixPS"); // 수정시 가져오기필요문구 나타낼스판
////////////////////////////////////////////////////////////
	var latPE = document.getElementById("latPE");
	var lonPE = document.getElementById("lonPE");
	var ePT = document.getElementById("ePT");
	var ePTStation = document.getElementById("ePTStation");
	var disPE = document.getElementById("disPE");
	var linePE = document.getElementById("linePE");
	var fixPE = document.getElementById("fixPE");;  // 수정시 가져오기필요문구 나타낼스판
////////////////////////////////////////////////////////////	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.52084556725995, 126.97701335521351), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	    };
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var mapTypeControl = new kakao.maps.MapTypeControl();
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
	    map: map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
	    drawingMode: [ // drawing manager로 제공할 그리기 요소 모드입니다
	        kakao.maps.drawing.OverlayType.MARKER
	    ],
	    // 사용자에게 제공할 그리기 가이드 툴팁입니다
	    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
	    guideTooltip: ['draw', 'drag', 'edit'], 
	    markerOptions: { // 마커 옵션입니다 
	        draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
	        removable: true, // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다 
	         markerImages : [
	        	{
	                src: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png',
	                width: 50,
	                height: 45,
	                shape: 'rect',
	                coords: '0,0,31,35',
	                offsetX : 15, // 지도에 고정시킬 이미지 내 위치 좌표
	                offsetY : 43 // 지도에 고정시킬 이미지 내 위치 좌표
	            }
	         ]
	    }
	};    
	    
	var options2 = { // Drawing Manager를 생성할 때 사용할 옵션입니다
	    map: map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
	    drawingMode: [ // drawing manager로 제공할 그리기 요소 모드입니다
	        kakao.maps.drawing.OverlayType.MARKER
	    ],
	    // 사용자에게 제공할 그리기 가이드 툴팁입니다
	    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
	    guideTooltip: ['draw', 'drag', 'edit'], 
	    markerOptions: { // 마커 옵션입니다 
	        draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
	        removable: true, // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다  
	        markerImages : [
	        	{
	                src: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png',
	                width: 50,
	                height: 45,
	                shape: 'rect',
	                coords: '0,0,31,35',
	                offsetX : 15, // 지도에 고정시킬 이미지 내 위치 좌표
	                offsetY : 43 // 지도에 고정시킬 이미지 내 위치 좌표
	            }
	        ]
	    }
	};

	var options3 = { // Drawing Manager를 생성할 때 사용할 옵션입니다
	    map: map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
	    drawingMode: [ // drawing manager로 제공할 그리기 요소 모드입니다
	        kakao.maps.drawing.OverlayType.POLYLINE
	    ],
	    // 사용자에게 제공할 그리기 가이드 툴팁입니다
	    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
	    guideTooltip: ['draw', 'drag', 'edit'], 
	    polylineOptions: { // 선 옵션입니다
	        draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
	        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
	        editable: true, // 그린 후 수정할 수 있도록 설정합니다 
	        endArrow: true,
	        strokeColor: '#404040', // 선 색
	        strokeWeight:4,
	        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
	        hintStrokeOpacity: 0.8  // 그리중 마우스를 따라다니는 보조선의 투명도
	    }
	};       
	    
	// 위에 작성한 옵션으로 Drawing Manager를 생성합니다
	var manager = new kakao.maps.drawing.DrawingManager(options);
	var manager2 = new kakao.maps.drawing.DrawingManager(options2);
	var manager3 = new kakao.maps.drawing.DrawingManager(options3);

	function setFixC(){
		$(fixC).html("가져오기를 눌러주세요");
		$(fixC).attr("val", "y");
		$(fixPS).html("가져오기를 눌러주세요");
		$(fixPS).attr("val", "y");
		$(fixPE).html("가져오기를 눌러주세요");
		$(fixPE).attr("val", "y");
	}
	manager.addListener('state_changed', function() {
		setFixC();
	});
	manager2.addListener('state_changed', function() {
		setFixC();
	});
	kakao.maps.event.addListener(map, 'zoom_start', function() {
		setFixC();
	});
	manager3.addListener('state_changed', function() {
		var undoBtn =  document.getElementById("backPolyC");
		var redoBtn =  document.getElementById("frontPolyC");
		// 되돌릴 수 있다면 undo 버튼을 활성화 시킵니다 
		if (manager3.undoable()) {
			undoBtn.disabled = false;
			undoBtn.className = "";
		} else { // 아니면 undo 버튼을 비활성화 시킵니다 
			undoBtn.disabled = true;
			undoBtn.className = "disabled";
		}

		// 취소할 수 있다면 redo 버튼을 활성화 시킵니다 
		if (manager3.redoable()) {
			redoBtn.disabled = false;
			redoBtn.className = "";
		} else { // 아니면 redo 버튼을 비활성화 시킵니다 
			redoBtn.disabled = true;
			redoBtn.className = "disabled";
		}
		setFixC();
	});
	
	
	// 버튼 클릭 시 호출되는 핸들러 입니다
	function selectOverlay(type) {
	    var data = manager.getData();
	    var start = data[kakao.maps.drawing.OverlayType.MARKER];
	    if(start.length==0){
		   // 클릭한 그리기 요소 타입을 선택합니다
		   manager.select(kakao.maps.drawing.OverlayType[type]);
	      
	    }
		manager2.cancel();
	    manager3.cancel();
	}
	function selectOverlay2(type) {
	     var data = manager2.getData();
	     var end = data[kakao.maps.drawing.OverlayType.MARKER];
	    if(end.length==0){ 
	    	// 클릭한 그리기 요소 타입을 선택합니다
	     	manager2.select(kakao.maps.drawing.OverlayType[type]);
	    }
	    manager.cancel();
		manager3.cancel();
	}
	function selectOverlay3(type) {
	     var data = manager3.getData();
	     var linepath = data[kakao.maps.drawing.OverlayType.POLYLINE];
	    if(linepath.length == 0){
		     // 클릭한 그리기 요소 타입을 선택합니다
		     manager3.select(kakao.maps.drawing.OverlayType[type]);
	    }
	    manager.cancel();
		manager2.cancel();
	}

	function back(){
	    	if (manager3.undoable()) {
			// 이전 상태로 되돌림
			manager3.undo();
	}
	    }
	    
	function front(){
	    if (manager3.redoable()) {
			// 이전 상태로 되돌린 상태를 취소
			manager3.redo();
	}
	    }    
	    
	var geocoder = new kakao.maps.services.Geocoder();

	var startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
	startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
	startOption = { 
	offset: new kakao.maps.Point(15, 43) // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	};
	//출발 마커 이미지를 생성합니다
	var startImage = new kakao.maps.MarkerImage(startSrc, startSize, startOption);

	//출발 마커를 생성합니다
	var startMarker = new kakao.maps.Marker({
	image: startImage // 출발 마커이미지를 설정합니다
	});

	var arriveSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
	arriveSize = new kakao.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
	arriveOption = { 
	offset: new kakao.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	};
	//도착 마커 이미지를 생성합니다
	var arriveImage = new kakao.maps.MarkerImage(arriveSrc, arriveSize, arriveOption);

	//도착 마커를 생성합니다 
	var arriveMarker = new kakao.maps.Marker({  
	image: arriveImage // 도착 마커이미지를 설정합니다
	});
	
	var polyObj = new kakao.maps.Polyline(); // 라인의 길이를 담기위한 폴리라인객체
	function getInfo() {
		var data = manager.getData();
	    var start = data[kakao.maps.drawing.OverlayType.MARKER];
	    var data2 = manager2.getData();
	    var end = data2[kakao.maps.drawing.OverlayType.MARKER];
	    var data3 = manager3.getData();
	    var linepath = data3[kakao.maps.drawing.OverlayType.POLYLINE];
		
	    if(start.length==0){
	    	alert("출발점마커를 그려주세요");
	    }
	    else if(end.length==0){
	    	alert("도착점마커를 그려주세요");
		}
	    else if(linepath.length==0){
	    	alert("출발점과 도착점의 경로를 그려주세요");
		}
	    else{   
	        var sMarkerData = start[0];
	        var eMarkerData = end[0];
	        
	    	var lineP = linepath[0].points;
	    	var linePLength = lineP.length;
	    	lineP[0].x = sMarkerData.x; 
	    	lineP[0].y = sMarkerData.y;     	
	    	lineP[linePLength-1].x = eMarkerData.x;
	    	lineP[linePLength-1].y = eMarkerData.y;
	   	
	 		slat.value = sMarkerData.y;
	   		slon.value = sMarkerData.x;
	   		
	   		geocoder.coord2Address(sMarkerData.x, sMarkerData.y, function(result, status) {
			    if(status === kakao.maps.services.Status.OK) {
			    	console.log(result[0]);
			       sLoc.value = result[0].address.address_name;
			    }
			});
	   
			//////////////// 대중교통 출발점 위치표시
			var startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
			startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
			startOption = { 
			    offset: new kakao.maps.Point(15, 43) // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
			};
			startMarker.setPosition(new kakao.maps.LatLng(sMarkerData.y, sMarkerData.x));
			startMarker.setMap(mapPS);
			mapPS.setCenter(new kakao.maps.LatLng(sMarkerData.y, sMarkerData.x));
			///////////// 대중교통 출발점표시 끝	
	
		  	elat.value = eMarkerData.y;
		    elon.value = eMarkerData.x;
		    geocoder.coord2Address(eMarkerData.x, eMarkerData.y, function(result, status) {
			    if(status === kakao.maps.services.Status.OK) {
				    console.log(result[0]);
			       eLoc.value = result[0].address.address_name;
			    }
			});
		///////////// 대중교통 도착점 표시
		arriveMarker.setPosition(new kakao.maps.LatLng(eMarkerData.y, eMarkerData.x));
		arriveMarker.setMap(mapPE);
		mapPE.setCenter(new kakao.maps.LatLng(eMarkerData.y, eMarkerData.x));
		/////////////// 대중교통 도착점 표시 끝   
		var arr = new Array();
	    var i=0, cnt=0;
		var pathStr="[";
	        for(; i<linePLength; i++){
	            cnt++;
	        
	            arr[i] = new kakao.maps.LatLng(lineP[i].y, lineP[i].x);
	            var str = " new kakao.maps.LatLng("+lineP[i].y+","+lineP[i].x+")";
	            if(cnt < linePLength)
	           		 pathStr += str+",\r\n";
	            else
	                pathStr += str;
	        }
	       pathStr += "]";
	        
	    manager3.remove(manager3.getOverlays().polyline[0]);
	    manager3.put(kakao.maps.drawing.OverlayType.POLYLINE, arr);
    	$(fixC).html(""); // 새로 라인을 그리기 후 가져오기눌러주세요 글을 없앤다
    	$(fixC).attr("val", "n");
		polyObj.setPath(arr);
		var distance = (polyObj.getLength()/1000).toFixed(1);

		mapLevel.value = map.getLevel();
		line.value = pathStr;
	    dis.value = distance;
	    time.value = (distance/20*60).toFixed(0);
	  }
	}

//////////////////////////////////////////////////////////////////////// 코스설정끝

	var mapContainerPS = document.getElementById('mapPS'), // 지도를 표시할 div 
	 mapOptionPS = { 
	        center: new kakao.maps.LatLng(37.52084556725995, 126.97701335521351), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	 };

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var mapPS = new kakao.maps.Map(mapContainerPS, mapOptionPS); 
	var mapTypeControlPS = new kakao.maps.MapTypeControl();
	var zoomControlPS = new kakao.maps.ZoomControl();
	mapPS.addControl(mapTypeControlPS, kakao.maps.ControlPosition.TOPRIGHT);
	mapPS.addControl(zoomControlPS, kakao.maps.ControlPosition.RIGHT);

	var optionsPS = { // Drawing Manager를 생성할 때 사용할 옵션입니다
	    map: mapPS, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
	    drawingMode: [ // drawing manager로 제공할 그리기 요소 모드입니다
	        kakao.maps.drawing.OverlayType.MARKER,
	        kakao.maps.drawing.OverlayType.POLYLINE
	    ],
	    // 사용자에게 제공할 그리기 가이드 툴팁입니다
	    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
	    guideTooltip: ['draw', 'drag', 'edit'], 
	    markerOptions: { // 마커 옵션입니다 
	        draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
	        removable: true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다 
	    },
	    polylineOptions: { // 선 옵션입니다
	        draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
	        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
	        editable: true, // 그린 후 수정할 수 있도록 설정합니다 
	        endArrow: true,
	        strokeColor: '#404040', // 선 색
	        strokeWeight:4,
	        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
	        hintStrokeOpacity: 0.8  // 그리중 마우스를 따라다니는 보조선의 투명도
	    }
	}; 
	var managerPS = new kakao.maps.drawing.DrawingManager(optionsPS);
	
	managerPS.addListener('state_changed', function() {
		var undoBtn =  document.getElementById("backPolyPS");
		var redoBtn =  document.getElementById("frontPolyPS");
		// 되돌릴 수 있다면 undo 버튼을 활성화 시킵니다 
		if (managerPS.undoable()) {
			undoBtn.disabled = false;
			undoBtn.className = "";
		} else { // 아니면 undo 버튼을 비활성화 시킵니다 
			undoBtn.disabled = true;
			undoBtn.className = "disabled";
		}

		// 취소할 수 있다면 redo 버튼을 활성화 시킵니다 
		if (managerPS.redoable()) {
			redoBtn.disabled = false;
			redoBtn.className = "";
		} else { // 아니면 redo 버튼을 비활성화 시킵니다 
			redoBtn.disabled = true;
			redoBtn.className = "disabled";
		}
		$(fixPS).html("가져오기를 눌러주세요!");
		$(fixPS).attr("val", "y");
	});
	 
	function selectOverlayPS(type) {
	   	 managerPS.cancel();
	     var data = managerPS.getData();
	     if(startMarker.getMap() != null){
		    if(type=='MARKER'){
		     var pts = data[kakao.maps.drawing.OverlayType.MARKER];
		        if(pts.length==0){
		        	 managerPS.select(kakao.maps.drawing.OverlayType[type]);
		        }
		    }
		    else{
		        var linepath = data[kakao.maps.drawing.OverlayType.POLYLINE];
		         if(linepath.length == 0){
			   		 // 클릭한 그리기 요소 타입을 선택합니다
			    	 managerPS.select(kakao.maps.drawing.OverlayType[type]);
		    	}
		    }
	     }
	     else{
	    	 alert("상단의 코스경로만들기에서 가져오기 후 진행해주세요");
	     }

	}  
	function backPS(){
	  if (managerPS.undoable()) {
		// 이전 상태로 되돌림
		managerPS.undo();
	}
	    }   
	function frontPS(){
	  if (managerPS.redoable()) {
		// 이전 상태로 되돌린 상태를 취소
		managerPS.redo();
	}
	    }  
	var polyObjPS =  new kakao.maps.Polyline();   
	function getInfoPS(){
		var data = managerPS.getData();
	    var pts = data[kakao.maps.drawing.OverlayType.MARKER];
	    var linepath = data[kakao.maps.drawing.OverlayType.POLYLINE];
		if($(fixC).attr("val") == "y"){
			alert("상단의 코스경로만들기에서 가져오기 후 진행해주세요");
		}
		else if(pts.length==0){
			alert("대중교통마커를 그려주세요");
		}
		else if(linepath.length==0){
			alert("대중교통과 출발점과의 경로를 그려주세요");
		}
		else{	
			var lineP = linepath[0].points;
	    	var linePLength = lineP.length;
	
	    	lineP[0].x = pts[0].x;
	    	lineP[0].y = pts[0].y;
	    	lineP[linePLength-1].x = startMarker.getPosition().getLng();
	    	lineP[linePLength-1].y = startMarker.getPosition().getLat();
	    	
		  	latPS.value = pts[0].y;
		    lonPS.value = pts[0].x;
	  
		    var arr = new Array();
		    var i=0, cnt=0;
			var pathStr="[";
		        for(; i<linePLength; i++){
		            cnt++;
		            arr[i] = new kakao.maps.LatLng(lineP[i].y, lineP[i].x);
		            var str = " new kakao.maps.LatLng("+lineP[i].y+","+lineP[i].x+")";
		            if(cnt < linePLength)
		           		 pathStr += str+",\r\n";
		            else
		                pathStr += str;
		        }
		   pathStr += "]";
	        
		    managerPS.remove(managerPS.getOverlays().polyline[0]);
		    managerPS.put(kakao.maps.drawing.OverlayType.POLYLINE, arr);
			$(fixPS).html("");
			$(fixPS).attr("val", "n");
			polyObjPS.setPath(arr);
			var distance = (polyObjPS.getLength()/1000).toFixed(1);
	
			 linePS.value = pathStr;
		   	 disPS.value = distance;
		}
	}
/////////////////////////////////////////////////// 출발점 교통편 끝

	var mapContainerPE = document.getElementById('mapPE'), // 지도를 표시할 div 
	 mapOptionPE = { 
	        center: new kakao.maps.LatLng(37.52084556725995, 126.97701335521351), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	    };

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var mapPE = new kakao.maps.Map(mapContainerPE, mapOptionPE); 
	var mapTypeControlPE = new kakao.maps.MapTypeControl();
	var zoomControlPE = new kakao.maps.ZoomControl();
	mapPE.addControl(mapTypeControlPE, kakao.maps.ControlPosition.TOPRIGHT);
	mapPE.addControl(zoomControlPE, kakao.maps.ControlPosition.RIGHT);


	var optionsPE = { // Drawing Manager를 생성할 때 사용할 옵션입니다
	    map: mapPE, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
	    drawingMode: [ // drawing manager로 제공할 그리기 요소 모드입니다
	        kakao.maps.drawing.OverlayType.MARKER,
	        kakao.maps.drawing.OverlayType.POLYLINE
	    ],
	    // 사용자에게 제공할 그리기 가이드 툴팁입니다
	    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
	    guideTooltip: ['draw', 'drag', 'edit'], 
	    markerOptions: { // 마커 옵션입니다 
	        draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
	        removable: true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다 
	    },
	    polylineOptions: { // 선 옵션입니다
	        draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
	        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
	        editable: true, // 그린 후 수정할 수 있도록 설정합니다 
	        endArrow: true,
	        strokeColor: '#404040', // 선 색
	        strokeWeight:4,
	        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
	        hintStrokeOpacity: 0.8  // 그리중 마우스를 따라다니는 보조선의 투명도
	    }
	}; 
	var managerPE = new kakao.maps.drawing.DrawingManager(optionsPE);

		managerPE.addListener('state_changed', function() {
			var undoBtn =  document.getElementById("backPolyPE");
			var redoBtn =  document.getElementById("frontPolyPE");
			// 되돌릴 수 있다면 undo 버튼을 활성화 시킵니다 
			if (managerPE.undoable()) {
				undoBtn.disabled = false;
				undoBtn.className = "";
			} else { // 아니면 undo 버튼을 비활성화 시킵니다 
				undoBtn.disabled = true;
				undoBtn.className = "disabled";
			}
	
			// 취소할 수 있다면 redo 버튼을 활성화 시킵니다 
			if (managerPE.redoable()) {
				redoBtn.disabled = false;
				redoBtn.className = "";
			} else { // 아니면 redo 버튼을 비활성화 시킵니다 
				redoBtn.disabled = true;
				redoBtn.className = "disabled";
			}
			$(fixPE).html("가져오기를 눌러주세요!");
			$(fixPE).attr("val", "y");
	});
	    
	function selectOverlayPE(type) {
	   	 managerPE.cancel();
	     var data = managerPE.getData();
	    if(arriveMarker.getMap() != null ){
		    if(type=='MARKER'){
		     var pts = data[kakao.maps.drawing.OverlayType.MARKER];
		        if(pts.length==0){
		         managerPE.select(kakao.maps.drawing.OverlayType[type]);
		        }
		    }
		    else{
		        var linepath = data[kakao.maps.drawing.OverlayType.POLYLINE];
		         if(linepath.length == 0){
		   		 // 클릭한 그리기 요소 타입을 선택합니다
		    	 managerPE.select(kakao.maps.drawing.OverlayType[type]);
		    	}
		    }
	    }
	    else{
	    	alert("상단의 코스경로만들기에서 가져오기 후 진행해주세요");
	    }

	}  
	function backPE(){
	    if (managerPE.undoable()) {
		// 이전 상태로 되돌림
		managerPE.undo();
	}
	    }   
	function frontPE(){
	    if (managerPE.redoable()) {
		// 이전 상태로 되돌린 상태를 취소
		managerPE.redo();
	}
	    }  
    
	var polyObjPE =  new kakao.maps.Polyline();     
	function getInfoPE(){
		var data = managerPE.getData();
	    var pte = data[kakao.maps.drawing.OverlayType.MARKER];
	    var linepath = data[kakao.maps.drawing.OverlayType.POLYLINE];

	    if($(fixC).attr("val") == "y"){
			alert("상단의 코스경로만들기에서 가져오기 후 진행해주세요");
		}
		else if(pte.length==0){
			alert("대중교통마커를 그려주세요");
		}
		else if(linepath.length==0){
			alert("대중교통과 출발점과의 경로를 그려주세요");
		}
		else{
			var lineP = linepath[0].points;
	    	var linePLength = lineP.length;
	    	
			lineP[0].x = pte[0].x;
	    	lineP[0].y = pte[0].y;
	    	lineP[linePLength-1].x = arriveMarker.getPosition().getLng();
	    	lineP[linePLength-1].y = arriveMarker.getPosition().getLat();
	    	
		  	latPE.value = pte[0].y;
		    lonPE.value = pte[0].x;
		    
			var arr = Array();
		    var i=0, cnt=0;
			var pathStr="[";
		        for(; i<linePLength; i++){
		            cnt++;
		            arr[i] = new kakao.maps.LatLng(lineP[i].y, lineP[i].x);
		            var str = " new kakao.maps.LatLng("+lineP[i].y+","+lineP[i].x+")";
		            if(cnt < linePLength)
		           		 pathStr += str+",\r\n";
		            else
		                pathStr += str;
		        }
	        pathStr += "]";
	        
	        managerPE.remove(managerPE.getOverlays().polyline[0]);
		    managerPE.put(kakao.maps.drawing.OverlayType.POLYLINE, arr);
			$(fixPE).html("");
			$(fixPE).attr("val", "n");
		    
			polyObjPE.setPath(arr);
			var distance = (polyObjPE.getLength()/1000).toFixed(1);
	
			 linePE.value = pathStr;
		   	 disPE.value = distance;
		}
	}

	var mapTypes = { //자전거맵 표시변수
		    bicycle : kakao.maps.MapTypeId.BICYCLE
		};
		// 체크 박스를 선택하면 호출되는 함수입니다
	function setOverlayMapTypeId(m) { //자전거맵 함수
		var chkBicycle;
		if(m == map){
	   	  chkBicycle = document.getElementById('chkBicycle');
		}
		else if(m ==mapPS){
			chkBicycle = document.getElementById('chkBicyclePS');
		}
		else if(m ==mapPE){
			chkBicycle = document.getElementById('chkBicyclePE');
		}
	    m.removeOverlayMapTypeId(mapTypes.bicycle);
	    if (chkBicycle.checked) {
	        m.addOverlayMapTypeId(mapTypes.bicycle);    
	    }
	   
	}
//////////////////////////////////////////////////////// 파일드랍기능 구현
	var uploadFiles = [];
	var $drop = $("#drop");
	
	$drop.on("dragenter", function(e) { //드래그 요소가 들어왔을떄
		$(this).addClass('drag-over');
		}).on("dragleave", function(e) { //드래그 요소가 나갔을때
		$(this).removeClass('drag-over');
		}).on("dragover", function(e) {
			e.stopPropagation();
		e.preventDefault();
		}).on('drop', function(e) { //드래그한 항목을 떨어뜨렸을때
			e.preventDefault();
			$(this).removeClass('drag-over');
			var files = e.originalEvent.dataTransfer.files; //드래그&드랍 항목
			for(var i = 0; i < files.length; i++) {
				var file = files[i];
				var size = uploadFiles.push(file); //업로드 목록에 추가
				preview(file, size - 1); //미리보기 만들기
			}
		});

	function preview(file, idx) {
		var reader = new FileReader();
		reader.onload = (function(f, idx) {
			return function(e) {
				var div = '<div class="thumb"> \
				<div class="close" data-idx="' + idx + '">X</div> \
				<img src="' + e.target.result + '" title="' + escape(f.name) + '"/> \
				</div>';
				$("#thumbnails").append(div);
			};
		})(file, idx);
			reader.readAsDataURL(file);
	}


	
	$("#thumbnails").on("click", ".close", function(e) {
		var $target = $(e.target);
		var idx = $target.attr('data-idx');
		uploadFiles[idx].upload = 'disable'; //삭제된 항목은 업로드하지 않기 위해 플래그 생성
		$target.parent().remove(); //프리뷰 삭제
		});

////////////////////////////////////////////////////////
	function preCheck(){
		
		var cname = $.trim($(title).val());
		var fixCVal = $(fixC).attr("val"); 
		var fixPSVal = $(fixPS).attr("val"); 
		var fixPEVal = $(fixPE).attr("val");
		var fView = $("#firstView option:selected").val();
		var cDiff = $("#diff option:selected").val();
		var cwords = $.trim($(words).val());
		var sPTVal = $("#sPT option:selected").val();
		var sPTSt = $.trim($(sPTStation).val());
		var ePTVal = $("#ePT option:selected").val();
		var ePTSt = $.trim($(ePTStation).val());

		var krengAvail = /^[가-힣a-zA-Z\s]{2,10}$/;
		var krengnumAvail = /^[가-힣a-zA-Z0-9\s]{2,10}$/;
		var cnameCheck = krengAvail.test(cname);
		var sPTStCheck = krengnumAvail.test(sPTSt);
		var ePTStCheck = krengnumAvail.test(ePTSt);

		if(cname == ''){
			alert("페이지 상단의 코스명을 입력한 후 진행해주세요.");
			return 1;
		}
		if(cnameCheck == false){
			alert("코스명의 형식이 유효하지 않습니다(한글 또는 영문자 2~10자).");
			return 1;
		}  
		if(fixCVal != "n" || fixPSVal != "n" || fixPEVal != "n"){
			alert("코스만들기의 가져오기를 누른 후 진행해주세요.");
			return 1;
		}
		if(fView == 0){
			alert("코스풍경을 선택 후 진행해주세요.");
			return 1;
		}
		if(cDiff == 0){
			alert("코스난이도를 선택 후 진행해주세요.");
			return 1;
		}
		if(cwords == ''){
			alert("코스상세설명을 입력 후 진행해주세요.");
			return 1;
		}
		if(sPTVal ==0 || ePTVal==0 ){
			alert("대중교통을 선택한 후 진행해주세요.");
			return 1;
		}
		if(sPTSt =='' || ePTSt == '' ){
			alert("대중교통역 이름을 입력 후 진행해주세요.");
			return 1;
		}
		if(sPTStCheck == false || ePTStCheck == false ){
			alert("대중교통역 이름의 형식이 유효하지 않습니다(한글,영문자,숫자 2~10자)");
			return 1;
		}

		return 0;
	}
	$("#previewMakingCourse").click(function() {
		var fixCVal = $(fixC).attr("val");
		if(fixCVal != "n"){
			alert("코스 가져오기를 실행해야만 미리보기를 볼 수 있습니다.");
			return;
		}
		
		var c_name =  $.trim($(title).val());
	    var c_s_latitude = $.trim($(slat).val());
		var c_s_longitude =  $.trim($(slon).val());
		var c_s_locname =  $.trim($(sLoc).val());		
		var c_e_latitude =  $.trim($(elat).val());
		var c_e_longitude =  $.trim($(elon).val());
		var c_e_locname =  $.trim($(eLoc).val());
		var c_mapLevel =  $.trim($(mapLevel).val());
		var c_view1 = $.trim($(firstView).val());
		var c_view2 = $.trim($(secondView).val());
		var c_views = [];
		if(c_view1 != 0){
			c_views.push(c_view1);
		}
		if(c_view2 != 0){
			c_views.push(c_view2);
		}
		
		
		var c_words =  $.trim($(words).val());
		var c_difficulty =  $.trim($(diff).val());
		var c_distance =  $.trim($(dis).val());
		var c_time =  $.trim($(time).val());
		var c_line =  $.trim($(line).val());
	////////////////////////////////////////////////////
		var pts_latitude = $.trim($(latPS).val());
		var pts_longitude = $.trim($(lonPS).val());
		var pts_distance = $.trim($(disPS).val());
		var pts_img = $.trim($(sPT).val());
		var pts_station = $.trim($(sPTStation).val());
		var pts_line = $.trim($(linePS).val());
	////////////////////////////////////////////////////////////
		var pte_latitude = $.trim($(latPE).val());
		var pte_longitude = $.trim($(lonPE).val());
		var pte_distance = $.trim($(disPE).val());
		var pte_img = $.trim($(ePT).val());
		var pte_station = $.trim($(ePTStation).val());
		var pte_line = $.trim($(linePE).val());

		
		var courseData = {
				 "c_name": c_name,
			     "c_s_latitude" : c_s_latitude,
				 "c_s_longitude" : c_s_longitude,
				 "c_s_locname" : c_s_locname,
				 "c_e_latitude" : c_e_latitude,
				 "c_e_longitude" : c_e_longitude,
				 "c_e_locname" : c_e_locname,
				 "c_mapLevel" : c_mapLevel,
				 "c_views" : c_views,
				 "c_words" : c_words,
				 "c_difficulty" : c_difficulty,
				 "c_distance" : c_distance,
				 "c_time" : c_time,
				 "c_line" : c_line,

				 "pts_latitude" : pts_latitude,
				 "pts_longitude" : pts_longitude,
				 "pts_distance" : pts_distance,
				 "pts_img" : pts_img,
				 "pts_station" : pts_station,
				 "pts_line" : pts_line,

				 "pte_latitude" : pte_latitude,
				 "pte_longitude" : pte_longitude,
				 "pte_distance" : pte_distance,
				 "pte_img" : pte_img,
				 "pte_station" : pte_station,
				 "pte_line" : pte_line
			};
		console.log("코스명: "+c_name);
		console.log("출위도: "+c_s_latitude);
		console.log("출경도: "+c_s_longitude);
		console.log("출발명: "+c_s_locname);
		console.log("도위도: "+c_e_latitude);
		console.log("도경도: "+c_e_longitude);
		console.log("도착명: "+c_e_locname);
		console.log("맵레벨: "+c_mapLevel);
		console.log("풍경뷰 : " + c_views);
		console.log("설명: "+c_words);
		console.log("난이도: "+c_difficulty);
		console.log("코거리: "+c_distance);
		console.log("코타임: "+c_time);
		console.log("코라인: "+c_line);
		console.log("대출위도: "+pts_latitude);
		console.log("대출경도: "+pts_longitude);
		console.log("대출거리: "+pts_distance);
		console.log("대출이미지: "+pts_img);
		console.log("대출역: "+pts_station);
		console.log("대출라인: "+pts_line);
		console.log("대도위도: "+pte_latitude);
		console.log("대도경도: "+pte_longitude);
		console.log("대도거리: "+pte_distance);
		console.log("대도이미지: "+pte_img);
		console.log("대도역: "+pte_station);
		console.log("대도라인: "+pte_line);

		$.ajax({
			url:"/user/previewMakingCourse",
			type: "POST",
			data: courseData,
			success: function(){
				window.open("/user/preview","newWin","width=1200px,height=1000px,toolbar=no,resizable=no,location=no,menubar=no,directories=no,status=no");
			},
			error: function(){
				alert("에러발생");
			}
		})
	});

	$("#regCourse").click(function() {
		var check = preCheck();
		if(check == 1){
			return;
		}
		var preConfirm = confirm("등록하면 더 이상 수정이 불가능합니다.\r\n등록하시겠습니까?(미리보기를 통해 충분히 확인 후 진행해도 좋습니다)");

		if(preConfirm == false){
			return;
		}

		var c_name =  $.trim($(title).val());
	    var c_s_latitude = $.trim($(slat).val());
		var c_s_longitude =  $.trim($(slon).val());
		var c_s_locname =  $.trim($(sLoc).val());		
		var c_e_latitude =  $.trim($(elat).val());
		var c_e_longitude =  $.trim($(elon).val());
		var c_e_locname =  $.trim($(eLoc).val());
		var c_mapLevel =  $.trim($(mapLevel).val());
		var c_view1 = $.trim($(firstView).val());
		var c_view2 = $.trim($(secondView).val());
		var c_views = [];
		if(c_view1 != 0){
			c_views.push(c_view1);
		}
		if(c_view2 != 0){
			c_views.push(c_view2);
		}
		
		
		var c_words =  $.trim($(words).val());
		var c_difficulty =  $.trim($(diff).val());
		var c_distance =  $.trim($(dis).val());
		var c_time =  $.trim($(time).val());
		var c_line =  $.trim($(line).val());
	////////////////////////////////////////////////////
		var pts_latitude = $.trim($(latPS).val());
		var pts_longitude = $.trim($(lonPS).val());
		var pts_distance = $.trim($(disPS).val());
		var pts_img = $.trim($(sPT).val());
		var pts_station = $.trim($(sPTStation).val());
		var pts_line = $.trim($(linePS).val());
	////////////////////////////////////////////////////////////
		var pte_latitude = $.trim($(latPE).val());
		var pte_longitude = $.trim($(lonPE).val());
		var pte_distance = $.trim($(disPE).val());
		var pte_img = $.trim($(ePT).val());
		var pte_station = $.trim($(ePTStation).val());
		var pte_line = $.trim($(linePE).val());

		
		var courseData = {
				 "c_name": c_name,
			     "c_s_latitude" : c_s_latitude,
				 "c_s_longitude" : c_s_longitude,
				 "c_s_locname" : c_s_locname,
				 "c_e_latitude" : c_e_latitude,
				 "c_e_longitude" : c_e_longitude,
				 "c_e_locname" : c_e_locname,
				 "c_mapLevel" : c_mapLevel,
				 "c_views" : c_views,
				 "c_words" : c_words,
				 "c_difficulty" : c_difficulty,
				 "c_distance" : c_distance,
				 "c_time" : c_time,
				 "c_line" : c_line,

				 "pts_latitude" : pts_latitude,
				 "pts_longitude" : pts_longitude,
				 "pts_distance" : pts_distance,
				 "pts_img" : pts_img,
				 "pts_station" : pts_station,
				 "pts_line" : pts_line,

				 "pte_latitude" : pte_latitude,
				 "pte_longitude" : pte_longitude,
				 "pte_distance" : pte_distance,
				 "pte_img" : pte_img,
				 "pte_station" : pte_station,
				 "pte_line" : pte_line
			};
		console.log("코스명: "+c_name);
		console.log("출위도: "+c_s_latitude);
		console.log("출경도: "+c_s_longitude);
		console.log("출발명: "+c_s_locname);
		console.log("도위도: "+c_e_latitude);
		console.log("도경도: "+c_e_longitude);
		console.log("도착명: "+c_e_locname);
		console.log("맵레벨: "+c_mapLevel);
		console.log("풍경뷰 : " + c_views);
		console.log("설명: "+c_words);
		console.log("난이도: "+c_difficulty);
		console.log("코거리: "+c_distance);
		console.log("코타임: "+c_time);
		console.log("코라인: "+c_line);
		console.log("대출위도: "+pts_latitude);
		console.log("대출경도: "+pts_longitude);
		console.log("대출거리: "+pts_distance);
		console.log("대출이미지: "+pts_img);
		console.log("대출역: "+pts_station);
		console.log("대출라인: "+pts_line);
		console.log("대도위도: "+pte_latitude);
		console.log("대도경도: "+pte_longitude);
		console.log("대도거리: "+pte_distance);
		console.log("대도이미지: "+pte_img);
		console.log("대도역: "+pte_station);
		console.log("대도라인: "+pte_line);

		$.ajax({
			url:"/user/regCourse",
			type: "POST",
			data: courseData,
			success: function(response){
				if(response.code == "200"){
					alert("등록됫음");
					alert(response.message);
				}
				else{
					alert(response.message);
				}
			},
			error: function(){
				alert("에러발생");
			}
		});
	})

	/*
	  var c_s_latitude =  document.getElementById("c_s_latitude");
	var c_s_longitude =  document.getElementById("c_s_longitude");
	var c_s_locname =  document.getElementById("c_s_locname");
	
	var c_e_latitude =  document.getElementById("c_e_latitude");
	var c_e_longitude =  document.getElementById("c_e_longitude");
	var c_e_locname =  document.getElementById("c_e_locname");
	var c_mapLevel =  document.getElementById("c_mapLevel");
	var c_distance =  document.getElementById("c_distance");
	var c_time =  document.getElementById("c_time");
	var c_line =  document.getElementById("c_line");
	var fixC = $("#fixC");  // 수정시 가져오기필요문구 나타낼스판
////////////////////////////////////////////////////
	var pts_latitude = document.getElementById("pts_latitude");
	var pts_longitude = document.getElementById("pts_longitude");
	var pts_distance = document.getElementById("pts_distance");
	var pts_img = document.getElementById("pts_img");
	var pts_station = document.getElementById("pts_station");
	var pts_line = document.getElementById("pts_line");
	var fixPS = $("#fixPS"); // 수정시 가져오기필요문구 나타낼스판
////////////////////////////////////////////////////////////*
	var pte_latitude = document.getElementById("pte_latitude");
	var pte_longitude = document.getElementById("pte_longitude");
	var pte_distance = document.getElementById("pte_distance");
	var pte_img = document.getElementById("pte_img");
	var pte_station = document.getElementById("pte_station");
	var pte_line = document.getElementById("pte_line");
	var fixPE = $("#fixPE");  // 수정시 가져오기필요문구 나타낼스판
	*/
})
</script>
</head>
<body>
<header>
      <div id="logo">
         <a href="/mainPage"><img src='/headerImg/logo.png' height="100"></a>
      </div>
      <div id="login">
         <c:choose>
      	<c:when test="${m == null }">
      		<a href="/login">로그인</a>&nbsp;&nbsp;&nbsp;<a href="/signUp">회원가입</a>
      	</c:when>
      	<c:when test="${m != null }">
      		${m.nickName } 라이더! &nbsp;&nbsp;<a href="/logout">로그아웃</a>&nbsp;&nbsp;<a href="modify.do">마이페이지</a>
      	</c:when>
      </c:choose>
         <img src="img/myIcon.png" height="40">
         &nbsp;&nbsp;
      </div>
      <div id="top">
         오늘의 라이딩&nbsp;&nbsp;&nbsp;&nbsp;자전거길&nbsp;&nbsp;&nbsp;&nbsp;<a href="listReview.do">후기게시판</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="listMeeting.do">번개게시판</a>&nbsp;&nbsp;&nbsp;&nbsp;정보게시판
      </div>
   </header>
      <div id="clear"></div>
<section>
<div><h1>나만의 DIY 코스</h1></div>
<br>
<span id="cTitle">코스명 :</span><input type="text" name="title"  id="title">
<br>
<br>

<div id="map" style="width:1000px;height:500px;"></div>
<p>
    <button id="startC">출발</button>
    <button id="arriveC">도착</button>
    <button id="polyC" >선</button>
    <button id="backPolyC" class="disabled" disabled >선 되돌리기</button>
    <button id="frontPolyC"  class="disabled" disabled>선 앞돌리기</button>
    <button id="infoC" >가져오기</button><span id="fixC" val="y"></span> <br>
   <input type="checkbox" id="chkBicycle" /> 자전거도로 정보 보기
</p>

출발 - 위도 : <input type="text" id="slat" name="slat" value="0">
경도 : <input type="text" id="slon" name="slon" value="0">
출발지역명 : <input type="text" id="sLoc" name="sLoc">
<br>
도착 - 위도 : <input type="text" id="elat" name="elat" value="0">
경도 : <input type="text" id="elon" name="elon" value="0">
도착지역명 : <input type="text" id="eLoc" name="eLoc">
<br>
풍경(2개까지 선택가능) 1순위 :
<select id="firstView">
	<option value="0">--선택--</option>
	<option value="강">강</option>
	<option value="산">산</option>
	<option value="명소">명소</option>
	<option value="바다">바다</option>
</select>
2순위 :
<select id="secondView">
	<option value="0">--선택--</option>
	<option value="강">강</option>
	<option value="산">산</option>
	<option value="명소">명소</option>
	<option value="바다">바다</option>
</select>
<br>
거리 :  <input type="text"  id="dis" name="dis" value="0">km<br>
시간 : <input type="text" id="time" name="time" value="0">분<br>
난이도 : <select id="diff">
		<option value="0">--난이도 선택--</option>
		<option value="1">쉬움</option>
		<option value="2">보통</option>
		<option value="3">어려움</option>
		<option value="4">매우 어려움</option>
</select>
맵레벨: <input type="text" id="mapLevel" name="mapLevel" value="7"><br>
선경로 <br>
<textarea rows="10" cols="80" id="line" name="line" readonly="readonly"></textarea>
<br>
[코스설명]
<br>
<textarea rows="10" cols="100" id="words" name="words" placeholder="ex)시원한 강과함께 들판을 나란히 두고 라이딩하는 ...."  ></textarea>
<br>
[코스사진]<br>
<div id="drop" style="border:1px solid black; width:800px; height:300px; padding:3px">
<div id="thumbnails">
</div>
</div>
<br><br><br>
[출발점 대중교통]
<div id="mapPS" style="width:1000px;height:400px;"></div><br>
  <button id="publicTranportPS" >대중교통표시</button>
    <button id="polyPS" >선</button>
    <button id="backPolyPS" class="disabled" disabled>선 되돌리기</button>
    <button id="frontPolyPS" class="disabled" disabled>선 앞돌리기</button>
    <button id="infoPS" >가져오기</button><span id="fixPS" val="y"></span> <br>
     <input type="checkbox" id="chkBicyclePS" /> 자전거도로 정보 보기
    <br>
대중교통위치 - 위도 : <input type="text" id="latPS" name="latPS" value="0"> 경도 : <input type="text" id="lonPS" name="lonPS" value="0">
<br>
거리 :  <input type="text" id="disPS" name="disPS" value="0">km 
<select id="sPT" name="sPT">
<option value="(입력안함)">--대중교통선택--</option>
<option value="버스">버스</option>
<option value="1호선">1호선</option>
<option value="2호선">2호선</option>
<option value="3호선">3호선</option>
</select>
 역이름 : <input type="text" id="sPTStation" placeholder="ex)신촌역,신촌오거리..">
<br>
대중교통출발 선경로 <br>
<textarea rows="10" cols="80" id="linePS" name="linePS" readonly="readonly"></textarea>
<br><br><br>
[도착점 대중교통]
<div id="mapPE" style="width:1000px;height:400px;"></div><br>
  <button  id="publicTranportPE" >대중교통표시</button>
    <button id="polyPE" >선</button>
    <button id="backPolyPE" class="disabled" disabled>선 되돌리기</button>
    <button id="frontPolyPE" class="disabled" disabled>선 앞돌리기</button>
    <button id="infoPE" >가져오기</button><span id="fixPE" val="y"></span> <br>
     <input type="checkbox" id="chkBicyclePE" /> 자전거도로 정보 보기
    <br>

대중교통위치 - 위도 : <input type="text" id="latPE" name="latPE" value="0"> 경도 : <input type="text" id="lonPE" name="lonPE" value="0">
<br>
거리 :  <input type="text" id="disPE" name="disPE" value="0">km
<select id="ePT" name="ePT">
<option value="(입력안함)">--대중교통선택--</option>
<option value="버스">버스</option>
<option value="1호선">1호선</option>
<option value="2호선">2호선</option>
<option value="3호선">3호선</option>
</select>
  역이름 : <input type="text" id="ePTStation" placeholder="ex)신촌역,신촌오거리..">
<br>
대중교통도착 선경로 <br>
<textarea rows="10" cols="80" id="linePE" name="linePE" readonly="readonly"></textarea>
<br><br>
<button id="previewMakingCourse">미리보기</button> <button id="regCourse">등록</button>
</section>
	<div id="clear"></div>
  	
   <footer>
      <div id='footer_box'>
            <div id="footer_icon" >
               <img src='img/instagram.png' height="50px">
               <img src='img/facebook.png' height="50px">
               <img src='img/twitter.png' height="50px">
               <ul id="address">
                  <li>04108 | 서울시 마포구 백범로 23 구프라자 3층</li>
                  <li>TEL: 02-707-1480 | Email: ora@bit.com</li>
                  <li>COPYRIGHT (C)2020 오늘의 라이딩 ALL RIGHTS RESERVED</li>
               </ul>
            </div>
            
         </div>
   </footer>
</body>
</html>