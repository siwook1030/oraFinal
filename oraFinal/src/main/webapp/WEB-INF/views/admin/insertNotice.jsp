<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
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

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
window.onload = function(){
	 const token = $("meta[name='_csrf']").attr("content");
	    const header = $("meta[name='_csrf_header']").attr("content");
	    $(document).ajaxSend(function(e, xhr, options) {
	        if(token && header) {
	            xhr.setRequestHeader(header, token);
	        }
	    });

	
	const nTitle = document.getElementById("title");
	const nContent = document.getElementById("content");


	const btnInsert = document.getElementById("btnInsertN");
	
	btnInsertN.addEventListener("click", function(e) {
		if(nTitle.value.trim() === ""){
			alert("제목을 입력해야 될 거 아니야~!");
			return;
		}
		if(nContent.value.trim() === ""){
			alert("내용도 입력안하고 등록할거야~~?!");
			return;
		}

		const form = document.getElementById("form");
		const formData = new FormData(form);
		
		$.ajax({
			url: "/admin/insertNotice",
			type: "POST",
			data: formData,
			contentType: false,
			processData: false,
			success: function(response){
				if(response.code == "200"){
					alert(response.message);
					window.location = "/listNotice";
				}
				else{
					alert(response.message);
				}
			},
			error: function(){
				alert("에러발생");
			}
		})
	});
}
	
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
	          <!-- <li class="nav-item"><a href="contact.html" class="nav-link">Contact</a></li>-->
	        </ul>
	      </div>
	    </div>
	   </div> 
	</nav>
    <!-- END nav -->
    
	<section class="hero-wrap hero-wrap-2" style="background-image: url('/resources/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
             <p class="breadcrumbs"><span class="mr-2"><a href="mainPage">Home <i class="fa fa-chevron-right"></i></a></span> <span>오늘의 라이딩 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">공지사항 등록</h1>
          </div>
        </div>
      </div>
    </section>

	<section class="ftco-section contact-section">
      <div class="container">
        <div class="row block-9 justify-content-center mb-5">
          <div class="col-md-8 mb-md-5">
          	<h2 class="text-center" id="n_text">공지사항 등록</h2>
			<form id="form" class="bg-light p-5 contact-form">
				<select class="code_select" name="code_value" size="1">
		     		<c:forEach var="c" items="${category}">
		     			<option value="${c.code_value }">${c.code_name }</option>
		     		</c:forEach>
		        </select>
		        <br>
				<div class="form-group">
					<input type="hidden" name="n_no" value="${n_no }">
				</div>
				<div class="form-group">
					<input type="text" name="n_title" class="form-control" id="n_insert_title" placeholder="제목을 입력하세요" >
				</div>
				<div class="form-group">
					<textarea rows="20" cols="100" name="n_content" class="form-control" id="n_insert_content" placeholder="내용을 입력하세요"></textarea>
				</div>
				<input class="mb-6" type="file" name="uploadFile">
				<br>
				<a href="/listNotice"><button type="button" class="btn btn-warning" id="btnCancelN">취소</button></a>
				<button type="button" class="btn btn-success" id="btnInsertN">등록</button>	
			</form>
	      </div>
	    </div>
	  </div>
	</section>	
	<br>
	<jsp:include page="footer.jsp" />
</body>
</html>