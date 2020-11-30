<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>후기게시판</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
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
		.heading a { height: 60px; padding-bottom: 30px; display: inline-block; }
		.blog-entry .text { height: 450px; }
		.meta.mb-3 { height: 90px; }
		
		.metaDiv_1, .metaDiv_2 { width: 100%; }
		
		.c_name { display: inline-block; }
		.nickName { display: inline-block; }
		.date_diff_str { font-size: 13px; display: inline-block; vertical-align: top;  float: right; }
		.meta-chat { font-size: 14px; display: inline-block; float: right;}
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
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	let searchType = "";	// id,코스번호,제목,내용
	let searchValue = "";	// 검색을 위한 사용자입력값
	let searchMethod = 0;	// 제목,내용 검색방법을 일치or포함중에 선택
	let courseList;			// List<CourseVo> 를 담은 변수. select-option 태그 만들기 위한 용도
	
	// 마이페이지에서 내가 쓴 게시글 조회했을때 처리하기위한 코드.
	// GET방식 쿼리라서 querystring을 가져오기 위한 설정
	const URLSearch = new URLSearchParams(location.search);
	const RECORDS_PER_PAGE = 8;	// 페이지당 레코드 수
	const PAGE_LINKS = 5;			// 페이지 하단에 표시되는 페이지링크 수
	let page = 1;	// 현재 페이지 저장 변수(기본은 1페이지)


	$(document).ready(function(){
		const token = $("meta[name='_csrf']").attr("content");
	    const header = $("meta[name='_csrf_header']").attr("content");
	    const parameter = $("meta[name='_csrf_parameter']").attr("content");
	    $(document).ajaxSend(function(e, xhr, options) {
	        if(token && header) {
	            xhr.setRequestHeader(header, token);
	        }
	    });
		
		$("#myPage2").css({"display": "none"});
		if(URLSearch.has("searchType")) {
			searchType = URLSearch.get("searchType");
		}

		if(URLSearch.has("searchValue")) {
			searchValue = URLSearch.get("searchValue");
			if(searchValue == `${m.id}`){
		         $("#myPage1").css({"display": "none"});
		         $("#myPage2").css({"display": "inline-block"});
		      }
		}
		if(URLSearch.has("searchMethod")) {
			searchMethod = URLSearch.get("searchMethod");
		}
	

		getJson();			// 댓글과 페이지링크 만드는 함수
		getCourseList();	// List<CourseVo> 받아오기. 코스명으로 게시글 검색용도
		createInput("id");	// 처음엔 기본으로 id기반 검색으로 설정됨

		$(document).on("click", "#btnSearch", function(){	// 검색버튼 눌렀을때 게시물 목록을 거기에 맞춰서 다시 가져온다.
			searchType = $("#searchType").val();
			searchValue = $("#searchValue").val();
			if(searchType === "r_title" || searchType === "r_content") {
				searchMethod = $("#searchMethod").val();
			}
			getJson();
		});
		
		$("#searchType").change(function(){		// searchType이 바뀔때마다 동적으로 검색기능 생성
			createInput($(this).val());
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
				url: "/listReviewJson?"+parameter+"="+token,
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
			            let c_nameA;
			            if(item.c_no==0) {
				            c_nameA = $("<a href='#'></a>").html(item.c_name);
				        } else {
				            c_nameA = $("<a href='/detailCourse?c_no="+item.c_no+"'></a>").html(item.c_name);
					    }
			            const c_name = $('<div></div>').append(c_nameA).addClass('c_name');
			            const nickName_icon = $('<img/>').attr({src : 'rank/'+item.rank_icon, height : '20px'});
			            const nickNameA = $('<a href="/listReview?searchType=id&searchValue='+item.id+'"></a>').html(' '+item.nickName);
			            const nickName = $('<div></div>').append(nickName_icon, nickNameA).addClass('nickName');
			            const date_diff_str = $('<div></div>').html(item.date_diff_str).addClass('date_diff_str');
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

				        const metaDiv_1 = $('<div></div>').append(c_name, total_reply).addClass('metaDiv_1');
				        const metaDiv_2 = $('<div></div>').append(nickName, date_diff_str, /* r_hit, */).addClass('metaDiv_2');
			            /* metaDiv.append(c_name, nickName, date_diff_str, total_reply); */
			            metaDiv.append(metaDiv_1, metaDiv_2);
			            textDiv.append(contentImg, r_title, metaDiv);
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
	});
	</script>
<!--myPage CSS 시작-->
<style>
#login {
	font-size: 14px;
	text-align: right;
}

.my{
	padding: 5px;
	margin: 2px;

	
}

  .nav-link_2 {
    font-size: 12px;
    padding-top: .1rem;
    padding-bottom: .1rem;
    padding-left: 1px;
    padding-right: 1px;
    color: #fff;
    font-weight: 400;
    opacity: 1 !important; }

  .nav-link {
    font-size: 18px;
    padding-top: .7rem;
    padding-bottom: .7rem;
    padding-left: 20px;
    padding-right: 20px;
    color: #fff;
    font-weight: 600;
    opacity: 1 !important; }
  .nav-link:hover {
      color: #c8572d; }
  .nav-link2:visited{
                color: red;
            }

/* 화면 줄어들때 메뉴색 */
 @media (max-width: 991.98px) {
    .ftco-navbar-light {
      background: #000000 !important;
      position: relative;
      top: 0; } }
      
      
.my{
	padding: 50px;
	
}
 .my_ul{
	list-style:none; 
 	text-align: center;
 }
 .my_li{
    display:inline-block;  
	float:left;
 	padding: 50px;
 	border-left:1px solid #999;             /* 각 메뉴의 왼쪽에 "|" 표시(분류 표시) */
    font:bold 16px Dotum;                     /* 폰트 설정 - 12px의 돋움체 굵은 글씨로 표시 */
    padding:0 10px;  
 }
 
  .my_li2{
    display:inline-block;  
	float:left;
 	padding: 50px;
    padding:0 10px;  
    font:bold 16px Dotum;
 }
   
 #my_a{
 color: #bbbbbb;
     font:bold 14px Dotum; 
 }
 #my_a:hover {
 color: #d0a183; 
 FONT-SIZE: 13pt; 
 FONT-WEIGHT: bolder}
 
