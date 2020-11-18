<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
  <head>
    <title>Ecoverde - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="resources/css/animate.css">
    
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css">
    
    <link rel="stylesheet" href="resources/css/flaticon.css">
    <link rel="stylesheet" href="resources/css/style.css">
    
    
    
     
   <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script type="text/javascript">
   $(function(){

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
               else if(checkPhoneNum() == 1){
                  alert("이미 가입되어있는 번호입니다");
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
                        //$('#chekingPhone').attr("value","Y");
                     //   $('#inputNum').val('');
                        //inf.style.visibility="hidden";
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

      $(".hidden").css({display: "none"});
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

       $("#btnUpdate2").click(function() {
          if(phone.value.trim() != ''){
              if($("#btnUpdate2").attr("i") == "1"){
            alert("휴대전화 변경시 인증을먼저진행해주세요");
            phone.focus();
            return;
              }
         }
         const pwd1 = document.getElementById("password1").value;
         const pwd2 = document.getElementById("password2").value;
         var pass = false;
         if(pwd1 == pwd2){
            if(pwd1 != "" && pwd2 !=""){
            alert("비밀번호가 일치합니다");
           }
            pass = true;
         }else{
            alert("비밀번호가 일치하지 않습니다.");
             return false;
         }
         if(pass){
            if(pwd1 != "" && pwd2 !=""){
                const pwAvail = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,12}$/;
                const pwAvailCheck = pwAvail.test(pwd1.trim());
                if(!pwAvailCheck){
                    alert("비밀번호는 문자,숫자,특수기호 1가지이상 포함하여야합니다");
                    return;
                }
            }
            var data =$("#update").serialize();
            $.ajax("/update", {data:data,type: "POST",success:function(re){         
               alert("회원 정보가 수정되었습니다");         
               window.location.reload();
            }});      
         }
       });
   });
   </script>

   <style>
  
  
  /* 개별 */
      #change {
         padding: 10px;
         text-align: center;
         color: black;
      }
      #modify{
      font-size: 20px;
      margin: 10px auto;      
      text-align: left;
      width:500px; 
      height:40px;
      }
      #modify2{
      margin: 10px auto;      
      text-align: left;
      width:500px; 
      height:40px;
      }
      
      #modify_input{
      margin-bottom: 20px;
      
      text-align: left;
      width:500px; 
      height:40px;
      }
      .modify_input{
      margin-bottom: 20px;
      
      text-align: left;
      width:500px; 
      height:40px;
      }
      
      .phone_input{
      margin-bottom: 20px;
      
      text-align: left;
      width:440px; 
      height:40px;
      }
      
      
      
	.send{ <!--인증번호 받기버튼-->
		background: #24A148 !important;
		border: 1px solid #24A148 !important;
		color: #fff !important; }
		margin-bottom: 20px;
		      
		text-align: left;
		width:440px; 
		height:40px;
      }
      
     .phone_input { <!--새전화번호입력-->
			padding-right: 50px;
			font-size: 14px;
		}
		
 	 .my { float: center; }
     .my a {
         display: block;
         background-color: #ffffff;
         color: gray;
         padding: 15px;
         float: left;
         width: 100px;
         text-align: center;
         text-decoration: none;
         text-align: center;
         font-weight: bold;
      }
      .my a.current {
         color: black;
         background-color: #FF6347; //주황색 클릭
      }
      .my a:hover:not(.current) {
         background-color: #CD853F; //갈색 마우스위로
         color: white;
      }
   </style>
  </head>
  <body>
    
	  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="index.html">Ecoverde</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="index.html" class="nav-link">Home</a></li>
	          <li class="nav-item"><a href="about.html" class="nav-link">About</a></li>
	          <li class="nav-item"><a href="agent.html" class="nav-link">Agent</a></li>
	          <li class="nav-item"><a href="services.html" class="nav-link">Services</a></li>
	          <li class="nav-item"><a href="properties.html" class="nav-link">Properties</a></li>
	          <li class="nav-item"><a href="blog.html" class="nav-link">Blog</a></li>
	          <li class="nav-item active"><a href="contact.html" class="nav-link">Contact</a></li>
	        </ul>
	      </div>
	    </div>
	  </nav>
    <!-- END nav -->
  
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home <i class="fa fa-chevron-right"></i></a></span> <span>Contact <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">회원정보수정</h1>
          </div>
        </div>
      </div>
    </section>

 <ul id="mytab">
         <h1>마이페이지</h1>
            <li id="my"><a class="current" href="/myPage">정보 수정</a></li>
            <li id="my"><a href="/myPageSaveCourse">찜 목록</a></li>
            <li id="my"><a href="/myPageMyCourse">작성 코스(준비중)</a></li>
            <li id="my"><a href="/myPageListReview">작성 후기</a></li>
            <li id="my"><a href="myPageListMeeting">작성 번개</a></li>
            <li id="my"><a href="/myPageMyRank">랭킹</a></li>
     </ul>
    <section class="ftco-section contact-section">
      <div class="container">
        <div class="row block-9 justify-content-center mb-5">
          <div class="col-md-8 mb-md-5">
          	<h2 class="text-center">회원정보수정</h2>
            <form action="#" class="bg-light p-5 contact-form">
              <div class="form-group">
			    <div id=modify>이름</div>
	            <input type="text" class="form-control text-muted " disabled="disabled" value="${m.name} "  />
            
              </div>
              <div id=modify>닉네임</div>
              <div class="form-group">
                <input type="text" class="form-control" disabled="disabled" value="${m.nickName}" style="background-color: #e2e2e2;">
              </div>
                <input class="updateMember form-control hidden" style="visibility: hidden ;" placeholder="바꿀 닉네임을 입력하세요" name="nickName"/>
              

              <div id=modify>전화번호</div>
              <div class="form-group">
                <input type="text" class="form-control" disabled="disabled" value="${m.phone }">
              </div>
                <input   type="tel" id="phone" name="phone" class="updateMember form-control hidden" maxlength="11"  placeholder="새 전화번호를 입력하세요 ex)01012345678" > 
		 
		         <div id="clickForm">
		         <input type="button" id="sendPhone" class="btn btn-primary  hidden form-control " value="인증번호 받기">
		         </div>
		         <div id="inputNumForm">
		            <input type="tel" id="inputNum" class="updateMember form-control hiddenPhone" name="inputNum" maxlength="6" placeholder="인증번호를 입력하세요">
		            <input type="button" id="checkNum" class="hiddenPhone send form-control btn btn-primary" value="인증">
		         </div>    
		
		                
		            <div id=modify class="hidden">비밀번호</div>
		            <div ></div>
		               <input type="password" id="password1" class="updateMember form-control hidden" style="visibility: hidden ;" placeholder="새 비밀번호를 입력하세요" name="password"/>
		          
		               <input type="password" id="password2" class="updateMember form-control hidden" style="visibility: hidden ;" placeholder="새 비밀번호를 다시 입력하세요" name="password2"/>
		            
		           
		      	   <input type="password" id="pwd" class="updateMember form-control " placeholder="회원정보 수정을 위해서는 비밀번호 입력하세요" name="pwd" style="border: 1px solid #ff0000;"/>
		        	 <div ></div>

            </form>
             </div>
            </div>
         
           <div style="text-align: center">
             <button id = btnUpdate value="수정하기" class="btn btn-primary py-3 px-5 "> 수정하기</button>
		      <button id="btnUpdate2" style="visibility: hidden" class="btn btn-primary py-3 px-5" >수정완료</button>
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
       
    </footer>
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
                <div id=modify>가입일</div>
            <input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.regdate }"  />

         <div ></div>
         <input type="password" id="pwd" class="updateMember modify_input" placeholder="비밀번호 입력" name="pwd"/>
         <div ></div>
         <button id="btnUpdate">확인</button>
         <div ></div>
         <button id="btnUpdate2" style="visibility: hidden" >수정하기</button>
   </div>
</ul>

  <script src="resources/js/jquery.min.js"></script>
  <script src="resources/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="resources/js/popper.min.js"></script>
  <script src="resources/js/bootstrap.min.js"></script>
  <script src="resources/js/jquery.easing.1.3.js"></script>
  <script src="resources/js/jquery.waypoints.min.js"></script>
  <script src="resources/js/jquery.stellar.min.js"></script>
  <script src="resources/js/owl.carousel.min.js"></script>
  <script src="resources/js/jquery.magnific-popup.min.js"></script>
  <script src="resources/js/jquery.animateNumber.min.js"></script>
  <script src="resources/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="resources/js/google-map.js"></script>
  <script src="resources/js/main.js"></script>
    
  </body>
</html>