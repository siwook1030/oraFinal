<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />


<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>오늘의 라이딩 - Today's riding</title>
    <meta charset="utf-8">
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
  
   /*매인섹션부분css------------ ----------------
   section {
   	margin: 0 auto;
	   	width: 1000px;
	   	font-family: 'NEXON Lv1 Gothic Low OTF';
	   	text-align: center;*/
   }
  
   메인섹션 끝css--------------------------*/

   /*float 초기화 아이디*/
   #clear{
   	clear: both; 
   }

   
    .cViewIcon {
   	width: 34px;
   }
      .viewImg {
   	margin-right: 10px;
   }
   
   .owl-carousel .owl-item img{
   		display: inline;
   		width: 25px;
   }
   
     .cInfoIcon {
		width: 25px;
   }
   .search-place:after,	 .col-md-4, .img, .search-place img {
   	border-radius: 10px;
   }
   	
   	/* 버튼세개 */
	.hero-wrap .overlay {
		opacity: 1;
	 }
	.btn-light {
		margin-top: 3px; 
/* 		color: #212529;
		background-color: #f8f9fa;
		border-color: #f8f9fa; */
		/* border-color: #f8f9fa; */
		color: white;
		background-color: transparent;
		border: 2px solid white;
		font-size: 15px;
		font-weight: bold;
	}
	.btn:hover {
		background-color: white;
	}
	.text .mb-4 p {
		font-size: 19px;
	}
	.heading-section .subheading:before,.heading-section .subheading:after{
		background: white;
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
	
	#cBound {
				margin-top:5px;
				padding : 6px;
				border : 1px solid white;
				opacity: 0.9;
				background-color: white;
				border-radius: 3px;
				cursor: pointer;
	}
	
	#markerInfo {
	margin: 0 0 0 8px;
	padding: 5px; 
	z-index: 1; left: 10px; 
	width: 190px; 
	background-color:rgba(255,255,255,0.8); 
	text-align: center; 
	color: black; 
	font-size: 14px; 
	font-weight: bold; 
	}
	.allMapMarker {
		width: 20px;
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7bf02997fccc8f4d0d956482ddd50a0b&libraries=clusterer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/js/shuffleArray.js"></script>
<script type="text/javascript">
window.onload = function(){
		const token = $("meta[name='_csrf']").attr("content");
	    const header = $("meta[name='_csrf_header']").attr("content");
	    const parameter = $("meta[name='_csrf_parameter']").attr("content");
	    $(document).ajaxSend(function(e, xhr, options) {
	        if(token && header) {
	            xhr.setRequestHeader(header, token);
	        }
	    });
	
	console.log("자스작동한다");
	
	const rcViewWord = document.getElementById("rcViewWord");
	const rcList = document.getElementById("rcList");
	let cListByView; //뷰를 구분으로 코스리스트를 담은 리스트 헤더에 사용할거임


	const cBound = document.getElementById("cBound");
	const markerInfo = document.getElementById("markerInfo");
	const mapCenter = new kakao.maps.LatLng(35.84079054000633, 127.8426863007031);
	
	const map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : mapCenter, // 지도의 중심좌표 
        level : 13 // 지도의 확대 레벨 
    });
	map.setMaxLevel(13);
	const zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	map.addControl(cBound, kakao.maps.ControlPosition.RIGHT);
	map.addControl(markerInfo, kakao.maps.ControlPosition.BOTTOMLEFT);

	cBound.addEventListener("click", function(e) {
		map.setLevel(13);
		map.setCenter(mapCenter);
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
						' <a class="title" href="/detailCourse?c_no='+c.c_no+'" target="_blank" title="' + c.c_name + '"><img width="22px" title="'+c.c_views[0]+'" src="/courseViewImg/'+c.c_views[0]+'.png"> ' + c.c_name + '</a>';   

			content += '    <span title="' + c.nickName + '">' + "made by "+c.nickName + '</span>';
     
			content += '    <span class="tel">'+ c.c_loc + "〃"+c.c_distance +"km 〃 "+courseTime+ " 〃 "+diffContent+'</span>' + 
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
		rcList.innerHTML="";
		rcViewWord.innerHTML="";

		const vNameSpan = document.createElement("span");
		vNameSpan.className = "property-wrap ftco-animate fadeInUp ftco-animated";
		vNameSpan.innerHTML = vName;
		
		subVlist.forEach(function(c, i) {
			const courseBox = document.createElement("div");
			courseBox.className="col-md-4";
			
			let courseContent = '<div class="ftco-animate fadeInUp ftco-animated"><a href="/detailCourse?c_no='+c.c_no+'" class="search-place img" style="background-image: url('+c.c_photo[0].cp_path+'/'+c.c_photo[0].cp_name+');">';

			courseContent += '<div class="desc"><h3><span>'+c.c_name+'</span></h3><span>'+c.c_loc+'</span> <span>'+c.c_view+'</span> <br><span>'+c.c_tag+'</span></div></a></div>';

			courseBox.innerHTML = courseContent;
			rcList.append(courseBox);

		})
		rcViewWord.append(vNameSpan);
	}

	// 이달의 추천코스 자동 넘어가기 기능
	const dotArr = document.querySelectorAll(".owl-dots button");
	const maxDot = dotArr.length-1;
	let dotNum = 0;
	const clickDotInterval = setInterval(clickDot, 2000);
	function clickDot(){
		if(dotNum > maxDot){
			dotNum = 0;
		}
		dotArr[dotNum].click();
		dotNum++;
	}

	
	
}
</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a style="font-size: 30px;" class="navbar-brand" href="/mainPage">
				<span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
					<font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</font>
				</span>
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        	<span class="oi oi-menu"></span> Menu
			</button>
			<div style="display: block;">
				<div class="collapse navbar-collapse" id="ftco-nav">
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
				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto" >
						<li class="nav-item active"><a href="/mainPage" class="nav-link">Home</a></li>
						<li id="courseDropPoint"  class="nav-item dropdown">
							<a class="nav-link  dropdown-toggle" href="#" data-toggle="dropdown">  오늘의 라이딩  </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/listNotice"> 공지사항 </a></li>
							</ul>
						</li>
						<li id="courseDropPoint"  class="nav-item dropdown">
							<a class="nav-link  dropdown-toggle" href="#" data-toggle="dropdown">  라이딩 코스  </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/searchCourse"> 맞춤 코스 검색 </a></li>
								<li><a class="dropdown-item" href="/tagSearchCourse"> 태그 코스 검색 </a></li>
							</ul>
						</li>
						<li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
						<li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
						<li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
    <!-- END nav -->	

	<!-- 메인 이미지 -->
    <section class="hero-wrap" data-stellar-background-ratio="0.5">
      <div class="overlay" style="overflow: hidden;"><video autoplay muted loop src="/resources/images/mainPageVideo01.mov"></video></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center">
          <div class="col-lg-7 col-md-6 ftco-animate d-flex align-items-end">
          	<div class="text">
	            <h1 class="mb-4">오늘도 <br>달려볼까요?</h1>
	            <p style="font-size: 19px; font-weight: bold;">당신의 완벽한 라이딩을 위하여 근사한 곳으로 안내할게요!</p>
	            <a href="#mapLink" class="btn btn-light py-3 px-4">모든 코스 보기</a>
	            <a href="/searchCourse" class="btn btn-light py-3 px-4">맞춤 코스 검색</a>
	            <a href="/tagSearchCourse" class="btn btn-light py-3 px-4">태그 코스 검색</a>
