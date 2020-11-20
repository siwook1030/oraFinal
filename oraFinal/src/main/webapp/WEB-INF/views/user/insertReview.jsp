<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
	input, select { border: none; background-color: transparent; width: 55%; text-align: center; }
	textarea:focus, input:focus { outline: none; }
	#c_no { width: auto; }
	/* 등록, 취소 버튼 */
 	.btn { color: white; padding: 7px 17px; margin: 3px 1px; font-size: 19px; border: none; cursor: pointer; width: auto; }
 	/* #btnDiv { clear: both; text-align: center; padding-top: 40px; text-align: center; } */

</style>
<link rel="stylesheet" type="text/css" href="/ckeditor5/editor-styles.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/ckeditor5/build/ckeditor.js"></script>
<script type="text/javascript">
let current_urls = [];		// 현재 editor에 있는 img src들의 배열을 담은 변수. url저장형식 => /review/46076431.jpg
$(document).ready(function(){
	
	if(${rtvo == null}) {	// 기존 작성중인 게시글이 없을 경우 신규 임시저장 레코드 생성
		createReviewTempRecord();
	}else {
		let answer = confirm("작성중인 게시글이 있습니다. 불러올까요?");
		if(answer) {		// 작성중인 게시글 불러오기. controller에서 model에 rtvo를 실은 것을 불러온다.
			$("#r_title").val('${rtvo.r_title}');
			$("#c_no").val(${rtvo.c_no});
			$("#editor").text('${rtvo.r_content}');
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
            uploadUrl: '/reviewImageInsert',

            // Enable the XMLHttpRequest.withCredentials property.
            withCredentials: true,		// 기본값

            // Headers sent along with the XMLHttpRequest to the upload server.
            headers: {
                'X-CSRF-TOKEN': 'CSRF-Token',				// 기본값
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
						//console.log("삭제된URL:"+deleted_url);
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
	
	$("#inputInsert").click(function(){		// 게시글 등록버튼 누르면 image src배열정보 전달. 이것을 토대로 review_file table에 record등록.
		let $image_urls = $("<input>").attr({
			type: "hidden",
			name: "image_urls",
			value: current_urls
		});
		$(this).parent("form").append($image_urls);
	});

});

// 사용자가 insert한 이미지 삭제 시 비동기 삭제처리를 위한 함수
function imageDelete(url){
	$.ajax({
		url: "/reviewImageDelete",
		beforeSend : function(xhr){
            xhr.setRequestHeader("uploadFolder", "review");
        },
		data: {url: url},
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
		url: "/reviewAutoSave",
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
</script>
</head>
<body>
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
							<li class="nav-item"><a href="/login" class="nav-link">로그인</a></li>
							<li class="nav-item"><a href="/signUp" class="nav-link">회원가입</a></li>
						</c:when>
						<c:when test="${m != null }">
							<li class="nav-item"><a class="nav-link">${m.nickName } 라이더님</a></li>
							<li class="nav-item"><a href="/logout" class="nav-link">로그아웃</a></li>&nbsp;&nbsp;
							<li class="nav-item"><a href="/myPage?id=${m.id}" class="nav-link">마이페이지</a></li>
						</c:when>
					</c:choose>
				</ul>
			</div>

	     
				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
						<li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
						<li class="nav-item active"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
						<li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
						<li class="nav-item"><a href="" class="nav-link">라이딩 정보</a></li>
					</ul>
				</div>
			</div>
     	</nav>
    <!-- END nav -->
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/resources/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home <i class="fa fa-chevron-right"></i></a></span> <span>후기 게시판 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">후기 게시판</h1>
          </div>
        </div>
      </div>
    </section>

	<section class="ftco-section ftco-agent">
    	<div class="container">
    	
    		<!-- 글 등록 -->
			<form action="/user/insertReview" method="post">
		    	<div class="row justify-content-center pb-5">
					<div class="col-md-12 heading-section text-center ftco-animate">
			          	<span class="subheading">Today's Riding</span>
			          	<!-- 제목 -->
			            <h2 class="mb-4"><input type="text" name="r_title" id="r_title" placeholder="제목을 입력해주세요." required="required"></h2>
			          </div>
		        </div>
		        
				<!-- 코스선택 -->
				<div>
					<img src="/meetingImg/ridingRoute.png" width="40px;" style="padding-bottom: 10px;">
					<select name="c_no" id="c_no">
						<c:forEach var="vo" items="${list }">
							<option value="${vo.c_no }">${vo.c_name }</option>
						</c:forEach>
					</select>
				</div>
				
				<!-- 글내용 -->
				<textarea name="r_content" id="editor"></textarea>
				
				<!-- autosave 상태표시창 -->
				<div id="snippet-autosave-status">
					<div id="snippet-autosave-status_spinner">
						<span id="snippet-autosave-status_spinner-label"></span>
						<span id="snippet-autosave-status_spinner-loader"></span>
					</div>
				</div>
				<span id ="btnDiv">
					<input type="submit" class="btn" value="등록" id="inputInsert" style="background-color: #c8572d">
					<input type="reset" class="btn" value="취소" style="background-color: #eccb6a">
				</span>
	
			</form>
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