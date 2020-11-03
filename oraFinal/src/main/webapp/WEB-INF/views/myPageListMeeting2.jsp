<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
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
			margin-top: 100px;
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
		table {
			border-collapse: collapse;
			text-align: center;
		}
		#pageStr {
			text-align: center;
			margin: 30px 0 70px;
		}
		td, th {
			border-bottom: 1px #7a7a7a solid;
			padding: 4px 0 4px;
		}
	</style>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("table > #tr").hover(function(){
				$(this).css("text-decoration","underline");
			},function(){
				$(this).css("text-decoration","none");
			});
		});
	</script>
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
      	<li><a href="/listReview">후기게시판</a></li>
      	<li><a href="/listMeeting">번개게시판</a></li>
      	<li>정보게시판</li>
      </ul>
   </header>
   <section>
   		<br>
		<a href="/listMeeting?pageNo=1"><p style="font-size: 20px">번개 게시판</p></a>
		<p style="font-size: 15px">만나서 같이 라이딩 해요.</p>
		<br><br><br>
		<hr style="height: 10%; color: black;">
		<br>
		<table width="100%">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
				 <th>코스</th>
				 <th>모임날짜</th>
				 <th>제목</th>
				 <th>작성자</th>
				 <th>작성시간</th>
				 <th>조회</th>
			</tr>
				<c:forEach var="mt" items="${list }">	
					<tr id="tr">
						<td>${mt.m_no }</td>
						<td>${mt.c_name }</td>
						<td>${mt.m_time }</td>
						<td>
							<a href="detailMeeting?m_no=${mt.m_no }">
							${mt.m_title }</a>
						</td>
						<td>
							<img src="rank/${mt.rank_icon }" height='20px'">
							${mt.nickName }
						</td>
						<td>${mt.m_regdate }</td>
						<td>${mt.m_hit }</td>
					</tr>
				</c:forEach>
			
		</table>
		<br>
		<a href="/insertMeeting"><img src="meetingImg/insert.png" height="30px" align="right"></a><br><br>
		<div id="pageStr">${pageStr }</div>
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