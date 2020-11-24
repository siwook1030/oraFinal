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
   
       <!-- 스크립트 기본 -->


<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/login.js">
</script>
<style type="text/css">
	
   .form-control2 { /* 모달 전화번호 입력/인증번호 받기 버튼*/
    display: inline-block;
    float:inherit;
    width: 80%;
    height: calc(1.5em + 0.75rem + 2px);
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
}
      
   .form-control3 { /* 모달 인증번호 입력/인증완료 버튼*/
    display: block;
    width: 30%;
    height: calc(1.5em + 0.75rem + 2px);
    padding: 0.375rem 0.75rem;
    font-size: .9rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
}
   .form-input-control3 { /* 모달 인증번호 입력/인증완료 버튼*/
    display: block;
    width: 50%;
    height: calc(1.5em + 0.75rem + 2px);
    padding: 0.375rem 0.75rem;
    font-size: .9rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
}
	 *:focus { outline:none; }
	    
    	/* =============================== 현왕 모달창 내부 css =================================== */
 
   .modal_wrapId{ /* 아이디 찾기 모달*/
        display: none;
        width: 400px;
        height: 270px;
        position: absolute;
        top:100%;
        left: 50%;
        padding:20px;
        margin: -420px 0 0 -210px; /*위치*/
        background:#ffffff;
        z-index: 3;
        font-family: sans-serif;
        text-align: center;
    }
    .black_bgId{/*아이디찾기 모달 띄었을때 배경*/
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
    
	
   .modal_wrapPwd{ /*비밀번로호 모달*/
        display: none;
        width: 400px;
        height: 350px;
        position: absolute;
        top:100%;
        left: 50%;
        padding:20px;
        margin: -420px 0 0 -210px; /*위치*/
        background:#ffffff;
        z-index: 3;
        font-family: sans-serif;
        text-align: center;
    }
    .black_bgPwd{ /*비밀번호찾기 모달 띄었을때 배경*/
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
      
         /*회색부분 크기*/
    .colmd7 { 
    -webkit-box-flex: 0;
    -ms-flex: 0 0 66.66667%;
    flex: 0 0 66.66667%;
    max-width: 40%; }   /*여기*/
      
      
    
/* =============================== 현왕 모달창 내부 css 종료 =================================== */
/* =============================== 현왕 모달창 열기 & 내부 버튼 css 시작 =================================== */
#modal_btn, #btn_pw_ok, .modal_closeId .modal_closeIPwd {
    background-color: white;
    color: #17A2B8;
    border: solid 1px #17A2B8;
   border-radius: 5px;
    cursor: pointer;
   font-family: inherit;
}
#modal_btn:hover, #btn_pw_ok:hover, .modal_closeId:hover .modal_closePwd:hover{
         background-color: #17A2B8;
         color: white;
      }
/* =============================== 현왕 모달창 열기 & 내부 버튼 css 종료 =================================== */
    </style>
    
<jsp:include page="my_header2.jsp"/>
</head>
<body>



