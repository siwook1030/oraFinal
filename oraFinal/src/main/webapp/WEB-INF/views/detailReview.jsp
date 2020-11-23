<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 라이딩</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/animate.css">    
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css">   
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/style.css">
	<!-- ckeditor스타일 적용을 위한 css -->
	<link rel="stylesheet" type="text/css" href="/ckeditor5/content-styles.css">
	<style type="text/css">
		.btnContainer {
			/* display: flex; */
			/* flex-direction: row; */
			/* justify-content: flex-end; */
		}
		/* ck-content안의 이미지에 좌/우 정렬 줄경우 ck-content의 height이 0이되는 현상해결 */
		.ck-content::after {
			content: "";
			display: block;
			clear: both;
		}
		.ck-content { padding: 20px; margin-bottom: 100px; width: auto; }
		/* 닉네임, 등록일자, 조회수 */
 		.nickNameInfo { font-size: 17px; display: inline-block; }
		.boardInfo { float: right; display: inline-block; font-size: 14px; }
		.boardInfo > div { display: inline-block; margin: 2px; }
		/* 코스 */
		.selectedCourse img { width: 35px; margin-right: 10px; }
		.selectedCourse a { font-size: 18px; display: inline-block; vertical-align: bottom; }
		.selectedCourse { width: 300px; border: 1px #D5D5D5 solid; border-radius: 10px; margin: 2px auto; padding: 25px; text-align: center; }
		/* 게시글 수정삭제 버튼 */
		.btn { color: white; padding: 8px 12px; margin: 20px 0; background-color: #88BEA6; display: inline-block; font-size: 15px; border: none; cursor: pointer; }
		/* 댓글수량 */
		#repImg { display: inline-block; width: 29px; padding-right: 5px; margin-bottom: 3px; }
		#total_reply { display: inline-block; font-size: 18px; }
		/* 댓글 */
		.replyNicknameContainer { display: flex; }
		.regdate { float: left; padding-left: 30px; font-size: 13px; display: inline-block; }
		.replyContent { padding-left: 30px; margin-top: 2px; font-size: 14px; }
		.replyNickname { /* margin-top: 3px;  */font-size: 14px; padding-left: 5px; width: auto; margin-top: 3px; }
		.textareaContainer > textarea { width: 100%; height: 130px; padding: 10px 10px 10px 13px; font-size: 14px; }
		.btnContainer img { width: 18px; margin-left: 5px; }
		.btnReply { font-size: 13px; display: inline-block; vertical-align: top; padding-left: 10px; cursor: pointer; }
		.modAndDel { display: inline; padding-right: 10px; width: auto; float: right; }
		.replyOne { border: 1px solid gray; }
		.myRep { display: inline-block; margin-left: 10px; padding: 2px 6px; border: 1px solid red; border-radius: 12px; font-size: 12px; }
		.sendReply { margin: 0px; float: right; position: relative; bottom: 60px; right: 10px; }


</style>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	var querystring = location.search;		// querystring 가져오기 ex) r_no=1
	var n = querystring.indexOf("=");		// value를 가져오기위한 =의 index알아오기 ex) 4
	var r_no = querystring.substring(n+1);	// 게시판번호 저장 변수 ex) 1
	let login_id = "${m.id}";				// 로그인 안했을 때는 'empty string'
	var $replyTextArea = $("<textarea></textarea>").attr("placeholder", "답글을 입력하세요.");	// 대댓글을 위한 textarea 전역변수
	$(document).ready(function(){
		detailReviewReply();	// 댓글 목록 ajax으로 가져오는 함수	
		// 본문 댓글을 위한 입력창 만들기
		let $div1 = $("<div></div>").addClass("textareaContainer");		// 자식인 textarea 찾기위해 클래스 지정
		let $textarea = $("<textarea></textarea>").attr("placeholder", "댓글을 입력하세요.");
		$div1.append($textarea);
		let $div2 = $("<div></div>").addClass("btnContainer");			// css적용을 위한 클래스
		let $button = $("<button></button>").addClass("sendReply btn").text("등록");
		$div2.append($button);
		$("#replyToBoardArea").append($div1, $div2).attr("rr_ref", 0);	// rr_ref가 0이면 본문 댓글
		
		$(document).on("click", ".btnReply", function(event){	// 댓글 아이콘 입력시 댓글 입력창 동적생성 이벤트
			$(".div_c3_c2").empty();		// 모든 대댓글 입력창,등록버튼 비우기
			let $div1 = $("<div></div>").css("margin-left", "25px").addClass("textareaContainer").append($replyTextArea);	// 자식인 textarea 찾기위해 클래스 지정
			let $div2 = $("<div></div>").addClass("btnContainer");
			let $btn = $("<button></button>").addClass("sendReply btn").text("등록");		// 클릭 이벤트 적용을 위한 클래스
	
			$div2.append($btn);
			$(this).parent().siblings(".div_c3_c2").append($div1, $div2);
		});
		
		$(document).on("click", ".sendReply", function(event){		// 댓글 내용을 추출하여 insert ajax함수 호출
			// 본문 댓글과 대댓글을 하나의 이벤트로 처리하기 위해 클래스명과 노드구조 동일하게 맞춤
			let rr_ref = $(this).closest(".replyToReplyArea").attr("rr_ref");	// closest함수로 조상노드까지 검색가능
			let rr_content = $(this).parent().siblings(".textareaContainer").children("textarea").val();	// siblings은 형제노드를 찾는다
			//$(this).parent().siblings(".textareaContainer").children("textarea").val("");	// 댓글 내용 추출후에 비워주기
			if(rr_content === "") {		
				alert("댓글내용을 입력하세요!");	// 댓글내용없는데 등록버튼 누를 경우
			}else {
				insertReviewReply(rr_ref, rr_content);	// insert ajax호출
			}
		});
	
		$("#btnDelete").click(function(event){
			let answer = confirm("정말 삭제하시겠습니까?");
			if(!answer) {
				event.preventDefault();
			}
		});
	});
	function detailReviewReply(){	// 댓글 목록 ajax으로 가져오는 함수
		$.ajax({
			url: "/detailReviewReply",
			data: {r_no: r_no},		// 현재 게시글 번호 전달
			success: function(data){
				$("#replyArea").empty();	// 동적 댓글 생성 div비우기
				$("#total_reply").html("댓글 "+data.total_reply);	// 댓글 수
				$(data.rrlist).each(function(idx,item){		// 댓글 수 만큼 반복
					let $div = $("<div></div>");
					if(item.rr_step > 0) {	// 대댓글일경우 들여쓰기
						$div.css("margin-left", "25px");
					}
					let $div_c1 = $("<div></div>").addClass("replyNicknameContainer");	// css적용을 위한 클래스
					let $img = $("<img>").attr({
						"src": "rank/" + item.rank_icon,
						"height": 25
					});
	/* 랭크 아이콘 */	let $div_c1_c1 = $("<div></div>").append($img);
					let $div_c1_c2;
					let rr_id = item.id;	// 댓글을 작성한 id를 변수에 저장
	 				/* let $div_c1_c2 = $("<div></div>").append(item.nickName).css({marginTop: "3px", paddingLeft: "5px", width: "230px"}); */
	 				if(login_id === rr_id) {
		 				$myRep = $('<div></div>').html('내댓글').addClass('myRep');
	/* 닉네임 */			$div_c1_c2 = $("<div></div>").append(item.nickName, $myRep).addClass("replyNickname");
						
					} else {
						$div_c1_c2 = $("<div></div>").append(item.nickName).addClass("replyNickname");
			 		}
	/* 작성일자 */		let $div_c1_c3 = $("<div></div>").text(item.date_diff_str).addClass("regdate"); // css적용을 위한 클래스
					$div_c1.append($div_c1_c1, $div_c1_c2/* , $div_c1_c3 */);
	
					let $div_c2 = $("<div></div>").html(item.rr_content).addClass("replyContent"); // 댓글내용
	
					let $div_c3 = $("<div></div>");
					let $div_c3_c1 = $("<div></div>").addClass("btnContainer");	// css적용을 위한 클래스
					let $btn_rep;
					let $img_mod;
					let $img_del;
					let $btn_modDel;
					if(login_id !== "") {		// 현재 로그인한 사용자일 경우 댓글아이콘 보이기
						/* let $img_rep = $("<img>").attr("src", "icons/reply.png");
						let $btn_rep = $("<div></div>").attr("title", "댓글").append($img_rep).addClass("btnReply"); */
						$btn_rep = $("<div></div>").html("답글달기").addClass("btnReply");
						/* $div_c3_c1.append($btn_rep); */
					}
					if(login_id === rr_id) {	// 로그인id와 댓글작성id가 일치할 경우 수정,삭제 아이콘 보이기
						$img_mod = $("<img>").attr({src: "icons/eraser.png", title: "수정", class: "img_mod"});
						//let $a_mod = $("<a></a>").attr("href", "").append($btn_mod);
						
						$img_del = $("<img>").attr({src: "icons/remove.png", title: "삭제", class: "img_del"});
						//let $a_del = $("<a></a>").attr("href", "").append($btn_del);
						
						$btn_modDel = $("<div></div>").addClass('modAndDel').append($img_mod, $img_del);
					}
					$div_c3_c1.append($div_c1_c3, $btn_rep, $btn_modDel);
					let $div_c3_c2 = $("<div></div>").addClass("div_c3_c2").addClass("replyToReplyArea").attr("rr_ref", item.rr_ref);
					// $div_c3_c2 노드에 이벤트로 동적으로 댓글입력창,등록버튼 생성됨. 이를 위한 클래스 'div_c3_c2' 
					// 'replyToReplyArea'클래스는 본문댓글,대댓글 공통클래스이며 댓글내용을 추출하여 ajax통신하기 위한 클래스
					$div_c3.append($div_c3_c1, $div_c3_c2);
					
					$div.append($div_c1, $div_c2, $div_c3);
					
					$("#replyArea").append($div, "<hr>");
				})
			}
		})
	}
	function insertReviewReply(rr_ref, rr_content){		// 댓글 내용을 입력 ajax함수
		$.ajax({
			url: "/insertReviewReply",
			data: {
				r_no: r_no,
				rr_ref: rr_ref,
				rr_content: rr_content
			},
			success: function(data){
				$("#replyToBoardArea").children(".textareaContainer").children("textarea").val("");	// 본문댓글 입력창 비우기
				$replyTextArea.val("");	// 대댓글 입력창 비우기
				detailReviewReply();	// 입력한 댓글을 보이기 위해 select ajax함수 재호출
			}
		})
	}
	</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a style="font-size: 30px;" class="navbar-brand" href="/mainPage">
				<span style="font-weight: bold;">
					<font color="#45A3F5">오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font> <font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</font>
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
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/resources/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate pb-0 text-center">
				
					<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a></span> <span class="mr-2"><a href="/listReview">라이딩 후기 <i class="fa fa-chevron-right"></i></a></span> <span>라이딩 후기 상세 <i class="fa fa-chevron-right"></i></span></p>
					<h1 class="mb-3 bread">후기 상세</h1>
				</div>
			</div>
		</div>
    </section>
	
	<!-- 본문 section 시작 -->
	<section class="ftco-section ftco-agent">
		<div class="container">
    	 	<!-- 글번호, 제목 -->
    		<div class="row justify-content-center pb-5">
          		<div class="col-md-12 heading-section text-center ftco-animate">
		          	<span class="subheading">${rvo.r_no }</span>
					<a href="detailReview?r_no=${rvo.r_no }"><h2 class="mb-4">${rvo.r_title }</h2></a>
          		</div>
			<!-- 코스명 -->
			<div class="selectedCourse">
				<img src="/meetingImg/ridingRoute.png">
				<a href="detailCourse?c_no=${rvo.c_no }"> ${rvo.c_name }</a>
			</div>
        	</div>
        	
			<!-- 닉네임, 등록일자, 조회수 -->
			<div style="padding: 0 10px;">
				<div class="nickNameInfo">
					<img src="rank/${rvo.rank_icon }" height="25"> ${rvo.nickName }
				</div>
				<div class="boardInfo">
					<div style="margin-right: 10px;">${rvo.r_regdate }</div>
					<div>조회수 ${rvo.r_hit }</div>
				</div>
			</div>
			<hr>

			<!-- 게시글내용 -->
			<div class="ck-content">
				${rvo.r_content }
			</div>
			
			<!-- 수정,삭제 버튼 -->
			<c:if test="${rvo.id == m.id }">
				<div style="text-align: right;">
					<a href="/user/updateReview?r_no=${rvo.r_no }" class="btn" style="background-color: #c8572d">수정</a>
					<a href="deleteReview?r_no=${rvo.r_no }" id="btnDelete" class="btn" style="background-color: #eccb6a">삭제</a>
				</div>
			</c:if>
			
			<!-- 댓글 수량 -->
			<img id="repImg" src="/icons/speech.png">
			<h3 id="total_reply"></h3>
			<hr>
			<!-- 댓글 목록 영역 -->
			<div id="replyArea"></div>
			<!-- 본문 댓글 영역 -->
			<c:if test="${m != null }">
				<div id="replyToBoardArea" class="replyToReplyArea"></div>
			</c:if>
		</div>
	</section>

	<!-- footer 시작 -->
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