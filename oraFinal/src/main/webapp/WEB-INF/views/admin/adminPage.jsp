<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
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

	 .cInfoIcon {
	   	width: 20px;
	   }
	   
	    .cViewIcon {
	   	width: 34px;
	   }
	   
	      .viewImg {
	   	margin-right: 10px;
	   }
   	
   	.approveBtn {
   		cursor: pointer;
   	}
   	.changCnt{
   		text-align: center;
   	}

	.d-flex .nav-link active, .d-flex .nav-link {
		font-weight: bold;
	}
	
	.d-flex .nav-link:hover, .d-flex .nav-link:focus{
		background: #f4dfcf;
   		 color: white; 
	}
	
	.cntImg {
		width: 80px;
		margin-right: 15px;
	}
	
</style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	window.onload = function(){
		 	const token = $("meta[name='_csrf']").attr("content");
		    const header = $("meta[name='_csrf_header']").attr("content");
		    $(document).ajaxSend(function(e, xhr, options) {
		        if(token && header) {
		            xhr.setRequestHeader(header, token);
		        }
		    });

		// 차트 구성하는 구간
		google.charts.load("current", {packages:["corechart"]});
		google.charts.setOnLoadCallback(drawChart);

		 function drawChart() {
		        const cDistance = google.visualization.arrayToDataTable([
		          ['DISTANCE', 'COUNT'],
		          ['Work',    11],
		          ['Eat',      2],
		          ['Commute',  2],
		          ['Watch TV', 2],
		          ['Sleep',    7]
		        ]);

		        const cDistanceOptions = {
		          title: '<코스검색 거리 선택>',
		          titleTextStyle: {color: 'black', fontSize: 16},
		          pieHole: 0.4,
		          forceIFrame:true,
		          width:'100%',
		          height: 400
		        };    

		        const cTime = google.visualization.arrayToDataTable([
			          ['TIME', 'COUNT'],
			          ['Work',     11],
			          ['Eat',      2],
			          ['Commute',  2],
			          ['Watch TV', 2],
			          ['Sleep',    7]
			        ]);

		        const cTimeOptions = {
		          title: '<코스검색 시간 선택>',
		          titleTextStyle: {color: 'black', fontSize: 16},
		          pieHole: 0.4,
		          forceIFrame:true,
		          width:'100%',
		          height:400
		        };

		        const cView = google.visualization.arrayToDataTable([
			          ['VIEW', 'COUNT'],
			          ['SD',      2],
			          ['Commute',  2],
			          ['Watch TV', 2],
			          ['Sleep',    7]
			        ]);

		        const cViewOptions = {
		          title: '<코스검색 시간 선택>',
		          titleTextStyle: {color: 'black', fontSize: 16},
		          pieHole: 0.4,
		          forceIFrame:true,
		          width:'100%',
		          height:400
		        };

		     

		        const cDistanceChart = new google.visualization.PieChart(document.getElementById('cDistanceChart'));
		        cDistanceChart.draw(cDistance, cDistanceOptions);

		        const cTimeChart = new google.visualization.PieChart(document.getElementById('cTimeChart'));
		        cTimeChart.draw(cTime, cTimeOptions);

		        const cViewChart = new google.visualization.PieChart(document.getElementById('cViewChart'));
		        cViewChart.draw(cView, cViewOptions);
		        
		        window.addEventListener("resize",drawChart,false);  
 
		      }

		
		//--------------------

		// 승인대기코스 갖고오는 구간 시작
		const cTempCnt = document.getElementById("course-temp-cnt");
		const searchList = document.getElementById("searchList");
		
		function setApproveCourse(){
			const cReq = new XMLHttpRequest();	
			cReq.addEventListener("load", function(e) {
					const cList = cReq.response;
					let cTempCntStr = "("+cList.length+")";
					 
					if(cList.length > 0){
						cTempCntStr += '<img src="/adminImg/new.png" width="40px">';
					}
					cTempCnt.innerHTML =cTempCntStr;
					searchList.innerHTML = "";
					cList.forEach(function(c, i) {
						setCourseBox(c);
					});		
			});
			cReq.addEventListener("error", function(e){
				alert("에러발생");
			});
			cReq.open("GET", "/admin/getCourseListByTemp");
			cReq.responseType="json";
			cReq.send(null);
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
				diffContent = '<span style="color:red;">힘듬</span>';
			}

			let courseViewContent="";
			c.c_views.forEach(function(v, i) {
				courseViewContent += '<div title="'+v+'" class="img viewImg" style="background-image: url(/courseViewImg/'+v+'.png);"></div>';
			});

			
		let courseContent = '<div class="property-wrap ftco-animate fadeInUp ftco-animated">\
				<a href="/detailCourse?c_no='+c.c_no+'" class="img" target="_blank" style="background-image: url('+c.c_photo[0].cp_path+'/'+c.c_photo[0].cp_name+');">\
					<div class="rent-sale">\
						<span class="rent">등록일 '+c.c_regdate+'</span><br>\
						<span class="rent">'+c.c_loc+'</span>\
					</div>\
					<p title="승인대기중" class="price"><span class="orig-price" style="color:black;">승인대기중</span></p>\
				</a>\
				<div class="text">\
					<h3><a href="/detailCourse?c_no='+c.c_no+'" target="_blank">'+c.c_name+'</a></h3>\
					<span class="location">made by '+c.nickName+'</span>\
					<span title="승인" class="approveBtn d-flex align-items-center justify-content-center btn-custom">\
						<span class="approveBtn" cno="'+c.c_no+'" cname="'+c.c_name+'" id="'+c.id+'" ><img class="approveBtn" cno="'+c.c_no+'"  cname="'+c.c_name+'"  id="'+c.id+'" width="32px" src="/adminImg/stamp.png"></span>\
					</span>\
					<ul class="property_list" style="font-weight: bold;" >\
						<li title="코스거리" ><span class="flaticon-bed"><img class="cInfoIcon" src="/searchCourseImg/distance.png"></span>'+c.c_distance+'km</li>\
						<li title="소요시간" ><span class="flaticon-bathtub"><img class="cInfoIcon" src="/searchCourseImg/time.png"></span>'+courseTime+'</li>\
						<li title="난이도" ><span class="flaticon-floor-plan"><img class="cInfoIcon" src="/searchCourseImg/difficulty.png"></span>'+diffContent+'</li>\
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
		// 승인대기코스 갖고오는 구간 끝
		
		// 첫 승인코스만들기 실행
		setApproveCourse();

		// 코스 승인하는 구간
		searchList.addEventListener("click", function(e) {
			const className = e.target.className;
			if(className == "approveBtn"){
					const c_no = e.target.getAttribute("cno");
					const c_name = e.target.getAttribute("cname");
					const id = e.target.getAttribute("id");

					const cfm = confirm(c_name+" 코스를 승인하시겠습니까?");

					if(!cfm){
						return;
					}
					
					approveCourse(c_no, c_name,id);
					console.log(c_no+"/"+c_name+"/"+id);
				}
		});

		function approveCourse(c_no, c_name,id){
			console.log(c_no+"/"+c_name+"/"+id);
			const data = new FormData();
			data.set("c_no", c_no);
			data.set("c_name", c_name);
			data.set("id", id);
			const aReq = new XMLHttpRequest();
			aReq.addEventListener("load", function(e) {
				const re = aReq.responseText;
				alert(re);
				setApproveCourse();
			});
			aReq.addEventListener("error", function(e) {
				alert("에러발생");
			});
			aReq.open("POST", "/admin/approveCourse");
			aReq.send(data);
		}
		
		//

		
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
                  <c:when test="${m == null }" >
                     <li class="nav-item"><a style="font-size: 15px;" href="/login" class="nav-link">로그인</a></li>
                     <li class="nav-item"><a style="font-size: 15px;" href="/signUp" class="nav-link">회원가입</a></li>
                  </c:when>
                  <c:when test="${m != null }">
                     <li class="nav-item"><a style="font-size: 15px;" class="nav-link">${m.nickName } 라이더님</a></li>
                     <li class="nav-item"><a style="font-size: 15px;" href="/logout" class="nav-link">로그아웃</a></li>&nbsp;&nbsp;
                     <li class="nav-item"><a style="font-size: 15px;" href="/myPage?id=${m.id}" class="nav-link">마이페이지</a></li>
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
             <li class="nav-item active"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
             <li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
             <li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
             <li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
             <!-- <li class="nav-item"><a href="contact.html" class="nav-link">Contact</a></li>-->
           </ul>
         </div>
       </div>
      </div>
   </nav>
    <!-- END nav -->
	<section class="hero-wrap hero-wrap-2" style="background-image: url('/resources/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">오늘의 라이딩 <i class="fa fa-chevron-right"></i></a></span> <span>관리자 페이지 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">관리자 페이지</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-counter img" id="section-counter">
    	<div class="container">
	    	<div class="col-md-12 heading-section text-center ftco-animate" style="margin-top: 50px;">
	     		<span class="subheading">오늘의 라이딩 현황을 파악합니다</span>
	     	</div>
    		<div class="row pt-md-5" style="border-bottom: solid 1px;">
          <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
            <div class="block-18 py-5 mb-4">
              <div class="text text-border d-flex align-items-center">
              	<img src="/adminImg/memberCnt.png" class="cntImg" title="전체 회원수">
                <strong class="number" data-number="${memberAllCnt }">0</strong>
                <span>회원</span>
              </div>
              <div class="changCnt">
              전일대비
              	<c:if test="${memberChangeCnt > 0}">
              		<span style="color: red;">▲</span> <span>${memberChangeCnt }</span>
              	</c:if>
              	<c:if test="${memberChangeCnt == 0}">
              		 <span style="color: black;">-</span> <span>${memberChangeCnt }</span>
              	</c:if>
              	<c:if test="${memberChangeCnt < 0}">
              		 <span style="color: blue;">▼</span> <span>${memberChangeCnt }</span>
              	</c:if>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
            <div class="block-18 py-5 mb-4">
              <div class="text text-border d-flex align-items-center">
              <img src="/adminImg/courseCnt.png" class="cntImg" title="전체 코스갯수">
                <strong class="number" data-number="${courseAllCnt }">0</strong>
                <span>코스</span>
              </div>
              <div class="changCnt">
               전일대비
              	<c:if test="${courseChangeCnt > 0}">
              		 <span style="color: red;">▲</span> <span>${courseChangeCnt }</span>
              	</c:if>
              	<c:if test="${courseChangeCnt == 0}">
              		 <span style="color: black;">-</span> <span>${courseChangeCnt }</span>
              	</c:if>
              	<c:if test="${courseChangeCnt < 0}">
              		 <span style="color: blue;">▼</span> <span>${courseChangeCnt }</span>
              	</c:if>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
            <div class="block-18 py-5 mb-4">
              <div class="text text-border d-flex align-items-center">
              <img src="/adminImg/reviewBoard.png" class="cntImg" title="리뷰게시판 총 게시물 갯수">
                <strong class="number" data-number="${reviewAllCnt }">0</strong>
                <span>리뷰<br>게시판</span>
              </div>
              <div class="changCnt">
              	전일대비
              	<c:if test="${reviewChangeCnt > 0}">
              		 <span style="color: red;">▲</span> <span>${reviewChangeCnt }</span>
              	</c:if>
              	<c:if test="${reviewChangeCnt == 0}">
              		 <span style="color: black;">-</span> <span>${reviewChangeCnt }</span>
              	</c:if>
              	<c:if test="${reviewChangeCnt < 0}">
              		 <span style="color: blue;">▼</span> <span>${reviewChangeCnt }</span>
              	</c:if>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
            <div class="block-18 py-5 mb-4">
              <div class="text d-flex align-items-center">
              <img src="/adminImg/meetingBoard.png" class="cntImg" title="번개게시판 총 게시물 갯수">
                <strong class="number" data-number="${meetingAllCnt }">0</strong>
                <span>번개<br>게시판</span>
              </div>
              <div class="changCnt">
              	전일대비 
              	<c:if test="${meetingChangeCnt > 0}">
              		 <span style="color: red;">▲</span> <span>${meetingChangeCnt }</span>
              	</c:if>
              	<c:if test="${meetingChangeCnt == 0}">
              		 <span style="color: black;">-</span> <span>${meetingChangeCnt }</span>
              	</c:if>
              	<c:if test="${meetingChangeCnt < 0}">
              		 <span style="color: blue;">▼</span> <span>${meetingChangeCnt }</span>
              	</c:if>
              </div>
            </div>
          </div>
        </div>
       
        
    	</div>
    </section>
    
  <section class="ftco-section ftco-property-details">
   <div class="container">
    <div class="row">
      		<div class="col-md-12 pills">
						<div class="bd-example bd-example-tabs">
							<div class="d-flex">
							  <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">

							    <li class="nav-item">
							      <a class="nav-link active" id="course-chart-tab" data-toggle="pill" href="#course-chart" role="tab" aria-controls="course-chart" aria-expanded="true">코스관련</a>
							    </li>
							    <li class="nav-item">
							      <a class="nav-link" id="pills-manufacturer-tab" data-toggle="pill" href="#pills-manufacturer" role="tab" aria-controls="pills-manufacturer" aria-expanded="true">검색관련</a>
							    </li>
							    <li class="nav-item">
							      <a class="nav-link" id="course-temp-tab" data-toggle="pill" href="#course-temp" role="tab" aria-controls="course-temp" aria-expanded="true">승인대기 코스 <span id="course-temp-cnt"></span></a>
							    </li>
							  </ul>
							</div>

						  <div class="tab-content" id="pills-tabContent">
						    <div class="tab-pane fade show active" id="course-chart" role="tabpanel" aria-labelledby="course-chart-tab">
						    	<div class="row">
						    	<div class="col-md-12 heading-section text-center ftco-animate">
						    		<span class="subheading">코스검색 관련 현황</span>
						        	  <div style="margin: 20px 0 20px 0;"></div>
										<div id="cDistanceChart" style="width: 50%; height: 400px;" class="float-left"></div>
						    			<div id="cTimeChart" style="width: 50%; height: 400px;" class="float-right" ></div>
						    			<div id="cViewChart" style="width: 50%; height: 400px;" class="float-left" ></div>
						    	</div>
						    	</div>
						    </div>

						    <div class="tab-pane fade" id="pills-manufacturer" role="tabpanel" aria-labelledby="pills-manufacturer-tab">
						    
						    </div>

						    <div class="tab-pane fade" id="course-temp" role="tabpanel" aria-labelledby="course-temp-tab">
						      <div class="row" id="searchList">
							   	
							   	
							   	</div>
						    </div>
						  </div>
						</div>
		      </div>
				</div>
			</div>
		</section>
    
    
    <footer class="ftco-footer ftco-section">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Ecoverde</h2>
              <p>Far far away, behind the word mountains, far from the countries.</p>
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
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Search Properties</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>For Agents</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Reviews</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>FAQs</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">About Us</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Our Story</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Meet the team</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Careers</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
             <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Company</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>About Us</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Press</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Contact</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Careers</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Have a Questions?</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon fa fa-map"></span><span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span></li>
	                <li><a href="#"><span class="icon fa fa-phone"></span><span class="text">+2 392 3929 210</span></a></li>
	                <li><a href="#"><span class="icon fa fa-envelope pr-4"></span><span class="text">info@yourdomain.com</span></a></li>
	              </ul>
	            </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">
	
            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
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