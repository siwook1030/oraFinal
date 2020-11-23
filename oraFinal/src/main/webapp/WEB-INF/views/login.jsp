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
        height: 300px;
        position: absolute;
        top:100%;
        left: 50%;
        padding:20px;
        margin: -90px 0 0 -200px; /*위치*/
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
        margin: -90px 0 0 -200px; /*위치*/
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
    
	<script type="text/javascript">
	$(function(){
		
	    
	    function onClickId() {
	        document.querySelector('.modal_wrapId').style.display ='block';
	        document.querySelector('.black_bgId').style.display ='block';
	    }   
	    function onClickPwd() {
	        document.querySelector('.modal_wrapPwd').style.display ='block';
	        document.querySelector('.black_bgPwd').style.display ='block';
	    }    
	    function offClickId() {
	        document.querySelector('.modal_wrapId').style.display ='none';
	        document.querySelector('.black_bgId').style.display ='none';
	        location.reload();
	    }
	    function offClickPwd() {
	        document.querySelector('.modal_wrapPwd').style.display ='none';
	        document.querySelector('.black_bgPwd').style.display ='none';
	        location.reload();
	    }
	 
	    document.getElementById('login-button-id').addEventListener('click', onClickId);
	    document.getElementById('login-button-pwd').addEventListener('click', onClickPwd);
	    document.querySelector('.modal_closeId').addEventListener('click', offClickId);
	    document.querySelector('.modal_closePwd').addEventListener('click', offClickPwd);
	<!-- ===================================== 현왕 모달창 실행 자바스크립트 추가 종료 =========================================== -->
	<!-- ===================================== 현왕 모달창 내용 자바스크립트 추가 & 암호 변경하면 비밀번호 <input type=text>에 전달 =========================================== -->
	      const phone = document.getElementById("phone");
	      const phonePwd = document.getElementById("phonePwd");
	      const sendPhone = document.getElementById("sendPhone");
	      const sendPhonePwd = document.getElementById("sendPhonePwd");
	      const checkNum = document.getElementById("checkNum");
	      const inputNum = document.getElementById("inputNum");
	      const inputNumPwd = document.getElementById("inputNumPwd");
	      const inf = document.getElementById("inputNumForm");
	      const id = document.getElementById("IdPwd");
		  $("#bb").css({display: "none"});
		  
	      sendPhone.onclick=sendPhoneReq;   
	      sendPhonePwd.onclick=sendPhoneReqPwd;   
	      
	      checkNum.onclick=checkNumReq;   
	      checkNumPwd.onclick=checkNumReqPwd;   
	      
	      let i = 1;
	       $("#btnUpdate2").click(function() {
	          const pwd1 = document.getElementById("password1").value;
	          const pwd2 = document.getElementById("password2").value;
	          var pass = false;
	          if(pwd1 == pwd2){
	             if(pwd1 != "" && pwd2 !=""){
	             alert("비밀번호가 일치합니다");
	            }//if
	             pass = true;
	          }else{//if
	             alert("비밀번호가 일치하지 않습니다.");
	              return false;
	          }//else
	          if(pass){
	             if(pwd1 != "" && pwd2 !=""){
	                 const pwAvail = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,12}$/;
	                 const pwAvailCheck = pwAvail.test(pwd1.trim());
	                 if(!pwAvailCheck){
	                     alert("비밀번호는 문자,숫자,특수기호 1가지이상 포함하여야합니다");
	                     return;
	                 }//if
	             }//if
	             $.ajax("/updatePwd", {
		             data:{"password" : pwd1 , "id" : id.value},
		             type: "POST",
		             success:function(re){
			             console.log(id.value);         
			             console.log(pw1);         
	                alert("회원 정보가 수정되었습니다");         
	                window.location.reload();
	             }});      //에이작
	          }//if
	        });//펑션끝
	      function sendPhoneReqPwd(){// 인증번호 발송
	         const phAvail = /^01[0179][0-9]{7,8}$/;
	         const phAvailCheck = phAvail.test(phonePwd.value.trim());
	         
	            if(id.value.trim() == ""){
	               alert("아이디를 입력하세요.");
	               id.focus();
	               return;
	            }
	            if(phonePwd.value.trim() == ''){
	               alert("휴대전화를 입력하세요.");
	               phonePwd.focus();
	               return;
	            }
	               if(phonePwd.value.trim() == ''){
	                  alert("휴대전화번호를 입력하세요..");
	                  phonePwd.focus();
	                  return;
	               }
	               else if(phAvailCheck == false){
	                  alert("유효하지 않은 번호입니다.");
	                  phonePwd.focus();
	                  return;
	               }
	               else if(checkPhoneNumPwd() == 0){
	                  alert("가입 되어있지 않은 번호입니다");
	                  phonePwd.focus();
	                  return;
	               }
	               $.ajax({
	   	                  url: "/selectMemberId",
	   	                  type: "POST",
	   	               	  async: false,
	   	                  data:{
	   	                     "phone":phonePwd.value.trim()
	   	                  },
	   	                success: function(data){
		      	        	if(id.value.trim() != data.id){
								alert("가입 하신 아이디와 전화번호를 다시확인해주세요.");
								i = 0;	
								return;
				      	    }else{
								i = 1;
						    }
	   	                }
	         	  	});
	         	  	
        	  		if(i == 0){
            	  		return;
            	  	}
	               $.ajax({
	                  url: "/smsSend",
	                  type: "GET",
	                  data:{
	                     "phoneNum":phonePwd.value.trim()
	                  },
	                  success: function(data){
	                     if(data == "1"){
	                        alert("인증번호가 발송되었습니다.");
	                        $("#phonePwd").prop('readonly', true);
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
	      function sendPhoneReq(){// 인증번호 발송
	         const phAvail = /^01[0179][0-9]{7,8}$/;
	         const phAvailCheck = phAvail.test(phone.value.trim());
	            if(phone.value.trim() == ''){
	               alert("휴대전화를 입력하세요.");
	               phone.focus();
	               return;
	            }
	               if(phone.value.trim() == ''){
	                  alert("휴대전화번호를 입력하세요..");
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
	                        $("#IdPwd").prop('readonly', true);
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
	      
	      function checkNumReqPwd(){//인증번호 확인
	         
	               if(inputNumPwd.value.trim() == ''){
	                  alert("인증번호를 입력하세요..");
	                  inputNumPwd.focus();
	                  return;
	               }
	               else if(inputNumPwd.value.trim().length != 6){
	                  alert("인증번호는 6자리입니다.");
	                  inputNumPwd.focus();
	                  return;
	               }
	               let idR = 0;      
	               $.ajax({
	                  url: "/smsSend",
	                  type: "POST",
	                  data:{
	                     "num":inputNumPwd.value.trim()
	                  },
	                  success: function(data){
	                     if(data == '1'){
		                     idR = 1;
	                        alert("인증되었습니다.");
	                        $.ajax({
		      	                  url: "/selectMemberId",
		      	                  type: "POST",
		      	                  data:{
		      	                     "phone":phonePwd.value.trim()
		      	                  },
		      	                success: function(data){
			      	                $("#bb").css({display: "block"});
		      	                }
		            	   });
	                       
	                        inputNumPwd.value="";
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
	      function checkNumReq(){//인증번호 확인
	         
	               if(inputNum.value.trim() == ''){
	                  alert("인증번호를 입력하세요..");
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
			      	                $("#h2").text("고객님의 아이디는 "+data.id+" 입니다.");
		      	                }
		            	   });
	                       
	                        inputNum.value="";
	                        $(".hiddenPhone").css({display: "none"});
	                        $("#kakusu").css({display:"none"});
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
	      function checkPhoneNumPwd(){//디비저장 폰있는지 중복방지
	          let check = 1;
	          const phoneNum = phonePwd.value.trim();
	          
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
					<li class="qnav-item"><a href="" class="nav-link">라이딩 정보</a></li>
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
					<h1 class="mb-3 bread">Login</h1>
				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section ftco-no-pb ftco-no-pt contact-section">
		<div class="container">
			<div class="row block-9 justify-content-center mb-5"> 
<!-- 여기  wrap-about py-md-5 ftco-animate-->		<div class="colmd8 mb-md-5 bg-light p-5 contact-form">
			
					<div class="heading-section pr-md-5">
						<h2 class="mb-4" style="text-align: center; font-size: 30px;">오늘의 라이딩 로그인</h2>
						<p style="text-align: center; color: black; margin: 0 0 10px;">오늘도 힘차게 달려볼까요.?</p>
						<div class="container">
									<input type="text" class="form-control form-group" id="member-id"  placeholder="아이디를 입력하세요." name="member-id"  maxlength="12" required>
									<input type="password" class="form-control form-group" id="member-password"  placeholder="비밀번호를 입력하세요." name="member-password" maxlength="12" required>
									<input type="hidden" id="token" data-token-name="${_csrf.headerName}" 	placeholder="비밀번호를 입력하세요." value="${_csrf.token}">
					    		<div style="text-align: center;">
					    			<button id="login-button" type="button" class="btn btn-primary form-control" onclick="location.href='/mainPage'">로그인</button>
									<button id="login-button-id" type="button" class="btn" style="font-size: 15px;">아이디찾기</button>
					    			<button id="login-button-pwd" type="button" class="btn"  style="font-size: 15px; ">비밀번호찾기</button>
					    			<button id="login-button-pwd" type="button" class="btn "onclick="location.href='/signUp'"  style="font-size: 15px; ">회원가입</button>
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
                <input type="tel" id="phone" name="phone"  class=" hidden form-group form-control2" maxlength="11" placeholder="휴대폰 번호'-'없이 입력해 주세요." > 
		         <input type="button" id="sendPhone" class="hidden  btn btn-primary form-group form-control2" value="인증번호 받기">
		         </div>
		         <div id="inputNumForm">
		            <input type="tel" id="inputNum" class="hiddenPhone form-group form-input-control3" name="inputNum" maxlength="6" placeholder="인증번호를 입력하세요.">
		            <input type="button" id="checkNum" class="hiddenPhone btn btn-primary form-control3" value="인증">
		         </div> 
<%--수정필요 --%>		         <div id="miseru" style="padding: 50px;">
		         <h2 id="h2"class="mb-4" style=" text-align:center;  font-size: 16px"></h2>
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
               	<h4 class="mb-4" style="text-align: center; font-size: 20px;">비밀번호 재발급</h4>
                 <div>
  	            <input type="text" id="IdPwd" name="Id" class="hidden  form-group form-control2" maxlength="12"  placeholder="아이디를 입력하세요." > 
                </div>
                <input type="tel" id="phonePwd" name="phone" class="hidden  form-group form-control2" maxlength="11"  placeholder="휴대폰 번호'-'없이 입력해 주세요." > 
		         <div>
		         <input type="button" id="sendPhonePwd" class="hidden btn btn-primary form-control2 form-group" value="인증번호 받기">
		         </div>
		         <div id="inputNumForm">
		            <input type="tel" id="inputNumPwd" class="hiddenPhone form-group form-input-control3" name="inputNumPwd" maxlength="6" placeholder="인증번호를 입력하세요.">
		            <input type="button" id="checkNumPwd" class="hiddenPhone btn btn-primary form-control3" value="인증">
		         </div> 
             <br>
             	<div id="bb">
             	 <div id=modify class="hidden">비밀번호</div>
		         <div ></div>
		         <input type="password" id="password1" class="hidden"  placeholder="새 비밀번호를 입력하세요." name="password"/>
		         <div ></div>
		         <input type="password" id="password2" class="hidden"  placeholder="새 비밀번호를 다시 입력하세요." name="password2"/>
		         <button id="btnUpdate2"  class="" >수정하기</button>
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