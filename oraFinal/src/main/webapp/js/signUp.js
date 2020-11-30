window.onload = function(){
	const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    const parameter = $("meta[name='_csrf_parameter']").attr("content");
    $(document).ajaxSend(function(e, xhr, options) {
        if(token && header) {
            xhr.setRequestHeader(header, token);
        }
    });

   console.log("작동함");
   const id = document.getElementById("id");
   const pwd = document.getElementById("password");
   const pwdCheck = document.getElementById("passwordCheck");
   const name = document.getElementById("name");
   const nickName = document.getElementById("nickName");
   const phone = document.getElementById("phone");
   const sendPhone = document.getElementById("sendPhone");
   const chekingPhone = document.getElementById("chekingPhone");
   const chekedPhone = document.getElementById("chekedPhone");
   const checkNum = document.getElementById("checkNum");
   const inputNum = document.getElementById("inputNum");
   const inf = document.getElementById("inputNumForm");
   const signUpBtn = document.getElementById("signUp");
   inf.style.display = "none";
   inf.style.visibility="hidden";

   sendPhone.onclick=sendPhoneReq;   
   checkNum.onclick=checkNumReq;   
   signUpBtn.onclick=signUp;
   /*
   $('#sendPhone').click(function(){
      sendPhone();
   })
   $('#checkNum').click(function(){
      checkNum();
   })
   $('#signUp').click(function(){
      signUp();
   })   */

   console.log("작동함22");
function signUp(){
      console.log("작동함");
      const idAvail = /^[a-z0-9]{8,12}$/;
      const pwAvail = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,12}$/;
      const nameAvail = /^[가-힣]{2,6}$/;
      const nickNameAvail = /^[가-힣a-zA-Z0-9]{2,8}$/;
      
      const idAvailCheck = idAvail.test(id.value.trim());
      const pwAvailCheck = pwAvail.test(pwd.value.trim());
      const nameAvailCheck = nameAvail.test(name.value.trim());
      const nickNameAvailCheck = nickNameAvail.test(nickName.value.trim());
      
      console.log(idAvailCheck);
      console.log(pwAvailCheck);
      console.log(nameAvailCheck);
      console.log(nickNameAvailCheck);

         if(id.value.trim() == ''){
            alert("ID를 입력하세요.");
            id.focus();
            return;
         }
         else if(idAvailCheck == false){
            alert("ID형식이 올바르지 않습니다(8~12자 영어소문자,숫자).");
            id.focus();
            return;
         }
         else if(pwd.value.trim() == ''){
            alert("Password를 입력하세요.");
            pwd.focus();
            return;
         }
         else if(pwAvailCheck == false){
            alert("비밀번호 형식이 올바르지 않습니다(8~12자 영문자+숫자+특수문자1개이상).");
            pwd.focus();
            return;
         }
         //패스워드 확인
         else if(pwd.value != pwdCheck.value ){
            alert('Password가 일치하지 않습니다.');
            pwd.focus();
            return;
         }
         else if(name.value.trim() == ''){
            alert("이름을 입력하세요");
            name.focus();
            return;
         }
         else if(nameAvailCheck == false){
            alert("이름 형식이 올바르지 않습니다(한글 2~6자).");
            name.focus();
            return;
         }
         else if(nickName.value.trim() == ''){
            alert("닉네임을 입력하세요.");
            nickName.focus();
            return;
         }
         else if(nickNameAvailCheck == false){
            alert("닉네임 형식이 올바르지 않습니다(한글,영문자,숫자 2~8자).");
            nickName.focus();
            return;
         }
         else if(phone.value.trim() == ''){
            alert("휴대전화를 입력하세요");
            phone.focus();
            return;
         }
            

         if(check() != 0){
            alert("중복된 아이디입니다");
            id.focus();
            return;
         }
         if(checkNick() != 0){
            alert("중복된 닉네임입니다");
            nickName.focus();
            return;
         }
         

         if(chekingPhone.value == 'N'){
            alert("휴대전화를 인증해주세요.");
            sendPhone.focus();
            return;
         }
         else if(chekedPhone.value != phone.value.trim()){
            alert("휴대전화를 인증해주세요.");
            sendPhone.focus();
            return;
         }
         else{

            signUpOk();
         }

}      

function signUpOk(){

      $.ajax({
            url: "/signUp?"+parameter+"="+token,
            type: "POST",
            data: $("#signUpForm").serialize(),
            success: function(data){
               if(data == "1"){
                  alert("회원가입 성공!");
                  window.location = "/mainPage";
               }else{
                  alert("회원가입 실패");
               }
            },
            error: function(){
               alert('서버에러');
            }
         });

}

   
function sendPhoneReq(){
   const phAvail = /^01[0179][0-9]{7,8}$/;
   const phAvailCheck = phAvail.test(phone.value.trim());   
   
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
                  chekedPhone.value = phone.value.trim();
                  //$('#chekedPhone').attr("value",$.trim($('#phone').val()));
                  alert("인증번호가 발송되었습니다.");
                  inf.style.display="block";
                  inf.style.visibility="visible";
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

function checkNumReq(){
   
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
            url: "/smsSend?"+parameter+"="+token,
            type: "POST",
            data:{
               "num":inputNum.value.trim()
            },
            success: function(data){
               if(data == '1'){
                  alert("인증되었습니다.");
                  chekingPhone.value="Y";
                  inputNum.value="";
                  //$('#chekingPhone').attr("value","Y");
               //   $('#inputNum').val('');
                  inf.style.display="none";
               }else{
                  alert("인증번호가 일치하지 않습니다.");
               }
            },
            error: function(){
               alert("서버에러");
            }
         });
         
}

function check(){
      let idCheckNum = 1;
          $.ajax({
            url: "/idCheck?"+parameter+"="+token,
            async: false,
            type: "POST",
            data:{
               "id":id.value.trim()
            },
            success: function(data){
               if(data == "0"){
                  console.log('나0이다');
                  idCheckNum = 0;
               }else{
                  idCheckNum = 1;
               }
            },
            error: function(){
               alert('서버에러');
            }
         });

      return idCheckNum;
}

function checkNick(){
      let nickCheck = 1;
         $.ajax({
            url: "/nickCheck?"+parameter+"="+token,
            type: "POST",
            async: false,
            data:{
               "nickName":nickName.value.trim()
            },
            success: function(data){
               if(data == "0"){
                  nickCheck = 0;
               }else{
                  nickCheck = 1;
               }
            },
            error: function(){
               alert('서버에러');
            }
         });

      return nickCheck;      
}

function checkPhoneNum(){
   let check = 1;
   const phoneNum = phone.value.trim();
   
   $.ajax({
      url:"/phoneNumCheck?"+parameter+"="+token,
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

}