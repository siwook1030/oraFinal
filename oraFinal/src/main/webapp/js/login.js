window.onload = function(){
	
	
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
		url:"/login",
		type :  "POST",
		dataType : "json",
		data : {
			memberId :id.value.trim(),
			memberPassword : pwd.value.trim()
		},
		/*beforeSend : function(xhr)
		{
			//이거 안하면 403 error
			//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
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

}