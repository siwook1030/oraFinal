<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Ora - meeting Board</title>
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
/* 		section {
			margin: 0 auto;
			width: 1000px;
			text-align: left;
		} */
		table {
			border-collapse: collapse;
			text-align: center;
		}
/* 		td, th {
			border-bottom: 1px #7a7a7a solid;
			padding: 4px 0 4px;
		} */
		#page {
			text-align: center;
			margin-top: 50px;
		}
		span {
			margin: 3px;
			padding: 4px 8px;
		}
		.btn {
			color: white;
			padding: 8px 12px;
			background-color: #88BEA6;
			float: right;
			font-size: 15px;
			border: none;
			cursor: pointer;
		}
	</style>

	<script type="text/javascript">
	window.onload = function(){
		let pageNo = 1;
		const recordSize = ${recordSize};
		const pageSize = ${pageSize};
		listMeeting();

		// 나우페이지를 주면 리스트를 띄울 함수 하나
		// 페이징바를 만들 함수하나
	      
		function listMeeting(){
			$.ajax({
				url: "/listMeetingJson",
	            type: "GET",
	            data : {
	               "pageNo": pageNo
	            },
	            success: function(map){
	               //$('#rowDFlex').empty();
	               setPage(map.totRecord);
	               setList(map.list);
	            }
	         })                  
	      }

		function setPage(totRecord){
			$('.pageUl').empty();
			$('.pageUl').css('cursor','pointer');
			
			// 총 페이지 수
			console.log("*** totRecord : "+totRecord)
			let totPage = Math.ceil(totRecord/recordSize);
			console.log('*** totPage : '+totPage);

			// 페이지 버튼 숫자
			let startPage = parseInt((pageNo-1)/pageSize)*pageSize+1;
			let endPage = startPage+pageSize-1;
			if(endPage>totPage) {
				endPage = totPage;
			}
			console.log('*** startPage : '+startPage);
			console.log('*** endPage : '+endPage);

			if(startPage>1) {
				const prev = $('<span></span>').attr('idx',(startPage-1)).html('<');
				const pageLi = $('<li></li>').append(prev);
				$('.pageUl').append(pageLi);
	            $(prev).click(function(){
	               const idx = $(this).attr('idx');
	               pageNo = idx;
	               listMeeting();
	            });
			}
	         
			for(let i=startPage; i<=endPage; i++){
				const a = $('<span></span>').attr('idx',i).html(i);
				const pageLi = $('<li></li>').append(a);
				//$('.pageUl').append(pageLi);
	            if(i==pageNo){
	               $(a).css({
	                  color: 'white',
	                  backgroundColor: '#ECCB6A',
	                  borderRadius: '15px'
	               });
	            }
	            $('.pageUl').append(pageLi);
	            $(a).click(function() {
	               const idx = $(this).attr('idx');
	               if(pageNo==idx){
	                  return;
	               } 
	               console.log(idx);
	               pageNo = idx;
	               listMeeting();
	            });         
	         }
	          if(totPage>endPage){
	            const next = $('<span></span>').attr('idx',(endPage+1)).html('>');
	            const pageLi = $('<li></li>').append(next);
				$('.pageUl').append(pageLi);
	            $(next).click(function(){
	               const idx = $(this).attr('idx');
	               pageNo = idx;
	               listMeeting();
	            });
	         }         
	      }

	      ///////////////////

	      function setList(arr){
		      console.log(arr);
	    	  $('#rowDFlex').empty();
	         $.each(arr, function(idx, data){
		         console.log(data.mf[0]);
		         
	            //console.log('*** arr length : '+arr.length);
	            const m_no = $('<td></td>').html(data.m_no);
	            const c_name = $('<td></td>').html(data.c_name);
	            const m_time = $('<td></td>').html(data.m_time);
	            const nickName_icon = $('<img/>').attr({src : 'rank/'+data.rank_icon, height : '20px'});
	            const nickName = $('<td></td>').append(nickName_icon, data.nickName);
	            const m_regdate = $('<td></td>').html(data.m_regdate);
	            const m_hit = $('<td></td>').html(data.m_hit);
	            
	            const faSpan = $('<span></span>').addClass('fa fa-comment'); // 말풍선
	            const meta_chat = $('<a></a>').addClass('meta-chat').append(faSpan, " "+data.m_repCnt); // 말풍선 + 댓글수
	            const m_repCnt = $('<div></div>').append(meta_chat);

				// 사진출력
				let CImg;
				if(data.mf.length!=0) {
					 CImg = $('<img/>').attr('src',"/"+data.mf[0].mf_path+"/"+data.mf[0].mf_savename);
				} else {
					 CImg = $('<img/>').attr('src',"/rank/Lv3.png");
				}
	            const contentImg = $('<a></a>').addClass('block-20 img').attr("href",'detailMeeting?m_no='+data.m_no).append(CImg);
	            
				// <a></a>에 내용 담음
	            const c_nameA = $('<a></a>').append(c_name);
	            const c_nameDiv = $('<div></div>').append(c_nameA);
	            
	            const m_timeA = $('<a></a>').append(m_time);
	            const m_timeDiv = $('<div></div>').append(m_timeA);
	            
	            const nickNameA = $('<a></a>').append(nickName);
	            const nickNameDiv = $('<div></div>').append(nickNameA);
	            
	            const m_regdateA = $('<a></a>').append(m_regdate);
	            const m_regdateDiv = $('<div></div>').append(m_regdateA);
	            
	            const m_hitA = $('<a></a>').append(m_hit);
	            const m_hitDiv = $('<div></div>').append(m_hitA);
	            
	            const m_repCntA = $('<a></a>').append(m_repCnt);
	            const m_repCntDiv = $('<div></div>').append(m_repCntA);

	            const metaDiv = $('<div></div>').addClass('meta mb-3');
	            const textDiv = $('<div></div>').addClass('text');
	            const blog_entryDiv = $('<div></div>').addClass('blog-entry justify-content-end');
	            const col = $('<div></div>').addClass('col-md-3 d-flex ftco-animate fadeInUp ftco-animated');
	        
	            const m_title = $('<a></a>').attr('href','detailMeeting?m_no='+data.m_no).html(data.m_title);
	            const heading = $('<h3></h3>').addClass('heading').append(m_title);
	            
	            //metaDiv.append(/* m_no, */ c_name, m_time, nickName, m_regdate, m_hit, m_repCnt);
	            metaDiv.append(c_nameDiv, m_timeDiv, nickNameDiv, m_regdateDiv, /* m_hitDiv, */ m_repCntDiv);
	            textDiv.append(contentImg, metaDiv, heading);
	            blog_entryDiv.append(textDiv);
	            col.append(blog_entryDiv);

	         	$('#rowDFlex').append(col);   
	         });
	      }
	      
	   }

	   function checkLogin(){
	      let check;
	         $.ajax({
	            url: "/checkLogin",
	            type: "POST",
	            async: false,
	            success: function(response){
	               check =  response;
	            },
	            error: function(){
	               alert("에러발생");
	            }
	         })
	      return check;
	      }
	</script>
	    
	</head>
	<body>
    
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="/mainPage"><img src='/headerImg/logo.png' height="100"></a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="oi oi-menu"></span> Menu
			</button>
			
