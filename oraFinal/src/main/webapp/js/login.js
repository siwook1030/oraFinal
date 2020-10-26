$(function(){
	$("#member-id,#member-password").keydown(function(key) {
		if (key.keyCode == 13) {
			login();
		}
});

	$("#login-button").click(function(){
		login();
	});		

/**
* 로그인 
*/
function login(){
	if($.trim($("#member-id").val()) == ''){
				alert("아이디를 입력해 주세요.");
				$("#member-id").focus();
				return;
			}else if($.trim($("#member-password").val()) == ''){
				alert("패스워드를 입력해 주세요.");
				$("#member-password").focus();
				return;
			}
	
	$.ajax({
		url:"/login",
		type :  "POST",
		dataType : "json",
		data : {
			memberId :$.trim($("#member-id").val()),
			memberPassword : $.trim($("#member-password").val())
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

})