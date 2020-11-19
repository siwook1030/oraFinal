<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Ora - meeting Board</title>
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
      #change {
        margin: 50px auto;
        padding: 30px;
        text-align: center;
        color: black;
      }

      * {
        margin: 0;
        padding: 0;
      }

      #form {
        margin: 8px auto;
        text-align: center;
      }

      #form input {
        height: 40%;
        width: 70%;
        display: inline-block
      }

      #radioBox {
        margin: 15px auto 15px auto;
        text-align: center;
      }

      #radioBox form {
        width: 100px;
      }

      #inputNumForm {
        visibility: hidden;
        text-align: center;
        margin: 10px auto;
      }

      #inputNum {
        height: 40%;
        width: 50%;
        display: inline-block;
      }

      #checkNum {
        height: 40%;
        width: 20%;
        display: inline-block;
      }

      #clickForm {
        text-align: center;
        margin: 0 auto;
        width: 68%;
      }

      #clickForm input {
        height: 30px;
        width: 310px;
      }

      #join {
        text-align: center;
        margin: 20px auto;
      }

      #join input {
        height: 45%;
        width: 70%;
      }
</style>


</head>
<body>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/js/signUp.js"></script>
    <!-- 부트 nav시작 -->
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="/mainPage"><img src='/headerImg/logo.png' height="100"></a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="oi oi-menu"></span> Menu
			</button>
			
<%-- 					<div id="login">
						<c:choose>
							<c:when test="${m == null }">
								<a href="/login">로그인</a>&nbsp;&nbsp;&nbsp;<a href="/signUp">회원가입</a>
							</c:when>
							<c:when test="${m != null }">
								${m.nickName } 라이더! &nbsp;&nbsp;<a href="/logout">로그아웃</a>&nbsp;&nbsp;<a href="/myPage?id=${m.id}">마이페이지</a>
							</c:when>
						</c:choose>
					</div> --%>

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
					<li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
					<li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
					<li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
					<li class="nav-item"><a href="" class="nav-link">라이딩 정보</a></li>
				</ul>
			</div>
		</div>
     </nav>
    <!-- END nav -->
    
    
    <!-- nav 아래 사진부분 시작 -->
    <section class="hero-wrap hero-wrap-2" style="background-image: url('resources/images/bg_3.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
             
            <h1 class="mb-3 bread">회원가입</h1>
          </div>
        </div>
      </div>
    </section>

    <!-- nav 아래 사진부분 끝 -->


<!-- 회원가입 입력창 시작 -->
<section class="ftco-section contact-section">
         <div class="container">
           <div class="row block-9 justify-content-center mb-5">
             <div class="col-md-8 mb-md-5">
                <form action="/signUp" id="signUpForm" method="post" class="bg-light p-5 contact-form">
                  <h2 class="text-center">회원가입 </h2>
                  <div id="form"><input type="text" type="text" class="form-control text-muted " id="id" name="id" maxlength="12" placeholder="id(8~12자리)"></div>
                  <div id="form"><input type="password" class="form-control text-muted " id="password" name="password" maxlength="12" type="password" placeholder="password(8~12자리)"></div>
                  <div id="form"><input type="password" class="form-control text-muted " id="passwordCheck" name="passwordCheck" maxlength="12" type="password" placeholder="password Check"></div>
                  <div id="form"><input type="text" class="form-control text-muted " id="name" name="name" type="text" maxlength="6" placeholder="name ex)홍길동"></div>
                  <div id="radioBox">
	                  여자<input type="radio" id="genderW" name="gender" value="W" checked="checked">
	                  남자<input type="radio" id="genderM" name="gender" value="M">
                  </div>
                  <div id="form"><input id="nickName" class="form-control text-muted  " name="nickName" type="text" maxlength="8" placeholder="닉네임(최대 8자리)"></div>
                  <div id="form"><input type="tel" class="form-control form-group text-muted " id="phone" name="phone" maxlength="11" placeholder="ex)01012345678"><input type="hidden" id="chekedPhone" value=""><input type="hidden" id="chekingPhone" value="N"></div>
                  <div id="join"><input type="button" id="sendPhone" value="인증번호 발송" class="btn form-control form-group btn-primary py-3 px-5"></div>
                  <div id="inputNumForm"><input type="tel" id="inputNum" name="inputNum" maxlength="6" placeholder="인증번호" class=" form-control "><input type="button" id="checkNum" value="인증" class=" form-control btn btn-primary "></div>
                  <div id="join"><input type="button" id="signUp" value="Sign Up" class="btn form-control form-group btn-primary py-3 px-5 "></div>
                </form>
              </div>
            </div>
          </div>
        </section>

<!-- 회원가입 입력창 끝-->


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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/resources/js/google-map.js"></script>
  <script src="/resources/js/main.js"></script>

  
    
  </body>
</html>