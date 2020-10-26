<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}
header {
	width: 1000px;
	height: 100px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
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

/* 헤더 끝 -------------------------------------------------- */

h2 {
	padding: 20px;
	width: 120px;
	margin: 40px auto;
	color: #88bea6;
	text-align: center;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	text-decoration: none;
}

a{
	text-decoration: none;
	color: black;
}

#contents {
	width: 900px;
	height: 700px;
	margin: 20px auto;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 15px;
}

table, th, td {
	border: solid 1px #fff2e4;
	border-collapse: collapse;
}

th {
	padding: 6px;
	text-align: center;
	background-color: #fff2e4;
}

td {
	padding: 6px;
	text-align: center;
}

p {
	padding: 10px;
}


/* 푸터 시작 -------------------------------------------------- */

footer {
	margin: 30px auto;
	width: 100%;
	height: 150px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
}
#footer_box {
	width: 1140px;
	height: 150px;
	margin: 0 auto;
	text-align: center;    
}
#footer_icon{
	margin: 0 auto;
}
#address {
	margin: 10px 0 0 0;
	font-size: 11px;
	list-style-type: none;
}

   /*float 초기화 아이디*/
#clear{
	clear: both; 
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
			<li class="menu">오늘의 라이딩</li>
			<li>|</li>
			<li class="menu">자전거 길</li>
			<li>|</li>
			<li class="menu"><a href="listReview">후기게시판</a></li>
			<li>|</li>
			<li class="menu"><a href="listMeeting">번개게시판</a></li>
			<li>|</li>
			<li class="menu">정보게시판</li>
		</ul>
	</header>
   
	<a href="listNotice"><h2>공지사항</h2></a>
	<section id="contents">
			<table border="1" width="100%">
		      <tr>
		         <th>${n.code_name }</th>
		         <th>${n.n_title }</th>
		         <th>${n.n_regdate }</th>
		         <th>${n.n_hit }</th>
		      </tr>
		    </table> 

			<br>
			<p>${n.n_content }</p><br>
		</section>
	<br>
	<footer>
		<div id='footer_box'>
			<div id="footer_icon" >
				<img src='/footerImg/instagram.png' height="50px">
	            <img src='/footerImg/facebook.png' height="50px">
	            <img src='/footerImg/twitter.png' height="50px">
				<ul id="address">
					<li>04108 | 서울시 마포구 백범로 23 구프라자 3층</li>
					<li>TEL: 02-707-1480 | Email: ora@bit.com</li>
					<li>COPYRIGHT (C)2020 오늘의 라이딩 ALL RIGHTS RESERVED</li>
               </ul>
			</div>
		</div>
	</footer>
</body>
</html>