<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>후기게시판 글쓰기</title>
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
  </head>
<style type="text/css">
	/* 제목 입력 */
	#r_title { text-align: center; }
	/* input, select, textarea 태그설정 */
	input, select { border: none; background-color: transparent; width: auto; text-align: center; }
	input:focus { outline: none; }
	#c_no { width: auto; }
	/* 등록, 취소 버튼 */
 	.btn { color: white; padding: 7px 17px; margin: 3px 1px; font-size: 19px; border: none; cursor: pointer; width: auto; }
 	/* 등록, 취소버튼 div */
	#submitWrap { text-align: center; padding-top: 50px; }
	/* 임시저장상태 */
	#snippet-autosave-status_spinner-label { padding: 3px 5px; width: 75px; }
	#snippet-autosave-status_spinner-loader { width: 400px; margin-left: 50px; }
	/* 코스선택 */
	#selectCourse { width: 30%; border: 1px #D5D5D5 solid; border-radius: 10px; margin: 2px auto; padding: 25px; text-align: center; }
	#selectCourse #c_no { vertical-align: bottom; width: 70%; }
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
<link rel="stylesheet" type="text/css" href="/ckeditor5/editor-styles.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/ckeditor5/build/ckeditor.js"></script>
<script type="text/javascript">
let current_urls = [];		// 현재 editor에 있는 img src들의 배열을 담은 변수. url저장형식 => /review/46076431.jpg
$(document).ready(function(){
	 const token = $("meta[name='_csrf']").attr("content");
	 const header = $("meta[name='_csrf_header']").attr("content");
	 const parameter = $("meta[name='_csrf_parameter']").attr("content");
	    $(document).ajaxSend(function(e, xhr, options) {
	        if(token && header) {
	            xhr.setRequestHeader(header, token);
	        }
	    });
	
	if(${rtvo == null}) {	// 기존 작성중인 게시글이 없을 경우 신규 임시저장 레코드 생성
		createReviewTempRecord();
	}else {
		let answer = confirm("작성중인 게시글이 있습니다. 불러올까요?");
		if(answer) {		// 작성중인 게시글 불러오기. controller에서 model에 rtvo를 실은 것을 불러온다.
			$("#r_title").val('${rtvo.r_title}');
			$("#c_no").val(${rtvo.c_no});
			$("#editor").text('${rtvo.r_content}');
		}else {				// 기존 작성글 불러오기 취소할 경우 기존 사진 삭제 
			let urls = Array.from( new DOMParser().parseFromString( '${rtvo.r_content}', 'text/html' )
				    .querySelectorAll( 'img' ) )
				    .map( img => img.getAttribute( 'src' ) );
			if(urls.length > 0) {
				imageDelete(urls);
			}
		}
	}
	
	// let pluginList = ClassicEditor.builtinPlugins.map( plugin => plugin.pluginName );
	// console.log(pluginList);	// 사용가능한 플러그인 리스트

	ClassicEditor
	.create( document.querySelector( '#editor' ), {
		removePlugins: [ 'ImageCaption' ],		// 불필요한 플러그인 삭제
		toolbar: {			
			items: [		// 툴바에 표시할 아이콘 정의
				'heading',
				'|',
				'bold',
				'italic',
				'link',
				'bulletedList',
				'numberedList',
				'|',
				'alignment',
				'indent',
				'outdent',
				'|',
				'imageUpload',
				'blockQuote',
				'insertTable',
				'mediaEmbed',
				'undo',
				'redo',
				'|',
				'fontBackgroundColor',
				'fontColor',
				'fontSize',
				'fontFamily',
				'specialCharacters',
				'underline',
				'|'
			]
		},
		language: 'ko',
		image: {
			// Configure the available styles.
            styles: [
                'alignLeft', 'alignCenter', 'alignRight'
            ],

            // Configure the available image resize options.
            resizeOptions: [
                {
                    name: 'imageResize:original',
                    label: 'Original',
                    value: null
                },
                {
                    name: 'imageResize:50',
                    label: '50%',
                    value: '50'
                },
                {
                    name: 'imageResize:75',
                    label: '75%',
                    value: '75'
                }
            ],

            // You need to configure the image toolbar, too, so it shows the new style
            // buttons as well as the resize buttons.
            toolbar: [
                'imageStyle:alignLeft', 'imageStyle:alignCenter', 'imageStyle:alignRight',
                '|',
                'imageResize'
                //'|',
                //'imageTextAlternative'
            ]
		},
		table: {
			contentToolbar: [
				'tableColumn',
				'tableRow',
				'mergeTableCells',
				'tableCellProperties',
				'tableProperties'
			]
		},
		licenseKey: '',
		//plugins: [ SimpleUploadAdapter ],
        simpleUpload: {
            // The URL that the images are uploaded to.
            uploadUrl: '/reviewImageInsert?'+parameter+'='+token,

            // Enable the XMLHttpRequest.withCredentials property.
            withCredentials: true,		// 기본값

            // Headers sent along with the XMLHttpRequest to the upload server.
            headers: {
                Authorization: 'Bearer <JSON Web Token>',	// 기본값
                uploadFolder: 'review'
            }
        },
		autosave: {
			waitingTime: 1000,	// ms단위. 마지막 변화감지 후 설정한 시간만큼 대기 한 후 이벤트 처리
			save(editor) {
				return saveData(editor.getData());
			}
		},
		mediaEmbed : {
			previewsInData: true	// 이거 안하면 동영상 표시가 안됨. 
		}
		
	} )
	.then( editor => {
		window.editor = editor;		// 기본값
		displayStatus( editor );	// 기본값
		//console.log( editor );	// 에디터 객체 전체 정보
		
		// ***** 실시간 이미지 삭제 코드 시작 *****
		editor.model.document.on( 'change:data', (eventInfo) => {
			//console.log( eventInfo );
			//console.log("현재URL:"+current_urls);
			let after_urls = Array.from( new DOMParser().parseFromString( editor.getData(), 'text/html' )
		    .querySelectorAll( 'img' ) )
		    .map( img => img.getAttribute( 'src' ) );	// 현재 editor에 있는 img src들의 배열 저장
		    //console.log("이후URL:"+after_urls);
		    
		    let deleted_url;
		    if(current_urls.length > after_urls.length) {
			    console.log("이미지 삭제됨!");
				for(let i = 0; i < current_urls.length; i++) {
					let isChanged = true;
					for(let j = 0; j < after_urls.length; j++) {
						if(current_urls[i] === after_urls[j]) {
							isChanged = false;
							break;
						}
					}
					if(isChanged) {
						deleted_url = current_urls[i];
						console.log(deleted_url);
						imageDelete(deleted_url);
						break;
					}
				}
			}
		    current_urls = after_urls;
		});
		// ***** 실시간 이미지 삭제 코드 끝 *****
	} )
	.catch( error => {
		console.error( 'Oops, something went wrong!' );
		console.error( 'Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:' );
		console.warn( 'Build id: b5mnviaze78m-31mkvnarb2x6' );
		console.error( error );
		
	} );
	
	$("#inputInsert").click(function(event){		// 게시글 등록버튼 누르면 image src배열정보 전달. 이것을 토대로 review_file table에 record등록.
		let r_content = editor.getData();
		if($.trim(r_content) === '') {
			event.preventDefault();
			alert('글 내용을 입력해주세요.');
			// $("#editor").focus();	// 에디터에는 focus 적용 안되는듯.
			return;
		}
		$("#image_urls").attr("value", current_urls);
	});

	$("#btnCancle").click(function(event){
		// input type submit이 아닌 그냥 button이어도 누르면 submit해버린다. 그래서 기본이벤트 삭제처리함.
		event.preventDefault();
		location.href = "/listReview";
	});



// 사용자가 insert한 이미지 삭제 시 비동기 삭제처리를 위한 함수
function imageDelete(urls){
	$.ajax({
		url: "/reviewImageDelete?"+parameter+"="+token,
		beforeSend : function(xhr){
            xhr.setRequestHeader("uploadFolder", "review");		// 삭제할 파일위치 정보전달
        },
        method: "post",
        traditional: true,
		data: {urls: urls},
		success: function(data){

		}
	});
}
// 작성중인 게시글이 없을 경우 review_temp테이블에 empty record생성 
function createReviewTempRecord() {
	$.ajax({
		url: "/createReviewTempRecord",
		success: function(response){
			
		}
	});
}
// autosave 함수
function saveData( data ) {
	let r_title = $("#r_title").val();
	let c_no = $("#c_no").val();
    $.ajax({
		url: "/reviewAutoSave?"+parameter+"="+token,
		method: "post",
		data: {
			r_title: r_title,
			c_no: c_no,
			r_content: data
		},
		success: function(res){

		}
    });
}

// Update the "Status: Saving..." info.
function displayStatus( editor ) {
    const pendingActions = editor.plugins.get( 'PendingActions' );
    const statusIndicator = document.querySelector( '#snippet-autosave-status' );

    pendingActions.on( 'change:hasAny', ( evt, propertyName, newValue ) => {
        if ( newValue ) {
            statusIndicator.classList.add( 'busy' );
        } else {
            statusIndicator.classList.remove( 'busy' );
        }
    } );
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
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/headerImg/reviewMain.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate pb-0 text-center">
					<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a></span><span class="mr-2"><a href="/listReview">라이딩 후기 <i class="fa fa-chevron-right"></i></a></span> <span>라이딩 후기 등록 <i class="fa fa-chevron-right"></i></span></p>
					<h1 class="mb-3 bread">후기 등록</h1>
				</div>
			</div>
		</div>
    </section>

		<section class="ftco-section ftco-agent">
			<div class="container">
    			<!-- 글등록 form 시작 -->
				<form action="/user/insertReview?${_csrf.parameterName}=${_csrf.token}" method="post">
			    	<div class="row justify-content-center pb-5">
						<div class="col-md-12 heading-section text-center ftco-animate">
				          	<span class="subheading">Today's Riding</span>
				          	<!-- 제목 -->
				            <h2 class="mb-4"><input type="text" name="r_title" id="r_title" placeholder="제목을 입력해주세요." required="required"></h2>
				            <!-- 코스선택 -->
							<div id="selectCourse">
								<img src="/meetingImg/ridingRoute.png" style="margin-right: 20px; width: 40px;">
								<select name="c_no" id="c_no">
									<c:forEach var="vo" items="${list }">
										<option value="${vo.c_no }">${vo.c_name }</option>
									</c:forEach>
								</select>
							</div>
						</div>
			        </div>
			        
					<!-- 글내용 -->
					<textarea name="r_content" id="editor"></textarea>
					<!-- 현재 editor에 있는 img src들의 배열 전달 -->
	        		<input type="hidden" id="image_urls" name="image_urls">
	        		<!-- autosave 상태표시창 -->
	        		<div id="snippet-autosave-status">
						<!-- div id="snippet-autosave-status_label">Status:</div> -->
						<div id="snippet-autosave-status_spinner">
							<span id="snippet-autosave-status_spinner-label"></span>
							<span id="snippet-autosave-status_spinner-loader"></span>
						</div>
					</div>
					<div id="submitWrap">
						<input type="submit" value="등록" class="btn" id="inputInsert" style="background-color: #eccb6a">
						<button type="button" class="btn" id="btnCancle" style="background-color: #d0a183">취소</button>
	 				</div>
				</form>
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