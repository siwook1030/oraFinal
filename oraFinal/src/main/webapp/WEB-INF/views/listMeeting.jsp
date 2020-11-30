<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>번개게시판</title>
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
 	<style>
		.btn { color: white; padding: 8px 12px; background-color: #88BEA6; float: right; font-size: 15px; border: none; cursor: pointer; }
		/* 글등록버튼 페이징버튼과 공간분리 */
		.col.text-center * { clear: both; margin-bottom: 20px; }
		.emptyStr { position: relative; bottom: 130px; left: 70px; color: black; opacity: 0.2; }
		/* 썸네일사진 중앙기준 */
		#listImg { position: absolute; left: 50%; top: 50%; height: auto; width: auto; width: 767px;
		 	-webkit-transform: translate(-50%,-50%); /* 구글, 사파리 */
			-ms-transform: translate(-50%,-50%); /* 익스플로러 */
		 	transform: translate(-50%, -50%); }
		/* 게시글 제목 */
		.heading a { height: 60px; padding-bottom: 30px; display: inline-block; }
		.blog-entry .text { height: 500px; /* border: 1px solid orange; */ }
		.meta.mb-3 { height: 95px; /* border: 1px solid purple */; }
		.meta.mb-3 div { /* border: 1px solid pink; */ }
		.metaDiv_1, .metaDiv_2 { width: 100%; }
		.c_name { display: inline-block; }
		.nickName { display: inline-block; }
		.m_regdate { font-size: 13px; display: inline-block; vertical-align: top;  float: right; }
		.meta-chat { font-size: 14px; display: inline-block; float: right;}
		.m_timeImg, .m_time { display: inline-block; margin-right: 10px; vertical-align: bottom; font-size: 20px; }
		.m_timeImg { margin-bottom: 4px; }
		/* 페이징 */
		.pageUl { border: none; }
		.block-27 ul li a, .block-27 ul li span { color: black; }
		.btnPrevNext { border: none; }
		
		/* myPage CSS 시작 */
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
		    opacity: 1 !important;
		}
		
		.nav-link {
		    font-size: 18px;
		    padding-top: .7rem;
		    padding-bottom: .7rem;
		    padding-left: 20px;
		    padding-right: 20px;
		    color: #fff;
		    font-weight: 600;
		    opacity: 1 !important;
		}
		.nav-link:hover {
			color: #c8572d;
		}
		.nav-link2:visited {
			color: red;
		}
		
		/* 화면 줄어들때 메뉴색 */
		@media (max-width: 991.98px) {
			.ftco-navbar-light {
				background: #000000 !important;
				position: relative;
				top: 0; }
		}    
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
			FONT-WEIGHT: bolder;
		}
		/* myPage 끝 */	
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
		
		let pageNo = 1;
		let id = `${id}`;
		const recordSize = ${recordSize};
		const pageSize = ${pageSize};
		listMeeting();
		$("#id1").css({"display": "bloak" ,});
		$("#id2").css({"display": "none"});
		// 나우페이지를 주면 리스트를 띄울 함수 하나
		// 페이징바를 만들 함수하나
	    
		function listMeeting(){
			$.ajax({
				url: "/listMeetingJson",
	            type: "GET",
	            data : {
	               "pageNo": pageNo,
	               "id": id
	            },
	            success: function(map){
		           console.log(map.list);
	               $('#rowDFlex').empty();
	               setPage(map.totRecord);
	               setList(map.list);
	               if(map.id !== '%' && map.id == `${m.id}`){
					$("#id1").css({"display": "none"});
					$("#id2").css({"display": "inline-block"});
			       }
				}
			})                  
		}

		function setPage(totRecord){
			$('.pageUl').empty();
			$('.pageUl').css('cursor','pointer');
			
			// 총 페이지 수
			console.log("*** totRecord : "+totRecord)
			let totPage = Math.ceil(totRecord/recordSize);
			console.log('*** totPage : '+totPage);

			// 페이지 버튼 숫자
			let startPage = parseInt((pageNo-1)/pageSize)*pageSize+1;
			let endPage = startPage+pageSize-1;
			if(endPage>totPage) {
				endPage = totPage;
			}
			console.log('*** startPage : '+startPage);
			console.log('*** endPage : '+endPage);

			if(startPage>1) {
				const prev = $('<span></span>').attr('idx',(startPage-1)).html('<');
				$(prev).css({
					border: 'none'
				});
				const pageLi = $('<li></li>').append(prev);
	            $(prev).click(function(){
	               const idx = $(this).attr('idx');
	               pageNo = idx;
	               listMeeting();
	            });
				$('.pageUl').append(pageLi);
			}
	         
			for(let i=startPage; i<=endPage; i++){
				const a = $('<span></span>').attr('idx',i).html(i);
				const pageLi = $('<li></li>').append(a);
				if(i==pageNo){
					$(a).css({
						color: 'white',
						backgroundColor: '#ECCB6A',
						border: 'none'
					});
	            } else {
	            	$(a).css({
						border: 'none'
					});
			    }
	            $(a).click(function() {
					const idx = $(this).attr('idx');
					if(pageNo==idx){
						return;
					} 
					console.log(idx);
					pageNo = idx;
					listMeeting();
				});         
	            $('.pageUl').append(pageLi);
			}
			if(totPage>endPage){
				const next = $('<span></span>').attr('idx',(endPage+1)).html('>');
				$(next).css({
					border: 'none'
				});
				const pageLi = $('<li></li>').append(next);
				$(next).click(function(){
					const idx = $(this).attr('idx');
					pageNo = idx;
					listMeeting();
				});
				$('.pageUl').append(pageLi);
			}         
		}

		function setList(arr){
			console.log(arr);
			$('#rowDFlex').empty();
			$.each(arr, function(idx, data){
				// console.log('*** arr length : '+arr.length);
				// console.log(data.mf[0]);

				let listImg;
				let emptyStr;
				if(data.mf.length!=0) {
					listImg = $('<img id="listImg"/>').attr('src',"/"+data.mf[0].mf_path+"/"+data.mf[0].mf_savename);
				} else {
					listImg = $('<img/>').attr('src',"/icons/empty.png");
					emptyStr = $('<div></div>').html('').addClass('emptyStr'); // 빈화면에 글씨적을 수 있음
				}
				const contentImg = $('<a></a>').addClass('block-20 img').attr("href",'detailMeeting?m_no='+data.m_no).append(listImg, emptyStr);

				// 게시글 내용
				// const m_no = $('<div></div>').html(data.m_no);
				let c_nameA;
				if(data.c_no == 0) {
					c_nameA = $('<a href="#"></a>').html(data.c_name);
				} else {
					c_nameA = $('<a href="/detailCourse?c_no='+data.c_no+'"></a>').html(data.c_name);
				}
				const c_name = $('<div></div>').append(c_nameA).addClass('c_name');
				const m_timeImg = $('<img/>').attr({src : '/meetingImg/calendar.png', height : '30px'}).addClass('m_timeImg');
				const m_time = $('<div></div>').html(data.m_time).addClass('m_time');
				const nickNameImg = $('<img/>').attr({src : '/rank/'+data.rank_icon, height : '20px'});
				const nickNameA = $('<a href="/listMeeting?id='+data.id+'"></a>').html(' '+data.nickName);
				const nickName = $('<div></div>').append(nickNameImg, nickNameA).addClass('nickName');
				const m_regdate = $('<div></div>').html(data.date_diff_str).addClass('m_regdate');
				// const m_hit = $('<div></div>').html(data.m_hit);
				const speechImg = $('<span></span>').addClass('fa fa-comment'); // 말풍선
				const m_repCnt = $('<div></div>').addClass('meta-chat').append(speechImg, " "+data.m_repCnt); // 말풍선 + 댓글수
				const m_titleA = $('<a></a>').attr('href','detailMeeting?m_no='+data.m_no).html(data.m_title);
				const m_title = $('<h3></h3>').addClass('heading').append(m_titleA);

				// div에 내용담기
				const metaDiv = $('<div></div>').addClass('meta mb-3');
				const textDiv = $('<div></div>').addClass('text');
				const blog_entryDiv = $('<div></div>').addClass('blog-entry justify-content-end');
				const col = $('<div></div>').addClass('col-md-3 d-flex ftco-animate fadeInUp ftco-animated');

				const metaDiv_1 = $('<div></div>').append(c_name, m_repCnt).addClass('metaDiv_1');
				const metaDiv_2 = $('<div></div>').append(nickName, m_regdate /* , m_hit */).addClass('metaDiv_2');
				metaDiv.append(metaDiv_1, metaDiv_2);
               
				textDiv.append(contentImg, m_title, m_timeImg, m_time, metaDiv);
				blog_entryDiv.append(textDiv);
				col.append(blog_entryDiv);

				$('#rowDFlex').append(col);   
			});
		}    
	} /* window 끝 */

	function checkLogin(){
		let check;
			$.ajax({
				url: "/checkLogin?"+parameter+"="+token,
				type: "POST",
	            async: false,
	            success: function(response){
					check =  response;
	            },
	            error: function(){
	               alert("에러발생");
	            }
			})
			return check;
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
						<li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
						<li class="nav-item active"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
						<li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
    <!-- END nav -->	

   <section class="hero-wrap hero-wrap-2" style="background-image: url('headerImg/meetingMain.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate pb-0 text-center">
				
				<div id="id1">
					<p class="breadcrumbs"><span class="mr-2"><a href="mainPage">Home <i class="fa fa-chevron-right"></i></a></span> <span>번개 라이딩 <i class="fa fa-chevron-right"></i></span></p>
					<h1 class="mb-3 bread">번개 라이딩</h1>
				</div>
	
	            <div id="id2">
					<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="ftco-animate pb-0 text-center">
     				 <span>
						<h1 class="mb-3 bread" style="padding-top: 170px;">My 번개</h1>
		           		 </span>
			           <ul class="my" style="font-size: 10px">
					 		<li class="my_li2" ><a id="my_a" class="nav-link_2" href="/myPage" >정보 수정</a></li>
					 		<li class="my_li" ><a id="my_a" class="nav-link_2" href="/myPageSaveCourse" >찜 목록</a></li>
							<li class="my_li" ><a id="my_a" class="nav-link_2" href="/myPageMyCourse" >내 코스</a></li>
			                <li class="my_li"><a id="my_a" class="nav-link_2" href="/listReview?searchType=id&searchValue=${m.id }">내 후기</a></li>
			      <!--      <li class="my_li"><a id="my_a" class="nav-link_2" href="/listMeeting?id=${m.id}">내 번개</a></li>  -->
			                <li class="my_li"><a id="my_a" class="nav-link_2" href="/myPageMyRank">랭킹</a></li>
			              </ul>
					</div>
				</div>
				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section">
		<div class="container">
        	<div class="row d-flex" id="rowDFlex"><!-- 리스트출력 --></div> 
			<div class="row mt-5">
				<div class="col text-center">
					<!-- 등록버튼 -->
					<div><a href="/user/insertMeeting" class="btn btn-success">등록</a></div>                    
					<div class="block-27"><ul class="pageUl"><!-- 페이징처리 --></ul></div>
				</div>
			</div>
		</div> <!-- container 끝 -->
	</section>
    
	<jsp:include page="footer.jsp" />
</body>
</html>