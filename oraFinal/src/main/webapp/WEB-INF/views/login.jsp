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

/* =============================== 현왕 모달창 내부 css =================================== */
    .modal_wrap .title{
      font-size:20px;
      padding: 20px; 
      background : gold;
      border-radius: 10px;
      font-weight: bold;
   }
   .modal_wrap{
        display: none;
        width: 500px;
        height: 500px;
        position: absolute;
        top:100%;
        left: 50%;
        margin: -250px 0 0 -250px;
        background:#eee;
        z-index: 3;
        font-family: sans-serif;
        text-align: center;
        border-radius: 10px;
    }
    .black_bg{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 220%;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    }
    
/* =============================== 현왕 모달창 내부 css 종료 =================================== */

/* =============================== 현왕 모달창 열기 & 내부 버튼 css 시작 =================================== */
#modal_btn, #btn_pw_ok, .modal_close {
    background-color: white;
    color: #17A2B8;
    border: solid 1px #17A2B8;
   border-radius: 5px;
    cursor: pointer;
   font-family: inherit;
}
#modal_btn:hover, #btn_pw_ok:hover, .modal_close:hover{
         background-color: #17A2B8;
         color: white;
      }
/* =============================== 현왕 모달창 열기 & 내부 버튼 css 종료 =================================== */
    </style>
    
   <script type="text/javascript">
   $(function(){
      
       
       function onClickIdc() {
           document.querySelector('.modal_wrap').style.display ='block';
           document.querySelector('.black_bg').style.display ='block';
       }   
    /*    function onClickIdp() {
           document.querySelector('.modal_wrap').style.display ='block';
           document.querySelector('.black_bg').style.display ='block';
       }    */
       function offClick() {
           document.querySelector('.modal_wrap').style.display ='none';
           document.querySelector('.black_bg').style.display ='none';
           $("#pw").val($("#password_1").val());
       }
    
       document.getElementById('login-button-idc').addEventListener('click', onClickIdc);
       //document.getElementById('login-button-idp').addEventListener('click', onClickIdp);
       document.querySelector('.modal_close').addEventListener('click', offClick);
   <!-- ===================================== 현왕 모달창 실행 자바스크립트 추가 종료 =========================================== -->

   <!-- ===================================== 현왕 모달창 내용 자바스크립트 추가 & 암호 변경하면 비밀번호 <input type=text>에 전달 =========================================== -->

         const phone = document.getElementById("phone");
         const sendPhone = document.getElementById("sendPhone");
         const checkNum = document.getElementById("checkNum");
         const inputNum = document.getElementById("inputNum");
         const inf = document.getElementById("inputNumForm");

         sendPhone.onclick=sendPhoneReq;   
         checkNum.onclick=checkNumReq;   

         function sendPhoneReq(){// 인증번호 발송
            const phAvail = /^01[0179][0-9]{7,8}$/;
            const phAvailCheck = phAvail.test(phone.value.trim());
            
               if(phone.value.trim() == ''){
                  alert("휴대전화를 입력하세요");
                  phone.focus();
                  return;
               }
                  if(phone.value.trim() == ''){
                     alert("휴대전화번호를 입력하세요.");
                     phone.focus();
                     return;
                  }
                  else if(phAvailCheck == false){
                     alert("유효하지 않은 번호입니다.");
                     phone.focus();
                     return;
                  }
                  else if(checkPhoneNum() == 0){
                     alert("가입 되어있지 않은 번호입니다");
                     phone.focus();
                     return;
                  }
                  alert("번호발송");
                  $.ajax({
                     url: "/smsSend",
                     type: "GET",
                     data:{
                        "phoneNum":phone.value.trim()
                     },
                     success: function(data){
                        if(data == "1"){
                           alert("인증번호가 발송되었습니다.");
                           $("#phone").prop('readonly', true);
                           $(".hiddenPhone").css({display: "inline-block"});
                           
                           inputNum.value="";
                           inputNum.focus();
                        }else{
                           alert("인증번호 발송에 실패하였습니다.");
                        }
                     },
                     error: function(){
                        alert("서버에러");
                     }
                  });
                  
         }

         
         function checkNumReq(){//인증번호 확인
            
                  if(inputNum.value.trim() == ''){
                     alert("인증번호를 입력하세요.");
                     inputNum.focus();
                     return;
                  }
                  else if(inputNum.value.trim().length != 6){
                     alert("인증번호는 6자리입니다.");
                     inputNum.focus();
                     return;
                  }
                  let idR = 0;      
                  $.ajax({
                     url: "/smsSend",
                     type: "POST",
                     data:{
                        "num":inputNum.value.trim()
                     },
                     success: function(data){
                        if(data == '1'){
                           idR = 1;
                           alert("인증되었습니다.");

                           $.ajax({
                                 url: "/selectMemberId",
                                 type: "POST",
                                 data:{
                                    "phone":phone.value.trim()
                                 },
                               success: function(data){
                                  $("#h2").text("고객님의 아이디는:"+data+"입니다");
                               }
                        });
                          
                           inputNum.value="";

                           $(".hiddenPhone").css({display: "none"});
                        }else{
                           alert("인증번호가 일치하지 않습니다.");
                        }
                     },
                     error: function(){
                        alert("서버에러");
                     }
                  });
                  if(idR == 1){
                     
                }
                  
         }

         function checkPhoneNum(){//디비저장 폰있는지 중복방지
             let check = 1;
             const phoneNum = phone.value.trim();
             
             $.ajax({
                url:"/phoneNumCheck",
                type:"POST",
                async: false,
                data:{"phone":phoneNum},
                success:function(data){
                   if(data == "0"){
                      check = 0;
                   }
                },
                error:function(){
                   alert("에러발생");
                }
             });
             
             
             return check;
          }

         // $(".hidden").css({display: "none"});
          $(".hiddenPhone").css({display: "none"});

   });

   </script>

