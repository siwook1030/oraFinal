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
   	margin: 0 auto;
	   	width: 1000px;
	   	font-family: 'NEXON Lv1 Gothic Low OTF';
	   	text-align: center;
   }
   #recommendCourse{
   		margin-top: 20px;
   		text-align: center;
   }
    #rcTitle{
	border-bottom : solid 1px gray;
   	font-size : 110%;
   	width : 40%;
   	padding-bottom : 5px;
   	color: gray;
   	margin-left: auto; 
   	margin-right: auto;
   }
   #rcList{
   	width: 100%;
   }
	
	#rcBox{
		display: inline-table;
		width: 20%;
		height: 200px;
		margin: 0 10px 0 10px;
		word-break:break-all;
	}
 	
 	#rcBoxName{
 		background-color: black; 
 		padding: 5px 0 5px 0;
   		text-align : center;
    	opacity: 0.5;
    	margin-top: 80px;
    	font-size: 130%;
 	}
 	#rcBoxName span{
 		color: white;
 		
 	}
 	
    #helpDesk{
   		margin-top: 100px;
   		text-align: center;
   }
     #hdTitle{
	border-bottom : solid 1px gray;
   	font-size : 110%;
   	width : 40%;
   	padding-bottom : 5px;
   	color: gray;
   	margin-left: auto; 
   	margin-right: auto;
   }
   #hdList{
   	display: inline-block;
   	width: 100%;
   }
  #hdBox{
 	word-break:break-all;
  	display: inline-table;
  	width: 14%;
  	height: 140px;
  	margin: 0 10px 0 10px;
  	background-size: cover;
  }
   /*메인섹션 끝css--------------------------*/
   /*float 초기화 아이디*/
   #clear{
   	clear: both; 
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
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=clusterer"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/js/shuffleArray.js"></script>
<script type="text/javascript">
window.onload = function(){
	const rcViewWord = document.getElementById("rcViewWord");
	const rcList = document.getElementById("rcList");
	let cListByView; //뷰를 구분으로 코스리스트를 담은 리스트 헤더에 사용할거임
	const map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
        level : 14 // 지도의 확대 레벨 
    });
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
	kakao.maps.event.addListener(map, 'idle', function() {
		placeOverlay.setMap(null);
	});
    
    // 마커 클러스터러를 생성합니다 
    const clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 10 // 클러스터 할 최소 지도 레벨 
    });
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
	const imageSize = new kakao.maps.Size(30, 30);
    const riverImg = '/courseMarkerImg/river.png';   
    const mountImg = '/courseMarkerImg/mount.png';   
    const attractImg = '/courseMarkerImg/attract.png';   
    const seaImg = '/courseMarkerImg/sea.png';   
    
	const riverMarkerImg = new kakao.maps.MarkerImage(riverImg, imageSize);
	const mountMarkerImg = new kakao.maps.MarkerImage(mountImg, imageSize);
	const attractMarkerImg = new kakao.maps.MarkerImage(attractImg, imageSize);
	const seaMarkerImg = new kakao.maps.MarkerImage(seaImg, imageSize);
	
    const recomendNum = 3; // 추천코스리스트를 보여줄 수 0부터시작함
	let vNameList;
	let recomendList;
	$.ajax({
		url:"/recomandCourse",
		type:"GET",
		success:function(map){
			 vNameList = map.vNameList; // 뷰단어를 담은 리스트
			 cListByView  = map.cListByView;
			 recomendList = map.cListByView; // 추천코스리스트 랜덤을 돌려야하기때문에 따로 또 받음 
			 setClurseter();
			 setRecomendList(); // 처음 로드시 나타내준다
			 setInterval(setRecomendList, 3000);  // 계속하여 랜덤으로 보여주기위해 인터벌걸어준다
		},
		error:function(){
			alert("에러발생");
		}
	});
	function setClurseter(){
		const markerArr = [];
		const riverList = recomendList[0];
		const mountList = recomendList[1];
		const attractList = recomendList[2];
		const seaList = recomendList[3];
			// 마커이미지가 리스트종류에따라 달라야 하는데 한번에 돌려버리면 if문에 계속 걸리기때문에 나눠서 진행함
		riverList.forEach(function(c, i) {
			const courseMarker = new kakao.maps.Marker({
			    position: new kakao.maps.LatLng(c.c_s_latitude, c.c_s_longitude), 
			    image: riverMarkerImg // 마커이미지 설정 
			});
			kakao.maps.event.addListener(courseMarker, 'click', function() {
	            displayC(c);
	        });
	        markerArr.push(courseMarker);
		});
		
		mountList.forEach(function(c, i) {
			const courseMarker = new kakao.maps.Marker({
			    position: new kakao.maps.LatLng(c.c_s_latitude, c.c_s_longitude), 
			    image: mountMarkerImg // 마커이미지 설정 
			});
			kakao.maps.event.addListener(courseMarker, 'click', function() {
	            displayC(c);
	        });
			markerArr.push(courseMarker);
		});
		
		attractList.forEach(function(c, i) {
			const courseMarker = new kakao.maps.Marker({
			    position: new kakao.maps.LatLng(c.c_s_latitude, c.c_s_longitude), 
			    image: attractMarkerImg // 마커이미지 설정 
			});
			kakao.maps.event.addListener(courseMarker, 'click', function() {
	            displayC(c);
	        });
			markerArr.push(courseMarker);
		});
		
		seaList.forEach(function(c, i) {
			const courseMarker = new kakao.maps.Marker({
			    position: new kakao.maps.LatLng(c.c_s_latitude, c.c_s_longitude), 
			    image: seaMarkerImg // 마커이미지 설정 
			});
			kakao.maps.event.addListener(courseMarker, 'click', function() {
	            displayC(c);
	        });
			markerArr.push(courseMarker);
			
		});
		clusterer.addMarkers(markerArr);
	}
	
	
	function setRecomendList(){  // 추천코스부분 만들어줄 함수
		const rNum =  Math.floor(Math.random()*recomendList.length);
		const vName = vNameList[rNum];
		const vList = recomendList[rNum];
		vList.shuffle();
		const subVlist = vList.slice(0, recomendNum);
		console.log(subVlist);
		let rcContent = "";
		
		subVlist.forEach(function(c, i) {
			rcContent += '<a href="detailCourse?c_no='+c.c_no+'">';
			if(c.c_photo.length == 0){
				rcContent += '<div id="rcBox" style="background-image: url(/coursePhoto/nullcPhoto.png); background-size: cover;">';
			}
			else{
				rcContent += '<div id="rcBox" style="background-image: url(/coursePhoto/course'+c.c_no+'/'+c.c_photo[0].cp_name+'); background-size: cover;">';
			}
			
			rcContent += '<div>made by '+c.nickName+'</div><div id="rcBoxName"><span>'+c.c_name+'</span></div></div></a>';			
		})
		rcViewWord.innerHTML = vName;
		rcList.innerHTML = rcContent;
	}
	
	
}
</script>
</head>
<body>

