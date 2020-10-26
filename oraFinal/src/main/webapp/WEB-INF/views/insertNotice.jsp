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

section {
	width: 900px;
	height: 700px;
	margin: 20px auto;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 14pt;
	margin-top: 50px;
	margin-bottom: 100px;
}

#title{
	width: 700px;
	height: 30px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 15px;
	padding-left: 5px;
	margin-left: 5px;
}

select {
	width:70px;
	height: 30px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 13pt;
}

#content{
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 13pt;
	padding: 8px;
}

button,#btn_insert {
	width:50px;
	height: 30px;
    background-color: #c8572d;
    border: none;
    border-radius:5px;
    color:#ffffff;
    padding: 5px 0;
    font-family: 'NEXON Lv1 Gothic Low OTF';
    font: bold;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 13px;
    margin: 0 5px 0 0;
    cursor: pointer;
    float: right;
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
	<section>
		<form action="insertNotice" method="post">
			<select name="code_value" size="1">
	     		<option value="0">전체</option>
	     		<c:forEach var="c" items="${category }">
	     			<option value="${c.code_value }">${c.code_name }</option>
	     		</c:forEach>
	        </select>
	        <br>
			<br>
			<input type="hidden" name="n_no" value="${n_no }">
			글 제목  <input type="text" name="n_title" id="title" placeholder="제목을 입력하세요" >
			<br>
			<br>
			<textarea rows="20" cols="95" name="n_content" id="content" placeholder="내용을 입력하세요"></textarea>
			<br>
			<br>
			<button>취소</button>
			<button id="btn_insert">등록</button>
			
		</form>
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