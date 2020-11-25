<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <title>내 작성 코스</title>

<meta charset="UTF-8">
<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/js/myPageSaveCourse.js"></script></head>

<style>
#login {
	font-size: 14px;
	text-align: right;
}

.my{
	padding: 5px;
	margin: 2px;

	
}

  .nav-link_2 {
    font-size: 12px;
    font-family: "나눔스퀘어라운드";
    padding-top: .1rem;
    padding-bottom: .1rem;
    padding-left: 1px;
    padding-right: 1px;
    color: #fff;
    font-weight: 400;
    opacity: 1 !important; }

  .nav-link {
    font-size: 18px;
    font-family: "나눔스퀘어라운드";
    padding-top: .7rem;
    padding-bottom: .7rem;
    padding-left: 20px;
    padding-right: 20px;
    color: #fff;
    font-weight: 600;
    opacity: 1 !important; }
  .nav-link:hover {
      color: #c8572d; }
  .nav-link2:visited{
                color: red;
            }

<!--화면 줄어들때 메뉴색-->
 @media (max-width: 991.98px) {
    .ftco-navbar-light {
      background: #000000 !important;
      position: relative;
      top: 0; } }
      
      
.my{
	padding: 50px;
	
}
 .my_ul{
	list-style:none; 
 	text-align: center;
 }
 .my_li{
    display:inline-block;  
	float:left;
 	padding: 50px;
 	border-left:1px solid #999;             /* 각 메뉴의 왼쪽에 "|" 표시(분류 표시) */
    font:bold 16px Dotum;                     /* 폰트 설정 - 12px의 돋움체 굵은 글씨로 표시 */
    padding:0 10px;  
 }
 
  .my_li2{
    display:inline-block;  
	float:left;
 	padding: 50px;
    padding:0 10px;  
 }
   
 #my_a{
 color: #bbbbbb;
     font:bold 14px Dotum; 
 }
 #my_a:hover {
 color: #d0a183; 
 FONT-SIZE: 13pt; 
 FONT-WEIGHT: bolder}
 

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
    <li class="nav-item"><a style="font-size: 15px; color: #fff; cursor:default;" class="nav-link" href="/myPage?id=${m.id}">${m.nickName } 라이더님</a></li>
                     <li class="nav-item active"><a style="font-size: 15px;" href="/myPage?id=${m.id}" class="nav-link">마이페이지</a></li>
                     <li class="nav-item"><a style="font-size: 15px;" href="/logout" class="nav-link">로그아웃</a></li>
            </ul>
         </div>   

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
	          <li class="nav-item"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
	          <li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
	          <li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
	          <li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
	          <li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
	        </ul>
	      </div>
        
       </div>
 </nav>
   
   
    
   <section class="hero-wrap hero-wrap-2" style="background-image: url('https://cdn.pixabay.com/photo/2015/03/26/09/57/cyclists-690644__340.jpg');background-size:100% 600px;" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
      			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="ftco-animate pb-0 text-center">
      <span>
						<h1 class="mb-3 bread" style="padding-top: 170px;">내가 담은 코스</h1>
		            </span>
			              <ul class="my" style="font-size: 10px">
			             	<li class="my_li2" ><a id="my_a" class="nav-link_2" href="/myPage" >정보 수정</a></li>
					 <!--   <li class="my_li" ><a id="my_a" class="nav-link_2" href="/myPageSaveCourse" >찜목록</a></li>-->
							<li class="my_li" ><a id="my_a" class="nav-link_2" href="/myPageMyCourse" >내 코스</a></li>
			            	<li class="my_li"><a id="my_a" class="nav-link_2" href="/listReview?searchType=id&searchValue=${m.id }">내 후기</a></li>
			            	<li class="my_li"><a id="my_a" class="nav-link_2" href="/listMeeting?id=${m.id}">내 번개</a></li>  
			                <li class="my_li"><a id="my_a" class="nav-link_2" href="/myPageMyRank">랭킹</a></li>
			              </ul>
			         </div>
			         </div>
         
      
        </div>
      </div>
    </section>
    <!-- END nav -->




<body>

<section class="ftco-section ftco-no-pb ftco-no-pt">
    <div class="container_my" style="padding-left: 150px; padding-right: 150px; padding-top: 50px;">   
           
      <div class="row" id="saveCourseList"></div>
        <div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
                <li class="active" id="add" style="cursor:pointer; padding-bottom: 40px;"><span>+</span></li>
                
              </ul>
            </div>
          </div>
        </div>
    </div>
</section> 
<jsp:include page="footer.jsp"/>

  </body>


</html>