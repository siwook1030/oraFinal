<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />

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
      
</style>


</head>
<body>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/js/signUp.js"></script>
    <!-- 부트 nav시작 -->
    
    
    <!-- nav 아래 사진부분 시작 -->
 <section class="my-wrap my-wrap-2" style="background-color: #fff;"  id=top>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
             
           
          </div>
        </div>
      </div>
    </section>

    <!-- nav 아래 사진부분 끝 -->


<!-- 회원가입 입력창 시작 -->
<section class="my-wrap my-wrap-2">
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

  
    
  </body>
</html>