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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
		$(function(){
	
			
			$("#btnUpdate").click(function() {
				$(".updateMember").css({visibility: "visible"});
				$("#btnUpdate").css({visibility: "hidden"});
				$("#btnUpdate2").css({visibility: "visible"});
			});
			$("#btnUpdate2").click(function() {
				var data =$("#update").serialize();
				$.ajax("/update", {data:data,type: "POST",success:function(re){			
					alert("회원 정보가 수정되었습니다"+re);			
					window.location.reload();
				}});
				
			});
		});
	</script>	
</head>
<body>


 <jsp:include page="header.jsp"/>


   <ul>
            <li><a class="current" href="/myPage">정보수정</a></li>
            <li><a href='/myPageMyCourse'>찜목록</a></li>
            <li><a href="/myPageSaveCourse">내코스</a></li>
            <li><a href="/myPageListReview">내가쓴 후기</a></li>
            <li><a href="/myPageListMeeting2">내가쓴 미팅</a></li>
            <li><a href="/myPageMyRank">랭킹</a></li>

      </ul>
<button id="btnUpdate">수정</button>
<button id="btnUpdate2" style="visibility: hidden">수정</button>
</div>

<jsp:include page="footer.jsp"/>

</body>

</html>
