
  $(function(){
  			const token = $("meta[name='_csrf']").attr("content");
		    const header = $("meta[name='_csrf_header']").attr("content");
		    const parameter = $("meta[name='_csrf_parameter']").attr("content");
		    $(document).ajaxSend(function(e, xhr, options) {
		        if(token && header) {
		            xhr.setRequestHeader(header, token);
		        }
		    });
  
	  const nickName = document.getElementById("nickName");      
      const phone = document.getElementById("phone");
      const sendPhone = document.getElementById("sendPhone");
      const checkNum = document.getElementById("checkNum");
      const inputNum = document.getElementById("inputNum");
      const inf = document.getElementById("inputNumForm");

      sendPhone.onclick=sendPhoneReq;   
      checkNum.onclick=checkNumReq;   

      
      // 닉네임 중복버튼

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
                  url: "/smsSendMy",
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
                  url: "/smsSend?"+parameter+"="+token,
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

      $(".hidden").css({display: "none"});
      $(".hiddenPhone").css({display: "none"});
      $("#btnUpdate").click(function() {
          $("#btnUpdate2").attr("i", "1");
          let data = $("#pwd").val();
          console.log(data);
          $.ajax({
         url:"/passwordConfirm?"+parameter+"="+token,
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

    	   const nickNameAvail = /^[가-힣a-zA-Z0-9]{2,8}$/;
           const nickNameAvailCheck = nickNameAvail.test(nickName.value.trim());

           if(nickName.value.trim() != '')
                 if(nickNameAvailCheck == false){
                    alert("닉네임 형식이 올바르지 않습니다(한글,영문자,숫자 2~8자).");
                    nickName.focus();
                    return;
                 }


              if(checkNick() != 0){
                 alert("중복된 닉네임입니다");
                 nickName.focus();
                 return;
              }
              
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
            $.ajax("/update?"+parameter+"="+token, {data:data,type: "POST",success:function(re){         
               alert("회원 정보가 수정되었습니다");         
               window.location.reload();
            }});      
         }
       });
   });