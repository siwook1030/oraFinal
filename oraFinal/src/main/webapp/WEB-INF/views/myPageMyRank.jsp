<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="my_header.jsp"/>
     <style> 
      #change {
         margin: 50px auto;
         padding: 30px;
         text-align: center;
         color: black;
      }
   </style>

</head>

<body>
    
<section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_3.jpg');" data-stellar-background-ratio="0.5">
  <div class="overlay"></div>
  <div class="container">
    <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
      <div class="col-md-9 ftco-animate pb-0 text-center">
         <span><h1 class="mb-3 bread">마이페이지</h1></span>
         <p class="breadcrumbs">
            <span>
               <a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a>
               <a href="/myPage">정보 수정 <i class="fa fa-chevron-right"></i></a>
               <a href="/myPageSaveCourse">찜 목록 <i class="fa fa-chevron-right"></i></a>

               <a href="/myPageMyCourse">내 작성 코스<i class="fa fa-chevron-right"></i></a>
             <a href="/myPageListReview">내 작성 후기<i class="fa fa-chevron-right"></i></a>
            <a href="myPageListMeeting">내 작성 번개<i class="fa fa-chevron-right"></i></a>
            </span>
            <a href="/myPageMyRank">랭킹</a>
            </p>
      </div>
    </div>
  </div>
</section>


 <section class="ftco-section ftco-no-pb ftco-no-pt">
    <div class="container">   
           

      <div id="change">

         ${m.nickName }님의 랭크는 현재 ${m.rank_name } 입니다<br>
         <img src="rank/${r.rank_icon }" height='150px' width="150px"">
  
      </div>
    </div>
    </section> 


<jsp:include page="my_footer.jsp"/>
  </body>


</html>

       