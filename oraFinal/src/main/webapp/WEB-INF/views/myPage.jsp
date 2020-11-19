<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 정보 수정</title>
<jsp:include page="my_header.jsp"/>
    
     
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

    #modify {
      font-size: 20px;
      margin: 10px auto;
      text-align: left;
    }

    #modify2 {
      margin: 10px auto;
      text-align: left;
      width: 500px;
      height: 40px;
    }

    #modify_input {
      margin-bottom: 20px;

      text-align: left;
      width: 500px;
      height: 40px;
    }

    .modify_input {
      margin-bottom: 20px;

      text-align: left;
      width: 500px;
      height: 40px;
    }

    .phone_input {
      margin-bottom: 20px;

      text-align: left;
      width: 440px;
      height: 40px;
    }



    .send {
      < !--인증번호 받기버튼-->background: #24A148 !important;
      border: 1px solid #24A148 !important;
      color: #fff !important;
    }

    margin-bottom: 20px;

    text-align: left;
    width:440px;
    height:40px;
    }

    . new_input {
      display: block;
      width: 100%;
      height: calc(1.5em + 0.75rem + 2px);
      padding: 0.375rem 0.75rem;
      padding-top: 0.375rem;
      padding-right: 0.75rem;
      padding-bottom: 0.375rem;
      padding-left: 0.75rem;


    }

    .phone_input {
      < !--새전화번호입력-->padding-right: 50px;
      font-size: 14px;
    }

    .my {
      float: center;
    }

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
    
  
    
<section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');" data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
            <span>
              <h1 class="mb-3 bread">마이페이지</h1>
            </span>
            <p class="breadcrumbs">
              <span class="mr-2">
                <a href="index.html">Home <i class="fa fa-chevron-right"></i></a>
              </span>
              <a href="/myPage">정보 수정 <i class="fa fa-chevron-right"></i></a>
              <span>
                <a href="/myPageSaveCourse">찜 목록 <i class="fa fa-chevron-right"></i></a>
                <a href="/myPageMyCourse">내 작성 코스<i class="fa fa-chevron-right"></i></a>
                <a href="/myPageListReview">내 작성 후기<i class="fa fa-chevron-right"></i></a>
                <a href="myPageListMeeting">내 작성 번개<i class="fa fa-chevron-right"></i></a>
                <a href="/myPageMyRank">랭킹</a>
              </span>
            </p>
          </div>
        </div>
      </div>
    </section>
    <section class="ftco-section contact-section">
      <div class="container">
        <div class="row block-9 justify-content-center mb-5">
          <div class="col-md-8 mb-md-5">
            <form action="#" class="bg-light p-5 contact-form">
              <h2 class="text-center">회원정보수정</h2>
              <div class="form-group">
                <div id=modify>이름</div>
                <input type="text" class="form-control text-muted " disabled="disabled" value="${m.name} " />

              </div>
              <div id=modify>닉네임</div>
              <div class="form-group">
                <input type="text" class="form-control" disabled="disabled" value="${m.nickName}" style="background-color: #e2e2e2;">
              </div>
              <input class="updateMember form-control hidden" style="visibility: hidden ;" placeholder="바꿀 닉네임을 입력하세요" name="nickName" />

              <div id=modify>전화번호</div>
              <div class="form-group">
                <input type="text" class="form-control" disabled="disabled" value="${m.phone }">
              </div>
              <input type="tel" id="phone" name="phone" class="updateMember form-control form-group hidden" maxlength="11"
                placeholder="새 전화번호를 입력하세요 ex)01012345678">

              <div id="clickForm">
                <input type="button" id="sendPhone" class="btn btn-primary  hidden form-control form-group " value="인증번호 받기">
              </div>
              <div id="inputNumForm">
                <input type="tel" id="inputNum" class="updateMember form-control form-group hiddenPhone" name="inputNum" maxlength="6"
                  placeholder="인증번호를 입력하세요">
                <input type="button" id="checkNum" class="hiddenPhone send form-control form-group btn btn-primary" value="인증">
              </div>

              <div id=modify class="hidden">비밀번호</div>
              <div></div>
              <input type="password" id="password1" class="modify updateMember form-control form-group hidden" style="visibility: hidden ;"
                placeholder="새 비밀번호를 입력하세요" name="password" />

              <input type="password" id="password2" class="updateMember form-control form-group hidden" style="visibility: hidden ;"
                placeholder="새 비밀번호를 다시 입력하세요" name="password2" />

              <input type="password" id="pwd" class="updateMember form-control form-group " placeholder="회원정보 수정을 위해서는 비밀번호 입력하세요" name="pwd"
                style="border: 1px solid #ff0000;" />
              <div></div>

              <div style="text-align: center">
                <button id=btnUpdate value="수정하기" class="btn form-control form-group btn-primary py-3 px-5 "> 수정하기</button>
                <button id="btnUpdate2" style="visibility: hidden" class="btn form-group form-control btn-primary py-3 px-5">수정완료</button>
              </div>

            </form>
          </div>
        </div>
      </div>

    </section>
    <jsp:include page="my_footer.jsp" />

    </body>

    </html>