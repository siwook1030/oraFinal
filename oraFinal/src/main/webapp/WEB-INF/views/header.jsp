<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	font-family: 'NEXON Lv1 Gothic Low OTF';
}

header * {
	margin: 0px;
	padding: 0px;
	line-height: 150%;
}

header {
	width: 1100px;
	height: 100px;
	margin: 20px auto;
}

#logo {
	float: left; 
}

#top {
	margin: 50px 0 0 0;
	font-size: 17px;
	float: right;
}

#top li {
   display: inline;
   list-style-type: none;
}

.menu{
	margin: 0 20px 0 20px;
}

#login {
	font-size: 14px;
	text-align: right;
	margin: 0 20px 0 0;
}

header a{
	text-decoration: none;
	color: black;
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
window.onload = function(){
	$(document).on("mouseover", ".menu", function(){
		$(this).css("font-style,"bold");
	});
	$(document).on("mouseleave", ".menu", function(){
		$(this).css("font-style","light");
	});
}
</script>
</head>
<body>


	<header>
		<div id="logo">
			<a href="/mainPage"><img src='/headerImg/logo.png' height="100"></a>
		</div>
		
		<div id="login">
			<c:choose>
				<c:when test="${m == null }">
					<a href="/login">로그인</a>&nbsp;&nbsp;&nbsp;<a href="/signUp">회원가입</a>
				</c:when>
				<c:when test="${m != null }">
					${m.nickName } 라이더! &nbsp;&nbsp;<a href="/logout">로그아웃</a>&nbsp;&nbsp;<a href="/myPage?id=${m.id}">마이페이지</a>
				</c:when>
			</c:choose>
		</div>
		<ul id="top">
			<li class="menu"><a href="/listNotice">오늘의 라이딩</a></li>
			<li>|</li>
			<li class="menu"><a href="/searchCourse">라이딩 코스</a></li>
			<li>|</li>
			<li class="menu"><a href="/listReview">라이딩 후기</a></li>
			<li>|</li>
			<li class="menu"><a href="/listMeeting">번개 라이딩</a></li>
			<li>|</li>
			<li class="menu">라이딩 정보</li>
		</ul>
	</header>

</body>
</html>