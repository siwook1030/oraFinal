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
	margin: 0px;
	padding: 0px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
}

header {
	width: 1000px;
	height: 100px;
	margin: 20px auto;
}

#logo {
   float: left; 
}

li{
   list-style-type: none;  
}

#top {
	margin: 50px 0 0 0;
	font-size: 15px;
	float: right;
}

#top li {
	display: inline;
}

.menu{
	margin: 0 20px 0 20px;
}

#login {
	font-size: 13px;
	text-align: right;
	margin: 0 20px 0 0;
}

a{
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>

	<header>
		<div id="logo">
			<a href="/mainPage"><img src='headerImg/logo.png' height="100"></a>
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
			<li class="menu"><a href="listReview">라이딩 후기</a></li>
			<li>|</li>
			<li class="menu"><a href="listMeeting">번개 라이딩</a></li>
			<li>|</li>
			<li class="menu">라이딩 정보</li>
		</ul>
	</header>

</body>
</html>