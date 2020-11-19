<%@ page language="java"contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>< !DOCTYPE html>
<html>

<head>
<title>회원 가입</title>
<jsp:include page="my_header.jsp"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="resources/css/animate.css">
        <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
        <link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="resources/css/magnific-popup.css">
        <link rel="stylesheet" href="resources/css/flaticon.css">
        <link rel="stylesheet" href="resources/css/style.css">
</head>
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
     </body>