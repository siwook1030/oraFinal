<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
   <meta charset="UTF-8">
   <title>마이페이지-찜코스</title>
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
     li {
         float: center;
       }
      li a {
         display: block;
         background-color: #ffffff;
         color: gray;
         padding: 15px;
         float: left;
         width: 100px;
         text-align: center;
         text-decoration: none;
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
        <!-- 찜 코스 컨테이너--!>
          #container{
             columns-width:900px;
             columns-gap: 15px;
             background-color: #ffffff;
             color: inherit;
           }
         #tab{
            float:center;
            border:1px solid black;
            width:900px;
            height:50px;
         }
         #container figure{
              display: inline-block;
              border:1px solid rgba(0,0,0,0.2);
              margin-top:20px;
              margin-left:20px;
              margin-bottom: 15px;
              padding:10px;
              box-shadow: 2px 2px 5px rgba(0,0,0,0.5);
            }
            #container figure img{
              width:300px;
              height: 200px;
              text-align: center;
            }
            #container figure figcaption{
              border-top:1px solid rgba(0,0,0,0.2);
              padding:5px;
              margin-top:11px;
            }
   </style>

</head>

<body>
	<jsp:include page="header.jsp"/>
   <ul>
     <h1>마이페이지</h1>
            <li><a  href="/myPage">정보 수정</a></li>
            <li><a  href="/myPageSaveCourse">찜 목록</a></li>
            <li><a class="current" href="/myPageMyCourse">작성 코스(준비중)</a></li>
            <li><a href="/myPageListReview">작성 후기</a></li>
            <li><a href="myPageListMeeting">작성 번개</a></li>
 	        <li><a href="/myPageMyRank">랭킹</a></li>
      </ul>
<ul>
  <h1>찜코스목록</h1>
   여기에 샬롸샬롸
         <div id="container">
           <figure>
             <img src="https://mblogthumb-phinf.pstatic.net/20160331_158/dgdonggu_14594173450858FAJx_PNG/_%B5%BF%B1%B8%C3%BB%C5%B8%C0%CC%C6%B2__%B1%DD%C8%A3%B0%AD_%C0%DA%C0%FC%B0%C5%B1%E6_png.png?type=w2">

           <figcaption>코스이름 및 설명 </figcaption>
           <c:forEach var="vo" items="${list }">
           <option value="${vo.c_no }">난이도</option>
         </c:forEach>

         <!-- <img src=img/"> -->
         <!-- <figcaption>    </figcaption> -->
       </figure>

       <figure>
         <img src="https://mblogthumb-phinf.pstatic.net/20160331_75/dgdonggu_1459413365516NR83g_JPEG/IMG_0020.JPG?type=w2">
        <figcaption>코스이름 및 설명 </figcaption>
       <c:forEach var="vo" items="${list }">
       <option value="${vo.c_no }">난이도</option>
       </c:forEach>

       <!-- <img src=img/"> -->
       <!-- <figcaption>    </figcaption> -->
      </figure>
           <figure>
             <!-- <img src="img/${vo.cp_path }"> -->
             <c:forEach var="vo" items="${list }">
                         <!-- <img src="img/${vo.cp_path }"> -->
             <option value="${vo.cp_name }">코스사진</option>
           </c:forEach>

           <figcaption>코스이름 및 설명 </figcaption>
           <c:forEach var="vo" items="${list }">
           <option value="${vo.c_no }">난이도</option>
         </c:forEach>

         <!-- <img src=img/"> -->
         <!-- <figcaption>    </figcaption> -->
       </figure>

       <figure>
         <!-- <img src="img/${vo.cp_path }"> -->
         <c:forEach var="vo" items="${list }">
                     <!-- <img src="img/${vo.cp_path }"> -->
         <option value="${vo.cp_name }">코스사진</option>
       </c:forEach>

       <figcaption>코스이름 및 설명 </figcaption>
       <c:forEach var="vo" items="${list }">
       <option value="${vo.c_no }">난이도</option>
       </c:forEach>

       <!-- <img src=img/"> -->
       <!-- <figcaption>    </figcaption> -->
      </figure>
           <figure>
             <!-- <img src="img/${vo.cp_path }"> -->
             <c:forEach var="vo" items="${list }">
                         <!-- <img src="img/${vo.cp_path }"> -->
             <option value="${vo.cp_name }">코스사진</option>
           </c:forEach>

           <figcaption>코스이름 및 설명 </figcaption>
           <c:forEach var="vo" items="${list }">
           <option value="${vo.c_no }">난이도</option>
         </c:forEach>

         <!-- <img src=img/"> -->
         <!-- <figcaption>    </figcaption> -->
       </figure>

       <figure>
         <!-- <img src="img/${vo.cp_path }"> -->
         <c:forEach var="vo" items="${list }">
                     <!-- <img src="img/${vo.cp_path }"> -->
         <option value="${vo.cp_name }">코스사진</option>
       </c:forEach>

       <figcaption>코스이름 및 설명 </figcaption>
       <c:forEach var="vo" items="${list }">
       <option value="${vo.c_no }">난이도</option>
       </c:forEach>

       <!-- <img src=img/"> -->
       <!-- <figcaption>    </figcaption> -->
      </figure>
     </div>


</ul>
</body>

</html>