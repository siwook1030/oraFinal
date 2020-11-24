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
 	<style>
		.btn {
			color: white;
			padding: 8px 12px;
			background-color: #88BEA6;
			float: right;
			font-size: 15px;
			border: none;
			cursor: pointer;
		}
		/* 글등록버튼 페이징버튼과 공간분리 */
		.col.text-center * {
			clear: both;
			margin-bottom: 20px;
		}
		.emptyStr {
			position: relative;
			bottom: 130px;
			left: 70px;
			color: black;
			opacity: 0.2;
		}
		/* 썸네일사진 중앙기준 */
		#listImg { 
			position: absolute;
			left: 50%;
			top: 50%;
			height: auto;
			width: auto;
 			-webkit-transform: translate(-50%,-50%);
			-ms-transform: translate(-50%,-50%);
			transform: translate(-50%,-50%);
		}
		.pageUl {
			border: none;
		}
		.btnPrevNext {
			border: none;
		}
	</style>

	<script type="text/javascript">
	window.onload = function(){
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
	               //$('#rowDFlex').empty();
	               setPage(map.totRecord);
	               setList(map.list);
	               if(map.id !== '%'){
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

				// 사진출력
				let listImg;
				let emptyStr;
				if(data.mf.length!=0) {
					listImg = $('<img id="listImg"/>').attr('src',"/"+data.mf[0].mf_path+"/"+data.mf[0].mf_savename);
				} else {
					listImg = $('<img/>').attr('src',"/meetingImg/empty.png");
					emptyStr = $('<div></div>').html('').addClass('emptyStr'); // 빈화면에 글씨적을 수 있음
				}
/* 	            const contentImg = $('<a></a>').addClass('block-20 img').attr("href",'detailMeeting?m_no='+data.m_no).append(listImg, emptyStr);
 */	            const contentImg = $('<a></a>').addClass('block-20 img').attr("href",'detailMeeting?m_no='+data.m_no).append(listImg, emptyStr);

		        // 게시글 내용
	            // const m_no = $('<div></div>').html(data.m_no);
	            const c_nameA = $('<a></a>').html(data.c_name);
	            const c_name = $('<div></div>').append(c_nameA);
	            const m_time = $('<div></div>').html(data.m_time);
	            const nickName_icon = $('<img/>').attr({src : 'rank/'+data.rank_icon, height : '20px'});
	            const nickNameA = $('<a href="/listMeeting?id='+data.id+'"></a>').html(data.nickName);
	            const nickName = $('<div></div>').append(nickName_icon, nickNameA);
	            const m_regdate = $('<div></div>').html(data.m_regdate);
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

	            metaDiv.append(c_name, m_time, nickName, m_regdate, /* m_hit, */ m_repCnt);
	            textDiv.append(contentImg, metaDiv, m_title);
	            blog_entryDiv.append(textDiv);
	            col.append(blog_entryDiv);

				$('#rowDFlex').append(col);   
			});
		}    
	} /* window 끝 */

	function checkLogin(){
		let check;
			$.ajax({
				url: "/checkLogin",
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
         <a style="font-family: 나눔스퀘어라운드;font-size: 30px;" class="navbar-brand" href="/mainPage">
        <span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
        <font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</span></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
               <span class="oi oi-menu"></span> Menu
            </button>
         
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




<%-- 
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="/mainPage">오늘의 라이딩</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
					<span class="oi oi-menu"></span> Menu
				</button>
			
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
			</div> --%>

				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
						<li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
						<li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
						<li class="nav-item active"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
						<li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
					</ul>
				</div>
			</div>
     	</nav>
    	<!-- END nav -->
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('https://cdn.pixabay.com/photo/2017/08/07/00/02/people-2597767__340.jpg'; background-size:100% 800px;');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          
          	<div id="id1">
	          <p class="breadcrumbs"><span class="mr-2"><a href="mainPage">Home <i class="fa fa-chevron-right"></i></a></span> <span>번개 라이딩 <i class="fa fa-chevron-right"></i></span></p>
	          <h1 class="mb-3 bread">번개 라이딩</h1>
            </div>
            
            <div id="id2">
             <span >
              <h1 class="mb-3 bread">마이페이지</h1>
            </span>
            <p class="breadcrumbs">
              <span class="mr-2">
                <a href="index.html">Home <i class="fa fa-chevron-right"></i></a>
              </span>
              <a href="/myPage">정보 수정 <i class="fa fa-chevron-right"></i></a>
              <span>
                <a href="/myPageSaveCourse">찜 목록 <i class="fa fa-chevron-right"></i></a>
                <a href="/myPageMyCourse">내 작성 코스<i class="fa fa-chevron-right"></i></a>
                <a href="/myPageListReview">내 작성 후기<i class="fa fa-chevron-right"></i></a>
                <a href="listMeeting?id=${m.id}">내 작성 번개<i class="fa fa-chevron-right"></i></a>
                <a href="/myPageMyRank">랭킹</a>
              </span>
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
					<div><a href="/user/insertMeeting" class="btn">등록</a></div>                    
					<div class="block-27"><ul class="pageUl"><!-- 페이징처리 --></ul></div>
				</div>
			</div>
		</div> <!-- container 끝 -->
	</section>
    
	<!-- footer -->
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