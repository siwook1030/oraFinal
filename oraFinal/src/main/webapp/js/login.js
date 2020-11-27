

/*** 로그인(시욱씨) 시작 */
window.onload = function(){

      document.getElementById("phone").onkeypress=enterkeysendPhoneReq;
        function enterkeysendPhoneReq(){
         if(window.event.keyCode == 13){
            sendPhoneReq();
         }
      }
        document.getElementById("inputNum").onkeypress=enterkeycheckNumReq;
        function enterkeycheckNumReq(){
         if(window.event.keyCode == 13){
            checkNumReq();
         }
      }
        document.getElementById("phonePwd").onkeypress=enterkeysendPhoneReqPwd;
        document.getElementById("IdPwd").onkeypress=enterkeysendPhoneReqPwd;
        function enterkeysendPhoneReqPwd(){
         if(window.event.keyCode == 13){
            sendPhoneReqPwd();
         }
      }
        document.getElementById("inputNumPwd").onkeypress=enterkeycheckNumReqPwd;
        function enterkeycheckNumReqPwd(){
         if(window.event.keyCode == 13){
            checkNumReqPwd();
         }
      }
		 const token = $("meta[name='_csrf']").attr("content");
		 const header = $("meta[name='_csrf_header']").attr("content");
		 const parameter = $("meta[name='_csrf_parameter']").attr("content");
		    $(document).ajaxSend(function(e, xhr, options) {
		        if(token && header) {
		            xhr.setRequestHeader(header, token);
		        }
		    });
	
	document.getElementById("member-id").onkeyup=enterkey;
	document.getElementById("member-password").onkeyup=enterkey;
	function enterkey(){
		if(window.event.keyCode == 13){
			login();
		}
	}

	document.getElementById("login-button").onclick = login;


/**
* 로그인 
*/
function login(){
	const id = document.getElementById("member-id");
	const pwd = document.getElementById("member-password");
		
	if(id.value.trim() == ''){
				alert("아이디를 입력해 주세요.");
				id.focus();
				return;
			}else if(pwd.value.trim() == ''){
				alert("패스워드를 입력해 주세요.");
				pwd.focus();
				return;
			}
	
	$.ajax({
		url:"/login?"+parameter+"="+token,
		type :  "POST",
		dataType : "json",
		data : {
			memberId :id.value.trim(),
			memberPassword : pwd.value.trim()
		},
	/*	beforeSend : function(xhr)
		{
			xhr.setRequestHeader(parameter, token);
		},*/
		success : function(response){
			if(response.code == "200"){
				alert(response.message);
				window.location = response.item.url;
		
			} else {
				alert(response.message);
			}
		},
		error : function(a,b,c){
			console.log(a,b,c);
		}
		
	})
	
}






/*** 로그인(시욱씨) 끝 */



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
	    
	    
	    
/*** 모달 현왕 모달창 실행 자바스크립트 추가 종료 */
/*** 모달 현왕 모달창 내용 자바스크립트 추가 & 암호 변경하면 비밀번호 <input type=text>에 전달 */
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
	             alert("비밀번호가 일치하지 않습니다");
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
	             $.ajax("/updatePwd?"+parameter+"="+token, {
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
	               alert("아이디를 입력하세요");
	               id.focus();
	               return;
	            }
	            if(phonePwd.value.trim() == ''){
	               alert("휴대전화를 입력하세요");
	               phonePwd.focus();
	               return;
	            }
	               if(phonePwd.value.trim() == ''){
	                  alert("휴대전화번호를 입력하세요");
	                  phonePwd.focus();
	                  return;
	               }
	               else if(phAvailCheck == false){
	                  alert("유효하지 않은 번호입니다");
	                  phonePwd.focus();
	                  return;
	               }
	               else if(checkPhoneNumPwd() == 0){
	                  alert("가입 되어있지 않은 번호입니다");
	                  phonePwd.focus();
	                  return;
	               }
	               $.ajax({
	   	                  url: "/selectMemberId?"+parameter+"="+token,
	   	                  type: "POST",
	   	               	  async: false,
	   	                  data:{
	   	                     "phone":phonePwd.value.trim()
	   	                  },
	   	                success: function(data){
		      	        	if(id.value.trim() != data.id){
								alert("가입 하신 아이디와 전화번호를 다시확인해주세요");
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
	                  url: "/smsSendMy",
	                  type: "GET",
	                  data:{
	                     "phoneNum":phonePwd.value.trim()
	                  },
	                  success: function(data){
	                     if(data == "1"){
	                        alert("인증번호가 발송되었습니다");
	                        $("#phonePwd").prop('readonly', true);
	                        $(".hiddenPhone").css({display: "inline-block"});
	                        
	                        inputNum.value="";
	                        inputNum.focus();
	                     }else{
	                        alert("인증번호 발송에 실패하였습니다");
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
	               alert("휴대전화를 입력하세요");
	               phone.focus();
	               return;
	            }
	               if(phone.value.trim() == ''){
	                  alert("휴대전화번호를 입력하세요");
	                  phone.focus();
	                  return;
	               }
	               else if(phAvailCheck == false){
	                  alert("유효하지 않은 번호입니다");
	                  phone.focus();
	                  return;
	               }
	               else if(checkPhoneNum() == 0){
	                  alert("가입 되어있지 않은 번호입니다");
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
	                        alert("인증번호가 발송되었습니다");
	                        $("#phone").prop('readonly', true);
	                        $("#IdPwd").prop('readonly', true);
	                        $(".hiddenPhone").css({display: "inline-block"});
	                        
	                        inputNum.value="";
	                        inputNum.focus();
	                     }else{
	                        alert("인증번호 발송에 실패하였습니다");
	                     }
	                  },
	                  error: function(){
	                     alert("서버에러");
	                  }
	               });
	               
	      }
	      
	      function checkNumReqPwd(){//인증번호 확인
	         
	               if(inputNumPwd.value.trim() == ''){
	                  alert("인증번호를 입력하세요");
	                  inputNumPwd.focus();
	                  return;
	               }
	               else if(inputNumPwd.value.trim().length != 6){
	                  alert("인증번호는 6자리입니다");
	                  inputNumPwd.focus();
	                  return;
	               }
	               let idR = 0;      
	               $.ajax({
	                  url: "/smsSend?"+parameter+"="+token,
	                  type: "POST",
	                  data:{
	                     "num":inputNumPwd.value.trim()
	                  },
	                  success: function(data){
	                     if(data == '1'){
		                     idR = 1;
	                        alert("인증되었습니다");
	                        $.ajax({
		      	                  url: "/selectMemberId",
		      	                  type: "POST",
		      	                  data:{
		      	                     "phone":phonePwd.value.trim()
		      	                  },
		      	                success: function(data){
			      	                $("#bb").css({display: "block"});
			      	                $("#cc").css({display: "none"});
		      	                }
		            	   });
	                       
	                        inputNumPwd.value="";
	                        $(".hiddenPhone").css({display: "none"});
	                     }else{
	                        alert("인증번호가 일치하지 않습니다");
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
	                  alert("인증번호를 입력하세요");
	                  inputNum.focus();
	                  return;
	               }
	               else if(inputNum.value.trim().length != 6){
	                  alert("인증번호는 6자리입니다");
	                  inputNum.focus();
	                  return;
	               }
	               let idR = 0;      
	               $.ajax({
	                  url: "/smsSend?"+parameter+"="+token,
	                  type: "POST",
	                  data:{
	                     "num":inputNum.value.trim()
	                  },
	                  success: function(data){
	                     if(data == '1'){
		                     idR = 1;
	                        alert("인증되었습니다");
	                        $.ajax({
		      	                  url: "/selectMemberId",
		      	                  type: "POST",
		      	                  data:{
		      	                     "phone":phone.value.trim()
		      	                  },
		      	                success: function(data){
			      	                $("#h2").html("고객님의 아이디는<br> "+data.id+"<br> 입니다");
		      	                }
		            	   });
	                       
	                        inputNum.value="";
	                        $(".hiddenPhone").css({display: "none"});
	                        $("#kakusu").css({display:"none"});
	                     }else{
	                        alert("인증번호가 일치하지 않습니다");
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
	      // $(".hidden").css({display: "none"});
	       $(".hiddenPhone").css({display: "none"});
	});
}

/*** 로그인(길모) 시작 */