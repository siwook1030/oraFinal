function checkLogin(){
	let check;
		$.ajax({
			url: "/checkLogin",
			type: "POST",
			async: false,
			success: function(response){
				check =  response;
			},
			error: function(){
				alert("에러발생");
			}
		})
	return check;
	}
