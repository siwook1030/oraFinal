<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
		/* 공통 */
		* {
	   		padding : 0px;
	   		margin : 0px;
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
		#address {
			margin: 10px 0 0 0;
			font-size: 11px;
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
		section {
			margin: 0 auto;
			width: 1000px;
			text-align: left;
		}
		footer {
			width: 1000px;
			height: 150px;
			margin-top: 30px;
			margin: 10px auto;
		}
		#footer_box {
	       width: 1000px;
	       height: 150px;
	       margin: 0 auto;
	       text-align: center;
		}
		#footer_icon{
			margin: 0 auto;
		}
		
		/* 개별 */
		#error {
			width: 400px;
			height: 150px;
			margin: 200px auto;
			padding: 30px;
			text-align: center;
			color: white;
			background-color: #88bea6;
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
         	<c:when test="${id == null }">
	      		<a href="/login">로그인</a>&nbsp;&nbsp;&nbsp;<a href="/signUp">회원가입</a>
	      	</c:when>
	      	<c:when test="${id != null }">
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
	<section>
		<div id="error">
			<h3 style="margin-bottom: 5px;">* error *</h3>
			<hr style="width: 350; border-top: 1px solid white; margin: auto; background-color: transparent;"><br><br>
			
			<p>이용에 불편을 드려 죄송합니다.</p>
			<p>${msg }</p>
		</div>
	</section>
	<footer>
		<hr style="width: 100%; color: gray;">
		<br>
		<div id='footer_box'>
            <div id="footer_icon" >
               <img src='footerImg/instagram.png' height="50px">
               <img src='footerImg/facebook.png' height="50px">
               <img src='footerImg/twitter.png' height="50px">
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