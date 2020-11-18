<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
   <meta charset="UTF-8">
   <title>마이페이지-찜코스</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="resources/css/animate.css">
    
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css">
    
    <link rel="stylesheet" href="resources/css/flaticon.css">
    <link rel="stylesheet" href="resources/css/style.css">


   <style>
        <!-- 사진 프레임-->
           .all{
             position:relative;
             min-height:1px;
             padding-top: 50px;
           }

           .name{
              background-color:#ffffff;
           }
           .level{
              background-color: #F2F2F2;
			　
           }
           .time{
              background-color: #ffffff;
           }

         .img {
           border: 1px solid #ddd;
           border-radius: 4px;
           padding: 5px;
           width: 40%;
         }



          .zenbu{
          border: 1px solid blue;
          padding: 10px;
          height: 250o;
          min-height: 130px;
          max-width: 300px;
          overflow: auto;
          display: inline-block;
          background-color: #FfffF;
          }

       
         .syasin{
           width: 100%;
           max-width: 760px;
           border-radius: 7px;
         }





   </style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
window.onload = function(){
    let addIndex = 0;
    let lastIndex = 0;

    const saveCourseList = document.getElementById("saveCourseList");
    
    function getCourseList(index){   
       $.ajax({
         url: "/myPageSaveCourse",
         method:"POST",
         success: function(courseVo){
            $(courseVo).each(function(i, c) {
               lastIndex = i;
                 addIndex = i;
                 
                 console.log("index"+index);
                 console.log("lastIndex"+lastIndex);
       
                 
               if(i >= index){                
                return;               
               };
   	           
           const courseBox = document.createElement("div");
           courseBox.className="col-md-4";

     let courseContent = '<div class="property-wrap ftco-animate fadeInUp ftco-animated">\
              <a href="/detailCourse?c_no='+c.c_no+'" class="img" target="_blank" style="background-image: url('+c.c_photo[0].cp_path+'/'+c.c_photo[0].cp_name+');">\
                 <div class="rent-sale">\
                    <span class="rent">'+c.c_loc+'</span>\
                 </div>\
                 <p class="price"><span class="orig-price"></span></p>\
              </a>\
              <div class="text">\
                 <h3><a href="/detailCourse?c_no='+c.c_no+'" target="_blank">'+c.c_name+'</a></h3>\
                 <span class="location"></span>\
                 <span style="cursor: hand; cursor:pointer;" title="삭제" class="deleteSaveCourse d-flex align-items-center justify-content-center btn-custom" value="'+c.c_no+'">\
                    <span class="fa fa-link" value="'+c.c_no+'"></span>\
                 </span>\
                 <ul class="property_list">\
                    <li><span class="flaticon-bed"></span></li>\
                    <li><span class="flaticon-bathtub"></span></li>\
                    <li><span class="flaticon-floor-plan"></span></li>\
                 </ul>\
                 <div class="list-team d-flex align-items-center mt-2 pt-2 border-top">\
                    <div class="d-flex align-items-center"></div>\
                     <span class="text-right"></span>\
                 </div>\
              </div>\
           </div>'; 


           courseBox.innerHTML = courseContent;
           saveCourseList.append(courseBox);
            });//첫번째포문   
            }//에이작 석세스
         });//에이작끝

    };
       getCourseList(5);
    

       
       $(document).on("click",".deleteSaveCourse", function() {
          //var data=$(this).val();
          var data=$(this).attr("value");
             console.log(data);
             $.ajax({
                url:"/deleteSaveCourse",
                method:"POST",
                data:{"cno":data},
                success: function(re){
                   alert("찜코스가 삭제되었습니다"+re);
                   window.location.reload();
             }});            
       });//삭제클릭이벤트
    
       $("#add").click(function() {
          $("body #aa").empty();
           getCourseList((addIndex+ 5));
          alert(addIndex);
          if(lastIndex < (addIndex+5)){                    
             $("#add").remove();
             $("#lastPage").html("다음 페이지가 없습니다");

            };
    
       });   
 };
</script>
</head>

<body>

  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="index.html">Ecoverde</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="index.html" class="nav-link" >Home</a></li>
	          <li class="nav-item"><a href="about.html" class="nav-link">About</a></li>
	          <li class="nav-item"><a href="agent.html" class="nav-link">Agent</a></li>
	          <li class="nav-item"><a href="services.html" class="nav-link">Services</a></li>
	          <li class="nav-item"><a href="properties.html" class="nav-link">Properties</a></li>
	          <li class="nav-item active"><a href="blog.html" class="nav-link">Blog</a></li>
	          <li class="nav-item"><a href="contact.html" class="nav-link">Contact</a></li>
	        </ul>
	      </div>
	    </div>
	  </nav>
    <!-- END nav -->

    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home <i class="fa fa-chevron-right"></i></a></span> <span>Blog <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">Blog</h1>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section ftco-no-pb ftco-no-pt">
    <div class="container">   
		     <h1>찜코스목록</h1>
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
  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="resources/js/jquery.min.js"></script>
  <script src="resources/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="resources/js/popper.min.js"></script>
  <script src="resources/js/bootstrap.min.js"></script>
  <script src="resources/js/jquery.easing.1.3.js"></script>
  <script src="resources/js/jquery.waypoints.min.js"></script>
  <script src="resources/js/jquery.stellar.min.js"></script>
  <script src="resources/js/owl.carousel.min.js"></script>
  <script src="resources/js/jquery.magnific-popup.min.js"></script>
  <script src="resources/js/jquery.animateNumber.min.js"></script>
  <script src="resources/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="resources/js/google-map.js"></script>
  <script src="resources/js/main.js"></script>
    
  </body>


</html>