<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>오늘의 라이딩 - Today's riding</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/animate.css">
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css">
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/style.css">
<style type="text/css">

#box00{
  margin: 30px 10px 0 0;
  width: 400px;
  height: 30px;
}

#notice {
	padding: 20px;
	width: 120px;
	margin: 200px auto;
	color: #c8572d;
	text-align: center;
	text-decoration: none;
}
   
#list {
	width: 900px;
	height: 700px;
	margin: 50px auto;
	float: center;
}

#btn_search,#btn_write{
	width:50px;
	height: 30px;
    border: none;
    border-radius:5px;
    color:#ffffff;
    padding: 5px 0;
    font: bold;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 13px;
    margin: 0px;
    cursor: pointer;
}

#btn_search{
	background-color: #ECCB6A;
}

#btn_write{
	float: right;
	background-color: #88bea6;
}

button:hover {
	border: none;
    background-color: #ffffff;
    color: #c8572d;
}

select {
	height: 30px;
	width: 100px;
	font-size: 15px;
}

input#search{
	height: 30px;
	border: solid 1px;
	font-size: 11pt;
	color: #63717f;
	padding-left: 15px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

#tb{
	height: 600px;
}

table, th, td {
	margin-top: 30PX;
	border: solid 1px #fff2e4;
	border-collapse: collapse;
	font-size: 15px;
	color: #0f0f0f;
	text-decoration: none;
}

th {
	padding: 6px;
	text-align: center;
	background-color: #fff2e4;
	height: 25px;
}

td {
	padding: 6px;
	text-align: center;
	height: 30px;
}

#insertNotice{
	display: none;
}

#page {
	text-align: center;
	margin-top: 50px;
}

#num {
	margin: 3px;
	padding: 4px 8px;
}

   /*float 초기화 아이디*/
