<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
 <jsp:include page="my_header.jsp"/>

   <meta charset="UTF-8">
   <title>내 작성 코스</title>
   <meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="resources/css/animate.css">
    
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css">
    
    <link rel="stylesheet" href="resources/css/flaticon.css">
    <link rel="stylesheet" href="resources/css/style.css">

<style type="text/css">
	.cInfoIcon {
   	width: 24px;
   }
   
    .cViewIcon {
   	width: 34px;
   }
   
      .viewImg {
   	margin-right: 10px;
   }
      .search-place:after,	 .col-md-4, .img, .search-place img {
   	border-radius: 10px;
   }
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
window.onload = function(){
	const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    $(document).ajaxSend(function(e, xhr, options) {
        if(token && header) {
            xhr.setRequestHeader(header, token);
        }
    });
	
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

           let courseTime;
      		const hour = parseInt(c.c_time/60);
      		const mi = c.c_time%60;
      		if(hour >= 1){
      			courseTime = hour+'시간 '+mi+'분';
      		}
      		else{
      			courseTime = mi+'분';
      		}

      		const diff = c.c_difficulty;
      		let diffContent;
      		if(diff == 1){
      			diffContent = '<span style="color:#88bea6;">쉬움</span>';
      		}
      		else if(diff == 2){
      			diffContent = '<span style="color: #eccb6a;">보통</span>';
      		}
      		else if(diff == 3){
      			diffContent = '<span style="color: #c8572d;">어려움</span>';
      		}
      		else if(diff == 4){
      			diffContent = '<span style="color:red;">힘듬</span>';
      		}

      		let courseViewContent="";
      		c.c_views.forEach(function(v, i) {
      			courseViewContent += '<div title="'+v+'" class="img viewImg" style="background-image: url(/courseViewImg/'+v+'.png);"></div>';
      		});

      		
      	let courseContent = '<div class="property-wrap ftco-animate fadeInUp ftco-animated">\
      			<a href="/detailCourse?c_no='+c.c_no+'" class="img" target="_blank" style="background-image: url('+c.c_photo[0].cp_path+'/'+c.c_photo[0].cp_name+');">\
      				<div class="rent-sale">\
      					<span class="rent">'+c.c_loc+'</span>\
      				</div>\
      				<p title="태그" class="price"><span class="orig-price" style="color:black;">'+c.c_tag+'</span></p>\
      			</a>\
      			<div class="text">\
      				<h3><a href="/detailCourse?c_no='+c.c_no+'" target="_blank">'+c.c_name+'</a></h3>\
      				<span class="location">made by '+c.nickName+'</span>\
      				<span style="cursor: hand; cursor:pointer;" title="삭제" class="deleteSaveCourse d-flex align-items-center justify-content-center btn-custom" value="'+c.c_no+'">\
                    <span class="fa fa-link" value="'+c.c_no+'"></span>\
                	 </span>\
      				<ul class="property_list" style="font-weight: bold;" >\
      					<li title="코스거리" ><span class="flaticon-bed"><img class="cInfoIcon" src="/searchCourseImg/distance.png"></span>'+c.c_distance+'km</li>\
      					<li title="소요시간" ><span class="flaticon-bathtub"><img class="cInfoIcon" src="/searchCourseImg/time.png"></span>'+courseTime+'</li>\
      					<li title="난이도" ><span class="flaticon-floor-plan"><img class="cInfoIcon" src="/searchCourseImg/difficulty.png"></span>'+diffContent+'</li>\
      				</ul>\
      				<div class="list-team d-flex align-items-center mt-2 pt-2 border-top">\
      					<div class="d-flex align-items-center">'+courseViewContent+'</div>\
          				<span class="text-right">풍경</span>\
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
          $("body #saveCourseList").empty();
           getCourseList((addIndex+ 5));
          if(lastIndex < (addIndex+5)){                    
             $("#add").remove();
             $("#lastPage").html("다음 페이지가 없습니다");

            };
    
       });   
 };
</script>
</head>

<body>


    
   <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
             <span><h1 class="mb-3 bread">마이페이지</h1></span>
             <p class="breadcrumbs">
                <span>
                   <a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a>
                   <a href="/myPage">정보 수정 <i class="fa fa-chevron-right"></i></a>
            </span>
                <a href="/myPageSaveCourse">찜 목록 <i class="fa fa-chevron-right"></i></a>
                <span>
                <a href="/myPageMyCourse">내 작성 코스<i class="fa fa-chevron-right"></i></a>
                <a href="/myPageListReview">내 작성 후기<i class="fa fa-chevron-right"></i></a>
               <a href="myPageListMeeting">내 작성 번개<i class="fa fa-chevron-right"></i></a>
               <a href="/myPageMyRank">랭킹</a>
                </span>
                </p>
          </div>
        </div>
      </div>
    </section>


 <section class="ftco-section ftco-no-pb ftco-no-pt">
    <div class="container">   
           <h1>내가 찜한 코스 목록</h1>
           
      <div class="row" id="saveCourseList"></div>
        <div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
                <li class="active" id="add"><span>+</span></li>
                
              </ul>
            </div>
          </div>
        </div>
    </div>
    </section> 
<jsp:include page="my_footer.jsp"/>

  </body>


</html>