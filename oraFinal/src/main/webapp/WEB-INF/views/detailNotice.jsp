<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 라이딩 - Today's riding</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/animate.css">
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css">
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/style.css">
<style type="text/css">


</style> 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/js/loginCheck.js"></script>
<script type="text/javascript">
window.onload = function(){
	 const token = $("meta[name='_csrf']").attr("content");
	    const header = $("meta[name='_csrf_header']").attr("content");
	    $(document).ajaxSend(function(e, xhr, options) {
	        if(token && header) {
	            xhr.setRequestHeader(header, token);
	        }
	    });
	
	const checkM = checkLogin(); // 로그인이 되어있는 상태인지 체크한다
	console.log(checkM);
//
	const btnUD = document.getElementById("btnUD");
	const btnUpdate = document.getElementById("btnUpdateN");
	
	if(checkM.item.code_value != null && checkM.item.code_value == "00101"){
		btnUD.style.display = "inline";
	};

	

	/*btnUpdate.addEventListener("click", function(e){
		const n_no = btnUpdate.value;
		console.log(n_no);
		window.location = "/admin/updateNotice?n_no="+n_no;
	}*/
};
	

	
</script>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a style="font-size: 30px;" class="navbar-brand" href="/mainPage">
		        <span style="font-weight: bold;">
			        <font color="#45A3F5">오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
			        <font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</font></span></a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
					<span class="oi oi-menu"></span> Menu
				</button>
				
	      <div style="display: block;">
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
						<c:if test="${m.code_value == '00101' }">
								<li class="nav-item"><a style="font-size: 15px;" href="/admin/adminPage" class="nav-link">관리자 페이지</a></li>
							</c:if>
						</c:when>
					</c:choose>
				</ul>
			</div>      

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
	          <li class="nav-item active"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
	          <li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
	          <li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
	          <li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
	          <li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
	        </ul>
	      </div>
	    </div>
	   </div> 
	</nav>
    <!-- END nav -->
    
	<section class="hero-wrap hero-wrap-2" style="background-image: url('resources/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
             <p class="breadcrumbs"><span class="mr-2"><a href="mainPage">Home <i class="fa fa-chevron-right"></i></a></span> <span>오늘의 라이딩 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">공지사항 상세</h1>
          </div>
        </div>
      </div>
    </section>

	<section class="ftco-section">
      <div class="container">
        <div class="row justify-content-center mb-5" id="row">
          <div class="col-md-8 mx-md-5 ftco-animate">
            <h2 class="mb-5">${n.n_title }</h2>
            <hr>
            <div class="mb-5">
	            <div class="float-left">
	            	<strong><span class="list_code_name" id="detail_code_name">${n.code_name }</span></strong>
	            </div>
	            <div class="float-right">
	            	<strong><span>${n.n_regdate }</span></strong>
	            </div>
	        </div>
	        <hr class="mb-6">
          	<div class="text-center mb-6">
              <img src="/noticeImg/${n.n_file }" alt="" class="img-fluid">
            </div>
            <div id="n_content" style="white-space:pre;"><c:out value="${n.n_content}" /></div>
			<br>
			<a href="listNotice"><button type="button" class="btn btn-primary" id="btnListN">목록</button></a>
			<div id="btnUD">
				<a href="/deleteNotice?n_no=${n.n_no }"><button type="button" class="btn btn-warning" id="btnDeleteN">삭제</button></a>
				<!-- <button type="button" id="btnUpdate" value="${n.n_no }">수정</button> -->
			 	<a href="/admin/updateNotice?n_no=${n.n_no}"><button type="button" class="btn btn-success" id="btnUpdateN" value="${n.n_no }">수정</button></a> 
			</div>
          </div>
        </div> 
    
	  </div>	
	</section>
	<br>
	
	<!-- 푸터 -->
	<jsp:include page="footer.jsp" />
</body>
</html>