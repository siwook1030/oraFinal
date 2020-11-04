<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
   <meta charset="UTF-8">
   <title>마이페이지-정보수정</title>
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
      <!-- 회원정보-->
              #myinfo {
                padding-left: 800px;
                display: table;
                padding: 100px;
                width: 300px;
              .row {

              }
              .display: table-row;
              }
              .cell {
                display: table-cell;
                padding: 20px;
                border-bottom: 1px solid #DDD;
              }
              .col1 {
                background-color:#F2F2F2;
                text-align: center;
                width: 100px;
              }
              .col2 {
                padding-left: 20px;
                width: 300px;
              }



   </style>

</head>

<body>

   <ul id="mytab">
   <h1>마이페이지</h1>
            <li><a class="current" href="/myPage">정보 수정</a></li>
            <li><a href="/myPageSaveCourse">찜 목록</a></li>
            <li><a href="/myPageMyCourse">작성 코스(준비중)</a></li>
            <li><a href="/myPageListReview">작성 후기</a></li>
            <li><a href="myPageListMeeting">작성 번개</a></li>
 	        <li><a href="/myPageMyRank">랭킹</a></li>
      </ul>
<ul>
  <h1>정보수정</h1>

     <!--회원정보-->

         <div id="myinfo">
           <div class="row">
             <span class="cell col1">아이디</span>
             <span class="cell col2">${m.id}</span>
           </div>
           <div class="row">
             <span class="cell col1">비밀번호</span>
             <span class="cell col2">
             <input type="password" id="password"/></span>
           </div>
           <div class="row">
             <span class="cell col1">이름</span>
             <span class="cell col2">${m.name }</span>
           </div>
           <div class="row">
             <span class="cell col1">닉네임</span>
             <span class="cell col2">
             <input type="text" id="nickname"  placeholder="${m.nickName}"/></span>
           </div>
           <div class="row">
             <span class="cell col1">전화번호</span>
             <span class="cell col2">
             <input type="text" id="phone"  placeholder="${m.phone }"/></span>
           </div>
           <div class="row">
             <span class="cell col1">성별</span>
             <span class="cell col2">${m.gender }</span>
           </div>
           <div class="row">
             <span class="cell col1">회원등급</span>
             <span class="cell col2">${m.rank_name }</span>
           </div>
           <div class="row">
             <span class="cell col1">가입일</span>
             <span class="cell col2">${m.regdate }</span>
           </div>
         </div>

</ul>

	<jsp:include page="footer.jsp"/>

</body>

</html>
