<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <li><a href="/myPage">정보수정</a></li>
            <li><a class="current" href='/myPageMyCourse'>찜목록</a></li>
            <li><a href="/myPageSaveCourse">내코스</a></li>
            <li><a href="/myPageListReview">내가쓴 후기</a></li>
            <li><a href="/myPageListMeeting2">내가쓴 미팅</a></li>
            <li><a href="/myPageMyRank">랭킹</a></li>

      </ul>
<ul>
  <h1>찜코스목록</h1>
         <div id="container">
           <figure>
             <img src="${c.c_photo }">
           <figcaption>             ${courseList }			 ${c.c_no }			코스 뭐야:  ${cp.cp_name } </figcaption>
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
     </div>


</ul>
</body>

</html>
