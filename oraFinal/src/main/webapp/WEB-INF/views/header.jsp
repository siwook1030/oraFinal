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
li {
	list-style-type: none;
}
a {
	text-decoration: none;
	color: black;
}
header {
	width: 1000px;
    height: 100px;
	margin-top: 10px;
	margin: 10px auto;
}
#logo {
	float: left; 
}
#top {
	margin: 30px 20px 0 0;
	font-size: 12px;
	float: right;
	text-align: right;   
}
#top li {
	display: inline;
	margin-left: 18px;
}
#login {
	font-size: 11px;
	text-align: right;
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
	      		<a href="modify">${m.nickName } 라이더!</a> &nbsp;&nbsp;<a href="/logout">로그아웃</a>&nbsp;&nbsp;
	      	</c:when>
      	</c:choose>
      </div>
      <ul id="top">
      	<li>오늘의 라이딩</li>
      	<li>자전거 길</li>
      	<li><a href="listReview">후기게시판</a></li>
      	<li><a href="listMeeting">번개게시판</a></li>
      	<li>정보게시판</li>
      </ul>
   </header>
</body>
</html>