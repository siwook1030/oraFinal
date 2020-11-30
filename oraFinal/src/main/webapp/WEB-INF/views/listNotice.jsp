<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>공지사항</title>
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

/*#btn_search,#btn_write{
	width:58px;
	height: 39px;
    border: none;
    border-radius:5px;
    color:#ffffff;
    padding: 5px 0;
    font: bold;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    font-weight: bold;
    margin: 0px;
    cursor: pointer;
}*/
	/* header dropdown */
	.ftco-navbar-light .navbar-nav > .nav-item .dropdown-menu {
		/* background: #fff;
		background-color: #fff;
		opacity: 0.7; */
		background: rgba(255,255,255,0.7);
		/* border: 2px solid white; */
		/* width: 100px; */
		min-width: 9rem;
		color: white;
	}
	.dropdown-item {
		font-weight: bold;
		color: #5D5D5D;
	} 
	.navbar .nav-item:hover .dropdown-menu .dropdown-item {
		color: #5D5D5D;
	}
</style> 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/js/loginCheck.js"></script>
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
	
	const btn_search = document.getElementById("btn_search");
	const code_value = document.getElementById("code_value");
	const search = document.getElementById("search");
	const rowDFlex = document.getElementById("rowDFlex");
	console.log("asdasd");
	const checkM = checkLogin(); // 로그인이 되어있는 상태인지 체크한다
	console.log(checkM);
	
	let pageNo = 1;
	const recordSize = ${recordSize};
	const pageSize = ${pageSize};
	listNotice();
	$("#id1").css({"display": "bloak" ,});
	$("#id2").css({"display": "none"});
	
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
					if(map.id !== '%'){
						$("#id1").css({"display": "none"});
						$("#id2").css({"display": "inline-block"});
				    }
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

	function setList(list){
		console.log(list);
		$('#rowDFlex').empty();
		$.each(list, function(i, n) {
			/*let listImg;
			console.log(n);
			if(n.n_file != null){
				listImg = $('<img id="listImg"/>').attr('src',"/noticeImg/"+n.n_file);
			} else {
				listImg = $('<img/>').attr('src',"/icons/empty.png");
			}
			const contentImg = $('<a></a>').addClass('block-20 img').attr("href",'detailNotice?n_no='+n.n_no).append(listImg);*/
			// 목록 사진
			
			const listImg = $('<div></div>').addClass('list_n_file');
			const code_name = $('<div></div>').addClass('list_code_name').html(n.code_name);
			const n_regdate = $('<div></div>').addClass('list_n_regdate').html(n.n_regdate);
			const n_bar = $('<div></div>').addClass('list_n_bar').html("|");
			const n_hit = $('<div></div>').addClass('list_n_hit').html(n.n_hit);
			const n_titleA = $('<a></a>').attr('href','detailNotice?n_no='+n.n_no).html(n.n_title);
            const n_title = $('<h3></h3>').addClass('heading').append(n_titleA);
			// 목록 상세

            const metaDiv = $('<div></div>').addClass('meta mb2-3');
            const metaDiv2 = $('<div></div>').addClass('meta mb-3');
            const textDiv = $('<div></div>').addClass('text');
            const contentImg = $('<a></a>').addClass('block-20 img').attr("style",'background-image: url(/noticeImg/'+n.n_file+')').attr("href",'detailNotice?n_no='+n.n_no).append(listImg);
            const blog_entryDiv = $('<div></div>').addClass('blog-entry justify-content-end');
            const col = $('<div></div>').addClass('col-md-3 d-flex ftco-animate fadeInUp ftco-animated');

            metaDiv.append(code_name);
            metaDiv2.append(n_regdate, n_bar, n_hit);
            textDiv.append(contentImg, metaDiv, metaDiv2, n_title);
            blog_entryDiv.append(textDiv);
            col.append(blog_entryDiv);

			$('#rowDFlex').append(col);   
		})
	}

	function setPage(totRecord){
		$('#pageUl').empty();
		$('#pageUl').css('cursor','pointer');
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
			$(prev).css({
				border: 'none'
			});
			const pageLi = $('<li></li>').append(prev);
			$(prev).click(function(){
				const idx = $(this).attr('idx');
				pageNo = idx;
				listNotice();
			});
			$('#pageUl').append(pageLi);
		}
		
		for(let i=startPage; i<=endPage; i++){
			const a = $('<span></span>').attr('idx',i).html(i);
			const pageLi = $('<li></li>').append(a);
			if(i==pageNo){
				$(a).css({
					color: 'white',
					backgroundColor: '#bae4f0',
					border: 'none'
				});
            } else {
            	$(a).css({
					border: 'none'
				});
		    }
			$(a).click(function() {
				const idx = $(this).attr('idx');
				if(pageNo==idx){
					return;
				} 
				console.log(idx);
				pageNo = idx;
				listNotice();
			});
			$('#pageUl').append(pageLi);			
		}
		if(totPage>endPage){
			const next = $('<span></span>').attr('idx',(endPage+1)).html('>');
			$(next).click(function(){
				const idx = $(this).attr('idx');
				pageNo = idx;
				listNotice();
			});
			$('#pageUl').append(pageLi);
		}
					
	}

}
	

	
</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a style="font-size: 30px;" class="navbar-brand" href="/mainPage">
				<span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
					<font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</font>
				</span>
			</a>
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
								<li id="courseDropPoint"  class="nav-item dropdown">
									<a class="nav-link  dropdown-toggle" href="#" data-toggle="dropdown" style="font-size: 15px;">  ${m.nickName } 라이더 님  </a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="/myPage?id=${m.id}"> 정보 수정 </a></li>
										<li><a class="dropdown-item" href="/myPageSaveCourse"> 찜 목록 </a></li>
										<li><a class="dropdown-item" href="/myPageMyCourse"> 내 코스 </a></li>
										<li><a class="dropdown-item" href="/listReview?searchType=id&searchValue=${m.id }"> My 후기 </a></li>
										<li><a class="dropdown-item" href="/listMeeting?id=${m.id}"> My 번개 </a></li>
										<li><a class="dropdown-item" href="/myPageMyRank"> 랭킹 </a></li>
									</ul>
								</li>
								<li class="nav-item"><a style="font-size: 15px;" href="/logout" class="nav-link">로그아웃</a></li>
								<c:if test="${m.code_value == '00101' }">
									<li class="nav-item"><a style="font-size: 15px;" href="/admin/adminPage" class="nav-link">관리자 페이지</a></li>
								</c:if>
							</c:when>
						</c:choose>
					</ul>
				</div>    
				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto" >
						<li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
						<li id="courseDropPoint"  class="nav-item active dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">  오늘의 라이딩  </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/listNotice"> 공지사항 </a></li>
							</ul>
						</li>
						<li id="courseDropPoint"  class="nav-item dropdown">
							<a class="nav-link  dropdown-toggle" href="#" data-toggle="dropdown">  라이딩 코스  </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/searchCourse"> 맞춤 코스 검색 </a></li>
								<li><a class="dropdown-item" href="/tagSearchCourse"> 태그 코스 검색 </a></li>
							</ul>
						</li>
						<li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
						<li class="nav-item"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
						<li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
    <!-- END nav -->
    
	<section class="hero-wrap hero-wrap-2" style="background-image: url('headerImg/noticeMain.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
             <p class="breadcrumbs"><span class="mr-2"><a href="mainPage">Home <i class="fa fa-chevron-right"></i></a></span> <span>오늘의 라이딩 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-3 bread">공지사항</h1>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section">
      <div class="container">
      
      	<div id="searchBox">
		     	<select class="code_select" id="code_value" name="code_value" size="1">
		     		<option value="0">전체</option>
		     		<c:forEach var="c" items="${category }">
		     			<option value="${c.code_value }">${c.code_name }</option>
		     		</c:forEach>
		        </select>
				<input type="search" id="search" placeholder="Search..." />
				<button class="btn btn-warning" id="btn_search">검색</button>

		</div>
			
        <div class="row d-flex" id="rowDFlex"><!-- 리스트출력 --></div> 
      	<br>

        
		<div class="row mt-5">
			<div class="col text-center">
				<div id="insertNotice"><a href="/admin/insertNotice" class="btn btn-success" id="btnWriteN">글쓰기</a></div>                    
				<div class="block-27">
					<ul class="pageUl" id="pageUl"><!-- 페이징처리 --></ul>
				</div>
			</div>
		</div>
	  </div> <!-- container -->
	</section>
	
	<br>

	<jsp:include page="footer.jsp" />
	
</body>
</html>