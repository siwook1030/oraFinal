<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>오늘의 라이딩</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="resources/css/animate.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.min.css">
	<link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
	<link rel="stylesheet" href="resources/css/magnific-popup.css">
	<link rel="stylesheet" href="resources/css/flaticon.css">
	<link rel="stylesheet" href="resources/css/style.css">
	<style type="text/css">
		/* 검색창 */
		#searchANDinsertContainer { padding-bottom: 40px; text-align: right; }
		#searchInputWrap { display: inline-block; }
		#searchInputWrap .btn { background-color: #bae4f0; }
		#searchType, #searchValue, #searchMethod { height: 37px; width: auto; vertical-align: middle;  }
		#searchValue { width: 200px; }
		#searchMethod { margin-right: 5px; }
		/* 모든 버튼 */
		.btnDiv { height: 40px; text-align: right; margin-bottom: 30px; }
		.btn { color: white; padding: 8px 12px; margin-left: 5px; float: right; font-size: 15px; border: none; cursor: pointer; }
		/* 썸네일사진 중앙기준 */
		#listImg {
			position: absolute; left: 50%; top: 50%; height: auto; width: auto; width: 767px;
			-webkit-transform: translate(-50%,-50%); /* 구글, 사파리 */
			-ms-transform: translate(-50%,-50%); /* 익스플로러 */
			transform: translate(-50%, -50%);
		}
		/* 게시글 제목 */
		.blog-entry .text { height: 450px; /* border: 1px solid orange; */ }
		.meta.mb-3 { height: 90px; /* border: 1px solid purple; */ }
		.meta.mb-3 div { border: /* 1px solid pink; */ }
	</style>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	let searchType = "";	// id,코스번호,제목,내용
	let searchValue = "";	// 검색을 위한 사용자입력값
	let searchMethod = 0;	// 제목,내용 검색방법을 일치or포함중에 선택
	let courseList;			// List<CourseVo> 를 담은 변수. select-option 태그 만들기 위한 용도
	
	// 마이페이지에서 내가 쓴 게시글 조회했을때 처리하기위한 코드.
	// GET방식 쿼리라서 querystring을 가져오기 위한 설정
	const URLSearch = new URLSearchParams(location.search);
	if(URLSearch.has("searchType")) {
		searchType = URLSearch.get("searchType");
	}
	if(URLSearch.has("searchValue")) {
		searchValue = URLSearch.get("searchValue");
	}
	if(URLSearch.has("searchMethod")) {
		searchMethod = URLSearch.get("searchMethod");
	}
	
	const RECORDS_PER_PAGE = 8;	// 페이지당 레코드 수
	const PAGE_LINKS = 5;			// 페이지 하단에 표시되는 페이지링크 수
	let page = 1;	// 현재 페이지 저장 변수(기본은 1페이지)
	
	$(document).ready(function(){
		getJson();			// 댓글과 페이지링크 만드는 함수
		getCourseList();	// List<CourseVo> 받아오기. 코스명으로 게시글 검색용도
		createInput("id");	// 처음엔 기본으로 id기반 검색으로 설정됨
	
		$("#searchType").change(function(){		// searchType이 바뀔때마다 동적으로 검색기능 생성
			createInput($(this).val());
		});
		$(document).on("click", "#btnSearch", function(){	// 검색버튼 눌렀을때 게시물 목록을 거기에 맞춰서 다시 가져온다.
			searchType = $("#searchType").val();
			searchValue = $("#searchValue").val();
			if(searchType === "r_title" || searchType === "r_content") {
				searchMethod = $("#searchMethod").val();
			}
			getJson();
		});
	});
	function createInput(searchType){	// 검색기능 동적으로 생성
		$("#searchInputWrap").empty();
		if(searchType === "r_title" || searchType === "r_content") {
			let $select = $("<select></select>").attr("id", "searchMethod");
			let $option1 = $("<option></option>").val("1").text("일치");
			let $option2 = $("<option></option>").val("2").text("포함");
			$select.append($option1, $option2);
			$("#searchInputWrap").append($select);
		}
		if(searchType === "c_no") {
			let $select = $("<select></select>").attr("id", "searchValue");
			for(let i = 0; i < courseList.length; i++) {
				let $option = $("<option></option>").val(courseList[i].c_no).text(courseList[i].c_name);
				$select.append($option);
			}
			$("#searchInputWrap").append($select);
		} else {
			let $input = $("<input>").attr({type: "text", id: "searchValue", size: 10});
			$("#searchInputWrap").append($input);
		}
		let $button = $("<button></button>").attr({id: "btnSearch", class: "btn"}).text("검색");
		$("#searchInputWrap").append($button);
	}
	
	function getCourseList(){	// List<CourseVo> 받아오기. 코스명으로 게시글 검색용도
		$.ajax({
			url: "/getCourseList",
			success: function(data){
				courseList = data;
			}
		});
	}
	
	function getJson(){
		$.ajax({
			url: "/listReviewJson",
			dataType: "json",
			method: "post",
			data: {
				page: page,	// 현재 페이지 정보 전달
				RECORDS_PER_PAGE: RECORDS_PER_PAGE,	// 페이지당 레코드 수 전달
				searchType: searchType,
				searchValue: searchValue,
				searchMethod: searchMethod
			},
			success: function(data){
				var total_pages = data.total_pages;
				console.log("total_pages : " + total_pages);
				//console.log("data.list : " + data.list);
				$('#rowDFlex').empty();
				$(data.list).each(function(idx,item){
					//console.log(data.list);
					// 사진출력
					
					//console.log(item.rf[0].rf_path);
					//console.log(item.rf[0].rf_savename);
					let listImg;
					let emptyStr;
					if(item.rf.length!=0) {
						listImg = $('<img id="listImg"/>').attr('src',"/"+item.rf[0].rf_path+"/"+item.rf[0].rf_savename);
					} else {
						listImg = $('<img/>').attr('src',"/icons/empty.png");
						emptyStr = $('<div></div>').html('').addClass('emptyStr'); // 빈화면에 글씨적을 수 있음
					}
		            const contentImg = $('<a></a>').addClass('block-20 img').attr("href",'detailReview?r_no='+item.r_no).append(listImg, emptyStr);
	
					// 게시글 정보
		            const r_no = $('<div><div>').html(item.r_no);
		            const c_nameA = $("<a href='/detailCourse?c_no="+item.c_no+"'></a>").html(item.c_name);
		            const c_name = $('<div></div>').append(c_nameA);
		            const nickName_icon = $('<img/>').attr({src : 'rank/'+item.rank_icon, height : '20px'});
		            const nickNameA = $('<a href="/listReview?id='+item.id+'"></a>').html(item.nickName);
		            const nickName = $('<div></div>').append(nickName_icon, nickNameA);
		            const date_diff_str = $('<div></div>').html(item.date_diff_str);
		            const r_hit = $('<div></div>').html(item.r_hit);
		            const speechImg = $('<span></span>').addClass('fa fa-comment'); // 말풍선
		            const total_reply = $('<div></div>').addClass('meta-chat').append(speechImg, " "+item.total_reply); // 말풍선 + 댓글수
		            const r_titleA = $('<a></a>').attr('href','detailReview?r_no='+item.r_no).html(item.r_title);
		            const r_title = $('<h3></h3>').addClass('heading').append(r_titleA);
	
		        	// div에 내용담기
					const metaDiv = $('<div></div>').addClass('meta mb-3');
		            const textDiv = $('<div></div>').addClass('text');
		            const blog_entryDiv = $('<div></div>').addClass('blog-entry justify-content-end');
		            const col = $('<div></div>').addClass('col-md-3 d-flex ftco-animate fadeInUp ftco-animated');
		        
		            metaDiv.append(c_name, nickName, date_diff_str, /* r_hit, */ total_reply);
		            textDiv.append(contentImg, metaDiv, r_title);
		            blog_entryDiv.append(textDiv);
		            col.append(blog_entryDiv);
	
		            $('#rowDFlex').append(col);
				});
	
				// 페이지 하단에 표시되는 페이지링크 수에 따른 시작페이지, 종료페이지 계산
				// tmp는 시작페이지, 종료페이지 계산을 위한 임시변수
				var tmp = parseInt(page / PAGE_LINKS);	// 소수점에서 정수로 변환
				if(page % PAGE_LINKS != 0) {
					tmp += 1;
				}
				var end_page = PAGE_LINKS * tmp;
				var begin_page = end_page - (PAGE_LINKS - 1);
				if(end_page > total_pages) {
					end_page = total_pages;
				}
				
				$("#pageLink").empty();		// 기존 페이지 링크 삭제
				if(begin_page > PAGE_LINKS) {
					var $previous = $("<a></a>").attr("href", "").text("<");
					var pageLi = $('<li></li>').append($previous);
					$previous.css({
						border: "none",
						color: "black"
					});
					$previous.click(function(event){
						event.preventDefault();
						page = page - PAGE_LINKS;
						getJson();
					});
					$("#pageLink").append(pageLi, " ");
				}
				for(var i = begin_page; i <= end_page; i++) {
					// a태그 속성 idx는 클릭이벤트때 페이지값을 알기위한 임의로 만든 속성
					var $a = $("<a></a>").attr({href: "",idx: i}).text(i);
					var pageLi = $('<li></li>').append($a);
					if(page == i) {
						// 버튼 클릭시 css 적용
						$a.css({
							color: "white",
							backgroundColor: "#ECCB6A",
							border: "none"
						});	
					} else {
		            	$a.css({
							border: "none",
							color: "black"
						});
				    }
					$a.click(function(event){
						event.preventDefault();
						page = $(this).attr("idx");
						getJson();
					});
					$("#pageLink").append(pageLi, " ");
				}
				if(total_pages > end_page) {
					var $next = $("<a></a>").attr("href", "").text(">");
					var pageLi = $('<li></li>').append($next);
					$next.css({
						border: "none",
						color: "black"
					});
					$next.click(function(event){
						event.preventDefault();
						page = Number(page) + PAGE_LINKS;	// page를 문자열로 인식해서 Number로 형변환 후 계산해야 함.
						if(page > total_pages) {
							page = total_pages;
						}
						getJson();
					});
					$("#pageLink").append(pageLi, " ");
				}
			}
		})
	}
	</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a style="font-family: 나눔스퀘어라운드; font-size: 30px;" class="navbar-brand" href="/mainPage">
				<span style="font-weight: bold;">
					<font color="#45A3F5">오</font>
					<font color="#bae4f0">늘</font>
					<font color="#88bea6">의</font>
					<font color="#eccb6a">라</font>
					<font color="#d0a183">이</font>
					<font color="#c8572d">딩</font>
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
								<li class="nav-item"><a style="font-size: 15px;" class="nav-link">${m.nickName } 라이더님</a></li>
								<li class="nav-item"><a style="font-size: 15px;" href="/logout" class="nav-link">로그아웃</a></li>&nbsp;&nbsp;
								<li class="nav-item"><a style="font-size: 15px;" href="/myPage?id=${m.id}" class="nav-link">마이페이지</a></li>
							</c:when>
						</c:choose>
					</ul>
				</div> 
	
				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
						<li class="nav-item"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
						<li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
						<li class="nav-item active"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
						<li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
						<li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
					</ul>
				</div>
			</div>
		</div>
    </nav>
    <!-- END nav -->	
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('resources/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate pb-0 text-center">
					<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a></span><span>라이딩 후기 <i class="fa fa-chevron-right"></i></span></p>
					<h1 class="mb-3 bread">라이딩 후기</h1>
				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section ftco-agent">
		<div class="container">
			<!-- 검색 -->
			<div id="searchANDinsertContainer" >
				<select id="searchType">
					<option value="id">ID</option>
					<option value="c_no">코스</option>
					<option value="r_title">글제목</option>
					<option value="r_content">글내용</option>
				</select>
				<div id="searchInputWrap"></div>
			</div>
			<!-- 리스트출력 -->
			<div class="row d-flex" id="rowDFlex"></div> 
			<div class="row mt-5">
				<div class="col text-center">
					<!-- 등록버튼 -->
					<div class="btnDiv"><a href="/user/insertReview" class="btn" style="background-color: #88BEA6;">등록</a></div>
					<!-- 페이징처리 -->                  
					<div class="block-27"><ul id="pageLink"></ul></div>
				</div>
			</div>	
		</div> <!-- container 끝 -->
	</section>
		
	
	<!-- 푸터시작 -->
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