<!-- 	            <a href="#mapLink" class="btn btn-primary py-3 px-4 btn-light">모든 코스 보기</a>
	            <a href="/searchCourse" class="btn btn-primary py-3 px-4 btn-light">맞춤 코스 검색</a>
	            <a href="/tagSearchCourse" class="btn btn-primary py-3 px-4 btn-light">태그 코스 검색</a> -->
            </div>
          </div>
        </div>
      </div>
        <div style="color: gray; font-size: 13px; z-index: 1; margin-right: 10px; position: relative; bottom: 30px; text-align: right;">sources : youtube</div>
    </section>	

        
	<section class="ftco-section">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-12 heading-section text-center ftco-animate mb-5">
          	<span class="subheading">Today's Riding</span>
            <h2 class="mb-2">이달의 추천 코스</h2>
          </div>
        </div>
        <div class="row ftco-animate">
          <div class="col-md-12">
            <div class="carousel-properties owl-carousel">
            <c:forEach var="c" items="${thisMonthList }">       
              <div class="item">
                <div class="property-wrap ftco-animate">
		        			<a href="/detailCourse?c_no=${c.c_no}" class="img" style="background-image: url(${c.c_photo[0].cp_path}/${ c.c_photo[0].cp_name});">
		        				<div class="rent-sale">
		        					<span class="rent">${c.c_loc}</span>
		        				</div>
		        				<p title="코스태그" class="price"><span class="orig-price">${c.c_tag }</span></p>
		        			</a>
		        			<div class="text">	
		        				<h3><a href="#">${c.c_name }</a></h3>
		        				<span class="location">made by ${c.nickName }</span>
		        				<a href="#" title="${thisMonth }월 추천코스" class="d-flex align-items-center justify-content-center btn-custom">
		        					<span><img src="/mainPageImg/dec.png" width="40px"></span>
		        				</a>
		        				
		        				<ul class="property_list" style="font-weight: bold;" > 
									<li title="코스거리" ><span class="flaticon-bed"><img class="cInfoIcon" src="/searchCourseImg/distance.png"></span>${c.c_distance }km</li>
									<li title="소요시간" ><span class="flaticon-bathtub"><img class="cInfoIcon" src="/searchCourseImg/time.png"></span>
									<c:if test="${c.c_time >= 60 }">
										<fmt:formatNumber value="${c.c_time/60}" pattern="0" />시간 ${c.c_time%60}분
									</c:if>
									<c:if test="${c.c_time < 60 }">
										${c.c_time%60}분
									</c:if>
									</li>
									<li title="난이도" ><span class="flaticon-floor-plan"><img class="cInfoIcon" src="/searchCourseImg/difficulty.png"></span>
									<c:if test="${c.c_difficulty == 1 }"><span style="color:#88bea6;">쉬움</span></c:if>
									<c:if test="${c.c_difficulty == 2 }"><span style="color: #eccb6a;">보통</span></c:if>
									<c:if test="${c.c_difficulty == 3 }"><span style="color: #c8572d;">어려움</span></c:if>
									<c:if test="${c.c_difficulty == 4 }"><span style="color:red;">힘듦</span></c:if>
									</li>
								</ul>
						
		        				<div class="list-team d-flex align-items-center mt-2 pt-2 border-top">
		        					<div class="d-flex align-items-center">
			        				<c:forEach var="v" items="${c.c_views }">
			        					<div class="img viewImg" title="${v }" style="background-image: url(/courseViewImg/${v}.png);"></div>
			        				</c:forEach>
			        				</div>
			        				<span class="text-right">풍경</span>
		        				</div>
		        			</div>
		        		</div>
              		</div>
              
            	  </c:forEach>
                </div>
              </div>
            </div>
          </div>
        </section>
        
            
    <!-- 정재호 수정중 -->
 	<section class="ftco-section services-section bg-darken">
    	<div class="container">
    		<div class="row justify-content-center">
          <div class="col-md-12 text-center heading-section heading-section-white ftco-animate">
          	<span class="subheading">사용자 가이드</span><br>
            <h2 class="mb-3">오늘의 라이딩 100% 활용방법!</h2>
          </div>
        </div>
    		<div class="row">
    			<div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services services-2">
              <div class="media-body py-md-4 text-center">
              	<div class="icon mb-1 d-flex align-items-center justify-content-center"><!-- <span>01</span> -->
              	<img src="/resources/images/guide06.png" alt="" width="128px">
              	</div>
                <h3>라이딩 코스를 검색하세요!</h3>
                <p>거리, 소요시간, 풍경을 설정하여 코스를 검색해보세요. 최적의 코스를 추천해줍니다.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services services-2">
              <div class="media-body py-md-4 text-center">
              	<div class="icon mb-1 d-flex align-items-center justify-content-center"><!-- <span>02</span> -->
              	<img src="/resources/images/guide05.png" alt="" width="128px"></div>
                <h3>검색한 결과 중에 마음에 드는 코스를 찜하세요!</h3>
                <p>회원가입을 하면 원하는 코스를 "찜" 해두고 볼 수 있습니다. 열심히 활동하여 랭킹을 올려서 혜택을 받아보세요.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services services-2">
              <div class="media-body py-md-4 text-center">
              	<div class="icon mb-1 d-flex align-items-center justify-content-center"><!-- <span>03</span> -->
              	<img src="/resources/images/guide03.png" alt="" width="128px"></div>
                <h3>게시판을 통해 다른사람들과 교류하세요!</h3>
                <p>후기게시판에서 코스후기를 다른사람과 공유할 수 있어요. 혼자 라이딩하는게 외롭다면 번개게시판을 통해 약속을 잡아보세요.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services services-2">
              <div class="media-body py-md-4 text-center">
              	<div class="icon mb-1 d-flex align-items-center justify-content-center"><!-- <span>04</span> -->
              	<img src="/resources/images/guide04.png" alt="" width="128px"></div>
                <h3>나만의 코스를 만들어보세요!</h3>
                <p>나만 알고 있기 아까운 코스를 다른사람과 공유해보세요.</p>
              </div> 
          </div>
    		</div>
    	</div>
    </section>
        
        <section class="ftco-section">
     	 <div class="container">
	        <div class="row justify-content-center" style="margin-top: 100px;">
	          <div class="col-md-12 heading-section text-center ftco-animate mb-5">
	          	<span class="subheading">Today's Riding</span>
	            <h2 class="mb-2">풍경별 추천코스</h2>
	            <span style="font: italic bold 1.5em/1em Georgia,serif; font-size:15px; color: gray;">view is <span id="rcViewWord"></span></span>
	          </div>
	        </div>
	        
	        <div class="row" id="rcList">
	        
	        </div>
        
        <div id="mapLink"></div>
         <div  class="row justify-content-center" style="margin-top: 150px;">
          <div class="col-md-12 heading-section text-center ftco-animate mb-5">
          	<span class="subheading">Today's Riding</span>
            <h2 class="mb-2">자전거 지도</h2>
          </div>
        </div>
	        <div class="col-md-12" >
	           <div id="map" style="width:100%;height:600px; text-align: center; border-radius: 20px;"></div>
	           <button id="cBound" title="한눈에 보기"><img width="20px" src="/detailCourseImg/cBoundBtn.png"></button>
	           <div id="markerInfo">
	           <img class="allMapMarker" src="/courseMarkerImg/river.png">강 
	           <img class="allMapMarker" src="/courseMarkerImg/mount.png">산 
	           <img class="allMapMarker" src="/courseMarkerImg/attract.png">명소 
	           <img class="allMapMarker" src="/courseMarkerImg/sea.png">바다 
	           </div>
	        </div>
      </div>
    </section>
 	
 	
 
  <jsp:include page="footer.jsp" />


</body>
</html>