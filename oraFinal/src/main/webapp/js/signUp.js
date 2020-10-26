$(function(){

	$('#sendPhone').click(function(){
		sendPhone();
	})
	
	$('#checkNum').click(function(){
		checkNum();
	})
	
	
	$('#signUp').click(function(){
		signUp();
	})				


function signUp(){
		var idAvail = /^[a-z][a-z\d]{8,12}$/;
		var pwAvail = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,12}$/;
		var nameAvail = /^[가-힣]{2,6}$/;
		var nickNameAvail = /^[가-힣a-zA-Z0-9]{2,8}$/;
		
		var idAvailCheck = idAvail.test($.trim($('#id').val()));
		var pwAvailCheck = pwAvail.test($.trim($('#password').val()));
		var nameAvailCheck = nameAvail.test($.trim($('#name').val()));
		var nickNameAvailCheck = nickNameAvail.test($.trim($('#nickName').val()));
		
		console.log(idAvailCheck);
		console.log(pwAvailCheck);
		console.log(nameAvailCheck);
		console.log(nickNameAvailCheck);

			if($.trim($('#id').val()) == ''){
				alert("ID를 입력하세요.");
				$('#id').focus();
				return;
			}
			else if(idAvailCheck == false){
				alert("ID형식이 올바르지 않습니다(8~12자 영어소문자,숫자).");
				$('#id').focus();
				return;
			}
			else if($.trim($('#password').val()) == ''){
				alert("Password를 입력하세요.");
				$('#password').focus();
				return;
			}
			else if(pwAvailCheck == false){
				alert("비밀번호 형식이 올바르지 않습니다(8~12자 영문자+숫자+특수문자1개이상).");
				$('#password').focus();
				return;
			}
			//패스워드 확인
			else if($('#password').val() != $('#passwordCheck').val()){
				alert('Password가 일치하지 않습니다.');
				$('#password').focus();
				return;
			}
			else if($.trim($('#name').val()) == ''){
				alert("이름을 입력하세요");
				$('#name').focus();
				return;
			}
			else if(nameAvailCheck == false){
				alert("이름 형식이 올바르지 않습니다(한글 2~6자).");
				$('#name').focus();
				return;
			}
			else if($.trim($('#nickName').val()) == ''){
				alert("닉네임을 입력하세요.");
				$('#nickName').focus();
				return;
			}
			else if(nickNameAvailCheck == false){
				alert("닉네임 형식이 올바르지 않습니다(한글,영문자,숫자 2~8자).");
				$('#nickName').focus();
				return;
			}
			else if($.trim($('#phone').val()) == ''){
				alert("휴대전화를 입력하세요");
				$('#phone').focus();
				return;
			}
			
			

			if(check() != 0){
				alert("중복된 아이디입니다");
				$('#id').focus();
				return;
			}
			if(checkNick() != 0){
				alert("중복된 닉네임입니다");
				$('#nickName').focus();
				return;
			}


			if($('#chekingPhone').val() == 'N'){
				alert("휴대전화를 인증해주세요.");
				$('#sendPhone').focus();
				return;
			}
			else if($('#chekedPhone').val() != $.trim($('#phone').val())){
				alert("휴대전화를 인증해주세요.");
				$('#sendPhone').focus();
				return;
			}
			else{

				signUpOk();
			}

}		

function signUpOk(){
		
		$.ajax({
				url: "/signUp",
				type: "POST",
				data: $("#signUpForm").serialize(),
				success: function(data){
					if(data == "1"){
						alert("회원가입 성공!");
						window.location = "http://localhost:8088/mainPage";
					}else{
						alert("회원가입 실패");
					}
				},
				error: function(){
					alert('서버에러');
				}
			});

}

	
function sendPhone(){
	inf = document.getElementById("inputNumForm");
	var phAvail = /^01[0179][0-9]{7,8}$/;
	var phAvailCheck = phAvail.test($.trim($('#phone').val()));	
	
			if($.trim($('#phone').val()) == ''){
				alert("휴대전화번호를 입력하세요.");
				$('#phone').focus();
				return;
			}
			else if(phAvailCheck == false){
				alert("유효하지 않은 번호입니다.");
				$('#phone').focus();
				return;
			}
			
			$.ajax({
				url: "/smsSend",
				type: "GET",
				data:{
					"phoneNum":$.trim($('#phone').val())
				},
				success: function(data){
					if(data == "1"){
						$('#chekedPhone').attr("value",$.trim($('#phone').val()));
						alert("인증번호가 발송되었습니다.");
						inf.style.visibility="visible";
						$('#inputNum').val('');
						$('#inputNum').focus();
					}else{
						alert("인증번호 발송에 실패하였습니다.");
					}
				},
				error: function(){
					alert("서버에러");
				}
			});
			
}

function checkNum(){
	 inf = document.getElementById("inputNumForm");
	
			if($.trim($('#inputNum').val()) == ''){
				alert("인증번호를 입력하세요.");
				$('#inputNum').focus();
				return;
			}
			else if($.trim($('#inputNum').val()).length != 6){
				alert("인증번호는 6자리입니다.");
				$('#inputNum').focus();
				return;
			}
					
			$.ajax({
				url: "/smsSend",
				type: "POST",
				data:{
					"num":$.trim($('#inputNum').val())
				},
				success: function(data){
					if(data == '1'){
						alert("인증되었습니다.");
						$('#chekingPhone').attr("value","Y");
						$('#inputNum').val('');
						inf.style.visibility="hidden";
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
		var idCheckNum = 1;
			 $.ajax({
				url: "/idCheck",
				async: false,
				type: "POST",
				data:{
					"id":$.trim($('#id').val())
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
		var nickCheck = 1;
			$.ajax({
				url: "/nickCheck",
				type: "POST",
				async: false,
				data:{
					"nickName":$.trim($('#nickName').val())
				},
				success: function(data){
					if(data == 0){
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

})