</head>
<body>


   <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
     
     <script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
   <script type="text/javascript" src="/js/login.js"></script>
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
                  <div id="inputNumForm"><input type="tel" id="inputNum" name="inputNum" maxlength="6" placeholder="인증번호" class=" form-control " style="display: inline-block;"><input type="button" id="checkNum" value="인증" class=" form-control btn btn-primary "></div>
                  <div id="join"><input type="button" id="signUp" value="Sign Up" class="btn form-control form-group btn-primary py-3 px-5 "></div>
                </form>
              </div>
            </div>
          </div>
        </section>

<!-- 회원가입 입력창 끝-->

<!-- 회원가입 입력창 끝-->

   <section class="ftco-section ftco-no-pb ftco-no-pt">
      <div class="container">
         <div class="row">
            
            <div class="col-md-5 wrap-about py-md-5 ftco-animate">
               <div class="heading-section pr-md-5">
                  <h2 class="mb-4" style="text-align: center; font-size: 30px;">오늘의 라이딩 로그인</h2>
                  <p style="text-align: center; color: black; margin: 0 0 10px;">오늘도 힘차게 달려볼까요?</p>
                  <div class="container">
                     <form  class="was-validated">
                        <div class="form-group">
                           <label for="member-id">아이디</label>
                           <input type="text" class="form-control" id="member-id" onkeyup="enterkey()" placeholder="Enter id" name="member-id"  maxlength="12" required>
                           <div class="valid-feedback">입력완료.</div>
                           <div class="invalid-feedback">입력해주세요.</div>
                        </div>
                         <div class="form-group">
                           <label for="member-password">비밀번호</label>
                           <input type="password" class="form-control" id="member-password" onkeyup="enterkey()" placeholder="Enter password" name="member-password" maxlength="12" required>
                           <input type="hidden" id="token" data-token-name="${_csrf.headerName}" placeholder="Password" value="${_csrf.token}">
                           <div class="valid-feedback">입력완료.</div>
                           <div class="invalid-feedback">입력해주세요.</div>
                        </div>
                         <div style="text-align: center;">
                            <a href="/signUp"><button class="btn btn-primary" type="button">회원가입</button></a> 
                            <button id="login-button" type="button" class="btn btn-primary">로그인</button>
                           <button id="login-button-idc" type="button" class="btn btn-primary">아이디찾기</button>
                            <button id="login-button-idp" type="button" class="btn btn-primary">비밀번호찾기</button>
                                                    
                        </div>                  
                     </form>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </section>
<!-- 로그인 끝 -->





  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


 
     <%-- =================== 화면에서 안보이는 모달창 부분 [ 버튼 클릭시 모달 화면으로 보이는 내용 ] 아이디찾기 완료 =================== --%>
       <div class="black_bg"></div>
         <div class="modal_wrap">
                  <div>전화번호</div>
                <input   type="tel" id="phone" name="phone" class="hidden" maxlength="11"  placeholder="전화번호를 입력하세요 ex)01012345678" > 
               <div>
               <input type="button" id="sendPhone" class="hidden" value="인증번호 받기">
               </div>
               <div id="inputNumForm">
                  <input type="tel" id="inputNum" class="hiddenPhone" name="inputNum" maxlength="6" placeholder="인증번호를 입력하세요">
                  <input type="button" id="checkNum" class="hiddenPhone" value="인증">
               </div> 
             <br>
             <h2 id="h2"></h2>
             <button type="button" class="modal_close">창 닫기</button>
         </div>
    
    <%-- =================== 화면에서 안보이는 모달창 부분 [ 버튼 클릭시 모달 화면으로 보이는 내용 ] =================== --%>
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
   
<%-- =================== 화면에서 안보이는 모달창 부분 [ 버튼 클릭시 모달 화면으로 보이는 내용 ] 아이디찾기 완료 =================== --%>
       <div class="black_bg"></div>
         <div class="modal_wrap">
                  <div>전화번호</div>
                <input   type="tel" id="phone" name="phone" class="hidden" maxlength="11"  placeholder="전화번호를 입력하세요 ex)01012345678" > 
               <div>
               <input type="button" id="sendPhone" class="hidden" value="인증번호 받기">
               </div>
               <div id="inputNumForm">
                  <input type="tel" id="inputNum" class="hiddenPhone" name="inputNum" maxlength="6" placeholder="인증번호를 입력하세요">
                  <input type="button" id="checkNum" class="hiddenPhone" value="인증">
               </div> 
             <br>
             <h2 id="h2"></h2>
             <button type="button" class="modal_close">창 닫기</button>
         </div>
    
    <%-- =================== 화면에서 안보이는 모달창 부분 [ 버튼 클릭시 모달 화면으로 보이는 내용 ] =================== --%>
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