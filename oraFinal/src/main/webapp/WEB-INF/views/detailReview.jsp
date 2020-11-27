<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>후기게시판</title>
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
	<!-- ckeditor스타일 적용을 위한 css -->
	<link rel="stylesheet" type="text/css" href="/ckeditor5/content-styles.css">
	<style type="text/css">
		input:focus, textarea:focus { outline: none; }
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
		/* 댓글수 */
		#repImg { display: inline-block; width: 25px; padding-right: 5px; margin-bottom: 3px; }
		#total_reply { display: inline-block; font-size: 18px; }
		/* 댓글 */
		.replyNicknameContainer { display: flex; /* height: auto; */ }
		.regdate { padding-left: 30px; font-size: 13px; display: inline-block; margin-bottom: 5px; }
		.replyContent { padding-left: 30px; margin-top: 2px; font-size: 14px; height: auto; }
		.replyNickname { margin-top: 3px; font-size: 14px; padding-left: 5px; width: auto; margin-top: 3px; }
		.textareaContainer > textarea { width: 100%; height: 110px; padding: 10px 10px 10px 13px; font-size: 14px; border: none;}
		.btnContainer { height: auto; margin-left: 25px; text-align: right;}
		.btnContainer img { width: 20px; margin-left: 5px; } /* 댓글 수정삭제 이미지 */
		.modAndDel { display: inline-block; padding-right: 10px; width: auto; text-align: right; vertical-align: top;} /* 댓글수정삭제 div */
		.btnReply { font-size: 13px; display: inline-block; vertical-align: top; padding-left: 5px; cursor: pointer; text-decoration: underline; }
		.div_c3 { display: inline-block; width: 85%}
		.myRep { display: inline-block; margin-left: 10px; padding: 2px 6px; border: 1px solid red; border-radius: 12px; font-size: 12px; } /* 내댓글 표시 */
		.sendReply { margin: 0 7px 7px 0; }
		.textareaContainer { border: 1px solid gray; text-align: right; }
		.divRep { height: auto; }

		.modReplyWrap {
			display: flex;
			flex-direction: row;
		}
		.modReplyTextArea {
			flex-grow: 1;
			flex-basis: 90%;
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

	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	// 답글달기버튼 btnIdx속성 기본값. 각 버튼마다 rr_no값을 넣어주고 눌러서 열면 rr_no를 닫으면 -1을 넣어줘서 여닫기능구현.
	let btnIdx = -1;
	var querystring = location.search;		// querystring 가져오기 ex) r_no=1
	var n = querystring.indexOf("=");		// value를 가져오기위한 =의 index알아오기 ex) 4
	var r_no = querystring.substring(n+1);	// 게시판번호 저장 변수 ex) 1
	let login_id = "${m.id}";				// 로그인 안했을 때는 'empty string'
	var $replyTextArea = $("<textarea></textarea>").attr("placeholder", "답글을 입력하세요.");	// 대댓글을 위한 textarea 전역변수
	$(document).ready(function(){
		const token = $("meta[name='_csrf']").attr("content");
	    const header = $("meta[name='_csrf_header']").attr("content");
	    const parameter = $("meta[name='_csrf_parameter']").attr("content");
	    $(document).ajaxSend(function(e, xhr, options) {
	        if(token && header) {
	            xhr.setRequestHeader(header, token);
	        }
	    });
		
		detailReviewReply();	// 댓글 목록 ajax으로 가져오는 함수	
		// 본문 댓글을 위한 입력창 만들기
		let $div1 = $("<div></div>").addClass("textareaContainer");		// 자식인 textarea 찾기위해 클래스 지정
		let $textarea = $("<textarea></textarea>").attr("placeholder", "댓글을 입력하세요.");
		
		let $div2 = $("<div></div>").addClass("btnContainer");			// css적용을 위한 클래스
		let $button = $("<button></button>").addClass("sendReply btn").text("등록");
		$div2.append($button);
		
		$div1.append($textarea, $div2);
		$("#replyToBoardArea").append($div1).attr("rr_ref", 0);	// rr_ref가 0이면 본문 댓글
		
		$(document).on("click", ".btnReply", function(event){	// 댓글 아이콘 입력시 댓글 입력창 동적생성 이벤트
			$(".div_c5").empty();		// 모든 대댓글 입력창,등록버튼 비우기
			if($(this).attr("btnIdx") !== btnIdx) {
				btnIdx = $(this).attr("btnIdx");	// 한번더 누르면 닫힘
				// 자식인 textarea 찾기위해 클래스 지정
				let $div1 = $("<div></div>").css("margin-left", "25px").addClass("textareaContainer").append($replyTextArea);
				let $div2 = $("<div></div>").addClass("btnContainer");
				let $btn = $("<button></button>").addClass("sendReply btn").text("등록");		// 클릭 이벤트 적용을 위한 클래스
		
				$div2.append($btn);
				$div1.append($div2)
				$(this).parent().siblings(".div_c5").append($div1);
				
			}else {
				btnIdx = -1;	// 한번더 누르면 무조건 열림
			}
		});
		
		$(document).on("click", ".sendReply", function(event){		// 댓글 내용을 추출하여 insert ajax함수 호출
			// 본문 댓글과 대댓글을 하나의 이벤트로 처리하기 위해 클래스명과 노드구조 동일하게 맞춤
			
			let rr_ref = $(this).closest(".replyToReplyArea").attr("rr_ref");	// closest함수로 조상노드까지 검색가능
			//$(this).parent().siblings(".textareaContainer").children("textarea").val("");	// 댓글 내용 추출후에 비워주기
			let rr_content = $(this).parent().siblings("textarea").val();	// siblings은 형제노드를 찾는다
			//alert("rr_ref:"+rr_ref);
			//alert("rr_content:"+rr_content);
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

	function detailReviewReply(){	// 댓글 목록 ajax으로 가져오는 함수
		$.ajax({
			url: "/detailReviewReply",
			data: {r_no: r_no},		// 현재 게시글 번호 전달
			success: function(data){
				$("#replyArea").empty();	// 동적 댓글 생성 div비우기
				$("#total_reply").html("댓글 "+data.total_reply);	// 댓글 수
				$(data.rrlist).each(function(idx,item){		// 댓글 수 만큼 반복
					let $div = $("<div></div>").addClass('divRep');
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
						/* $div.css("height", "auto"); */
			 		}
					$div_c1.append($div_c1_c1, $div_c1_c2);
	/* 작성일자 */		//let $div_c1_c3 = $("<div></div>").text(item.date_diff_str);
					let $div_c4 = $("<div></div>").addClass("regdate").text(item.date_diff_str+" "); // css적용을 위한 클래스

					let $span = $("<span></span>").html(item.rr_content);
					// 댓글내용. 수정을 위해 rr_no값 속성에 추가
					let $div_c2 = $("<div></div>").html($span).addClass("replyContent").attr("rr_no", item.rr_no);
					
					let $div_c3 = $("<div></div>").addClass("div_c3");	// 댓글 수정버튼 클릭 시 댓글내용 찾기위한 클래스지정
					let $div_c3_c1 = $("<div></div>").addClass("btnContainer");	// css적용을 위한 클래스
					let $btn_rep;
					let $img_mod;
					let $img_del;
					let $btn_modDel;
					if(login_id !== "") {		// 현재 로그인한 사용자일 경우 댓글아이콘 보이기
						/* let $img_rep = $("<img>").attr("src", "icons/reply.png");
						let $btn_rep = $("<div></div>").attr("title", "댓글").append($img_rep).addClass("btnReply"); */
						$btn_rep = $("<div></div>").html("답글달기").addClass("btnReply").attr("btnIdx", item.rr_no);	// 버튼여닫기능용도 attr
						/* $div_c3_c1.append($btn_rep); */
						$div_c4.append($btn_rep);
					}
					if(login_id === rr_id) {	// 로그인id와 댓글작성id가 일치할 경우 수정,삭제 아이콘 보이기
						$img_mod = $("<img>").attr({src: "icons/eraser.png", title: "수정", class: "img_mod"});
						let $a_mod = $("<a></a>").attr({href: "", rr_no: item.rr_no}).append($img_mod);
						$a_mod.click(function(event){	// 댓글 수정 이벤트
							$(".replyContent").children("span").css("display","unset");		// 숨겨진거 보이게 하기
							$(".replyContent").children("div").remove();		// 모든 댓글 수정창 제거
							event.preventDefault();
							let replyContent = $(this).closest(".div_c3").siblings(".replyContent");
							let span = $(replyContent).children("span").css("display","none");
							let $textarea = $("<textarea></textarea>").text($(span).text()).addClass("modReplyTextArea");
							let $btnMod = $("<button></button>").text("수정");
							let $btnCancel = $("<button></button>").text("취소");
							let $div = $("<div></div>").addClass("modReplyWrap");	// css적용을 위한 클래스
							$div.append($textarea, $btnMod, $btnCancel);
							$(replyContent).children("div").remove();
							replyContent.append($div);
							$btnCancel.click(function(event){	// 댓글 수정 취소
								$(".replyContent").children("span").css("display","unset");		// 숨겨진거 보이게 하기
								$(".replyContent").children("div").remove();		// 모든 댓글 수정창 제거
							});
							$btnMod.click(function(event){		// 댓글 수정
								let rr_no = $(this).closest(".replyContent").attr("rr_no");
								// text는 예전 데이터. val로 해야 현재 수정된 데이터를 가져옴.
								let rr_content = $(this).siblings("textarea").val();
								updateRep(rr_no, rr_content);
							});
						});
						
						$img_del = $("<img>").attr({src: "icons/remove.png", title: "삭제", class: "img_del"});
						let $a_del = $("<a></a>").attr({href: "", rr_no: item.rr_no}).append($img_del);
						$a_del.click(function(event){	// 댓글 삭제 이벤트
							event.preventDefault();
							let answer = confirm("댓글을 삭제하시겠습니까?");
							if(answer) {
								deleteRepOne($(this).attr("rr_no"));
							}
						});
						
						$btn_modDel = $("<div></div>").addClass('modAndDel').append($a_mod, $a_del);
					}
					$div_c3_c1.append($btn_modDel);
					// let $div_c3_c2 = $("<div></div>").addClass("div_c3_c2").addClass("replyToReplyArea").attr("rr_ref", item.rr_ref);
					let $div_c5 = $("<div></div>").addClass("div_c5").addClass("replyToReplyArea").attr("rr_ref", item.rr_ref);
					// $div_c3_c2 노드에 이벤트로 동적으로 댓글입력창,등록버튼 생성됨. 이를 위한 클래스 'div_c3_c2' 
					// 'replyToReplyArea'클래스는 본문댓글,대댓글 공통클래스이며 댓글내용을 추출하여 ajax통신하기 위한 클래스
					$div_c3.append($div_c3_c1);
					
					$div.append($div_c1, $div_c2, $div_c4, $div_c3, $div_c5, "<hr>");
					
					$("#replyArea").append($div);
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
	function deleteRepOne(rr_no){
		$.ajax({
			url: "/deleteRepOne?"+parameter+"="+token,
			data: {rr_no: rr_no},
			method: "post",
			async: false,				// 동기방식으로해서 처리결과 확인 후 select ajax함수 재호출
			success: function(){
				detailReviewReply();	// 삭제한 댓글 결과를 보기 위해 select ajax함수 재호출
			}
		});
	}
	function updateRep(rr_no, rr_content){
		$.ajax({
			url: "/updateRep?"+parameter+"="+token,
			data: {rr_no: rr_no, rr_content: rr_content},
			method: "post",
			async: false,				// 동기방식으로해서 처리결과 확인 후 select ajax함수 재호출
			success: function(){
				detailReviewReply();	// 수정한 댓글 결과를 보기 위해 select ajax함수 재호출
			}
		});
	}
});
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
					<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a></span> <span class="mr-2"><a href="/listReview">라이딩 후기 <i class="fa fa-chevron-right"></i></a></span> <span>후기 상세 <i class="fa fa-chevron-right"></i></span></p>
					<h1 class="mb-3 bread">후기 상세</h1>
				</div>
			</div>
		</div>
    </section>
	
	<!-- 본문 section 시작 -->
	<section class="ftco-section ftco-agent">
		<div class="container">
    		<div class="row justify-content-center pb-5">
				<!-- 글번호, 제목 -->
          		<div class="col-md-12 heading-section text-center ftco-animate">
		          	<span class="subheading">${rvo.r_no }</span>
					<a href="detailReview?r_no=${rvo.r_no }"><h2 class="mb-4">${rvo.r_title }</h2></a>
          		</div>
				<!-- 코스명 -->
				<div class="selectedCourse">
					<img src="/meetingImg/ridingRoute.png">
					<c:if test="${rvo.c_no==0 }">
						<a href="#"> ${rvo.c_name }</a>
					</c:if>
					<c:if test="${rvo.c_no!=0 }">
						<a href="detailCourse?c_no=${rvo.c_no }"> ${rvo.c_name }</a>
					</c:if>
				</div>
	        </div>
	        	
			<!-- 닉네임, 등록일자, 조회수 -->
			<div style="padding: 0 10px;">
				<div class="nickNameInfo">
					<img src="rank/${rvo.rank_icon }" height="25"> ${rvo.nickName }
				</div>
				<div class="boardInfo">
					<div style="margin-right: 10px;">${rvo.date_diff_str }</div>
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
			
			<!-- 댓글수 -->
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