<jsp:include page="header.jsp"/>
      <div id="clear"></div>
  	<section>
  	<div id="mainPhoto" style="width: 100%; height: 500px; background-image: url('/mainPageImg/mainPhoto1.png');background-size: cover;"></div>
  	<div id="map" style="width:50%;height:350px;"></div>
  		<h4><span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
  		<font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</span></font>과 함께 달려보세요!</h4>
  		<div id="recommendCourse">
  		<div id="rcTitle">
  		Today's&nbsp;Riding<span style="font: italic bold 1.5em/1em Georgia,serif; font-size:15px; color: gray;">&nbsp;&nbsp;&nbsp;view is <span id="rcViewWord">${view }</span></span>
  		</div>
  		<br>
  		<div id="rcList">
  		</div>
  		</div>
  		<div id="helpDesk">
  		<div id="hdTitle">
  		HELP DESK
  		</div>
  		<br>
  		<div id="hdList">
  			<a><div id="hdBox" style="background-image: url('/mainPageImg/howToUse.png');"></div></a>
  			<a href="listNotice"><div id="hdBox" style="background-image: url('/mainPageImg/notice.png');"></div></a>
  			<a><div id="hdBox" style="background-image: url('/mainPageImg/event.png');"></div></a>
  			<a href="/user/makingCourse"><div id="hdBox" style="background-image: url('/mainPageImg/cs.png');"></div></a>
  		</div>
  		</div>
  	</section>
  	<div id="clear"></div>
  	
  	
  	
  	
  	<jsp:include page="footer.jsp"/>
</body>
</html>