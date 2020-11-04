<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-작성한 번개글</title>

<style type="text/css">
  ul { //메뉴 스타일
         box-pack:center;
                        justify-content: center; // 창에따라 사이즈 달라짐
         background-color: #ffffff;
         list-style-type: none;
         margin: 50px; //메뉴 위치
         padding: 50px;
         overflow: hidden;
      }
      li { float: center; }
      li a {
         display: block;
         background-color: #ffffff;
         color: gray;
         padding: 15px;
         float: left; // 수평으로만들기 (지우면 세로로됨)
         width: 100px;
         text-decoration: none;
         text-align: center;
         font-weight: bold;
      }
      li a.current {
         color: black;
         background-color: #FF6347; //주황색 클릭

      }
      li a:hover:not(.current) {
         background-color: #CD853F; //갈색 마우스위로
         color: white;
      }

		<!-- 후기게시판 테이블-->
		section {
			margin: 0 auto;
			width: 700px;
			text-align: left;
		}
		table {
			border-collapse: collapse;
			text-align: center;
			width: 800px;
		}
		.pageStr {
			text-align: center;
		}
		td, th {
			border-bottom: 1px #7a7a7a solid;
		}
</style>
</head>
<body>

<nav>
  <ul>
   <h1>마이페이지</h1>
            <li><a  href="/myPage">정보 수정</a></li>
            <li><a href="/myPageSaveCourse">찜 목록</a></li>
            <li><a href="/myPageMyCourse">작성 코스(준비중)</a></li>
            <li><a  href="/myPageListReview">작성 후기</a></li>
            <li><a class="current" href="myPageListMeeting">작성 번개</a></li>
 	        <li><a href="/myPageMyRank">랭킹</a></li>
   </ul>
</nav>
<ul>

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
		<div id="pageStr">${pageStr }</div>
</ul>	
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