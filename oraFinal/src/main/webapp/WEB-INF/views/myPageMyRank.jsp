<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-내랭크</title>


<style>
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
         float: left;
         width: 100px;
         text-align: center;
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
      section{
         margin: 100px; //메뉴 위치
         padding: 50px;
      }
</style>
</head>
<body>
	
  <ul id="mytab">
   <h1>마이페이지</h1>
            <li><a href="/myPage">정보 수정</a></li>
            <li><a href="/myPageSaveCourse">나의 찜코스</a></li>
            <li><a href="/myPageMyCourse">내가만든 코스</a></li>
            <li><a href="/myPageListReview">나의 라이딩 후기</a></li>
            <li><a href="/myPageListMeeting">나의 번개라이딩</a></li>
 	        <li><a class="current" href="/myPageMyRank">랭킹</a></li>
      </ul>
  <ul>
		${m.nickName }님의 랭크는 현재 ${m.rank_name } 입니다<br>
		<img src="rank/${r.rank_icon }" height='150px' width="150px"">
</ul>
<jsp:include page="footer.jsp"/>
</body>
</html>
