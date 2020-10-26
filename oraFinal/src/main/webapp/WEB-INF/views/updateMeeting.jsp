<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	header {
      width: 1000px;
      height: 100px;
      margin-top: 10px;
      font-family: 'NEXON Lv1 Gothic Low OTF';
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
   #login {
      font-size: 11px;
      text-align: right;
   }
   table {
   	
   }
   footer {
       width: 1000px;
       height: 150px;
       margin-top: 30px;
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
    #address {
       margin: 10px 0 0 0;
       font-size: 11px;
    }
    li {
    	list-style-type: none;
    }
	* {
   		padding : 0px;
   		margin : 0px;
   		font-family: 'NEXON Lv1 Gothic Low OTF';
	}
	a {
		text-decoration: none;
		color: black;
	}
	table {
		border-collapse: collapse;
		text-align: center;
	}
	.pageStr{
		text-align: center;
	}
	section {
		padding: 30px;
	}
	
</style>
</head>
<body>
	<header>
		<div id="logo">
			<img src='headerImg/logo.png' height="100">
		</div>
	    <nav>
		    <div id="login">
				<c:choose>
					<c:when test="${m == null }">
			      		<a href="/login">로그인</a>&nbsp;&nbsp;&nbsp;<a href="/signUp">회원가입</a>
			      	</c:when>
			      	<c:when test="${m != null }">
			      		<a href="modify">${m.nickname } 라이더!</a> &nbsp;&nbsp;<a href="/logout">로그아웃</a>
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
		</nav>
	</header>
   
   <section>
   <br>
	<h2>게시글 수정</h2>
	<br><br>
	<form action="updateMeetingOk.do" method="post">
	글번호 : ${m.m_no }<br>
	<input type="hidden" name="m_no" value="${m.m_no }">
	코스번호 : <input type="number" name="c_no" value="${m.c_no }"><br>
	작성자 : ${m.nick_name }
	<input type="hidden" name="id" value="${m.id }"><br>
	제목 : <input type="text" name="m_title" value="${m.m_title }"><br>
	내용 : <br>
	<textarea rows="10" cols="60" name="m_content">${m.m_content }</textarea><br>
	<input type="file" name="mf_name" value="${mf.mf_name }"><br><br>
	<input type="submit" value="등록">
	<input type="reset" value="취소">
</form>
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