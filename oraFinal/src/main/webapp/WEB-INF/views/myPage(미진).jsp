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
             	<h4>이름</h4>
					<div class="form-group">
						<input type="text" class="form-control text-muted" disabled="disabled" value="${m.name} "  />
					</div>
				<h4>닉네임</h4>
					<div class="form-group">
						<input type="text" class="form-control text-muted" placeholder="${m.nickName}" />
					</div>
				<h4>새 비밀번호</h4>
					<div class="form-group">
						<input type="password" class="form-control text-muted" placeholder="새 비밀번호를 입력하세요" />
					</div>
				<h4>새 비밀번호 확인</h4>
					<div class="form-group">
						<input type="password" class="form-control text-muted" placeholder="새 비밀번호를 다시 입력하세요" />				</div>
             	<h4>성별</h4>
					<div class="form-group">
						<input type="text" class="form-control text-muted" disabled="disabled" value="${m.gender }"  />
					</div>
             	<h4>회원등급</h4>
					<div class="form-group">
						<input type="text" class="form-control text-muted" disabled="disabled" value="${m.rank_name }"  />
					</div>
             	<h4>가입일</h4>
					<div class="form-group">
						<input type="text" class="form-control text-muted" disabled="disabled" value="${m.regdate }"  />
					</div>


           </div>
</ul>

	<jsp:include page="footer.jsp"/>

</body>

</html>