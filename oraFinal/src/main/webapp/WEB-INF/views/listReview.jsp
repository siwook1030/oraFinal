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
}
#pageLink {
	text-align: center;
}
.pageClick {
	background-color: #88BFAB;
	border-radius: 20px;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
const RECORDS_PER_PAGE = 10;	// 페이지당 레코드 수
const PAGE_LINKS = 5;			// 페이지 하단에 표시되는 페이지링크 수
let page = 1;	// 현재 페이지 저장 변수(기본은 1페이지)
$(document).ready(function(){
	getJson();
	// 마우스 over,leave 이벤트
	$(document).on("mouseover", ".row", function(){
		$(this).css("background-color","#88bea6");
	});
	$(document).on("mouseleave", ".row", function(){
		$(this).css("background-color","white");
	});
});
function getJson(){
	$.ajax({
		url: "/listReviewJson",
		dataType: "json",
		data: {
			page: page,	// 현재 페이지 정보 전달
			RECORDS_PER_PAGE: RECORDS_PER_PAGE	// 페이지당 레코드 수 전달
		},
		success: function(data){
			var total_pages = data.total_pages;
			//console.log("total_pages : " + total_pages);
			$("tbody").empty();		// 기존 레코드 삭제
			$(data.list).each(function(idx,item){
				var tr = $("<tr></tr>").addClass("row");	// 마우스 over,leave 이벤트	적용을 위한 클래스
				var td1 = $("<td></td>").html(item.r_no);
				var td2 = $("<td></td>").html(item.c_name);
				var a = $("<a></a>").attr("href","detailReview?r_no="+item.r_no).text(item.r_title);
				var td3 = $("<td></td>").html(a);
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
		<c:if test="${m != null }">
			<a href="/insertReview"><img src="buttons/insert.png" height="30px" align="right"></a>
		</c:if>
		<br><br>
		<div class="pageStr">${pageStr }</div>
	</section>
<jsp:include page="footer.jsp"/>
</body>
</html>