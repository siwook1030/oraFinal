<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>회원가입</title>
<jsp:include page="my_header.jsp"/>
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
      
         <!-- 메뉴 탭조절 	-->
.my-wrap {
  width: 100%;
  height: 850px;
  position: relative;
  background-size: cover;
  background-repeat: no-repeat;
  background-position: top center;
  z-index: 0; }
  @media (max-width: 991.98px) {
    .my-wrap {
      background-position: top center !important; } }
  .my-wrap.my-wrap-2 {
    height: 170px !important;
    position: relative; }
    .my-wrap.my-wrap-2 .slider-text {
      height: 190px !important; }
     .myp5 {
     	padding-top: 40px;
     	padding-bottom: 40px;
     }
     
	/* header dropdown */
	.ftco-navbar-light .navbar-nav > .nav-item .dropdown-menu {
		/* background: #fff;
		background-color: #fff;
		opacity: 0.7; */
		background: rgba(255,255,255,0.7);
		border: 2px solid white;
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


</head>
<body>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/js/signUp.js"></script>
<input type="hidden" id="initSearchTag" value="${searchTag }">
    
	<section class="hero-wrap hero-wrap-2" style="background-image: url('/headerImg/signUpAndInMain.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">HOME <i class="fa fa-chevron-right"></i></a></span> <span>회원가입 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread" id="tagTitle">회원가입</h1>
          </div>
        </div>
      </div>
    </section>


<!-- 회원가입 입력창 시작 -->
	<section class="ftco-section">
         <div class="container">
                     <div class="row block-9 justify-content-center mb-5">
             <div class="col-md-8 mb-md-5">
                <form action="/signUp" id="signUpForm" method="post" class="bg-light myp5 contact-form">
                  						<h2 class="mb-4" style="text-align: center; font-size: 30px;">회원가입</h2>
                  <div id="form" ><input type="text" type="text" class="form-control text-muted " id="id" name="id" maxlength="12" placeholder="사용하실 ID를 입력하세요(8~12자리)" required></div>
                  <div id="form"><input type="password" class="form-control text-muted " id="password" name="password" maxlength="12" type="password" placeholder="비밀번호를 입력하세요 영문+숫자+특수문자(8~12자리)조합"></div>
                  <div id="form"><input type="password" class="form-control text-muted " id="passwordCheck" name="passwordCheck" maxlength="12" type="password" placeholder="비밀번호를 다시 입력하세요"></div>
                  <div id="form"><input type="text" class="form-control text-muted " id="name" name="name" type="text" maxlength="6" placeholder="이름을 입력하세요"></div>
                  <div id="radioBox">
	                <label  style="font-size:14pt; padding-right: 100px;">여자<input type="radio" id="genderW" name="gender" value="W" checked="checked"></label>
	                <label  style="font-size:14pt;">  남자<input type="radio" id="genderM" name="gender" value="M"></label>
                  </div>
                  <div id="form"><input id="nickName" class="form-control text-muted  " name="nickName" type="text" maxlength="8" placeholder="사용하실 닉네임을 입력하세요(최대 8자리)"></div>
                  <div id="form"><input type="tel" class="form-control form-group text-muted " id="phone" name="phone" maxlength="11" placeholder="휴대폰 번호 '-'없이 입력하세요">
                  <input type="hidden" id="chekedPhone" value=""><input type="hidden" id="chekingPhone" value="N"></div>
                  <div id="join"><input type="button" id="sendPhone" value="인증번호 발송" class="btn form-control form-group btn-primary py-3 px-5"></div>
                  <div id="inputNumForm"><input type="tel" id="inputNum" name="inputNum" maxlength="6" placeholder="인증번호" class=" form-control " style="display: inline-block;">
                  <input type="button" id="checkNum" value="인증" class=" form-control btn btn-primary "></div>
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
    
  </body>
</html>