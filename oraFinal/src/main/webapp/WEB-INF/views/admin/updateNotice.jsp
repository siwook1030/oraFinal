<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">


h2 {
	padding: 20px;
	width: 120px;
	margin: 40px auto;
	color: #c8572d;
	text-align: center;
	text-decoration: none;
}

section {
	width: 900px;
	height: 700px;
	margin: 20px auto;
	font-size: 14pt;
	margin-top: 50px;
	margin-bottom: 100px;
}

#title{
	width: 700px;
	height: 30px;
	font-size: 15px;
	padding-left: 5px;
	margin-left: 5px;
}

select {
	width:100px;
	height: 30px;
	font-size: 13pt;
}

#content{
	font-size: 13pt;
	padding: 8px;
}

#btnCancel,#btnInsert {
	width:50px;
	height: 30px;
    border: none;
    border-radius:5px;
    background-color: #eccb6a;
    color:#ffffff;
    padding: 5px 0;
    font: bold;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 13px;
    margin: 0 5px 0 0;
    cursor: pointer;
    float: right;
}

#btnInsert{
	background-color: #88bea6;
}


   /*float 초기화 아이디*/
#clear{
	clear: both; 
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
window.onload = function(){
	const nTitle = document.getElementById("title");
	const nContent = document.getElementById("content");

	const btnInsert = document.getElementById("btnUpdate");
	
	btnInsert.addEventListener("click", function(e) {
		if(nTitle.value.trim() === ""){
			alert("제목을 입력해야 될 거 아니야~!");
			return;
		}
		if(nContent.value.trim() === ""){
			alert("내용도 입력안하고 등록할거야~~?!");
			return;
		}
		
		$.ajax({
			url: "/admin/updateNotice",
			type: "POST",
			data: $("#form").serialize(),
			success: function(response){
				if(response.code == "200"){
					alert(response.message);
					window.location = "/listNotice";
				}
				else{
					alert(response.message);
				}
			},
			error: function(){
				alert("에러발생");
			}
		})
	});
}
	
</script>
</head>
<body>
	<jsp:include page="../header.jsp"/>
   
	<a href="listNotice"><h2>공지사항</h2></a>
	<section>
		<form id="form">
			<select name="code_value" size="1">
	     		<c:forEach var="c" items="${category}">
	     			<option value="${c.code_value }">${c.code_name }</option>
	     		</c:forEach>
	        </select>
	        <br>
			<br>
			<input type="hidden" name="n_no" value="${n.n_no }">
			글 제목  <input type="text" name="n_title" id="title" placeholder="제목을 입력하세요" value="${n.n_title }">
			<br>
			<br>
			<textarea rows="20" cols="95" name="n_content" id="content" placeholder="내용을 입력하세요">${n.n_content }</textarea>
			<br>
			<br>
		</form>
		<button type="button" id="btnCancel">취소</button>
		<button type="button" id="btnUpdate">수정</button>	
	</section>	
	<br>
	<jsp:include page="../footer.jsp"/>
</body>
</html>