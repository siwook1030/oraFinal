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

#box{
  margin: 30px 10px 0 0;
  width: 400px;
  height: 30px;
}

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
	margin: 50px auto;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	float: center;
}

#btn_search,#btn_write{
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
    margin: 0px;
    cursor: pointer;
}

#btn_write{
	float: right;
}

button:hover {
	border: none;
    background-color: #ffffff;
    color: #c8572d;
}

select {
	font-size: 12px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	height: 30px;
	width: 70px;
}

#container input#search{
	height: 30px;
	border: solid 1px;
	font-size: 11pt;
	color: #63717f;
	padding-left: 15px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

#tb{
	height: 600px;
}

table, th, td {
	margin-top: 30PX;
	border: solid 1px #fff2e4;
	border-collapse: collapse;
	font-size: 15px;
	color: black;
	text-decoration: none;
}

th {
	padding: 6px;
	text-align: center;
	background-color: #fff2e4;
	height: 20px;
}

td {
	padding: 6px;
	text-align: center;
	height: 20px;
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
		<div id="box">
			<div id="container">

		     	<select name="code_value" size="1">
		     		<option value="0">전체</option>
		     		<c:forEach var="c" items="${category }">
		     			<option value="${c.code_value }">${c.code_name }</option>
		     		</c:forEach>
		        </select>
					<input type="search" id="search" placeholder="Search..." />
					<button id="btn_search">검색</button>

			</div>

		</div>
		
		<div id="tb">
			<table border="1" width="100%">
				<tr>
					<th>카테고리</th>
					<th>제목</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
				<c:forEach var="n" items="${list }">
				<tr>
					<td>${n.code_name }</td>
					<td>
						<a href="detailNotice?n_no=${n.n_no }">${n.n_title }</a>
					</td>
					<td>${n.n_regdate }</td>
					<td>${n.n_hit }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<a href="/insertNotice"><button id="btn_write" type="button">글쓰기</button></a><br>
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