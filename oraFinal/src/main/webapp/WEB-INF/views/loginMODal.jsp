<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Ora - login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!--  -->
	
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/animate.css">  
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css">
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/style.css">
    <style type="text/css">
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
    <!-- 스크립트 기본 -->
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  	
  	<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
	<script type="text/javascript" src="/js/login.js">
	</script>
	<script type="text/javascript">
	<!-- ===================================== 현왕 모달창 실행 자바스크립트 추가 =========================================== -->
	window.onload = function() {
	    
	    function onClick() {
	        document.querySelector('.modal_wrap').style.display ='block';
	        document.querySelector('.black_bg').style.display ='block';
	    }   
	    function offClick() {
	        document.querySelector('.modal_wrap').style.display ='none';
	        document.querySelector('.black_bg').style.display ='none';
	        $("#pw").val($("#password_1").val());
	    }
	 
	    document.getElementById('login-button-idc').addEventListener('click', onClick);
	    document.querySelector('.modal_close').addEventListener('click', offClick);
	<!-- ===================================== 현왕 모달창 실행 자바스크립트 추가 종료 =========================================== -->

	<!-- ===================================== 현왕 모달창 내용 자바스크립트 추가 & 암호 변경하면 비밀번호 <input type=text>에 전달 =========================================== -->
	   $("#btn_pw_ok").click(function(){
	        var pwd1 = $("#password_1").val();
	        var pwd2 = $("#password_2").val();
	        if ( pwd1 != '' && pwd2 == '' ) {
	            null;
	        } else if (pwd1 != "" || pwd2 != "") {
	            if (pwd1 == pwd2) {
	            if(pwd1.length > 16){
	               alert("비밀번호가 너무 깁니다.");
	               $("#alert-success").css('display', 'none');
	               $("#alert-danger").css('display', 'none');
	               $("#alert-danger2").css('display', 'inline-block');
	            } else {
	               $("#alert-success").css('display', 'inline-block');
	               $("#alert-danger").css('display', 'none');
	               $("#alert-danger2").css('display', 'none');
	            }
	            } else {
	                alert("비밀번호가 일치하지 않습니다. 비밀번호를 재확인해주세요.");
	                $("#alert-success").css('display', 'none');
	                $("#alert-danger").css('display', 'inline-block');
	                $("#alert-danger2").css('display', 'none');
	            }
	            
	        }
	        return false;
	   });

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
	         alert("번호발송");
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
	                        //inf.style.visibility="visible";
	                        
	                        inputNum.value="";
	                        inputNum.focus();
	                        //$('#inputNum').val('');
	                        //$('#inputNum').focus();
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
	                     
	               $.ajax({
	                  url: "/smsSend",
	                  type: "POST",
	                  data:{
	                     "num":inputNum.value.trim()
	                  },
	                  success: function(data){
	                     if(data == '1'){
	                        alert("인증되었습니다.");
	                        inputNum.value="";
	                        $("#btnUpdate2").attr("i", "0");
	                        $(".hiddenPhone").css({display: "none"});
	                     }else{
	                        alert("인증번호가 일치하지 않습니다.");
	                     }
	                  },
	                  error: function(){
	                     alert("서버에러");
	                  }
	               });
	               
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
	       $("#btnUpdate").click(function() {
	           $("#btnUpdate2").attr("i", "1");
	           let data = $("#pwd").val();
	           console.log(data);
	           $.ajax({
	          url:"/passwordConfirm",
	          method:"POST",
	          data:{password:data},
	          success: function(c){
	             if(c == "확인되었습니다"){
	                $(".updateMember").css({visibility: "visible"});
	                   $("#btnUpdate").css({display:"none"});
	                   $("#btnUpdate2").css({visibility: "visible"});
	                   $("#pwd").css({display:"none"});
	                   $(".hidden").css({display: "inline-block"});
	             }
	              alert(c);
	         }});
	          });
	};

	</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="index.html">오늘의 라이딩</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
			</button>
			<div class="collapse navbar-collapse" id="ftco-nav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
					<li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
					<li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
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
					<p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home <i class="fa fa-chevron-right"></i></a></span> <span>Login <i class="fa fa-chevron-right"></i></span></p>
					<h1 class="mb-3 bread">Login</h1>
				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section ftco-no-pb ftco-no-pt">
		<div class="container">
			<div class="row">
				<div class="col-md-7 order-md-last d-flex align-items-stretch">
					<div class="img w-100 img-2 mr-md-2" style="background-image: url(/resources/images/about.jpg);"></div>
					<div class="img w-100 img-2 ml-md-2" style="background-image: url(/resources/images/about-2.jpg);"></div>
				</div>
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
					    			<button id="login-button" type="button" class="btn btn-primary">비밀번호찾기</button>
					    			
								</div>					   
							</form>
						</div>
					</div>
				</div>
			</div>
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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/resources/js/google-map.js"></script>
  <script src="/resources/js/main.js"></script>
    
     <%-- =================== 화면에서 안보이는 모달창 부분 [ 버튼 클릭시 모달 화면으로 보이는 내용 ] =================== --%>
       <div class="black_bg"></div>
         <div class="modal_wrap">
                  <div id=modify>전화번호</div>
                <input   type="tel" id="phone" name="phone" class="updateMember form-control hidden" maxlength="11"  placeholder="전화번호를 입력하세요 ex)01012345678" > 
		         <div id="clickForm">
		         <input type="button" id="sendPhone" class="btn btn-primary  hidden form-control " value="인증번호 받기">
		         </div>
		         <div id="inputNumForm">
		            <input type="tel" id="inputNum" class="updateMember form-control hiddenPhone" name="inputNum" maxlength="6" placeholder="인증번호를 입력하세요">
		            <input type="button" id="checkNum" class="hiddenPhone send form-control btn btn-primary" value="인증">
		         </div> 
             <br>
             <button id="btn_pw_ok" type="button">암호 확인</button>
             <button type="button" class="modal_close">창 닫기</button>
         </div>
    
    <%-- =================== 화면에서 안보이는 모달창 부분 [ 버튼 클릭시 모달 화면으로 보이는 내용 ] =================== --%>
<%-- =======================================  현왕 암호 출력 & 모달 종료 ================================================= --%>
    

 
  </body>
</html>