#clear{
	clear: both; 
}
</style> 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/js/loginCheck.js"></script>
<script type="text/javascript">
window.onload = function(){
	const checkM = checkLogin(); // 로그인이 되어있는 상태인지 체크한다
	console.log(checkM);
	
	let pageNo = 1;
	const recordSize = ${recordSize};
	const pageSize = ${pageSize};
	listNotice();
	
	
	const tbody = document.getElementById("tbody");
	const btn_search = document.getElementById("btn_search");
	const code_value = document.getElementById("code_value");
	const search = document.getElementById("search");
	const rowDFlex = document.getElementById("rowDFlex");
	
//
	
	const insertNotice = document.getElementById("insertNotice");
	if(checkM.item.code_value != null && checkM.item.code_value == "00101"){
		insertNotice.style.display = "inline";
	}

	function listNotice(){
		const cvalue = code_value.value;
		const searchText = search.value.trim();
		
			$.ajax({
				url:"/listNoticeJson",
				type:"GET",
				data : {
					"pageNo": pageNo,
					"code_value":cvalue,
					"searchText":searchText
				},
				success:function(map){
					//$('tbody').empty();
					setList(map.list);
					setPage(map.totRecord);
					console.log(map.totRecord);
				}
			});
		}
		
	
	btn_search.addEventListener("click", function(e){
		pageNo=1;
		listNotice();
	});
	search.addEventListener("keyup", function(e) {
		if(e.keyCode == '13'){
			pageNo=1;
			listNotice();
		}
	})

	/*
	function setList(list){
		tbody.innerHTML="";
		list.forEach(function(n, i){
		const tr = document.createElement("tr");
		let nc = '<td>'+n.code_name+'</td>';
			  nc+=    '<td><a href="detailNotice?n_no='+n.n_no+' ">'+n.n_title+'</a></td>';
			  nc+= '<td>'+n.n_regdate+'</td>';
			  nc+= '<td>'+n.n_hit+'</td>';
		   tr.innerHTML=nc;
		   tbody.append(tr);	
		});
		
	};
	*/

	function setList(list){
		console.log(list);
		rowDFlex.innerHTML="";
		list.forEach(function(n, i) {
			let listImg = '<img id=listImg src="/noticeImg/'+n.nf[0].nf_savename+'"';
			const contentImg;
		}
	}

	function setPage(totRecord){
		$('#page').empty();
		$('#page').css('cursor','pointer');
		//$('#page').css('cursor','pointer');
		// 총 페이지 수
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
			$('#page').append(prev);
			$(prev).click(function(){
				const idx = $(this).attr('idx');
				pageNo = idx;
				listNotice();
			});
		}
		
		for(let i=startPage; i<=endPage; i++){
			const a = $('<span></span>').attr('idx',i).html(i);
			if(i==pageNo){
				$(a).css({
					color: 'white',
					backgroundColor: '#bae4f0',
					borderRadius: '15px'
				});
			}
			$('#page').append(a);
			$(a).click(function() {
				const idx = $(this).attr('idx');
				if(pageNo==idx){
					return;
				} 
				console.log(idx);
				pageNo = idx;
				listNotice();
			});			
		}
			if(totPage>endPage){
			const next = $('<span></span>').attr('idx',(endPage+1)).html('>');
			$('#page').append(next);
			$(next).click(function(){
				const idx = $(this).attr('idx');
				pageNo = idx;
				listNotice();
			});
		}			
	}

}
	

	
</script>
</head>
<body>

   <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a style="font-family: 나눔스퀘어라운드;font-size: 30px;" class="navbar-brand" href="/mainPage">
        <span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
        <font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</span></a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
					<span class="oi oi-menu"></span> Menu
				</button>
	      
			<div class="collapse navbar-collapse" id="ftco-nav">
		        <ul class="navbar-nav ml-auto">
					<c:choose>
						<c:when test="${m == null }">
							<li class="nav-item"><a style="font-size: 15px;" href="/login" class="nav-link">로그인</a></li>
							<li class="nav-item"><a style="font-size: 15px;" href="/signUp" class="nav-link">회원가입</a></li>
						</c:when>
						<c:when test="${m != null }">
							<li class="nav-item"><a style="font-size: 15px;" class="nav-link">${m.nickName } 라이더님</a></li>
							<li class="nav-item"><a style="font-size: 15px;" href="/logout" class="nav-link">로그아웃</a></li>&nbsp;&nbsp;
							<li class="nav-item"><a style="font-size: 15px;" href="/myPage?id=${m.id}" class="nav-link">마이페이지</a></li>
						</c:when>
					</c:choose>
				</ul>
			</div>      

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
	          <li class="nav-item" active><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
	          <li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
	          <li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
	          <li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
	          <li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
	          <!-- <li class="nav-item"><a href="contact.html" class="nav-link">Contact</a></li>-->
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
             <p class="breadcrumbs"><span class="mr-2"><a href="mainPage">Home <i class="fa fa-chevron-right"></i></a></span> <span>공지사항 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">공지사항</h1>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section">
      <div class="container">
        <div class="row d-flex" id="rowDFlex"><!-- 리스트출력 --></div> 
      <br>

        
		<div class="row mt-5">
			<div class="col text-center">
				<div><a href="/user/insertMeeting" class="btn">등록</a></div>                    
				<div class="block-27">
					<ul class="pageUl"><!-- 페이징처리 --></ul>
				</div>
			</div>
		</div>
	</div> <!-- container -->
	</section>
	
	<!-- <section class="ftco-section" id="list">
		<div id="box00">
			<div id="container00">

		     	<select id="code_value" name="code_value" size="1">
		     		<option value="0">전체</option>
		     		<c:forEach var="c" items="${category }">
		     			<option value="${c.code_value }">${c.code_name }</option>
		     		</c:forEach>
		        </select>
				<input type="search" id="search" placeholder="Search..." />
				<button id="btn_search">검색</button>

			</div>

		</div>
		
		<div id="tb">
			<table border="1" width="100%">
				<thead>
					<tr>
						<th>카테고리</th>
						<th>제목</th>
						<th>등록일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody id="tbody"></tbody>
			</table>
		</div>

		<div id="insertNotice">
			<a href="/admin/insertNotice"><button id="btn_write">글쓰기</button></a><br>
		</div>
		<div id="page"></div>
		
	</section> -->
	<br>
	<footer class="ftco-footer ftco-section">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">오늘의 라이딩</h2>
              <p>당신의 멋진 라이딩을 위하여</p>
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