<!--myPage 끝-->
</style>
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
						<li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
						<li id="courseDropPoint"  class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">  오늘의 라이딩  </a>
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
						<li class="nav-item active"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
						<li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
						<li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
    <!-- END nav -->	
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('headerImg/reviewMain.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>

		<div class="container">
			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate pb-0 text-center">
					<div id="myPage1">
						<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a></span><span>라이딩 후기 <i class="fa fa-chevron-right"></i></span></p>
						<h1 class="mb-3 bread">라이딩 후기</h1>
					</div>
				
					<div id="myPage2">	
					<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="ftco-animate pb-0 text-center">
     				 <span>
						<h1 class="mb-3 bread" style="padding-top: 170px;">My 후기</h1>
		           		 </span>
			           <ul class="my" style="font-size: 10px">
							<li class="my_li2" ><a id="my_a" class="nav-link_2" href="/myPage" >정보 수정</a></li>
					 		<li class="my_li" ><a id="my_a" class="nav-link_2" href="/myPageSaveCourse" >찜 목록</a></li>
							<li class="my_li" ><a id="my_a" class="nav-link_2" href="/myPageMyCourse" >내 코스</a></li>
			          <!--  <li class="my_li"><a id="my_a" class="nav-link_2" href="/listReview?searchType=id&searchValue=${m.id }">내 후기</a></li>-->
			            	<li class="my_li"><a id="my_a" class="nav-link_2" href="/listMeeting?id=${m.id}">내 번개</a></li>  
			                <li class="my_li"><a id="my_a" class="nav-link_2" href="/myPageMyRank">랭킹</a></li>
			              </ul>
					</div>
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
    <jsp:include page="footer.jsp" />
      
  </body>
</html>