<%-- 					<div id="login">
						<c:choose>
							<c:when test="${m == null }">
								<a href="/login">로그인</a>&nbsp;&nbsp;&nbsp;<a href="/signUp">회원가입</a>
							</c:when>
							<c:when test="${m != null }">
								${m.nickName } 라이더! &nbsp;&nbsp;<a href="/logout">로그아웃</a>&nbsp;&nbsp;<a href="/myPage?id=${m.id}">마이페이지</a>
							</c:when>
						</c:choose>
					</div> --%>

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
					<li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
					<li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
					<li class="nav-item active"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
					<li class="nav-item"><a href="" class="nav-link">라이딩 정보</a></li>
				</ul>
			</div>
		</div>
     </nav>
    <!-- END nav -->
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('resources/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
             <p class="breadcrumbs"><span class="mr-2"><a href="mainPage">Home <i class="fa fa-chevron-right"></i></a></span> <span>번개 라이딩<i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">번개 라이딩</h1>
          </div>
        </div>
      </div>
    </section>

      



    <section class="ftco-section">
      <div class="container">
        <div class="row d-flex" id="rowDFlex">
        
	         	<!-- <div class="col-md-3 d-flex ftco-animate">
                  <div class="blog-entry justify-content-end">
                    <div class="text">
                      <a href="blog-single.html" class="block-20 img" style="background-image: url('images/image_1.jpg');">
                      </a>
                      <div class="meta mb-3">
                        <div><a href="#">오호선을 따라서</a></div>
                        <div><a href="#" class="meta-chat"><span class="fa fa-comment"></span> 6</a></div><br>
                        <div><a href="#">오늘의 라이딩</a></div>
                      </div>
                      <h3 class="heading"><a href="#">이렇게 떴으면 좋겠는데</a></h3>
                    </div>
                  </div>
               </div> -->

        </div>
      <br>

        
       <div class="row mt-5">
				<div class="col text-center" style="border: 1px solid black">
					
					<a href="/user/insertMeeting" class="btn">등록</a>
					<!-- <div id="page"></div> -->
                    
                    <div class="block-27" style="border: 1px solid black">
                      <ul class="pageUl">
                        <<!-- li>&lt;</li>
                        <li class="active"><span>1</span></li>
                        <li>2</li>
                        <li>3</li>
                        <li>4</li>
                        <li>5</li>
                        <li>&gt;</li> -->
                      </ul>
                    </div>
                  </div>
                </div>
      </div> <!-- container -->
    </section>
    

    <footer class="ftco-footer ftco-section">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Ecoverde</h2>
              <p>Far far away, behind the word mountains, far from the countries.</p>
              <ul class="ftco-footer-social list-unstyled mt-5">
                <li class="ftco-animate"><a href="#"><span class="fa fa-twitter"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="fa fa-facebook"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="fa fa-instagram"></span></a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">Community</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Search Properties</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>For Agents</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Reviews</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>FAQs</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">About Us</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Our Story</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Meet the team</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Careers</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
             <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Company</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>About Us</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Press</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Contact</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Careers</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
               <h2 class="ftco-heading-2">Have a Questions?</h2>
               <div class="block-23 mb-3">
                 <ul>
                   <li><span class="icon fa fa-map"></span><span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span></li>
                   <li><a href="#"><span class="icon fa fa-phone"></span><span class="text">+2 392 3929 210</span></a></li>
                   <li><a href="#"><span class="icon fa fa-envelope pr-4"></span><span class="text">info@yourdomain.com</span></a></li>
                 </ul>
               </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">
   
            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer>
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
  
  <script src="/resources/js/jquery.min.js"></script>
  <script src="/resources/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/resources/js/popper.min.js"></script>
  <script src="/resources/js/bootstrap.min.js"></script>
  <script src="/resources/js/jquery.easing.1.3.js"></script>
  <script src="/resources/js/jquery.waypoints.min.js"></script>
  <script src="/resources/js/jquery.stellar.min.js"></script>
  <script src="/resources/js/owl.carousel.min.js"></script>
  <script src="/resources/js/jquery.magnific-popup.min.js"></script>
  <script src="/resources/js/jquery.animateNumber.min.js"></script>
  <script src="/resources/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/resources/js/google-map.js"></script>
  <script src="/resources/js/main.js"></script>

  
    
  </body>
</html>