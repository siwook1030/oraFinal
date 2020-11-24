<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <title>내 작성 코스</title>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/js/myPageMyCourse.js"></script></head>

<style>
#login {
	font-size: 14px;
	text-align: right;
}

.my{
	padding: 5px;
	margin: 2px;

	
}

  .my-link_2 {
    font-size: 12px;
    font-family: "나눔스퀘어라운드";
    padding-top: .1rem;
    padding-bottom: .1rem;
    padding-left: 1px;
    padding-right: 1px;
    color: #fff;
    font-weight: 400;
    opacity: 1 !important; }

  .my-link {
    font-size: 18px;
    font-family: "나눔스퀘어라운드";
    padding-top: .7rem;
    padding-bottom: .7rem;
    padding-left: 20px;
    padding-right: 20px;
    color: #fff;
    font-weight: 600;
    opacity: 1 !important; }
  .my-link:hover {
      color: #c8572d; }
  .my-link2:visited{
                color: red;
            }

<!--화면 줄어들때 메뉴색-->
 @media (max-width: 991.98px) {
    .ftco-navbar-light {
      background: #000000 !important;
      position: relative;
      top: 0; } }

</style>
</head>   

 <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="resources/css/animate.css">
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css">
    <link rel="stylesheet" href="resources/css/flaticon.css">
    <link rel="stylesheet" href="resources/css/style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="resources/css/animate.css">
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css">
    <link rel="stylesheet" href="resources/css/flaticon.css">
    <link rel="stylesheet" href="resources/css/style.css">


  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
      <div class="container" ">
         			 <a style="font-family: 나눔스퀘어라운드;font-size: 30px;" class="navbar-brand" href="/mainPage">
        <span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
        <font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</span></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
               <span class="oi oi-menu"></span> Menu
            </button>
         
           <div class="collapse navbar-collapse" id="ftco-nav" style="display: block; ">
              <ul class="navbar-nav ml-auto">
      
                     <li class="nav-item my-link_2"><a style="font-size: 15px; color: #fff;" href="/myPage?id=${m.id}">${m.nickName } 라이더님</a></li>
                     <li class="nav-item"><a style="font-size: 15px;" href="/logout" class="my-link">로그아웃</a></li>&nbsp;
                     <li class="nav-item active"><a style="font-size: 15px;" href="/myPage?id=${m.id}" class="my-link">마이페이지</a></li>
            </ul>
         </div>
		<div  class="collapse navbar-collapse" style="display: block; font-size: 12px; ">
              <ul class="navbar-nav ml-auto" style="list-style:none float:right; ">
				<li class="my"><a href="/myPage" class="my-link_2" >정보 수정</a></li>
				<li class="my"><a class="my-link_2" href="/myPageSaveCourse" >찜 목록</a></li>
                <li class="my"><a class="my-link_2" href="/myPageMyCourse"  style="color:#d0a183;font-weight: bold;">내 코스</a></li>
                <li class="my"><a class="my-link_2" href="myPageListReview?id=${m.id}">내 후기</a></li>
                <li class="my"><a class="my-link_2"href="listMeeting?id=${m.id}">내 번개</a></li>
                <li class="my"><a class="my-link_2"href="/myPageMyRank">랭킹</a></li>
                
              

              </ul>
         </div>      

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="/mainPage" class="my-link">Home</a></li>
	          <li class="nav-item"><a href="/listNotice" class="my-link">오늘의 라이딩</a></li>
	          <li class="nav-item"><a href="/searchCourse" class="my-link">라이딩 코스</a></li>
	          <li class="nav-item"><a href="/listReview" class="my-link">라이딩 후기</a></li>
	          <li class="nav-item"><a href="/listMeeting" class="my-link">번개 라이딩</a></li>
	          <li class="nav-item"><a href="/user/makingCourse" class="my-link">메이킹 코스</a></li>
	        </ul>
	      </div>
        
       </div>
 </nav>
   
    <!-- END nav -->



<body>
    
   <section class="hero-wrap hero-wrap-2" style="background-image: url('https://cdn.pixabay.com/photo/2017/08/01/01/18/road-2562568__340.jpg');background-size:100% 600px;" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        </div>
      </div>
    </section>


 <section class="ftco-section ftco-no-pb ftco-no-pt">
    <div class="container_my" style="padding-left: 150px; padding-right: 150px; padding-top: 50px;">   
           <h1>내가 만든 코스 목록</h1>
           
      <div class="row" id="saveCourseList"></div>
        <div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
                <li class="active" id="add"><span>+</span></li>
                <div id="lastPage"></div>
                
              </ul>
            </div>
          </div>
        </div>
    </div>
    </section> 

<jsp:include page="my_footer.jsp"/>
  </body>


</html>