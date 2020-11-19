<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
section {
	margin: 0 auto;
	width: 1000px;
	text-align: left;
}
table {
	border-collapse: collapse;
	text-align: center;
}
.pageStr {
	text-align: center;
}
td, th {
	border-bottom: 1px #7a7a7a solid;
}
a {
	text-decoration: none;
	color: black;
}
#pageLink {
	text-align: center;
}
.pageClick {
	background-color: #88BFAB;
	border-radius: 20px;
}
#searchANDinsertContainer {
	display: flex;
	flex-direction: row;
}
#btnInsert {
	flex-grow: 1;
	flex-basis: 50%;
}
#searchInputWrap {
	float: right;
}
#searchTypeWrap {
	margin-top: 1px;
}
.total_reply {
	color: blue;
	font-size: 10px;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
let searchType = "";	// id,코스번호,제목,내용
let searchValue = "";	// 검색을 위한 사용자입력값
let searchMethod = 0;	// 제목,내용 검색방법을 일치or포함중에 선택
let courseList;			// List<CourseVo> 를 담은 변수. select-option 태그 만들기 위한 용도

// 마이페이지에서 내가 쓴 게시글 조회했을때 처리하기위한 코드.
// GET방식 쿼리라서 querystring을 가져오기 위한 설정
const URLSearch = new URLSearchParams(location.search);
if(URLSearch.has("searchType")) {
	searchType = URLSearch.get("searchType");
}
if(URLSearch.has("searchValue")) {
	searchValue = URLSearch.get("searchValue");
}
if(URLSearch.has("searchMethod")) {
	searchMethod = URLSearch.get("searchMethod");
}

const RECORDS_PER_PAGE = 10;	// 페이지당 레코드 수
const PAGE_LINKS = 5;			// 페이지 하단에 표시되는 페이지링크 수
let page = 1;	// 현재 페이지 저장 변수(기본은 1페이지)

$(document).ready(function(){
	getJson();			// 댓글과 페이지링크 만드는 함수
	getCourseList();	// List<CourseVo> 받아오기. 코스명으로 게시글 검색용도
	createInput("id");	// 처음엔 기본으로 id기반 검색으로 설정됨
	// 마우스 over,leave 이벤트
	$(document).on("mouseover", ".row", function(){
		$(this).css("background-color","#88bea6");
	});
	$(document).on("mouseleave", ".row", function(){
		$(this).css("background-color","white");
	});

	$("#searchType").change(function(){		// searchType이 바뀔때마다 동적으로 검색기능 생성
		createInput($(this).val());
	});
	$(document).on("click", "#btnSearch", function(){	// 검색버튼 눌렀을때 게시물 목록을 거기에 맞춰서 다시 가져온다.
		searchType = $("#searchType").val();
		searchValue = $("#searchValue").val();
		if(searchType === "r_title" || searchType === "r_content") {
			searchMethod = $("#searchMethod").val();
		}
		getJson();
	});
});
function createInput(searchType){	// 검색기능 동적으로 생성
	$("#searchInputWrap").empty();
	if(searchType === "c_no") {
		let $select = $("<select></select>").attr("id", "searchValue");
		for(let i = 0; i < courseList.length; i++) {
			let $option = $("<option></option>").val(courseList[i].c_no).text(courseList[i].c_name);
			$select.append($option);
		}
		$("#searchInputWrap").append($select);
	}else {
		let $input = $("<input>").attr({type: "text", id: "searchValue", size: 10});
		$("#searchInputWrap").append($input);
	}

	if(searchType === "r_title" || searchType === "r_content") {
		let $select = $("<select></select>").attr("id", "searchMethod");
		let $option1 = $("<option></option>").val("1").text("일치");
		let $option2 = $("<option></option>").val("2").text("포함");
		$select.append($option1, $option2);
		$("#searchInputWrap").append($select);
	}
	
	let $button = $("<button></button>").attr("id", "btnSearch").text("검색");
	$("#searchInputWrap").append($button);
}

function getCourseList(){	// List<CourseVo> 받아오기. 코스명으로 게시글 검색용도
	$.ajax({
		url: "/getCourseList",
		success: function(data){
			courseList = data;
		}
	});
}

function getJson(){
	$.ajax({
		url: "/listReviewJson",
		dataType: "json",
		method: "post",
		data: {
			page: page,	// 현재 페이지 정보 전달
			RECORDS_PER_PAGE: RECORDS_PER_PAGE,	// 페이지당 레코드 수 전달
			searchType: searchType,
			searchValue: searchValue,
			searchMethod: searchMethod
		},
		success: function(data){
			var total_pages = data.total_pages;
			//console.log("total_pages : " + total_pages);
			//console.log("data.list : " + data.list);
			$("tbody").empty();		// 기존 레코드 삭제
			$(data.list).each(function(idx,item){
				var tr = $("<tr></tr>").addClass("row");	// 마우스 over,leave 이벤트	적용을 위한 클래스
				var td1 = $("<td></td>").html(item.r_no);
				var td2 = $("<td></td>").html(item.c_name);
				var a = $("<a></a>").attr("href","detailReview?r_no="+item.r_no).text(item.r_title);
				// >>> 여기 댓글 수 추가
				var $span = $("<span></span>").text(" ["+item.total_reply+"]").addClass("total_reply");
				var td3 = $("<td></td>").append(a, $span);
				var img = $("<img>").attr({
					src: "rank/"+item.rank_icon,
					height: "20px"
				});
				var td4 = $("<td></td>").append(img,item.nickName);
				var td5 = $("<td></td>").text(item.date_diff_str);
				var td6 = $("<td></td>").text(item.r_hit);
				tr.append(td1,td2,td3,td4,td5,td6);
				$("tbody").append(tr);
			})
			// 페이지 하단에 표시되는 페이지링크 수에 따른 시작페이지, 종료페이지 계산
			// tmp는 시작페이지, 종료페이지 계산을 위한 임시변수
			var tmp = parseInt(page / PAGE_LINKS);	// 소수점에서 정수로 변환
			if(page % PAGE_LINKS != 0) {
				tmp += 1;
			}
			var end_page = PAGE_LINKS * tmp;
			var begin_page = end_page - (PAGE_LINKS - 1);
			if(end_page > total_pages) {
				end_page = total_pages;
			}
			
			$("#pageLink").empty();		// 기존 페이지 링크 삭제
			if(begin_page > PAGE_LINKS) {
				var $previous = $("<a></a>").attr("href", "").text("[이전]");
				$previous.click(function(event){
					event.preventDefault();
					page = page - PAGE_LINKS;
					getJson();
				});
				$("#pageLink").append($previous, " ");
			}
			for(var i = begin_page; i <= end_page; i++) {
				// a태그 속성 idx는 클릭이벤트때 페이지값을 알기위한 임의로 만든 속성
				var $a = $("<a></a>").attr({href: "",idx: i}).text(i);
				if(page == i) {
					$a.addClass("pageClick");	// 현재 페이지랑 일치하는 페이지링크에 css클래스 적용
				}
				$a.click(function(event){
					event.preventDefault();
					page = $(this).attr("idx");
					getJson();
				});
				$("#pageLink").append($a, " ");
			}
			if(total_pages > end_page) {
				var $next = $("<a></a>").attr("href", "").text("[다음]");
				$next.click(function(event){
					event.preventDefault();
					page = Number(page) + PAGE_LINKS;	// page를 문자열로 인식해서 Number로 형변환 후 계산해야 함.
					if(page > total_pages) {
						page = total_pages;
					}
					getJson();
				});
				$("#pageLink").append($next, " ");
			}
		}
	})
}
</script>
</head>
<body>
<jsp:include page="header.jsp"/>
<section>
   		<br>
		<p style="font-size: 20px">후기 게시판</p>
		<p style="font-size: 15px">라이딩 경험을 공유해요.</p>
		<br><br><br>
		<hr style="height: 10%; color: black;">
		<br>
		<table width="100%">
			<thead>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					 <th>코스</th>
					 <th>제목</th>
					 <th>작성자</th>
					 <th>작성시간</th>
					 <th>조회</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<div id="pageLink"></div>
		<br>
		<div id="searchANDinsertContainer">
			<div id="searchTypeWrap">
				<select id="searchType">
					<option value="id">ID</option>
					<option value="c_no">코스</option>
					<option value="r_title">글제목</option>
					<option value="r_content">글내용</option>
				</select>
			</div>
			<div id="searchInputWrap"></div>
			<div id="btnInsert">
				<a href="/user/insertReview"><img src="buttons/insert.png" height="30px" align="right"></a>
			</div>
		</div>
		<br><br>
		
	</section>
<jsp:include page="footer.jsp"/>
</body>
</html>