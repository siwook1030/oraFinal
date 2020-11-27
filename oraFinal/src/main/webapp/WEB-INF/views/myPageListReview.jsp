<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <jsp:include page="my_header.jsp"/>
  	<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
    <title>마이페이지</title>

<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
<script type="text/javascript">
window.onload = function(){
	const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    const parameter = $("meta[name='_csrf_parameter']").attr("content");
    $(document).ajaxSend(function(e, xhr, options) {
        if(token && header) {
            xhr.setRequestHeader(header, token);
        }
    });
	
}

</script>

  </head>
  <body>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container_my">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          
             <span><h1 class="mb-3 bread">마이페이지</h1></span>
          
             <p class="breadcrumbs">

                <span>
                   <a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a>
                 <a href="/myPage">정보 수정 <i class="fa fa-chevron-right"></i></a>
                <a href="/myPageSaveCourse">찜 목록 <i class="fa fa-chevron-right"></i></a>
                <a href="/myPageMyCourse">내 작성 코스<i class="fa fa-chevron-right"></i></a>
                </span>
                <a href="myPageListReview?id=${m.id}">내 작성 후기<i class="fa fa-chevron-right"></i></a>
            <span>
                <a href="listMeeting?id=${m.id}">내 작성 번개<i class="fa fa-chevron-right"></i></a>
               <a href="/myPageMyRank">랭킹</a>
                </span>
                </p>
            
          </div>
        </div>
      </div>
    </section>
    
    
 <section class="ftco-section ftco-no-pb ftco-no-pt">
    <div class="container">   
           <h1>내가 만든 코스 목록?</h1>
           
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
      
      
    </section>   

  
  
   <jsp:include page="my_footer.jsp"/>
    
  </body>
</html>