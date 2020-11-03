<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

 /*매인섹션 시작----------------  */
 section {
 	  margin: 0 auto;
 	  width: 1000px;
 }
 #cTitle{
	font-size: 140%;
}

 /*매인섹션 끝 ------------------*/

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
window.onload = function(){
	const courseName =  document.getElementById("courseName");
	const slat =  document.getElementById("slat");
	const slon =  document.getElementById("slon");
	const sLoc =  document.getElementById("sLoc");
	
	const elat =  document.getElementById("elat");
	const elon =  document.getElementById("elon");
	const eLoc =  document.getElementById("eLoc");
	const words = document.getElementById("words");
	const firstView =  document.getElementById("firstView");
	const secondView =  document.getElementById("secondView");
	const dis =  document.getElementById("dis");
	const time =  document.getElementById("time");
	const diff =  document.getElementById("diff");
	const line =  document.getElementById("line");
	const fixC =  document.getElementById("fixC"); // 수정시 가져오기필요문구 나타낼스판
////////////////////////////////////////////////////
	const latPS = document.getElementById("latPS");
	const lonPS = document.getElementById("lonPS");
	const sPT = document.getElementById("sPT");
	const sPTStation = document.getElementById("sPTStation");
	const disPS = document.getElementById("disPS");
	const linePS = document.getElementById("linePS");
	const fixPS = document.getElementById("fixPS"); // 수정시 가져오기필요문구 나타낼스판
////////////////////////////////////////////////////////////
	const latPE = document.getElementById("latPE");
	const lonPE = document.getElementById("lonPE");
	const ePT = document.getElementById("ePT");
	const ePTStation = document.getElementById("ePTStation");
	const disPE = document.getElementById("disPE");
	const linePE = document.getElementById("linePE");
	const fixPE = document.getElementById("fixPE");;  // 수정시 가져오기필요문구 나타낼스판

////////////////////////////////////////////////////////////// 변수선언끝 	
	const courseNameCnt = document.getElementById("courseNameCnt");  // 10자
	const wordsCnt = document.getElementById("wordsCnt");  // 3000자
	const sPTStationCnt = document.getElementById("sPTStationCnt"); // 14자
	const ePTStationCnt = document.getElementById("ePTStationCnt"); // 14자

	const courseNameMaxCnt = 10;
	const wordsMaxCnt = 3000;
	const stationMaxCnt = 14;
	
	courseName.addEventListener("keydown", function(e) {
		textCount(e.target, courseNameCnt, courseNameMaxCnt);
	});
	courseName.addEventListener("keyup", function(e) {
		textCount(e.target, courseNameCnt, courseNameMaxCnt);
	});
	words.addEventListener("keydown", function(e) {
		textCount(e.target, wordsCnt, wordsMaxCnt);
	});
	words.addEventListener("keyup", function(e) {
		textCount(e.target, wordsCnt, wordsMaxCnt);
	});
	sPTStation.addEventListener("keydown", function(e) {
		textCount(e.target, sPTStationCnt, stationMaxCnt);
	});
	sPTStation.addEventListener("keyup", function(e) {
		textCount(e.target, sPTStationCnt, stationMaxCnt);
	});
	ePTStation.addEventListener("keydown", function(e) {
		textCount(e.target, ePTStationCnt, stationMaxCnt);
	});
	ePTStation.addEventListener("keyup", function(e) {
		textCount(e.target, ePTStationCnt, stationMaxCnt);
	});

	function textCount(textArea, countTag, maxCnt){  // 글자수세는 함수
		let txtCnt = textArea.value.length;
		if(txtCnt > maxCnt){
			txtCnt = maxCnt;
		}
		countTag.innerHTML = txtCnt+" / "+maxCnt;
	}

// ------------------------- 글자수 세기 이벤트끝 (코스명,코스설명,출발도착대중교통역)

// ------------------------------------------------------- 풍경 2순위 노드생성
	firstView.addEventListener("change", function(e) {
		let secondViewContent = '<option value="0">--선택안함--</option>';
		let secondViewArr;
		const fViewValue = e.target.value;
		if(fViewValue == "0"){
			secondViewArr = [];
		}
		if(fViewValue == "강"){
			secondViewArr = ["산","명소","바다"];
		}
		if(fViewValue == "산"){
			secondViewArr = ["강","명소","바다"];
		}
		if(fViewValue == "명소"){
			secondViewArr = ["강","산","바다"];
		}
		if(fViewValue == "바다"){
			secondViewArr = ["강","산","명소"];
		}

		secondViewArr.forEach(function(v, i) {
			secondViewContent += '<option value='+v+'>'+v+'</option>';
		});

		secondView.innerHTML = secondViewContent;
	});
// --------------------------------------------------------- 풍경2순위 노드생성 끝
	document.getElementById("startC").addEventListener("click", function(e) {
		selectOverlay('MARKER');
	});
	document.getElementById("arriveC").addEventListener("click", function(e) {
		selectOverlay2('MARKER');
	});
	document.getElementById("polyC").addEventListener("click", function(e) {
		selectOverlay3('POLYLINE');
	});
	document.getElementById("backPolyC").addEventListener("click", function(e) {
		back();
	});
	document.getElementById("frontPolyC").addEventListener("click", function(e) {
		front();
	});
	document.getElementById("infoC").addEventListener("click", function(e) {
		getInfo();
	});
	document.getElementById("chkBicycle").addEventListener("click", function(e) {
		setOverlayMapTypeId(map);
	});

//////////////////////////////////////// 코스끝
	document.getElementById("publicTranportPS").addEventListener("click", function(e) {
		selectOverlayPS('MARKER');
	});
	document.getElementById("polyPS").addEventListener("click", function(e) {
		selectOverlayPS('POLYLINE');
	});
	document.getElementById("backPolyPS").addEventListener("click", function(e) {
		backPS();
	});
	document.getElementById("frontPolyPS").addEventListener("click", function(e) {
		frontPS();
	});
	document.getElementById("infoPS").addEventListener("click", function(e) {
		getInfoPS();
	});
	document.getElementById("chkBicyclePS").addEventListener("click", function(e) {
		setOverlayMapTypeId(mapPS);
	});

//////////////////////////////////////////// 대중교통 출발점 끝
	document.getElementById("publicTranportPE").addEventListener("click", function(e) {
		selectOverlayPE('MARKER');
	});
	document.getElementById("polyPE").addEventListener("click", function(e) {
		selectOverlayPE('POLYLINE');
	});
	document.getElementById("backPolyPE").addEventListener("click", function(e) {
		backPE();
	});
	document.getElementById("frontPolyPE").addEventListener("click", function(e) {
		frontPE();
	});
	document.getElementById("infoPE").addEventListener("click", function(e) {
		getInfoPE();
	});
	document.getElementById("chkBicyclePE").addEventListener("click", function(e) {
		setOverlayMapTypeId(mapPE);
	});

//////////////////////////////////////////////대중교통 도착점 끝
	
////////////////////////////////////////////////////////////	
	  
	const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.52084556725995, 126.97701335521351), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	    };
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	const map = new kakao.maps.Map(mapContainer, mapOption); 
	const mapTypeControl = new kakao.maps.MapTypeControl();
	const zoomControl = new kakao.maps.ZoomControl();
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	const options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
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
	    
	const options2 = { // Drawing Manager를 생성할 때 사용할 옵션입니다
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

	const options3 = { // Drawing Manager를 생성할 때 사용할 옵션입니다
	    map: map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
	    drawingMode: [ // drawing manager로 제공할 그리기 요소 모드입니다
	        kakao.maps.drawing.OverlayType.POLYLINE
	    ],
	    // 사용자에게 제공할 그리기 가이드 툴팁입니다
	    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
	    guideTooltip: ['draw', 'edit'], 
	    polylineOptions: { // 선 옵션입니다
	    //    draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
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
	const manager = new kakao.maps.drawing.DrawingManager(options);
	const manager2 = new kakao.maps.drawing.DrawingManager(options2);
	const manager3 = new kakao.maps.drawing.DrawingManager(options3);

	function setFixC(){
		fixC.innerHTML="가져오기를 눌러주세요";
		fixC.setAttribute("val", "y");
		fixPS.innerHTML="가져오기를 눌러주세요";
		fixPS.setAttribute("val", "y");
		fixPE.innerHTML="가져오기를 눌러주세요";
		fixPE.setAttribute("val", "y");
	}
	manager.addListener('state_changed', function() { // 3개의 맵에서 수정이 일어나면 가져오기를 진행하라고 표시
		setFixC();
	});
	manager2.addListener('state_changed', function() {
		setFixC();
	});
	
	manager3.addListener('state_changed', function() {
		const undoBtn =  document.getElementById("backPolyC");
		const redoBtn =  document.getElementById("frontPolyC");
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
		const data = manager.getData();
		const start = data[kakao.maps.drawing.OverlayType.MARKER];
	    if(start.length==0){
		   // 클릭한 그리기 요소 타입을 선택합니다
		   manager.select(kakao.maps.drawing.OverlayType[type]);
	      
	    }
		manager2.cancel();
	    manager3.cancel();
	}
	function selectOverlay2(type) {
		const data = manager2.getData();
		const end = data[kakao.maps.drawing.OverlayType.MARKER];
	    if(end.length==0){ 
	    	// 클릭한 그리기 요소 타입을 선택합니다
	     	manager2.select(kakao.maps.drawing.OverlayType[type]);
	    }
	    manager.cancel();
		manager3.cancel();
	}
	function selectOverlay3(type) {
		const data = manager3.getData();
		const linepath = data[kakao.maps.drawing.OverlayType.POLYLINE];
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
	    
	const geocoder = new kakao.maps.services.Geocoder();

	const startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
	startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
	startOption = { 
	offset: new kakao.maps.Point(15, 43) // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	};
	//출발 마커 이미지를 생성합니다
	const startImage = new kakao.maps.MarkerImage(startSrc, startSize, startOption);

	//출발 마커를 생성합니다
	const startMarker = new kakao.maps.Marker({
	image: startImage // 출발 마커이미지를 설정합니다
	});

	const arriveSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
	arriveSize = new kakao.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
	arriveOption = { 
	offset: new kakao.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	};
	//도착 마커 이미지를 생성합니다
	const arriveImage = new kakao.maps.MarkerImage(arriveSrc, arriveSize, arriveOption);

	//도착 마커를 생성합니다 
	const arriveMarker = new kakao.maps.Marker({  
	image: arriveImage // 도착 마커이미지를 설정합니다
	});
	
	const polyObj = new kakao.maps.Polyline(); // 라인의 길이를 담기위한 폴리라인객체
	function getInfo() {
	
	    if(!manager.getOverlays().marker[0]){
	    	alert("출발점마커를 그려주세요");
	    }
	    else if(!manager2.getOverlays().marker[0]){
	    	alert("도착점마커를 그려주세요");
		}
	    else if(!manager3.getOverlays().polyline[0]){
	    	alert("출발점과 도착점의 경로를 그려주세요");
		}
	    else{ 

			const sMarkerLatLon = manager.getOverlays().marker[0].getPosition();
			const eMarkerLatLon = manager2.getOverlays().marker[0].getPosition();
			
	    	const data = manager3.getData();
	    	const latlonArr = data[kakao.maps.drawing.OverlayType.POLYLINE][0].points;
			console.log(latlonArr[0]);
			latlonArr[0].x = sMarkerLatLon.getLng();
			latlonArr[0].y = sMarkerLatLon.getLat();
			latlonArr[latlonArr.length-1].x = eMarkerLatLon.getLng();
			latlonArr[latlonArr.length-1].y = eMarkerLatLon.getLat();
		
			slat.value = sMarkerLatLon.getLat();
	   		slon.value = sMarkerLatLon.getLng();
	   		geocoder.coord2Address(sMarkerLatLon.getLng(), sMarkerLatLon.getLat(), function(result, status) {
			    if(status === kakao.maps.services.Status.OK) {
			       sLoc.value = result[0].address.address_name;
			    }
			});
			//////////////// 대중교통 출발점 위치표시
			startMarker.setPosition(sMarkerLatLon);
			startMarker.setMap(mapPS);
			mapPS.setCenter(sMarkerLatLon);
			///////////// 대중교통 출발점표시 끝	
			
			elat.value = eMarkerLatLon.getLat();
	   		elon.value = eMarkerLatLon.getLng();
		    geocoder.coord2Address(eMarkerLatLon.getLng(), eMarkerLatLon.getLat(), function(result, status) {
			    if(status === kakao.maps.services.Status.OK) {
			       eLoc.value = result[0].address.address_name;
			    }
			});
		///////////// 대중교통 도착점 표시
		arriveMarker.setPosition(eMarkerLatLon);
		arriveMarker.setMap(mapPE);
		mapPE.setCenter(eMarkerLatLon);
		/////////////// 대중교통 도착점 표시 끝   
	    let cnt=0;
	    let pathStr="[";
	        for(let i=0; i<latlonArr.length; i++){
	            cnt++;
	            let str = " new kakao.maps.LatLng("+latlonArr[i].y+","+latlonArr[i].x+")";
	            latlonArr[i] = new kakao.maps.LatLng(latlonArr[i].y,latlonArr[i].x);
	            if(cnt < latlonArr.length)
	           		 pathStr += str+",\r\n";
	            else
	                pathStr += str;
	        }
	   pathStr += "]";

	    manager3.remove(manager3.getOverlays().polyline[0]);
	    manager3.put(kakao.maps.drawing.OverlayType.POLYLINE, latlonArr);
    	fixC.innerHTML=""; // 새로 라인을 그리기 후 가져오기눌러주세요 글을 없앤다
    	fixC.setAttribute("val", "n");
    	
		polyObj.setPath(latlonArr);
		const distance = (polyObj.getLength()/1000).toFixed(1);
		
		line.value = pathStr;
	    dis.value = distance;
	    time.value = (distance/20*60).toFixed(0);
	  }
	}

//////////////////////////////////////////////////////////////////////// 코스설정끝

	const mapContainerPS = document.getElementById('mapPS'), // 지도를 표시할 div 
	 mapOptionPS = { 
	        center: new kakao.maps.LatLng(37.52084556725995, 126.97701335521351), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	 };

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	const mapPS = new kakao.maps.Map(mapContainerPS, mapOptionPS); 
	const mapTypeControlPS = new kakao.maps.MapTypeControl();
	const zoomControlPS = new kakao.maps.ZoomControl();
	mapPS.addControl(mapTypeControlPS, kakao.maps.ControlPosition.TOPRIGHT);
	mapPS.addControl(zoomControlPS, kakao.maps.ControlPosition.RIGHT);

	const optionsPS = { // Drawing Manager를 생성할 때 사용할 옵션입니다
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
	       // draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
	        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
	        editable: true, // 그린 후 수정할 수 있도록 설정합니다 
	        endArrow: true,
	        strokeColor: '#404040', // 선 색
	        strokeWeight:4,
	        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
	        hintStrokeOpacity: 0.8  // 그리중 마우스를 따라다니는 보조선의 투명도
	    }
	}; 
	const managerPS = new kakao.maps.drawing.DrawingManager(optionsPS);
	
	managerPS.addListener('state_changed', function() {
		const undoBtn =  document.getElementById("backPolyPS");
		const redoBtn =  document.getElementById("frontPolyPS");
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
		fixPS.innerHTML="가져오기를 눌러주세요!";
		fixPS.setAttribute("val", "y");
	});
	 
	function selectOverlayPS(type) {
	   	 managerPS.cancel();
	   	const data = managerPS.getData();
	     if(startMarker.getMap() != null){
		    if(type=='MARKER'){
		    	const pts = data[kakao.maps.drawing.OverlayType.MARKER];
		        if(pts.length==0){
		        	 managerPS.select(kakao.maps.drawing.OverlayType[type]);
		        }
		    }
		    else{
		    	const linepath = data[kakao.maps.drawing.OverlayType.POLYLINE];
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
	const polyObjPS =  new kakao.maps.Polyline();   
	function getInfoPS(){
		if(fixC.getAttribute("val") == "y"){
			alert("상단의 코스경로만들기에서 가져오기 후 진행해주세요");
		}
		else if(!managerPS.getOverlays().marker[0]){
			alert("대중교통마커를 그려주세요");
		}
		else if(!managerPS.getOverlays().polyline[0]){
			alert("대중교통과 출발점과의 경로를 그려주세요");
		}
		else{
			const psMarkerLatLon = managerPS.getOverlays().marker[0].getPosition();
			const data = managerPS.getData();
			const latlonArr = data[kakao.maps.drawing.OverlayType.POLYLINE][0].points;	
	
			latlonArr[0].x = psMarkerLatLon.getLng();
			latlonArr[0].y = psMarkerLatLon.getLat();
			latlonArr[latlonArr.length-1].x = startMarker.getPosition().getLng();
			latlonArr[latlonArr.length-1].y = startMarker.getPosition().getLat();
	    	
		  	latPS.value = psMarkerLatLon.getLat();
		    lonPS.value = psMarkerLatLon.getLng();
	  
		    let cnt=0;
		    let pathStr="[";
		        for(let i=0; i<latlonArr.length; i++){
		            cnt++;
		            let str = " new kakao.maps.LatLng("+latlonArr[i].y+","+latlonArr[i].x+")";
		            latlonArr[i] = new kakao.maps.LatLng(latlonArr[i].y,latlonArr[i].x);
		            if(cnt < latlonArr.length)
		           		 pathStr += str+",\r\n";
		            else
		                pathStr += str;
		        }
		   pathStr += "]";
	
		    managerPS.remove(managerPS.getOverlays().polyline[0]);
		    managerPS.put(kakao.maps.drawing.OverlayType.POLYLINE, latlonArr);
		    fixPS.innerHTML="";
			fixPS.setAttribute("val", "n");
			polyObjPS.setPath(latlonArr);
			const distance = (polyObjPS.getLength()/1000).toFixed(1);
	
			linePS.value = pathStr;
		   	disPS.value = distance;
		}
	}
/////////////////////////////////////////////////// 출발점 교통편 끝

	const mapContainerPE = document.getElementById('mapPE'), // 지도를 표시할 div 
	 mapOptionPE = { 
	        center: new kakao.maps.LatLng(37.52084556725995, 126.97701335521351), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	    };

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	const mapPE = new kakao.maps.Map(mapContainerPE, mapOptionPE); 
	const mapTypeControlPE = new kakao.maps.MapTypeControl();
	const zoomControlPE = new kakao.maps.ZoomControl();
	mapPE.addControl(mapTypeControlPE, kakao.maps.ControlPosition.TOPRIGHT);
	mapPE.addControl(zoomControlPE, kakao.maps.ControlPosition.RIGHT);


	const optionsPE = { // Drawing Manager를 생성할 때 사용할 옵션입니다
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
	       // draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
	        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
	        editable: true, // 그린 후 수정할 수 있도록 설정합니다 
	        endArrow: true,
	        strokeColor: '#404040', // 선 색
	        strokeWeight:4,
	        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
	        hintStrokeOpacity: 0.8  // 그리중 마우스를 따라다니는 보조선의 투명도
	    }
	}; 
	const managerPE = new kakao.maps.drawing.DrawingManager(optionsPE);

		managerPE.addListener('state_changed', function() {
			const undoBtn =  document.getElementById("backPolyPE");
			const redoBtn =  document.getElementById("frontPolyPE");
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
			fixPE.innerHTML="가져오기를 눌러주세요!";
			fixPE.setAttribute("val", "y");
	});
	    
	function selectOverlayPE(type) {
	   	 managerPE.cancel();
	   	const data = managerPE.getData();
	    if(arriveMarker.getMap() != null ){
		    if(type=='MARKER'){
		    	const pts = data[kakao.maps.drawing.OverlayType.MARKER];
		        if(pts.length==0){
		         managerPE.select(kakao.maps.drawing.OverlayType[type]);
		        }
		    }
		    else{
		    	const linepath = data[kakao.maps.drawing.OverlayType.POLYLINE];
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
    
	const polyObjPE =  new kakao.maps.Polyline();     
	function getInfoPE(){
		if(fixC.getAttribute("val") == "y"){
			alert("상단의 코스경로만들기에서 가져오기 후 진행해주세요");
		}
		else if(!managerPE.getOverlays().marker[0]){
			alert("대중교통마커를 그려주세요");
		}
		else if(!managerPE.getOverlays().polyline[0]){
			alert("대중교통과 출발점과의 경로를 그려주세요");
		}
		else{
			const peMarkerLatLon = managerPE.getOverlays().marker[0].getPosition();
			const data = managerPE.getData();
			const latlonArr = data[kakao.maps.drawing.OverlayType.POLYLINE][0].points;
	
			latlonArr[0].x = peMarkerLatLon.getLng();
			latlonArr[0].y = peMarkerLatLon.getLat();
			latlonArr[latlonArr.length-1].x = arriveMarker.getPosition().getLng();
			latlonArr[latlonArr.length-1].y = arriveMarker.getPosition().getLat();
	    	
		  	latPE.value = peMarkerLatLon.getLat();
		    lonPE.value = peMarkerLatLon.getLng();
	  
		    let cnt=0;
		    let pathStr="[";
		        for(let i=0; i<latlonArr.length; i++){
		            cnt++;
		            let str = " new kakao.maps.LatLng("+latlonArr[i].y+","+latlonArr[i].x+")";
		            latlonArr[i] = new kakao.maps.LatLng(latlonArr[i].y,latlonArr[i].x);
		            if(cnt < latlonArr.length)
		           		 pathStr += str+",\r\n";
		            else
		                pathStr += str;
		        }
		   pathStr += "]";
	
		    managerPE.remove(managerPE.getOverlays().polyline[0]);
		    managerPE.put(kakao.maps.drawing.OverlayType.POLYLINE, latlonArr);
		    fixPE.innerHTML="";
			fixPE.setAttribute("val", "n");
			polyObjPE.setPath(latlonArr);
			const distance = (polyObjPE.getLength()/1000).toFixed(1);
	
			linePE.value = pathStr;
		   	disPE.value = distance;
		}
	}

	const mapTypes = { //자전거맵 표시변수
		    bicycle : kakao.maps.MapTypeId.BICYCLE
		};
		// 체크 박스를 선택하면 호출되는 함수입니다
	function setOverlayMapTypeId(m) { //자전거맵 함수
		let chkBicycle;
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
	////////////-------------------------------바이크루트
	const bike = document.getElementById("bike");
	const bikeFile = document.getElementById("bikeFile");
	bike.addEventListener("click", function(e) {
		let reader = new FileReader();
		const file = bikeFile.files[0];
		reader.onload = function () {
			const courseBounds = new kakao.maps.LatLngBounds();
//			const parser = new DOMParser();
//			const xmlTrk = parser.parseFromString(reader.result, "text/xml");
//			console.log(xmlTrk);
//			const trkpaaa = xmlTrk.getElementsByTagName("trkpt");
//			console.log(trkpaaa[0]);
//			for(let i=0; i<trkpaaa.length; i++){
//				console.log(trkpaaa[i]);
//			}

			const  trkptArr = $(reader.result).find("trkpt");
			let latlonArr = new Array();
			$(trkptArr).each(function(i, element) {
				let lat = $(this).attr("lat");
				let lon = $(this).attr("lon");
				latlonArr[i] = new kakao.maps.LatLng(lat,lon);
				courseBounds.extend(latlonArr[i]);
			});
			if(manager.getOverlays().marker[0]){
				manager.remove(manager.getOverlays().marker[0]);
			}	
			manager.put(kakao.maps.drawing.OverlayType.MARKER, latlonArr[0],0);

			if(manager2.getOverlays().marker[0]){
				manager2.remove(manager2.getOverlays().marker[0]);
			}	
			manager2.put(kakao.maps.drawing.OverlayType.MARKER, latlonArr[latlonArr.length-1],0);
			
			if(manager3.getOverlays().polyline[0]){
				manager3.remove(manager3.getOverlays().polyline[0]);
			}	
			manager3.put(kakao.maps.drawing.OverlayType.POLYLINE, latlonArr);
			map.setBounds(courseBounds);
		};
			reader.readAsText(file, "UTF-8");

	})
	
//////////////////////////////////////////////////////// 파일드랍기능 구현
	const photoReg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
	
	const uploadFiles = [];
	const $drop = $("#drop");
	
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
			for(let i = 0; i < files.length; i++) {
				const file = files[i];
				if (!file.type.match(photoReg)) {
		              alert("확장자는 이미지 확장자만 가능합니다.");
		              continue;
		        }
				if(cPhotoNumCheck() >= 10){
					alert("사진은 최소4장 최대 10장까지만 등록가능합니다");
					return;
				}
				const size = uploadFiles.push(file); //업로드 목록에 추가
				preview(file, size - 1); //미리보기 만들기
			}
		});

	function preview(file, idx) {
		const reader = new FileReader();
		reader.onload = (function(f, idx) {
			return function(e) {
				const div = '<div class="thumb"> \
				<div class="close" data-idx="' + idx + '">X</div> \
				<img src="' + e.target.result + '" title="' + escape(f.name) + '"/> \
				</div>';
				$("#thumbnails").append(div);
			};
		})(file, idx);
			reader.readAsDataURL(file);
	}


	
	$("#thumbnails").on("click", ".close", function(e) {
		const $target = $(e.target);
		const idx = $target.attr('data-idx');
		uploadFiles[idx].upload = 'disable'; //삭제된 항목은 업로드하지 않기 위해 플래그 생성
		$target.parent().remove(); //프리뷰 삭제
		});

	function cPhotoNumCheck(){
		let cPhotoCnt = 0;  // 업로드할 사진수 체크
		uploadFiles.forEach(function(file, i) {
			if(file.upload != 'disable'){
				cPhotoCnt++;
			}
		})

		return cPhotoCnt;
	}
	
	
////////////////////////////////////////////////////////
	function preCheck(){ // 미리보기,등록 할때 값들 제어를 할 함수
		
		const cname = courseName.value.trim();
		const fixCVal = fixC.getAttribute("val");
		const fixPSVal = fixPS.getAttribute("val");
		const fixPEVal = fixPE.getAttribute("val");		
		const fView = firstView.options[firstView.selectedIndex].value;	
		const cDiff = diff.options[diff.selectedIndex].value;	
		const cwords = words.value.trim();

		const sPTVal = sPT.options[sPT.selectedIndex].value;
		const sPTSt = sPTStation.value.trim();
		const ePTVal = ePT.options[ePT.selectedIndex].value;
		const ePTSt = ePTStation.value.trim();

		const cPhotoCnt = cPhotoNumCheck();
		
		const krengAvail = /^[가-힣a-zA-Z\s]{2,10}$/;
		const krengnumAvail = /^[가-힣a-zA-Z0-9\s]{2,14}$/;
		const cnameCheck = krengAvail.test(cname);
		const sPTStCheck = krengnumAvail.test(sPTSt);
		const ePTStCheck = krengnumAvail.test(ePTSt);

		function cnameDupCheck(){  // 코스명 중복검사 함수
			let check = "1";
			$.ajax({
				url: "/user/cnameDupCheck",
				type: "POST",
				async: false,
				data:{"c_name" : cname},
				success: function(re){
					check = re;
				},
				error: function(){
					alert("에러발생");
				}
			});
			return check;
		}

		if(cname == ''){
			alert("페이지 상단의 코스명을 입력한 후 진행해주세요.");
			return 1;
		}
		if(cnameCheck == false){
			alert("코스명의 형식이 유효하지 않습니다(한글 또는 영문자 2~10자).");
			return 1;
		}
		if(cnameDupCheck() == "1"){
			alert("중복된 코스명입니다. 다른 코스명을 입력해주세요");
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
			alert("대중교통역 이름의 형식이 유효하지 않습니다(한글,영문자,숫자 2~14자)");
			return 1;
		}
		if(cPhotoCnt < 5){
			alert("코스사진은 최소4장 이상 업로드해야 합니다");
			return 1;
		}

		return 0;
	}

	function getCourseData(){  // 미리보기,등록할때 데이터를 전달할 함수		
		const uploadFiles = [];
		const formData = new FormData();
		uploadFiles.forEach(function(file, i) {
			if(file.upload != 'disable'){
				formData.append("uploadfile", file, file.name);
				//uploadFiles.push(file);
			}
		});
		
		const c_name =  courseName.value.trim();
		const c_s_latitude = slat.value.trim();
		const c_s_longitude = slon.value.trim();
		const c_s_locname = sLoc.value.trim();		
		const c_e_latitude = elat.value.trim();
		const c_e_longitude = elon.value.trim();
		const c_e_locname = eLoc.value.trim();
		const c_view1 = firstView.value.trim();
		const c_view2 = secondView.value.trim();
		const c_views = [];
		if(c_view1 != 0){
			c_views.push(c_view1);
		}
		if(c_view2 != 0){
			c_views.push(c_view2);
		}
		
		const c_words =  words.value.trim();
		const c_difficulty = diff.value.trim();
		const c_distance =  dis.value.trim();
		const c_time = time.value.trim();
		const c_line = line.value.trim();
	////////////////////////////////////////////////////
		const pts_latitude = latPS.value.trim();
		const pts_longitude = lonPS.value.trim();
		const pts_distance = disPS.value.trim();
		const pts_img = sPT.value.trim();
		const pts_station = sPTStation.value.trim();
		const pts_line = linePS.value.trim();
	////////////////////////////////////////////////////////////
		const pte_latitude = latPE.value.trim();
		const pte_longitude = lonPE.value.trim();
		const pte_distance = disPE.value.trim();
		const pte_img = ePT.value.trim();
		const pte_station = ePTStation.value.trim();
		const pte_line = linePE.value.trim();
		console.log("코스명: "+c_name);
		console.log("출위도: "+c_s_latitude);
		console.log("출경도: "+c_s_longitude);
		console.log("출발명: "+c_s_locname);
		console.log("도위도: "+c_e_latitude);
		console.log("도경도: "+c_e_longitude);
		console.log("도착명: "+c_e_locname);
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
	 	 courseData = {
				 "c_name": c_name,
			     "c_s_latitude" : c_s_latitude,
				 "c_s_longitude" : c_s_longitude,
				 "c_s_locname" : c_s_locname,
				 "c_e_latitude" : c_e_latitude,
				 "c_e_longitude" : c_e_longitude,
				 "c_e_locname" : c_e_locname,
				 "c_views" : c_views,
				 "uploadFiles" : uploadFiles,
				 
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
			formData.append("courseData", courseData);
			return formData;
	}
	
	document.getElementById("previewMakingCourse").addEventListener("click", function(e) {
		const fixCVal = fixC.getAttribute("val");
		if(fixCVal != "n"){
			alert("코스 가져오기를 실행해야만 미리보기를 볼 수 있습니다.");
			return;
		}

		$.ajax({
			url:"/user/previewMakingCourse",
			type: "POST",
			data: getCourseData(),
			contentType: false,
			processData: false,
			success: function(){
				window.open("/user/preview","newWin","width=1200px,height=1000px,toolbar=no,resizable=no,location=no,menubar=no,directories=no,status=no");
			},
			error: function(){
				alert("에러발생");
			}
		})
	});

	document.getElementById("regCourse").addEventListener("click", function(e) {
		const check = preCheck();
		if(check == 1){
			return;
		}
		const preConfirm = confirm("등록하면 더 이상 수정이 불가능합니다.\r\n등록하시겠습니까?(미리보기를 통해 충분히 확인 후 진행해도 좋습니다)");

		if(preConfirm == false){
			return;
		}

		$.ajax({
			url:"/user/regCourse",
			type: "POST",
			data: getCourseData(),
			success: function(response){
				if(response.code == "200"){
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
	});


}
</script>
</head>
<body>
<jsp:include page="../header.jsp"/>
      <div id="clear"></div>
<section>
<div><h1>나만의 DIY 코스</h1></div>
<br>
<span id="cTitle">코스명 :</span><input type="text" name="courseName"  id="courseName" maxlength="10"><span id="courseNameCnt"></span>
<br>
<br>

<div id="map" style="width:1000px;height:500px;"></div>
<p>
	<input type="file" value="경로파일" id="bikeFile">
	<button id="bike">경로만들기</button>
    <button id="startC">출발</button>
    <button id="arriveC">도착</button>
    <button id="polyC" >선</button>
    <button id="backPolyC" class="disabled" disabled >선 되돌리기</button>
    <button id="frontPolyC"  class="disabled" disabled>선 앞돌리기</button>
    <button id="infoC" >가져오기</button><span id="fixC" val="y"></span> <br>
   <input type="checkbox" id="chkBicycle" /> 자전거도로 정보 보기
</p>

출발 - 위도 : <input type="text" id="slat" name="slat" value="0" readonly="readonly">
경도 : <input type="text" id="slon" name="slon" value="0" readonly="readonly">
출발지역명 : <input type="text" id="sLoc" name="sLoc" readonly="readonly">
<br>
도착 - 위도 : <input type="text" id="elat" name="elat" value="0" readonly="readonly">
경도 : <input type="text" id="elon" name="elon" value="0" readonly="readonly">
도착지역명 : <input type="text" id="eLoc" name="eLoc" readonly="readonly">
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
<option value="0">--선택안함--</option>
</select>
<br>
거리 :  <input type="text"  id="dis" name="dis" value="0" readonly="readonly">km<br>
시간 : <input type="text" id="time" name="time" value="0" readonly="readonly">분<br>
난이도 : <select id="diff">
		<option value="0">--난이도 선택--</option>
		<option value="1">쉬움</option>
		<option value="2">보통</option>
		<option value="3">어려움</option>
		<option value="4">매우 어려움</option>
</select>
<br>
선경로 <br>
<textarea rows="10" cols="80" id="line" name="line" readonly="readonly"></textarea>
<br>
[코스설명]
<br>
<textarea rows="10" cols="100" id="words" name="words" maxlength="3000" placeholder="ex)시원한 강과함께 들판을 나란히 두고 라이딩하는 ...."  ></textarea>
<br>
<span id="wordsCnt"></span>
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
대중교통위치 - 위도 : <input type="text" id="latPS" name="latPS" value="0" readonly="readonly"> 경도 : <input type="text" id="lonPS" name="lonPS" value="0" readonly="readonly">
<br>
거리 :  <input type="text" id="disPS" name="disPS" value="0" readonly="readonly">km 
<select id="sPT" name="sPT">
<option value="(입력안함)">--대중교통선택--</option>
<option value="버스">버스</option>
<option value="1호선">1호선</option>
<option value="2호선">2호선</option>
<option value="3호선">3호선</option>
</select>
 역이름 : <input type="text" id="sPTStation" maxlength="14" placeholder="ex)신촌역,신촌오거리.."><span id="sPTStationCnt"></span>
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

대중교통위치 - 위도 : <input type="text" id="latPE" name="latPE" value="0" readonly="readonly"> 경도 : <input type="text" id="lonPE" name="lonPE" value="0" readonly="readonly">
<br>
거리 :  <input type="text" id="disPE" name="disPE" value="0" readonly="readonly">km
<select id="ePT" name="ePT">
<option value="(입력안함)">--대중교통선택--</option>
<option value="버스">버스</option>
<option value="1호선">1호선</option>
<option value="2호선">2호선</option>
<option value="3호선">3호선</option>
</select>
  역이름 : <input type="text" id="ePTStation" maxlength="14" placeholder="ex)신촌역,신촌오거리.."><span id="ePTStationCnt"></span>
<br>
대중교통도착 선경로 <br>
<textarea rows="10" cols="80" id="linePE" name="linePE" readonly="readonly"></textarea>
<br><br>
<button id="previewMakingCourse">미리보기</button> <button id="regCourse">등록</button>
</section>
	<div id="clear"></div>
<jsp:include page="../footer.jsp"/>
</body>
</html>