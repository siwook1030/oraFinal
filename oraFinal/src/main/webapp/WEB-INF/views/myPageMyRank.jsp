<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

   <title>내 랭킹</title>
	    
<!-- 마이페이지 tab 시작-->
     <style>
 	  #mytab_1 { //메뉴 스타일
         box-pack:center;
                        justify-content: center; // 창에따라 사이즈 달라짐
         background-color: #ffffff;
         list-style-type: none;
         margin: 50px auto; //메뉴 위치
         padding: 50px;
         overflow: hidden;
      }
      #mytab { float: center; }
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
                    
   </style>
 <!-- 마이페이지 tab 끝-->
 
 <!-- 컨테이너 시작-->
   <style type="text/css">
		/* 공통 */
		section {
			margin: 0 auto;
			width: 1000px;
			text-align: left;
		}
		
		/* 개별 */
		#change {
			margin: 50px auto;
			padding: 30px;
			text-align: center;
			color: black;
		}
	</style>
 <!-- 컨테이너 끝-->
    <style>
      input, button { font-family: inherit; font-size: inherit; }
    </style>
   
</head>
<body>

  <ul id="mytab_1">
   <h1>마이페이지</h1>
            <li><a id="mytab" href="/myPage">정보 수정</a></li>
            <li><a id="mytab" href="/myPageSaveCourse">찜 목록</a></li>
            <li><a id="mytab" href="/myPageMyCourse">작성 코스(준비중)</a></li>
            <li><a id="mytab" href="/myPageListReview">작성 후기</a></li>
            <li><a id="mytab" href="myPageListMeeting">작성 번개</a></li>
 	        <li><a class="current" href="/myPageMyRank">랭킹</a></li>
      </ul>
  <ul>
  
  
	<section>
		<div id="change">

		${m.nickName }님의 랭크는 현재 ${m.rank_name } 입니다<br>
		<img src="rank/${r.rank_icon }" height='150px' width="150px"">
  
		</div>
	</section>

</ul>


>>>>>>> branch '김미진' of https://github.com/siwook1030/oraFinal.git
<jsp:include page="footer.jsp"/>
</body>
</html>

