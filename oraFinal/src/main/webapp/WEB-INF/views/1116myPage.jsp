<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
   <title>마이페이지</title>
   <style>
    ul { //메뉴 스타일
         box-pack:center;
                        justify-content: center; // 창에따라 사이즈 달라짐
         background-color: #ffffff;
         list-style-type: none;
         margin: 50px; //메뉴 위치
         padding: 50px;
         overflow: hidden;
      }
      li { float: center; }
      li a {
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
      li a.current {
         color: black;
         background-color: #FF6347; //주황색 클릭
      }
      li a:hover:not(.current) {
         background-color: #CD853F; //갈색 마우스위로
         color: white;
      }
      <!-- 회원정보-->
      
              #myinfo {
                padding-left: 800px;
                display: table;
                padding: 100px;
                width: 300px;
              .row {
              }
              .display: table-row;
              }
              .cell {
                display: table-cell;
                padding: 20px;
                border-bottom: 1px solid #DDD;
              }
              .col1 {
                background-color:#F2F2F2;
                text-align: center;
                width: 100px;
              }
              .col2 {
                padding-left: 20px;
                width: 300px;
              }
              
   </style>
   
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

   <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script type="text/javascript">

   function pwd_check(){


      };
   </script>
   
 <!-- 컨테이너 시작-->
   <style type="text/css">

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
      

   </style>
 <!-- 컨테이너 끝-->
    <style>
      input, button { font-family: inherit; font-size: inherit; }
    </style>
    
    <style>


</style>

 

</head>
<body>
   
   
     <ul id="mytab">
         <h1>마이페이지</h1>
            <li><a class="current" href="/myPage">정보 수정</a></li>
            <li><a href="/myPageSaveCourse">찜 목록</a></li>
            <li><a href="/myPageMyCourse">작성 코스(준비중)</a></li>
            <li><a href="/myPageListReview">작성 후기</a></li>
            <li><a href="myPageListMeeting">작성 번개</a></li>
            <li><a href="/myPageMyRank">랭킹</a></li>
     </ul>
<ul>
     <!--회원정보-->
    
   <div id="change"> 
                <div id=modify>이름</div>
            <input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.name} "  />
               
            <form id="update">
            <div id=modify>닉네임</div>
            <input type="text" class="form-control text-muted modify_input " disabled="disabled" value="${m.nickName}" />
            <div ></div>
               <input class="updateMember modify_input hidden" style="visibility: hidden ;" placeholder="바꿀 닉네임을 입력하세요" name="nickName"/>





            
            <div id=modify>전화번호</div>
            <input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.phone }"  />
              
                  <div id="form">
            <input   type="tel" id="phone" name="phone" class="updateMember modify_input hidden" maxlength="11"  placeholder="ex)01012345678" >
         </div>
         <div id="clickForm">
            <input type="button" id="sendPhone" class="hidden modify_input" value="인증번호 받기">
         </div>
         <div id="inputNumForm">
            <input type="tel" id="inputNum" class="updateMember phone_input hiddenPhone" name="inputNum" maxlength="6" placeholder="인증번호">
            <input type="button" id="checkNum" class="hiddenPhone" value="인증">
         </div>    

                
            <div id=modify class="hidden">비밀번호</div>
         
            <div ></div>
               <input type="password" id="password1" class="updateMember modify_input hidden" style="visibility: hidden ;" placeholder="새 비밀번호를 입력하세요" name="password"/>
            <div ></div>
               <input type="password" id="password2" class="updateMember modify_input hidden" style="visibility: hidden ;" placeholder="새 비밀번호를 다시 입력하세요" name="password2"/>
            
            </form>
         
               <div id=modify>성별</div>
            <input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.gender }"  />

                <div id=modify>회원등급</div>
            <input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.rank_name }"  />

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

     
     
<jsp:include page="footer.jsp"/>

</body>
</html>