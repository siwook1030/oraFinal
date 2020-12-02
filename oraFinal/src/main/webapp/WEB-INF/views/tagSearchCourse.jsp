<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>코스 태그검색</title>   
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
	<link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="/resources/css/animate.css">
	<link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
	<link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
	<link rel="stylesheet" href="/resources/css/magnific-popup.css">
	<link rel="stylesheet" href="/resources/css/flaticon.css">
	<link rel="stylesheet" href="/resources/css/style.css">
<style type="text/css">
     #searchListBox{
   		
   		visibility: hidden;
   		display: none;
   }
   
    .cInfoIcon {
   	width: 25px;
   }
   .cViewIcon {
   	width: 34px;
   }
   
   .viewImg {
   	margin-right: 10px;
   }
   
     .search-place:after,	 .col-md-4, .img, .search-place img {
   	border-radius: 10px;
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

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
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

	const searchBtn = document.getElementById("searchBtn");
	const searchKeword = document.getElementById("searchKeword");

	// 코스상세에서 #태그 로 인입시 처리할 내용
	const initSearchTag = document.getElementById("initSearchTag").value;

	if(initSearchTag != "0" ){
		searchKeword.value = initSearchTag;
		searchTagCourse();
	}
	
//----------------------검색된 코스 만드는 곳 ------

	const searchList = document.getElementById("searchList");
	const courseNum = document.getElementById("courseNum");
	const courseNumSpan1 = document.createElement("span");
	courseNumSpan1.style.fontSize="18px";
	courseNumSpan1.style.fontWeight="bold";
	const courseNumSpan2 = document.createElement("span");
	courseNumSpan2.style.fontSize="14px";
	courseNumSpan2.innerHTML = "개 코스가 검색되었습니다";

	let scList = [];
	
	const searchListBox = document.getElementById("searchListBox");

	
	searchBtn.addEventListener("click", searchTagCourse)
	searchKeword.addEventListener("keydown", function(e) {
		if(e.keyCode == "13"){
			searchTagCourse();
		}	
	})
	
	
	function searchTagCourse(){
		const searchTag = searchKeword.value.trim();
		if(searchTag == ""){
			alert("한글자 이상은 입력해주세요");
			searchKeword.focus();
			return;
		}
		let cnt = 0;
		const tagSplit = searchTag.split(",");
		tagSplit.forEach(function(t, i) {
			if(t.trim() != ""){
				cnt++;
			}
		})
		
		if(cnt == 0){
			alert("한글자 이상은 입력해주세요");
			searchKeword.focus();
			return;
		}

		$.ajax({
			url:"/tagSearchCourse?"+parameter+"="+token,
			type:"POST",
			data:{"searchTag":searchTag},
			success:data => {
				searchList.innerHTML="";
				courseNum.innerHTML="";	
				scList = data;	
				scList.forEach(function(c, i) {
					setCourseBox(c);
				})
		
				searchListBox.style.visibility="visible";
				searchListBox.style.display="inline";
				courseNumSpan1.innerHTML = scList.length;
				courseNum.append(courseNumSpan1,courseNumSpan2);
				searchKeword.scrollIntoView();
			},
			error: err => {
				alert("에러발생");
			},
		})
	}

	function setCourseBox(c){
		const courseBox = document.createElement("div");
		courseBox.className="col-md-4";

		let courseTime;
		const hour = parseInt(c.c_time/60);
		const mi = c.c_time%60;
		if(hour >= 1){
			courseTime = hour+'시간 '+mi+'분';
		}
		else{
			courseTime = mi+'분';
		}

		const diff = c.c_difficulty;
		let diffContent;
		if(diff == 1){
			diffContent = '<span style="color:#88bea6;">쉬움</span>';
		}
		else if(diff == 2){
			diffContent = '<span style="color: #eccb6a;">보통</span>';
		}
		else if(diff == 3){
			diffContent = '<span style="color: #c8572d;">어려움</span>';
		}
		else if(diff == 4){
			diffContent = '<span style="color:red;">힘듦</span>';
		}

		let courseViewContent="";
		c.c_views.forEach(function(v, i) {
			courseViewContent += '<div title="'+v+'" class="img viewImg" style="background-image: url(/courseViewImg/'+v+'.png);"></div>';
		});

		
	let courseContent = '<div class="property-wrap ftco-animate fadeInUp ftco-animated">\
			<a href="/detailCourse?c_no='+c.c_no+'" class="img" target="_blank" style="background-image: url('+c.c_photo[0].cp_path+'/'+c.c_photo[0].cp_name+');">\
				<div class="rent-sale">\
					<span class="rent">'+c.c_loc+'</span>\
				</div>\
				<p title="코스태그" class="price"><span class="orig-price">'+c.c_tag+'</span></p>\
			</a>\
			<div class="text">\
				<h3><a href="/detailCourse?c_no='+c.c_no+'" target="_blank">'+c.c_name+'</a></h3>\
				<span class="location">made by '+c.nickName+'</span>\
				<a href="#tagTitle"  title="태그검색" class="d-flex align-items-center justify-content-center btn-custom" id="linkMap" lat="'+c.c_s_latitude+'" lng="'+c.c_s_longitude+'">\
					<span id="linkMap2" lat="'+c.c_s_latitude+'" lng="'+c.c_s_longitude+'"><img src="/searchCourseImg/loupe.png" width="32px"  lat="'+c.c_s_latitude+'" lng="'+c.c_s_longitude+'"></span>\
				</a>\
				<ul class="property_list" style="font-weight: bold;" >\
					<li title="코스거리" ><span class="flaticon-bed"><img class="cInfoIcon" src="/searchCourseImg/distance.png"></span>'+c.c_distance+'km</li>\
					<li title="소요시간" ><span class="flaticon-bathtub"><img class="cInfoIcon" src="/searchCourseImg/time.png"></span>'+courseTime+'</li>\
					<li title="난이도"  ><span class="flaticon-floor-plan"><img class="cInfoIcon" src="/searchCourseImg/difficulty.png"></span>'+diffContent+'</li>\
				</ul>\
				<div class="list-team d-flex align-items-center mt-2 pt-2 border-top">\
					<div class="d-flex align-items-center">'+courseViewContent+'</div>\
    				<span class="text-right">풍경</span>\
				</div>\
			</div>\
		</div>'; 
		
		courseBox.innerHTML = courseContent;
		searchList.append(courseBox);

	}

	// rest api 구현연습-----------------------------------
	 /*	const record = document.getElementById("record")
        const stop = document.getElementById("stop")
        const soundClips = document.getElementById("sound-clips")

        const audioCtx = new(window.AudioContext || window.webkitAudioContext)() // 오디오 컨텍스트 정의

        const analyser = audioCtx.createAnalyser()
        //        const distortion = audioCtx.createWaveShaper()
        //        const gainNode = audioCtx.createGain()
        //        const biquadFilter = audioCtx.createBiquadFilter()

        function makeSound(stream) {
            const source = audioCtx.createMediaStreamSource(stream)

            source.connect(analyser)
            //            analyser.connect(distortion)
            //            distortion.connect(biquadFilter)
            //            biquadFilter.connect(gainNode)
            //            gainNode.connect(audioCtx.destination) // connecting the different audio graph nodes together
            analyser.connect(audioCtx.destination)

        }

        if (navigator.mediaDevices) { 
            console.log('getUserMedia supported.')

            const constraints = {
                audio: true
            }
            let chunks = [];

            navigator.mediaDevices.getUserMedia(constraints)
                .then(stream => {

                    const mediaRecorder = new MediaRecorder(stream)     
     
                    
                    record.onclick = () => {
                        mediaRecorder.start();
                        console.log(mediaRecorder.state);
                        console.log("recorder started");
                        record.style.background = "red";
                        record.style.color = "black";
                    }

                    stop.onclick = () => {
                        mediaRecorder.stop();
                        console.log(mediaRecorder.state);
                        console.log("recorder stopped");
                        record.style.background = "";
                        record.style.color = "";
                    }

                    mediaRecorder.onstop = e => {

                        const blob = new Blob(chunks, {
                            'type': 'audio/wav'
                        })
                        console.log(chunks);
                        console.log(blob);
                        const audioURL = URL.createObjectURL(blob)
                        
                        const formdata= new FormData(); 
                        formdata.append('speak', blob); 
                        
                        axios.request({ 
                            method: 'POST',
                            headers: {
                                   'Content-Type' : 'multipart/form-data'
                                }, 
                            url: '/speechSearch?'+parameter+"="+token, 
                            data: formdata
                         }).then(
                                 rep => {
                         	console.log(rep);
                         	console.log(rep.data);
                         	console.log(rep.config.data);
                         }, 
                         err => {
                        	 console.log(err);
                         });
                     
                        chunks = [];
                    }

                    mediaRecorder.ondataavailable = e => {
                        chunks.push(e.data);
                    }
                })
                .catch(err => {
                    console.log('The following error occurred: ' + err);
                })
        }

	*/

	//------------------------------------------------------

}
</script>
</head>
<body>
<input type="hidden" id="initSearchTag" value="${searchTag }">
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
									<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" style="font-size: 15px;">  ${m.nickName } 라이더 님  </a>
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
						<li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
						<li id="courseDropPoint"  class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">  오늘의 라이딩  </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/listNotice"> 공지사항 </a></li>
							</ul>
						</li>
						<li id="courseDropPoint"  class="nav-item active dropdown">
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
    
	<section class="hero-wrap hero-wrap-2" style="background-image: url('/headerImg/searchCourseMain.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">HOME <i class="fa fa-chevron-right"></i></a></span> <span>라이딩 코스 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread" id="tagTitle">코스 태그검색</h1>
          </div>
        </div>
      </div>
    </section>
    
   <section class="ftco-section ftco-no-pb ftco-no-pt">
    	<div class="container">
	    	<div class="row">
					<div class="col-md-12">
						<div class="search-wrap-1 ftco-animate p-4" style="background-color: #d0a183;">
					              <input type="search" class="form-control" id="searchKeword" placeholder="여러개를 한번에 검색하고싶을땐 ',' 를 붙여주세요. ex)서울,힐링,바다,축제...">
					              <input type="button" value="Search" id="searchBtn" class="form-control btn btn-primary">
		        		</div>
					</div>
	    	</div>
	    </div>
    </section>
    
        <div>
  <!--  	<input type=checkbox id="chk-hear-mic"><label for="chk-hear-mic">마이크 소리 듣기</label>
    <button id="record">녹음</button>
    <button id="stop">정지</button>
    <div id="sound-clips"></div>-->
    </div>
    
    <section class="ftco-section goto-here">
    	<div class="container">
	    	<div id="searchListBox" >
	    		<div class="row justify-content-center">
	          		<div class="col-md-12 heading-section text-center ftco-animate mb-5">
	          			<span class="subheading">검색결과</span>
	            			<h2 class="mb-2"><span style="font-weight: bold;"><font color="#45A3F5" >C</font><font color="#bae4f0">o</font><font color="#88bea6">u</font><font color="#eccb6a">r</font><font color="#d0a183">s</font><font color="#c8572d">e</span></font>
			            <span style="font: italic bold 1.5em/1em Georgia,serif; font-size:10px; color: gray;">&nbsp;&nbsp;&nbsp;in #tag</span></h2>
	          		</div>
	        	</div>
	        	<div id="courseNum" style="text-align: left;"></div>
	        	<div class="row" id="searchList">
	        	
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