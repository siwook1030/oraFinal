$(function(){
	$("#insert").click(function(){
		insert();
	})		
})

/**
* 게시판 등록 
*/
function insert(){
	if($.trim($("#title").val()) == ''){
				alert("제목을 입력해 주세요.");
				$("#title").focus();
				return;
			}else if($("#content").val() == ''){
				alert("내용을 입력해 주세요.");
				$("#content").focus();
				return;
			}
			else{
				$('#freeForm').submit();
			}
	
}