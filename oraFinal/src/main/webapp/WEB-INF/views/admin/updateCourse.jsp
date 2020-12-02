<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>코스 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="/resources/css/animate.css">
	<link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
	<link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
	<link rel="stylesheet" href="/resources/css/magnific-popup.css">
	<link rel="stylesheet" href="/resources/css/flaticon.css">
	<link rel="stylesheet" href="/resources/css/style.css">
<style type="text/css">

 /*매인섹션 시작----------------  */
 section {
 	  margin: 0 auto;
 	  width: 1000px;
 }
 
 .bicycleInfo { 
	margin: 0 0 0 8px;
	padding: 10px; 
	z-index: 1; left: 10px; 
	width: 180px; 
	background-color:rgba(255,255,255,0.8); 
	text-align: center; 
	color: black; 
	font-size: 14px; 
	font-weight: bold; 
	
	} 
	#sPTStation, #ePTStation {
		width: 300px;
	}
	
	#courseForm {
		width: 100%;
	}
 
 #cTitle{
	font-size: 140%;
}

  #map, #mapPE, #mapPS {
    	border-radius: 20px;
    }

 /*매인섹션 끝 ------------------*/

   /*float 초기화 아이디*/
   #clear{
   	clear: both; 
   }
   /*파일업로드관련 css*/
    .drag-over { background-color: #CFF768; outline-style: dotted; outline-offset:-20px; }
	.thumb { width:100px; height:100px; padding:5px; float:left; }
	.thumb > img { width:100%; height: 100%; }
	.thumb > .close { position:absolute; cursor:pointer; background: rgba(255,255,255,0.8); }
	.x { width: 15px; height: 15px; float: left; }
.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap {position:relative;width:100%;height:500px;}	
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

   #undo.disabled, #redo.disabled {background-color:#ddd;color:#9e9e9e;}
   
   /* 게시판 레이아웃 */
	/* 게시판 인덱스 제외 전체 */
	#contents { border: 1px solid #D5D5D5; padding: 60px; margin: 50px 0 100px; }
	/* 코스이름 만들기 */
	#courseName { border: none; border-bottom: 1px solid gray; margin: 10px; width: 90%; height: 50px; margin: 20px 0 30px; font-size: 30px; }
	/* 지도 3 */
	#map, #mapPS, #mapPE { width: 100%; height: 470px; font-family: 'Malgun Gothic',dotum,'돋움',sans-serif; font-size: 12px; margin: 0 0 10px; }
	/* 등록, 미리보기 버튼 */
	.btnAdd { color: white; padding: 8px 12px; margin: 40px 0px; align-content: center; font-size: 15px; border: none; cursor: pointer; }
	/* 모든 버튼 중앙정렬 */
	.btnDiv { text-align: center; }
	.btnOption { color: white; padding: 8px 12px; margin: 40px 0px; background-color: #88BEA6; font-size: 15px; border: none; cursor: pointer; }
	button[disabled]{ color: #666666; padding: 8px 12px; margin: 40px 0px; background-color: #cccccc; font-size: 15px; border: none; cursor: not-allowed; }
 	/* view 순위 지정 */
	#rankViewAll { text-align: center; border: 1px solid gray; border-radius: 10px; padding: 20px; margin: 30px 0; }
 	#rankViewTitle { display: block; padding-bottom: 10px; }
 	.rankView { display: inline-block; width: 15%; text-align: center; padding: 20px 20px 10px;}
 	.rankView img { width: 35px; align: center; padding-bottom: 3px; }
 	input { padding: 4px 0; margin-bottom: 3px; border: none; }
 	/* 첨부파일버튼 */
 	.readFilebox label {position:relative; right:30px; margin: 3px 0; padding: 5px 15px;  color: white; font-size: 15px; vertical-align: middel; background-color: #88BEA6; cursor: pointer; text-align: center; }
	.readFilebox input[type="file"] { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; border: 0; }
 	.filebox label { position:relative; bottom:25px; left:20px;  color: #747474; font-size: 15px; vertical-align: middel; background-color: white; cursor: pointer; text-align: center; }
	.filebox input[type="file"] { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; border: 0; }
	#wordsDiv, #thumbnailsDiv { padding: 20px 3px; border: 1px solid gray; border-radius: 10px; text-align: center; margin-bottom: 30px; }
	
	.textFont {
		font-size: 110%;
		font-weight: bold;
	}
	/* header dropdown */
	.ftco-navbar-light .navbar-nav > .nav-item .dropdown-menu {
		/* background: #fff;
		background-color: #fff;
		opacity: 0.7; */
		background: rgba(255,255,255,0.7);
		/* border: 2px solid white; */
		/* width: 100px; */
		min-width: 9rem;
		color: white;
	}
	.dropdown-item {
		font-weight: bold;
		color: #5D5D5D;
	} 
	.navbar .nav-item:hover .dropdown-menu .dropdown-item {
		color: #5D5D5D;
	}
	
	.right-text {
		text-align: right;
	}
</style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/js/loginCheck.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7bf02997fccc8f4d0d956482ddd50a0b&libraries=drawing,services"></script>
<script>
window.onload = function(){
	 const token = $("meta[name='_csrf']").attr("content");
	    const header = $("meta[name='_csrf_header']").attr("content");
	    const parameter = $("meta[name='_csrf_parameter']").attr("content");
	  /*  $(document).ajaxSend(function(e, xhr, options) {
	        if(token && header) {
	            xhr.setRequestHeader(header, token);
	        }
	    });*/
	
	const oldCourseName = document.getElementById("oldCourseName");
	
	const nickName = document.getElementById("nickName");
	const courseNum = document.getElementById("courseNum");
	const courseId = document.getElementById("courseId");
	const courseCodeValue = document.getElementById("courseCodeValue");
	
	
	const courseName =  document.getElementById("courseName");
	const slat =  document.getElementById("slat");
	const slon =  document.getElementById("slon");
	const sLoc =  document.getElementById("sLoc");
	
	const elat =  document.getElementById("elat");
	const elon =  document.getElementById("elon");
	const eLoc =  document.getElementById("eLoc");
	const tag = document.getElementById("tag");
	const words = document.getElementById("words");
	const firstView =  document.getElementById("firstView");
	const secondView =  document.getElementById("secondView");
	const thirdView =  document.getElementById("thirdView");
	const fourthView =  document.getElementById("fourthView");
	const dis =  document.getElementById("dis");
	const time =  document.getElementById("time");
	const diff =  document.getElementById("diff");
	const line =  document.getElementById("line");
	const photoInput = document.getElementById("photoInput");
	const fixC =  document.getElementById("fixC"); // 수정시 가져오기필요문구 나타낼스판

	const thumbnails = document.getElementById("thumbnails"); // 코스사진거는데
	const drop = document.getElementById("drop"); // 코스사진 거는데 부모노드
////////////////////////////////////////////////////
	const pt_noPS = document.getElementById("pt_noPS");

	const latPS = document.getElementById("latPS");
	const lonPS = document.getElementById("lonPS");
	const sPT = document.getElementById("sPT");
	const sPTStation = document.getElementById("sPTStation");
	const disPS = document.getElementById("disPS");
	const linePS = document.getElementById("linePS");
	const fixPS = document.getElementById("fixPS"); // 수정시 가져오기필요문구 나타낼스판
////////////////////////////////////////////////////////////
	const pt_noPE = document.getElementById("pt_noPE");

	const latPE = document.getElementById("latPE");
	const lonPE = document.getElementById("lonPE");
	const ePT = document.getElementById("ePT");
	const ePTStation = document.getElementById("ePTStation");
	const disPE = document.getElementById("disPE");
	const linePE = document.getElementById("linePE");
	const fixPE = document.getElementById("fixPE");;  // 수정시 가져오기필요문구 나타낼스판

////////////////////////////////////////////////////////////// 변수선언끝 	
	const courseNameCnt = document.getElementById("courseNameCnt");  // 15자 
	const courseTagCnt = document.getElementById("courseTagCnt");  // 15자
	const wordsCnt = document.getElementById("wordsCnt");  // 3000자
	const sPTStationCnt = document.getElementById("sPTStationCnt"); // 14자
	const ePTStationCnt = document.getElementById("ePTStationCnt"); // 14자

	const courseNameMaxCnt = 15;
	const courseTagMaxCnt = 15;
	const wordsMaxCnt = 3000;
	const stationMaxCnt = 14;
	
	courseName.addEventListener("keydown", function(e) {
		textCount(e.target, courseNameCnt, courseNameMaxCnt);
	});
	courseName.addEventListener("keyup", function(e) {
		textCount(e.target, courseNameCnt, courseNameMaxCnt);
	});
	tag.addEventListener("keydown", function(e) {
		textCount(e.target, courseTagCnt, courseTagMaxCnt);
	});
	tag.addEventListener("keyup", function(e) {
		textCount(e.target, courseTagCnt, courseTagMaxCnt);
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

// ------------------------------------------------------- 풍경 셀렉트 노드생성
	const viewNameStr = "강,산,명소,바다";
	const noSelectView = '<option value="0">--선택안함--</option>';
	
	firstView.addEventListener("change", function(e) {
		firstViewChange(e.target);
	});
	
	secondView.addEventListener("change", function(e) {
		secondViewChange(e.target);
	});
	
	thirdView.addEventListener("change", function(e) {
		thirdViewChange(e.target);
	});
	
	function firstViewChange(target){
		let optionNode = noSelectView;   // 동적으로 만들 셀렉트의 옵션노드들을 담을 변수선언 // 첫번째값으로 --선택안함--을 넣고 시작
		const optionValue = target.value;
		if(optionValue == "0"){   
			secondView.innerHTML = optionNode;   // 이전뷰 선택된게 '선택' 일시 다음순위뷰들을 '--선택안함--' 으로 초기화시킨다 
			thirdView.innerHTML = optionNode;   
			fourthView.innerHTML = optionNode;   
			return;
		}
		const vname = viewNameStr.replace(optionValue, " ");
		const vArr = vname.split(",");
		vArr.forEach(function(v, i) {
			if(v != " "){
				optionNode += '<option value='+v+'>'+v+'</option>';
			}
		})
		secondView.innerHTML = optionNode; 
		thirdView.innerHTML = noSelectView;   
		fourthView.innerHTML = noSelectView;  	  // 뷰선택이 바뀔경우 바로 다음순위뷰를 제외한 다음 순위뷰들을 --선택안함--으로 초기화시킨다
	};
	function secondViewChange(target){
		let optionNode = noSelectView;   
		const optionValue = target.value;
		const firstValue = firstView.value;
		if(optionValue == "0"){   
			thirdView.innerHTML = optionNode;   
			fourthView.innerHTML = optionNode;   
			return;
		}
		const vname = viewNameStr.replace(firstValue, " ").replace(optionValue, " ");
		const vArr = vname.split(",");
		vArr.forEach(function(v, i) {
			if(v != " "){
				optionNode += '<option value='+v+'>'+v+'</option>';
			}
		})
		thirdView.innerHTML = optionNode;
		fourthView.innerHTML = noSelectView; 	
	};
	function thirdViewChange(target){
		let optionNode = noSelectView;   
		const optionValue = target.value;
		const firstValue = firstView.value;
		const secondValue = secondView.value;
		if(optionValue == "0"){   
			fourthView.innerHTML = optionNode;   
			return;
		}
		const vname = viewNameStr.replace(firstValue, " ").replace(secondValue, " ").replace(optionValue, " ");
		const vArr = vname.split(",");
		vArr.forEach(function(v, i) {
			if(v != " "){
				optionNode += '<option value='+v+'>'+v+'</option>';
			}
		})
		fourthView.innerHTML = optionNode; 	
	};

// --------------------------------------------------------- 풍경 셀렉트 노드생성 끝
	const infoC = document.getElementById("infoC");
	
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
	infoC.addEventListener("click", function(e) {
		getInfo();
	});
	document.getElementById("chkBicycle").addEventListener("click", function(e) {
		setOverlayMapTypeId(map);
	});

//////////////////////////////////////// 코스끝
	const infoPS = document.getElementById("infoPS");

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
	infoPS.addEventListener("click", function(e) {
		getInfoPS();
	});
	document.getElementById("chkBicyclePS").addEventListener("click", function(e) {
		setOverlayMapTypeId(mapPS);
	});

//////////////////////////////////////////// 대중교통 출발점 끝
	const infoPE = document.getElementById("infoPE");

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
	infoPE.addEventListener("click", function(e) {
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
	const bicycleInfo = document.getElementById("bicycleInfo");
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	const map = new kakao.maps.Map(mapContainer, mapOption); 
	const mapTypeControl = new kakao.maps.MapTypeControl();
	const zoomControl = new kakao.maps.ZoomControl();
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	map.addControl(bicycleInfo, kakao.maps.ControlPosition.BOTTOMLEFT);

////////////////////////////////////////////////////코스마커표시기능	
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
	
	//--------------

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
		infoC.disabled = false;
		infoPS.disabled = false;
		infoPE.disabled = false;
		
		
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
			undoBtn.className = "btnOption";
		} else { // 아니면 undo 버튼을 비활성화 시킵니다 
			undoBtn.disabled = true;
			undoBtn.className = "disabled";
		}

		// 취소할 수 있다면 redo 버튼을 활성화 시킵니다 
		if (manager3.redoable()) {
			redoBtn.disabled = false;
			redoBtn.className = "btnOption";
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
	

	let altitudeData = []; // 고도데이타를 담을 배열
	let altitudeArr = []; // 고도를 담을 배열
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
	    	const xyArr = data[kakao.maps.drawing.OverlayType.POLYLINE][0].points;

	    	xyArr[0].x = sMarkerLatLon.getLng();
	    	xyArr[0].y = sMarkerLatLon.getLat();
	    	xyArr[xyArr.length-1].x = eMarkerLatLon.getLng();
	    	xyArr[xyArr.length-1].y = eMarkerLatLon.getLat();
		
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
		
		
		const latArr = new Array();
		const lonArr = new Array();
		const latlonArr = new Array();
		
		
		
		for(let i=0; i<xyArr.length; i++){
			const lat = xyArr[i].y;
			const lon = xyArr[i].x;
			
			latArr.push(lat);
			lonArr.push(lon);
			latlonArr.push(new kakao.maps.LatLng(lat,lon));

		}

		if(altitudeArr.length != 0){
			if(latlonArr.length >= altitudeArr.length){
				const num = latlonArr.length - altitudeArr.length;
				const lastAlt = altitudeArr[altitudeArr.length-1];
				for(let i=0; i<num; i++){
					altitudeArr.push(lastAlt);
				}
			}
			else{
				altitudeArr = [];
			}
		}
		

   	   altitudeData = []; // 고도데이타 초기화
	   
	   polyObj.setPath(latlonArr);
	   const distance = (polyObj.getLength()/1000).toFixed(1);
	   
	   const distancePerLine = (distance/(altitudeArr.length-1)).toFixed(10);

		if(altitudeArr.length != 0){
			for(let i=0; i<altitudeArr.length; i++){
				altitudeData.push([distancePerLine*i,Number(Number((altitudeArr[i])).toFixed(1))]);
			}
			
		}
  
		drawAltitude();
	    manager3.remove(manager3.getOverlays().polyline[0]);
	    manager3.put(kakao.maps.drawing.OverlayType.POLYLINE, latlonArr);
    	fixC.innerHTML=""; // 새로 라인을 그리기 후 가져오기눌러주세요 글을 없앤다
    	fixC.setAttribute("val", "n");
    	
    	line.value = setGpx(latArr,lonArr,altitudeArr);

	    dis.value = distance;
	    time.value = (distance/20*60).toFixed(0);

	    infoC.disabled = true;
	  }
	}

//////////////////////////////////////////////////////////////////////// 코스설정끝

	const mapContainerPS = document.getElementById('mapPS'), // 지도를 표시할 div 
	 mapOptionPS = { 
	        center: new kakao.maps.LatLng(37.52084556725995, 126.97701335521351), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	 };
	const bicycleInfoPS = document.getElementById("bicycleInfoPS");
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	const mapPS = new kakao.maps.Map(mapContainerPS, mapOptionPS); 
	const mapTypeControlPS = new kakao.maps.MapTypeControl();
	const zoomControlPS = new kakao.maps.ZoomControl();
	mapPS.addControl(mapTypeControlPS, kakao.maps.ControlPosition.TOPRIGHT);
	mapPS.addControl(zoomControlPS, kakao.maps.ControlPosition.RIGHT);
	mapPS.addControl(bicycleInfoPS, kakao.maps.ControlPosition.BOTTOMLEFT);

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
			undoBtn.className = "btnOption";
		} else { // 아니면 undo 버튼을 비활성화 시킵니다 
			undoBtn.disabled = true;
			undoBtn.className = "disabled";
		}

		// 취소할 수 있다면 redo 버튼을 활성화 시킵니다 
		if (managerPS.redoable()) {
			redoBtn.disabled = false;
			redoBtn.className = "btnOption";
		} else { // 아니면 redo 버튼을 비활성화 시킵니다 
			redoBtn.disabled = true;
			redoBtn.className = "disabled";
		}
		fixPS.innerHTML="가져오기를 눌러주세요!";
		fixPS.setAttribute("val", "y");
		infoPS.disabled = false;
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
	  
		    let pathStr="[";
		        for(let i=0; i<latlonArr.length; i++){

		            pathStr += " new kakao.maps.LatLng("+latlonArr[i].y+","+latlonArr[i].x+"),";
		            latlonArr[i] = new kakao.maps.LatLng(latlonArr[i].y,latlonArr[i].x);

		        }
		   pathStr = pathStr.substring(0, pathStr.length-1);
		   pathStr += "]";
	
		    managerPS.remove(managerPS.getOverlays().polyline[0]);
		    managerPS.put(kakao.maps.drawing.OverlayType.POLYLINE, latlonArr);
		    fixPS.innerHTML="";
			fixPS.setAttribute("val", "n");
			polyObjPS.setPath(latlonArr);
			const distance = (polyObjPS.getLength()/1000).toFixed(1);
	
			linePS.value = pathStr;
		   	disPS.value = distance;

		   	infoPS.disabled = true;
		}
	}
/////////////////////////////////////////////////// 출발점 교통편 끝

	const mapContainerPE = document.getElementById('mapPE'), // 지도를 표시할 div 
	 mapOptionPE = { 
	        center: new kakao.maps.LatLng(37.52084556725995, 126.97701335521351), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	    };
	const bicycleInfoPE = document.getElementById("bicycleInfoPE");
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	const mapPE = new kakao.maps.Map(mapContainerPE, mapOptionPE); 
	const mapTypeControlPE = new kakao.maps.MapTypeControl();
	const zoomControlPE = new kakao.maps.ZoomControl();
	mapPE.addControl(mapTypeControlPE, kakao.maps.ControlPosition.TOPRIGHT);
	mapPE.addControl(zoomControlPE, kakao.maps.ControlPosition.RIGHT);
	mapPE.addControl(bicycleInfoPE, kakao.maps.ControlPosition.BOTTOMLEFT);


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
				undoBtn.className = "btnOption";
			} else { // 아니면 undo 버튼을 비활성화 시킵니다 
				undoBtn.disabled = true;
				undoBtn.className = "disabled";
			}
	
			// 취소할 수 있다면 redo 버튼을 활성화 시킵니다 
			if (managerPE.redoable()) {
				redoBtn.disabled = false;
				redoBtn.className = "btnOption";
			} else { // 아니면 redo 버튼을 비활성화 시킵니다 
				redoBtn.disabled = true;
				redoBtn.className = "disabled";
			}
			fixPE.innerHTML="가져오기를 눌러주세요!";
			fixPE.setAttribute("val", "y");
			infoPE.disabled = false;
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
	  

		    let pathStr="[";
		        for(let i=0; i<latlonArr.length; i++){

		            pathStr += " new kakao.maps.LatLng("+latlonArr[i].y+","+latlonArr[i].x+"),";
		            latlonArr[i] = new kakao.maps.LatLng(latlonArr[i].y,latlonArr[i].x);

		        }
		   pathStr = pathStr.substring(0, pathStr.length-1);
		   pathStr += "]";
	
		    managerPE.remove(managerPE.getOverlays().polyline[0]);
		    managerPE.put(kakao.maps.drawing.OverlayType.POLYLINE, latlonArr);
		    fixPE.innerHTML="";
			fixPE.setAttribute("val", "n");
			polyObjPE.setPath(latlonArr);
			const distance = (polyObjPE.getLength()/1000).toFixed(1);
	
			linePE.value = pathStr;
		   	disPE.value = distance;
		   	infoPE.disabled = true;
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
//	const bike = document.getElementById("bike");
	const bikeFile = document.getElementById("bikeFile");
	bikeFile.addEventListener("change", function(e) {
		let reader = new FileReader();
		const file = bikeFile.files[0];
		if(file == undefined){
			alert("gpx파일을 선택해야합니다");
			return;
		}
		const suffixtFileName = (file.name).substring(file.name.lastIndexOf(".")+1);
		if(suffixtFileName != "gpx"){
			alert("gpx파일을 선택해야합니다");
			return;
		}
		reader.onload = function () {

			const courseBounds = new kakao.maps.LatLngBounds();
			altitudeData = [];  // 고도 초기화
			altitudeArr = [];
			
			const eleArr = $(reader.result).find("trkseg ele");
			const  trkptArr = $(reader.result).find("trkseg trkpt");

			if(eleArr.length == 0 || trkptArr.length == 0){
				alert("gpx파일의 형식이 아닙니다.");
				return;
			}

			const latArr = new Array();
			const lonArr = new Array();
			const latlonArr = new Array();
					
			for(let i=0; i<trkptArr.length; i++){
				const lat = trkptArr[i].getAttribute("lat");
				const lon = trkptArr[i].getAttribute("lon");
				
				latArr.push(lat);
				lonArr.push(lon);
				latlonArr.push(new kakao.maps.LatLng(lat,lon));
				
				
			}
			
	
			polyObj.setPath(latlonArr);
			const distancePerLine = (((polyObj.getLength()/1000).toFixed(1))/(eleArr.length-1)).toFixed(10);

			for(let i=0; i<eleArr.length; i++){
				const elData = [distancePerLine*i,Number(Number((eleArr[i].innerHTML)).toFixed(1))];
				
				altitudeData.push(elData);			
				altitudeArr.push(eleArr[i].innerHTML);
				
			}

			const maxLat = Math.max.apply(null,latArr);
			const maxLon = Math.max.apply(null,lonArr);
			
			const minLat = Math.min.apply(null,latArr);
			const minLon = Math.min.apply(null,lonArr);

			courseBounds.extend(new kakao.maps.LatLng(maxLat,maxLon));
			courseBounds.extend(new kakao.maps.LatLng(minLat,minLon));

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
			drawAltitude();

			const sMarkerLatLon = latlonArr[0];
			const eMarkerLatLon = latlonArr[latlonArr.length-1];
		
			slat.value = sMarkerLatLon.getLat();
	   		slon.value = sMarkerLatLon.getLng();
	   		geocoder.coord2Address(sMarkerLatLon.getLng(), sMarkerLatLon.getLat(), function(result, status) {
			    if(status === kakao.maps.services.Status.OK) {
			       sLoc.value = result[0].address.address_name;
			    }
			    else{
			    	 sLoc.value = "";
			    	 alert("출발지 주소를 찾을 수 없습니다. 출발마커를 옮겨주세요.")
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
			    else{
			    	 eLoc.value = "";
			    	 alert("도착지 주소를 찾을 수 없습니다. 도착마커를 옮겨주세요.")
				}
			});
			///////////// 대중교통 도착점 표시
			arriveMarker.setPosition(eMarkerLatLon);
			arriveMarker.setMap(mapPE);
			mapPE.setCenter(eMarkerLatLon);
			/////////////// 대중교통 도착점 표시 끝  
	
		   const distance = (polyObj.getLength()/1000).toFixed(1);
	
	    	fixC.innerHTML=""; // 새로 라인을 그리기 후 가져오기눌러주세요 글을 없앤다
	    	fixC.setAttribute("val", "n");
	    	line.value = setGpx(latArr,lonArr,altitudeArr);
		    dis.value = distance;
		    time.value = (distance/20*60).toFixed(0);
		    
		    infoC.disabled = true;
//--------------------------------------------------
 
 	
			setGpx(latArr,lonArr,altitudeArr);
		};
			reader.readAsText(file, "UTF-8");
			this.value = null;
	});


	function setGpx(latArr,lonArr,altitudeArr){

		const maxLat = Math.max.apply(null,latArr);
		const maxLon = Math.max.apply(null,lonArr);
		
		const minLat = Math.min.apply(null,latArr);
		const minLon = Math.min.apply(null,lonArr);

		const startLat = latArr[0];
		const startLon = lonArr[0];
		const endLat = latArr[latArr.length-1];
		const endLon = lonArr[lonArr.length-1];

	let	gpxStr = '<?xml version="1.0" encoding="UTF-8"?>\r\n\
		<gpx xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1" xmlns="http://www.topografix.com/GPX/1/1" creator="siwook">\r\n\
			<metadata>\r\n\
				<desc>siwook</desc>\r\n\
				<bounds maxlat="'+maxLat+'" maxlon="'+maxLon+'" minlat="'+minLat+'" minlon="'+minLon+'" />\r\n\
			</metadata>\r\n\
			<wpt lat="'+startLat+'" lon="'+startLon+'">\r\n\
				<name>START</name>\r\n\
				<sym>Flag, Green</sym>\r\n\
				<extensions>\r\n\
					<gpxx:WaypointExtension xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3">\r\n\
					<gpxx:DisplayMode>SymbolAndName</gpxx:DisplayMode>\r\n\
					</gpxx:WaypointExtension>\r\n\
				</extensions>\r\n\
				<ele>0</ele>\r\n\
			</wpt>\r\n\
			<wpt lat="'+endLat+'" lon="'+endLon+'">\r\n\
				<name>END</name>\r\n\
				<sym>Flag, Green</sym>\r\n\
				<extensions>\r\n\
					<gpxx:WaypointExtension xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3">\r\n\
					<gpxx:DisplayMode>SymbolAndName</gpxx:DisplayMode>\r\n\
					</gpxx:WaypointExtension>\r\n\
				</extensions>\r\n\
				<ele>0</ele>\r\n\
			</wpt>\r\n\
			<trk>\r\n\
				<extensions>\r\n\
					<gpxx:TrackExtension xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3">\r\n\
					<gpxx:DisplayColor>Green</gpxx:DisplayColor>\r\n\
					</gpxx:TrackExtension>\r\n\
				</extensions>\r\n\
				<trkseg>\r\n';

		if(altitudeArr.length != 0){
			for(let i=0; i<latArr.length; i++){
				gpxStr += '<trkpt lat="'+latArr[i]+'" lon="'+lonArr[i]+'">\r\n\
								<ele>'+altitudeArr[i]+'</ele>\r\n\
						   </trkpt>\r\n';
			}
		}

		else{
			for(let i=0; i<latArr.length; i++){
				gpxStr += '<trkpt lat="'+latArr[i]+'" lon="'+lonArr[i]+'">\r\n\
								<ele>0</ele>\r\n\
						   </trkpt>\r\n';
			}
		}

		
		
		gpxStr +=		'</trkseg>\r\n\
					</trk>\r\n\
				</gpx>\r\n'
		

		return gpxStr;
 	}
	

	/////////----------------------------- 고도 차트 함수
	google.charts.load('current', {'packages':['corechart']});
	///////--------------------- 고도 차트
	   function drawAltitude() {
		   const data = new google.visualization.DataTable();
	        data.addColumn('number','거리');
	        data.addColumn('number','고도');

			if(altitudeData.length != 0){
				data.addRows(altitudeData);
			}
	        

	        const options = {
	            	  title: '자전거코스 고도',
	            	  animation:{duration:3000,easing:'out',startup:true},
	                  hAxis: {title: '거리(km)' ,titleTextStyle: {color: '#333'},gridlines: {color: 'transparent'}},
	                  vAxis: {title:'고도(m)',titleTextStyle: {color: '#333'},minValue: 0},
	                  curveType: 'function',
	                  width:'100%',
	                  height:300,
	                };

	        const chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
	        chart.draw(data, options);
	        window.addEventListener("resize",drawAltitude,false);
      }
//////////////////////////////////////////////////////// 파일드랍기능 구현
	const photoReg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
	
	const uploadFiles = [];
	
	drop.addEventListener("dragenter", function(e) {
		this.className = "drag-over";
	})
	drop.addEventListener("dragleave", function(e) {
		this.className = "";
	})
	drop.addEventListener("dragover", function(e) {
		e.stopPropagation();
		e.preventDefault();
	})
	drop.addEventListener("drop", function(e) {
		e.preventDefault();
		this.className = "";
		const cpFiles = e.dataTransfer.files;
		addPhoto(cpFiles);
	})
	photoInput.addEventListener("change", function(e) {
		const cpFiles = e.target.files;
		addPhoto(cpFiles);
	});
	
	function addPhoto(cpFiles){
		const files = cpFiles; //드래그&드랍 항목

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
			previewPhoto(file, size - 1); //미리보기 만들기
		}
	}
	
	function previewPhoto(file, idx) {

		const reader = new FileReader();
		reader.onload = (function(f, idx) {
			return function(e) {
				const thumb = document.createElement("div");
				thumb.className = "thumb";
				 
				const div =	'<div class="close" data-idx="' + idx + '"><img class="x" src="../icons/x.png"/></div>\
							<img src="' + e.target.result + '" title="' + escape(f.name) + '"/>\
							</div>';
				thumb.innerHTML = div;
				thumbnails.append(thumb);
			};
		})(file, idx);
			reader.readAsDataURL(file);
	}

	drop.addEventListener("click", function(e) {
		const className = e.target.className;

		if(className == "x"){
			const target = e.target.parentNode;
			const idx = target.getAttribute('data-idx');
			uploadFiles[idx].upload = 'disable';
			target.parentNode.parentNode.removeChild(target.parentNode);
		}
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

	/* 사진등록버튼 */
	const gallery = document.getElementById('gallery');
	gallery.addEventListener("mouseover", mouseOver);
	gallery.addEventListener("mouseout", mouseOut);
	function mouseOver() {
		gallery.src="../meetingImg/galleryOn.png";
	}
	function mouseOut() {
		gallery.src="../meetingImg/galleryOff.png";
	}
	
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

				const cycList = data.querySelectorAll('row');

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
	
////////////////////////////////////////////////////////
	function preCheck(){ // 미리보기,등록 할때 값들 제어를 할 함수
		
		const cname = courseName.value.trim();
		const sLocName = sLoc.value.trim();
		const eLocName = eLoc.value.trim();
		const fixCVal = fixC.getAttribute("val");
		const fixPSVal = fixPS.getAttribute("val");
		const fixPEVal = fixPE.getAttribute("val");
		const ctag = tag.value.trim();				
		const fView = firstView.options[firstView.selectedIndex].value;	
		const cDiff = diff.options[diff.selectedIndex].value;	
		const cwords = words.value.trim();

		const sPTVal = sPT.options[sPT.selectedIndex].value;
		const sPTSt = sPTStation.value.trim();
		const ePTVal = ePT.options[ePT.selectedIndex].value;
		const ePTSt = ePTStation.value.trim();

		const cPhotoCnt = cPhotoNumCheck();
		
		const krengAvail = /^[가-힣a-zA-Z\s]{2,15}$/;
		const krsharpAvail = /^[가-힣#\s]{2,15}$/;
		const krengnumAvail = /^[가-힣a-zA-Z0-9\s]{2,14}$/;
		const cnameCheck = krengAvail.test(cname);
		const tagCheck = krsharpAvail.test(ctag);
		const sPTStCheck = krengnumAvail.test(sPTSt);
		const ePTStCheck = krengnumAvail.test(ePTSt);

		function cnameDupCheck(){  // 코스명 중복검사 함수
			let check = "1";
			if(oldCourseName.value == cname){  // 수정전 코스명과 수정 후 코스명이 같을경우 대비
				return "0";
			}
			
			$.ajax({
				url: "/user/cnameDupCheck?"+parameter+'='+token,
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
			courseName.focus();
			return 1;
		}
		if(cnameCheck == false){
			alert("코스명의 형식이 유효하지 않습니다(한글 또는 영문자 2~15자).");
			courseName.focus();
			return 1;
		}
		if(cnameDupCheck() == "1"){
			alert("중복된 코스명입니다. 다른 코스명을 입력해주세요");
			courseName.focus();
			return 1;
		}  
		if(sLocName == ""){
			alert("출발지 지역명을 찾을 수 없습니다. 출발마커를 옮겨주세요.");
			sLoc.focus();
			return 1;
		}  
		if(eLocName == ""){
			alert("도착지 지역명을 찾을 수 없습니다. 도착마커를 옮겨주세요.");
			eLoc.focus();
			return 1;
		}  
		if(fixCVal != "n"){
			alert("코스만들기의 가져오기를 누른 후 진행해주세요.");
			mapContainer.scrollIntoView();
			return 1;
		}
		if(fixPSVal != "n"){
			alert("출발점 대중교통 코스만들기의 가져오기를 누른 후 진행해주세요.");
			mapContainerPS.scrollIntoView();
			return 1;
		}
		if( fixPEVal != "n"){
			alert("도착점 대중교통 코스만들기의 가져오기를 누른 후 진행해주세요.");
			mapContainerPE.scrollIntoView();
			return 1;
		}
		if(ctag == ""){
			alert("코스 #태그를 입력해주세요.");
			tag.focus();
			return 1;
		}
		if(tagCheck == false){
			alert("코스 #태그 형식히 유효하지 않습니다(한글,특수문자는#만 허용됩니다).");
			tag.focus();
			return 1;
		}
		if(fView == 0){
			alert("코스풍경을 선택 후 진행해주세요.");
			firstView.focus();
			return 1;
		}
		if(cDiff == 0){
			alert("코스난이도를 선택 후 진행해주세요.");
			diff.focus();
			return 1;
		}
		if(cwords == ''){
			alert("코스상세설명을 입력 후 진행해주세요.");
			words.focus();
			return 1;
		}
		if(sPTVal == '(입력안함)'){
			alert("출발점 대중교통을 선택한 후 진행해주세요.");
			sPT.focus();
			return 1;
		}
		if(sPTSt =='' ){
			alert("출발점 대중교통역 이름을 입력 후 진행해주세요.");
			sPTStation.focus();
			return 1;
		}
		if(sPTStCheck == false){
			alert("출발점 대중교통역 이름의 형식이 유효하지 않습니다(한글,영문자,숫자 2~14자)");
			sPTStation.focus();
			return 1;
		}
		
		if( ePTVal=='(입력안함)' ){
			alert("도착점 대중교통을 선택한 후 진행해주세요.");
			ePT.focus();
			return 1;
		}
		if(ePTSt == '' ){
			alert("도착점 대중교통역 이름을 입력 후 진행해주세요.");
			ePTStation.focus();
			return 1;
		}
		if(ePTStCheck == false ){
			alert("도착점 대중교통역 이름의 형식이 유효하지 않습니다(한글,영문자,숫자 2~14자)");
			ePTStation.focus();
			return 1;
		}
		if(cPhotoCnt < 5){
			alert("코스사진은 최소5장 이상 업로드해야 합니다");
			photoInput.focus();
			return 1;
		}

		return 0;
	}
	
	function getCourseData(){  // 미리보기,등록할때 데이터를 전달할 함수		

		courseName.value = courseName.value.trim();
		tag.value = tag.value.trim();
		words.value =  words.value.trim();
		sPTStation.value = sPTStation.value.trim();
		ePTStation.value = ePTStation.value.trim();
			
		const c_name = courseName.value.trim();

		const sLocName = "#"+sLoc.value.trim().split(" ", 1);  // 주소 맨처음 단어(도시이름)만 때온다 ex) '서울 양천구 목동' 일 경우  '서울'을 갖고옴
		const eLocName = "#"+eLoc.value.trim().split(" ", 1);
		let c_loc = sLocName;
		if(sLocName != eLocName){
			c_loc += eLocName;
		}

		const c_tags = [];
		const tagArr = tag.value.split("#");
		tagArr.forEach(function(t, i) {
			if(t != ""){
				c_tags.push(t);
			}
		});

		const c_views = [];
		if(firstView.value != "0"){
			c_views.push(firstView.value);
		}
		if(secondView.value != "0"){
			c_views.push(secondView.value);
		}
		if(thirdView.value != "0"){
			c_views.push(thirdView.value);
		}
		if(fourthView.value != "0"){
			c_views.push(fourthView.value);
		}
		const c_view = c_views.join("-");

		const pt_stationPS = sPT.value.trim()+" "+sPTStation.value.trim();
		const pt_stationPE = ePT.value.trim()+" "+ePTStation.value.trim();
		const pt_imgPS = sPT.value.trim()+".png";
		const pt_imgPE = ePT.value.trim()+".png";
		
		
		const courseForm = document.getElementById("courseForm");
		const formData = new FormData(courseForm);
		formData.set("c_name", c_name);
		formData.set("c_loc", c_loc);

		formData.set("c_view", c_view);
		formData.set("c_views", c_views);
		formData.set("c_tags", c_tags);
		
		formData.set("pt_stationPS", pt_stationPS);
		formData.set("pt_stationPE", pt_stationPE);
		formData.set("pt_imgPS", pt_imgPS);
		formData.set("pt_imgPE", pt_imgPE);

		uploadFiles.forEach(function(file, i) {
			if(file.upload != 'disable'){
				formData.append("uploadfile", file);
			}
		});
		
		return formData;
	}
	
	document.getElementById("previewUpdateCourse").addEventListener("click", function(e) {
		const fixCVal = fixC.getAttribute("val");
		if(fixCVal != "n"){
			alert("상단 첫 코스 가져오기를 실행해야만 미리보기를 볼 수 있습니다.");
			mapContainer.scrollIntoView(top);
			return;
		}

		$.ajax({
			url:"/user/previewMakingCourse?"+parameter+"="+token,
			type: "POST",
			data: getCourseData(),
			contentType: false,
			processData: false,
			success: function(re){
				const w = window.open("/user/preview","코스미리보기","width=1200px,height=1000px,toolbar=no,resizable=no,location=no,menubar=no,directories=no,status=no");
			},
			error: function(){
				alert("에러발생");
			}
		})
	});

	document.getElementById("updateCourse").addEventListener("click", function(e) {
		const check = preCheck();
		if(check == 1){
			return;
		}
		const preConfirm = confirm("정말로 수정을 완료하시겠습니까?");

		if(preConfirm == false){
			return;
		}

		$.ajax({
			url:"/admin/updateCourse?"+parameter+"="+token,
			type: "POST",
			data: getCourseData(),
			contentType: false,
			processData: false,
			success: function(response){
				if(response.code == "200"){
					alert(response.message);
					window.location = "/mainPage";
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

	//--------------- 수정내용 세팅장소  변수명 uc는 update course 줄임말 
	//const  url = document.location.href;
	//const courseNumber = url.substring(url.indexOf("=")+1);
	const courseNumber = ${c_no};

	const req = new XMLHttpRequest();
	req.open("GET", "/admin/getUpdateCourse?c_no="+courseNumber);
	req.send(null);
	req.addEventListener("load", function(e) {
		if(req.status == 200){
			const repMap = JSON.parse(this.response);
			const cJson = repMap.cJson;
			const ptJson = repMap.ptJson;
			setUpdateCourse(cJson,ptJson);
		}
		else{
			alert("에러발생");
		}
		
	})

	  function setUpdateCourse(cJson,ptJson){   // 업데이트코스 데이타 설정 함수
		
		const courseBounds = new kakao.maps.LatLngBounds();
		nickName.value = cJson.nickName;
		courseNum.value = cJson.c_no;
		courseId.value = cJson.id;
		courseCodeValue.value = cJson.code_value;
		oldCourseName.value = cJson.c_name;
		//----히든으로 넘길값들 (유지해야할 값)
		
		
		courseName.value = cJson.c_name;
		tag.value = cJson.c_tag;
		
		const ucLine = cJson.c_line;

		const eleArr = $(ucLine).find("trkseg ele");
		const trkptArr = $(ucLine).find("trkseg trkpt");
		const mnBound = $(ucLine).find("bounds")[0];

		const latArr = new Array();
		const lonArr = new Array();
		const latlonArr = new Array();

		for(let i=0; i<trkptArr.length; i++){
			const lat = trkptArr[i].getAttribute("lat");
			const lon = trkptArr[i].getAttribute("lon");
			
			latArr.push(lat);
			lonArr.push(lon);
			latlonArr.push(new kakao.maps.LatLng(lat,lon));	
			
		}

		polyObj.setPath(latlonArr);
		const distancePerLine = (((polyObj.getLength()/1000).toFixed(1))/(eleArr.length-1)).toFixed(10);

		for(let i=0; i<eleArr.length; i++){
			const elData = [distancePerLine*i,Number(Number((eleArr[i].innerHTML)).toFixed(1))];
			
			altitudeData.push(elData);			
			altitudeArr.push(eleArr[i].innerHTML);
			
		}
	
		const maxLat = mnBound.getAttribute("maxlat");
		const maxLon = mnBound.getAttribute("maxlon");	
		const minLat = mnBound.getAttribute("minlat");
		const minLon = mnBound.getAttribute("minlon");

		courseBounds.extend(new kakao.maps.LatLng(maxLat,maxLon));
		courseBounds.extend(new kakao.maps.LatLng(minLat,minLon));

		manager.put(kakao.maps.drawing.OverlayType.MARKER, latlonArr[0],0);  // 출발점마커 
		manager2.put(kakao.maps.drawing.OverlayType.MARKER, latlonArr[latlonArr.length-1],0); // 도착점 마커
		manager3.put(kakao.maps.drawing.OverlayType.POLYLINE, latlonArr);
		map.setBounds(courseBounds);
		google.charts.setOnLoadCallback(drawAltitude);

		const sMarkerLatLon = latlonArr[0];
		const eMarkerLatLon = latlonArr[latlonArr.length-1];
	
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

	   const distance = (polyObj.getLength()/1000).toFixed(1);

    	fixC.innerHTML=""; // 새로 라인을 그리기 후 가져오기눌러주세요 글을 없앤다
    	fixC.setAttribute("val", "n");
    	line.value = setGpx(latArr,lonArr,altitudeArr);
	    dis.value = distance;
	    time.value = (distance/20*60).toFixed(0);
	    
	    infoC.disabled = true;

		
		const c_views = cJson.c_views;
		//console.log(c_views);
		c_views.forEach(function(v, i) {  // 코스풍경 셀렉트 선택
			if(i == 0){
				const firstViewOp = document.querySelectorAll("#firstView option");
				firstViewOp.forEach(function(op, i) {
					if(op.value == v){
						op.selected = true;
						firstViewChange(op);
					}
				});
			}
			if(i == 1){
				const secondViewOp = document.querySelectorAll("#secondView option");
				secondViewOp.forEach(function(op, i) {
					if(op.value == v){
						op.selected = true;
						secondViewChange(op);
					}
				});
			}
			if(i == 2){
				const thirdViewOp = document.querySelectorAll("#thirdView option");
				thirdViewOp.forEach(function(op, i) {
					if(op.value == v){
						op.selected = true;
						thirdViewChange(op);
					}
				});
			}
			if(i == 3){
				const fourthViewOp = document.querySelectorAll("#fourthView option");
				fourthViewOp.forEach(function(op, i) {
					if(op.value == v){
						op.selected = true;
					}
				});
			}
		});
		diff.options[cJson.c_difficulty].selected = true;  // 난이도 셀렉트선택
		words.value = cJson.c_words;  // 코스설명 

		ptJson.forEach(function(p, i) {
			const ptLine = eval(p.pt_line);
			const ptValue = p.pt_img.substring(0,p.pt_img.indexOf("."));
			console.log(ptValue);
			
			if(p.code_value == "00201"){
				pt_noPS.value = p.pt_no;
	
				managerPS.put(kakao.maps.drawing.OverlayType.MARKER, ptLine[0],0);
				managerPS.put(kakao.maps.drawing.OverlayType.POLYLINE, ptLine);
				getInfoPS();
				const ptOptions = document.querySelectorAll('#sPT option');
				ptOptions.forEach(function(op, i) {
					if(op.value == ptValue){
						op.selected = true;
					}
				});
				sPTStation.value = p.pt_station.substring(p.pt_station.indexOf(" ")+1);
			}
			else{
				pt_noPE.value = p.pt_no;
					
				managerPE.put(kakao.maps.drawing.OverlayType.MARKER, ptLine[0],0);
				managerPE.put(kakao.maps.drawing.OverlayType.POLYLINE, ptLine);
				getInfoPE();
				const ptOptions = document.querySelectorAll('#ePT option');
				ptOptions.forEach(function(op, i) {
					if(op.value == ptValue){
						op.selected = true;
					}
				});
				ePTStation.value = p.pt_station.substring(p.pt_station.indexOf(" ")+1);
			}
		})
		
		cJson.c_photo.forEach(function(cp, i) {
			const imgUrl = cp.cp_path+"/"+cp.cp_name;
			const req = new XMLHttpRequest();
			req.open('GET',imgUrl);
			req.responseType="blob";
			req.send(null);
			req.addEventListener("load", function(e) {
				const imgFile = this.response;
				addPhoto([imgFile]);
				
			})
		
		});
		
	};	

	
	$("#courseForm button").attr("type", "button");
	
	
	//--------------- 수정내용 세팅장소 끝

}
</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
      <div class="container">
         <a style="font-family: 나눔스퀘어라운드;font-size: 30px;" class="navbar-brand" href="/mainPage">
        <span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
        <font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</font></span></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
               <span class="oi oi-menu"></span> Menu
            </button>
       <div style="display: block;">
         <div class="collapse navbar-collapse" id="ftco-nav" style="height: 20px;">
              <ul class="navbar-nav ml-auto">
               <c:choose>
                  <c:when test="${m == null }">
                     <li class="nav-item"><a style="font-size: 15px;" href="/login" class="nav-link">로그인</a></li>
                     <li class="nav-item"><a style="font-size: 15px;" href="/signUp" class="nav-link">회원가입</a></li>
                  </c:when>
                  <c:when test="${m != null }">
                     <li id="courseDropPoint"  class="nav-item dropdown">
                      <a class="nav-link  dropdown-toggle" href="#" data-toggle="dropdown" style="font-size: 15px;">  ${m.nickName } 라이더 님  </a>
                      <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="/myPage?id=${m.id}"> 정보 수정 </a></li>
                        <li><a class="dropdown-item" href="/myPageSaveCourse"> 찜 목록 </a></li>
                        <li><a class="dropdown-item" href="/myPageMyCourse"> 내 코스 </a></li>
                        <li><a class="dropdown-item" href="/listReview?searchType=id&searchValue=${m.id }"> My 후기 </a></li>
                        <li><a class="dropdown-item" href="/listMeeting?id=${m.id}"> My 번개 </a></li>
                        <li><a class="dropdown-item" href="/myPageMyRank"> 랭킹 </a></li>
                      </ul>
                    </li>
                     <li class="nav-item"><a style="font-size: 15px;" href="/logout" class="nav-link">로그아웃</a></li>
                       <c:if test="${m.code_value == '00101' }">
                     <li class="nav-item"><a style="font-size: 15px;" href="/admin/adminPage" class="nav-link">관리자 페이지</a></li>
							      </c:if>
                  </c:when>
               </c:choose>
            </ul>
         </div>      

         <div class="collapse navbar-collapse" id="ftco-nav" style="height: 40px;">
           <ul class="navbar-nav ml-auto">
             <li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
             <li class="nav-item"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
             <li class="nav-item" ><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
             <li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
             <li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
             <li class="nav-item" active><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
             <!-- <li class="nav-item"><a href="contact.html" class="nav-link">Contact</a></li>-->
           </ul>
         </div>
       </div>
     </div>
   </nav>
    <!-- END nav -->
	<section class="hero-wrap hero-wrap-2" style="background-image: url('/headerImg/makingCourseMain.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="#">HOME <i class="fa fa-chevron-right"></i></a></span> <span>코스 상세 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">코스 수정</h1>
          </div>
        </div>
      </div>
    </section>
    <section class="ftco-section ftco-property-details">
      <div class="container">
			<div class="col-md-12 heading-section text-center ftco-animate">
     			<span class="subheading">코스를 수정합니다</span>
     		</div>
	
	<div id="contents">
		<form id="courseForm">
		<div>
			<input type="text" name="c_name"  id="courseName" maxlength="15" placeholder="나만의 코스에 이름을 붙여주세요.">
			<span id="courseNameCnt"></span>
		</div>
			<div>
				<input type="text" id="oldCourseName" readonly="readonly">
			</div>
					
			<!-- div 감싼 이유 물어보기 -->
			<!-- <div id="detailMap">
				<div class="map_wrap"> -->
				<div id="map" style="text-align: center;"></div>
				<!-- </div> -->
			<!-- </div> -->
 			
 			<div class="bicycleInfo" id="bicycleInfo">
				<input type="checkbox" id="chkBicycle"/> 자전거도로 정보 보기
				<div style="padding-top: 5px;">
		  			<select id="publicCycle">
		  				<option value="0">공공자전거 대여위치</option>
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
	  		<!-- p지워도 되는지? -->
			<p>
				<div class="readFilebox" style="text-align:right;  position: relative; z-index: 2;">
					<label for="bikeFile">경로파일 불러오기</label>
					<input type="file" value="경로파일" id="bikeFile"><br>
				</div>
				<div class="btnDiv">
					<!--  <button type="button" class="btnOption" id="bike">경로만들기</button>-->
				    <button type="button" class="btnOption" id="startC">출발</button>
				    <button type="button" class="btnOption" id="arriveC">도착</button>
				    <button type="button" class="btnOption" id="polyC" >선</button>
				    <button type="button" class="btnOption" id="backPolyC" class="disabled" disabled>선 되돌리기</button>
				    <button type="button" class="btnOption" id="frontPolyC"  class="disabled" disabled>선 앞돌리기</button>
				    <button type="button" class="btnOption" id="infoC" disabled="disabled">가져오기</button><br>
				     <span id="fixC" val="y" style="color: #d0a183; font-weight: bold;"></span>
				</div>
			</p>
			
			<input type="hidden" id="nickName" name="nickName">
			<input type="hidden" id="courseNum" name="c_no" > 
			<input type="hidden" id="courseId" name="id"> 
			<input type="hidden" id="courseCodeValue" name="code_value">

			<div id="chart_div" style="width: 100%; height: 300px;"></div>
			<!-- 출발 -->
			<img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png">
			<!-- 위도 --> <input type="hidden" id="slat" name="c_s_latitude" value="0" readonly="readonly">
			<!-- 경도 --> <input type="hidden" id="slon" name="c_s_longitude" value="0" readonly="readonly">
			<!-- 출발지 --> <input type="text" id="sLoc" name="c_s_locname" readonly="readonly" size="50" placeholder="출발지 주소가 입력됩니다."><br>
			
			<!-- 도착 -->
			<img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png">
			<!-- 위도 --> <input type="hidden" id="elat" name="c_e_latitude" value="0" readonly="readonly">
			<!-- 경도 --> <input type="hidden" id="elon" name="c_e_longitude" value="0" readonly="readonly">
			<!-- 도착지 --> <input type="text" id="eLoc" name="c_e_locname" readonly="readonly" size="50" placeholder="도착지 주소가 입력됩니다."><br>
			
			<!-- 거리 -->거리 <input class="right-text" type="text"  id="dis" name="c_distance" value="0" readonly="readonly"> km<br>
			<!-- 시간 -->시간 <input class="right-text" type="text" id="time" name="c_time" value="0" readonly="readonly"> 분<br>
			<!-- 난이도 -->
			<div>
			<label for="diff" class="textFont">코스난이도 </label>
			<select id="diff" name="c_difficulty">
				<option value="0">--난이도 선택--</option>
				<option value="1">쉬움</option>
				<option value="2">보통</option>
				<option value="3">어려움</option>
				<option value="4">힘듦</option>
			</select>
			</div>
			<div>
			<label for="tag" class="textFont">코스 #태그 </label>
			 <input type="text" name="c_tag" id="tag" maxlength="15" placeholder="ex)#가을#축제#힐링" style="width: 300px;"> <span id="courseTagCnt"></span>
			</div>
			<div id="rankViewAll">
				<div id="rankViewTitle" class="textFont">어울리는 풍경을 지정해주세요.</div>
				<div class="rankView">
					<!-- 1순위 -->
					<img src="../courseMaking/finger_1.png"><br>
					<select id="firstView" name="c_view1">
						<option value="0">--1순위--</option>
						<option value="강">강</option>
						<option value="산">산</option>
						<option value="명소">명소</option>
						<option value="바다">바다</option>
					</select>
				</div>
				<div class="rankView">
					<!-- 2순위 -->
					<img src="../courseMaking/finger_2.png"><br>
					<select id="secondView" name="c_view2">
					<option value="0">--2순위--</option>
					</select>
				</div>
				<div class="rankView">
					<!-- 3순위 -->
					<img src="../courseMaking/finger_3.png"><br>
					<select id="thirdView" name="c_view3">
					<option value="0">--3순위--</option>
					</select>
				</div>
				<div class="rankView">
					<!-- 4순위 -->
					<img class="fingerImg" src="../courseMaking/finger_4.png"><br>
					<select id="fourthView" name="c_view4">
					<option value="0">--4순위--</option>
					</select>
				</div>
			</div>
			
			<!-- 선경로 숨겨도 되는지 물어보기 -->
			<div style="display: none;">
				<textarea rows="10" cols="80" id="line" name="c_line" style="border: none;"></textarea>
			</div>
			
			<!-- 코스 설명 -->
			<div id="wordsDiv" class="textFont">코스에 대해서 간단히 설명해주세요.
				<textarea rows="20" cols="30" id="words" name="c_words" maxlength="3000" placeholder="ex) 시원한 강과함께 들판을 나란히 두고 라이딩하는..." style="resize:none; border: none; width:80%; padding: 10px 5px 0 5px;"></textarea>
				<div style="text-align: right; padding-right: 130px; height: 50px;">
					<span id="wordsCnt"></span>
				</div>
			</div>
			
			
			<!-- 코스 사진 -->
			<div id="thumbnailsDiv" class="textFont">사진을 등록해주세요.
				<div id="drop" style="height: 300px; padding: 3px;">
					<div id="thumbnails"></div>
				</div>
			</div><br>
			<div class="filebox" style="position: relative; bottom: 100px; text-align: right; margin: 0 40px 0 0;">
				<label for="photoInput"><img src="../meetingImg/galleryOff.png" title="사진등록" id="gallery" width="50px"/></label>
				<input type="file" id="photoInput" multiple="multiple">
			</div>
				
			<strong>[출발점 대중교통]</strong>
			<div id="mapPS"></div>
			<div id="bicycleInfoPS" class="bicycleInfo">
				<input type="checkbox" id="chkBicyclePS"/> 자전거도로 정보 보기
			</div>
			<div class="btnDiv">
				<button type="button" class="btnOption" id="publicTranportPS" >대중교통표시</button>
				<button type="button" class="btnOption" id="polyPS" >선</button>
				<button type="button" class="btnOption" id="backPolyPS" class="disabled" disabled>선 되돌리기</button>
				<button type="button" class="btnOption" id="frontPolyPS" class="disabled" disabled>선 앞돌리기</button>
				<button type="button" class="btnOption" id="infoPS" disabled="disabled">가져오기</button><br>
				<span id="fixPS" val="y" style="color: #d0a183;; font-weight: bold;"></span>
			</div>
			<input type="hidden" id="pt_noPS" name="pt_noPS">
			<!-- 대중교통위치 -->
			<!-- 위도 --> <input type="hidden" id="latPS" name="pt_latitudePS" value="0">
			<!-- 경도 --> <input type="hidden" id="lonPS" name="pt_longitudePS" value="0">
			<div>
			<label for="disPS" class="textFont">거리 </label>
			<input class="right-text" type="text" id="disPS" name="pt_distancePS" value="0" readonly="readonly"> km
			</div>
			<div>
			<label for="sPT" class="textFont">대중교통 </label>
			<select id="sPT" name="pt_imgPS">
				<option value="(입력안함)">--대중교통선택--</option>
				<option value="지하철">지하철</option>
				<option value="시내버스">시내버스</option>
				<option value="시외버스">시외버스</option>
				<option value="기차">기차</option>
			</select>
			</div>
			<div>
			<label for="sPTStation" class="textFont">역/정류장 </label>
			 <input type="text" id="sPTStation"  name="pt_stationPS" maxlength="14" placeholder="ex)2호선 신촌역, 신촌오거리역.."> <span id="sPTStationCnt"></span>
			</div>
			<!-- 대중교통출발 선경로 -->
			<div style="display: none;">
				<textarea rows="10" cols="80" id="linePS" name="pt_linePS"></textarea>
			</div>
			<div style="margin-top: 50px;"></div>
			
			
			
			<strong>[도착점 대중교통]</strong>
			<div id="mapPE"></div>
			<div id="bicycleInfoPE" class="bicycleInfo">
				<input type="checkbox" id="chkBicyclePE"/> 자전거도로 정보 보기
			</div>
			<div class="btnDiv">
				<button type="button" class="btnOption" id="publicTranportPE" >대중교통표시</button>
			    <button type="button" class="btnOption" id="polyPE" >선</button>
			    <button type="button" class="btnOption" id="backPolyPE" class="disabled" disabled>선 되돌리기</button> <!-- disabled -->
				<button type="button" class="btnOption" id="frontPolyPE" class="disabled" disabled>선 앞돌리기</button>
				<button type="button" class="btnOption" id="infoPE" disabled="disabled">가져오기</button><br>
				<span id="fixPE" val="y" style="color: #d0a183;; font-weight: bold;"></span>
			</div>
			<input type="hidden" id="pt_noPE" name="pt_noPE">
			<!-- 대중교통위치 --> 
			<!-- 위도 --> <input type="hidden" id="latPE" name="pt_latitudePE" value="0" >
			<!-- 경도 --> <input type="hidden" id="lonPE" name="pt_longitudePE" value="0" >
			<div>
				<label for="disPE" class="textFont">거리 </label>
				 <input class="right-text" type="text" id="disPE" name="pt_distancePE" value="0" readonly="readonly"> km
			</div>			
			<div>
			<label for="ePT" class="textFont">대중교통 </label>
			<select id="ePT" name="pt_imgPE">
				<option value="(입력안함)">--대중교통선택--</option>
				<option value="지하철">지하철</option>
				<option value="시내버스">시내버스</option>
				<option value="시외버스">시외버스</option>
				<option value="기차">기차</option>
			</select>
			</div>
			<div>
			<label for="ePTStation" class="textFont">역/정류장 </label>
			 <input type="text" id="ePTStation" name="pt_stationPE" maxlength="14" placeholder="ex)2호선 신촌역, 신촌오거리역.."> <span id="ePTStationCnt"></span>
			</div>
			
			<!-- 대중교통도착 선경로 -->
			<div style="display: none;">
				<textarea rows="10" cols="80" id="linePE" name="pt_linePE" ></textarea>
			</div>
		</form>
			
			
			<div class="btnDiv">
				<button type="button" class="btnAdd" id="previewUpdateCourse" style="background-color: #eccb6a">미리보기</button>
				<button type="button" class="btnAdd" id="updateCourse" style="background-color: #d0a183">수정</button>
			</div>
			</div>
			</div>
		</section>
	<!-- footer 시작 -->
	<footer class="ftco-footer ftco-section">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Today's Riding</h2>
              <p>For your perfect ride.</p>
              <ul class="ftco-footer-social list-unstyled mt-5">
                <li class="ftco-animate"><a href="#"><span class="fa fa-twitter"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="fa fa-facebook"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="fa fa-instagram"></span></a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">Community</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>코스 찾기</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>라이딩 후기</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>번개 라이딩</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>FAQs</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">About Ora</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>오늘의 라이딩</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>공지사항</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>QnA</a></li>
              </ul>
            </div>
          </div>
          
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Have a Questions?</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon fa fa-map"></span><span class="text">서울시 마포구 백범로 23</span></li>
	                <li><a href="#"><span class="icon fa fa-phone"></span><span class="text">+82 02 1234 5678</span></a></li>
	                <li><a href="#"><span class="icon fa fa-envelope pr-4"></span><span class="text">ora@bit.com</span></a></li>
	              </ul>
	            </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">

            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> 오늘의 라이딩 All rights reserved
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer> 

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

  <script src="/resources/js/jquery.min.js"></script>
  <script src="/resources/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/resources/js/popper.min.js"></script>
  <script src="/resources/js/bootstrap.min.js"></script>
  <script src="/resources/js/jquery.easing.1.3.js"></script>
  <script src="/resources/js/jquery.waypoints.min.js"></script>
  <script src="/resources/js/jquery.stellar.min.js"></script>
  <script src="/resources/js/owl.carousel.min.js"></script>
  <script src="/resources/js/jquery.magnific-popup.min.js"></script>
  <script src="/resources/js/jquery.animateNumber.min.js"></script>
  <script src="/resources/js/scrollax.min.js"></script>
  <script src="/resources/js/main.js"></script>   

</body>
</html>