<section class="my-wrap my-wrap-2" style="background-color: #fff;"  id=top></section>
    <section class="">
      <div class="container" >
        <div class="row block-9 justify-content-center mb-5">
          <div class="colmd7 mb-md-5 bg-light p-5 contact-form">
					<div class="heading-section pr-md-5">
						<h2 class="mb-4" style="text-align: center; font-size: 30px;">오늘의 라이딩 로그인</h2>
						<p style="text-align: center; color: black; margin: 0 0 10px;">오늘도 힘차게 달려볼까요?</p>
						<div class="container">
									<input type="text" class="form-control form-group" id="member-id"  placeholder="아이디를 입력하세요" name="member-id"  maxlength="12" required>
									<input type="password" class="form-control form-group" id="member-password"  placeholder="비밀번호를 입력하세요" name="member-password" maxlength="12" required>
									
					    		<div style="text-align: center;">
					    			<button id="login-button" type="button" class="btn btn-primary form-control" onclick="location.href='/mainPage'">로그인</button>
									<button id="login-button-id" type="button" class="btn" style="font-size: 15px;">아이디찾기</button>
					    			<button id="login-button-pwd" type="button" class="btn"  style="font-size: 15px; ">비밀번호 재발급</button>
					    			<h6 style="font-size: 13px; display: inline-block;" >아직 회원이 아니세요?</h6>
					    			<button id="login-button-pwd" type="button" class="btn "onclick="location.href='/signUp'"  style="font-size: 15px;  ">회원가입</button>
								</div>					   
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


 
     <%-- =================== 화면에서 안보이는 모달창 부분 [ 버튼 클릭시 모달 화면으로 보이는 내용 ] 아이디찾기 완료 =================== --%>
       <div class="black_bgId"></div>
         <div class="modal_wrapId">
             <div class="close" style="float: right; padding-left: 400px" >    
             <button type="button" class=" btn btu-primary modal_closeId" >ⓧ</button>
             </div>
             	<h4 class="mb-4" style="text-align: center; font-size: 20px;">아이디 찾기</h4>
		         <div id=kakusu>
                <input type="tel" id="phone" name="phone"  class=" hidden form-group form-control2" maxlength="11" placeholder="휴대폰 번호'-'없이 입력해 주세요" required> 
		         <input type="button" id="sendPhone" class="hidden  btn btn-primary form-group form-control2" value="인증번호 받기">
		         </div>
		         <div id="inputNumForm">
		            <input type="tel" id="inputNum" class="hiddenPhone form-group form-input-control3" name="inputNum" maxlength="6" placeholder="인증번호를 입력하세요" required>
		            <input type="button" id="checkNum" class="hiddenPhone btn btn-primary form-control3" value="인증">
		         </div> 
<%--수정필요 --%>		         <div id="miseru" style="padding: 20px;">
		         <h3 id="h2"class="" style=" text-align:center;  font-size: 16px"></h3>
		         </div>
             <br>

         </div>
    
    <%-- =================== 화면에서 안보이는 모달창 부분 [ 버튼 클릭시 모달 화면으로 보이는 내용 ] =================== --%>
     <%-- =================== 화면에서 안보이는 모달창 부분 [ 버튼 클릭시 모달 화면으로 보이는 내용 ] 비밀번호 찾기 =================== --%>
       <div class="black_bgPwd"></div>
         <div class="modal_wrapPwd">
          <div class="close" style="float: right; padding-left: 400px" >    
             <button type="button" class=" btn btu-primary modal_closePwd" >ⓧ</button>
             </div>
             <div id="cc">
               	<h4 class="mb-4" style="text-align: center; font-size: 20px;">비밀번호 재발급</h4>
                 <div>
  	            <input type="text" id="IdPwd" name="Id" class="hidden  form-group form-control2" maxlength="12"  placeholder="아이디를 입력하세요" required> 
                </div>
                <input type="tel" id="phonePwd" name="phone" class="hidden  form-group form-control2" maxlength="11"  placeholder="휴대폰 번호'-'없이 입력해 주세요" required > 
		         <div>
		         <input type="button" id="sendPhonePwd" class="hidden btn btn-primary form-control2 form-group" value="인증번호 받기" required>
		         </div>
		         <div id="inputNumForm">
		            <input type="tel" id="inputNumPwd" class="hiddenPhone form-group form-input-control3" name="inputNumPwd" maxlength="6" placeholder="인증번호를 입력하세요" required>
		            <input type="button" id="checkNumPwd" class="hiddenPhone btn btn-primary form-control3" value="인증">
		         </div>
		         </div> 
             <br>
              	<div id="bb">
             	 <div id=modify class="hidden">
             	 	<h4 class="mb-4" style="text-align: center; font-size: 20px;">비밀번호 재발급</h4>
		         <div ></div>
		         <input type="password" id="password1" class="hidden form-group form-control2"  placeholder="새 비밀번호를 입력하세요" name="password"/ required >
		         <div ></div>
		         <input type="password" id="password2" class="hidden form-group form-control2"  placeholder="새 비밀번호를 다시 입력하세요" name="password2"/ required>
		         <button id="btnUpdate2"  class="hidden btn btn-primary form-control2 form-group" onclick="location.href='/login'">수정하기</button></a>
		         </div>   
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