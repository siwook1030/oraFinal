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
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
const RECORDS_PER_PAGE = 10;
const PAGE_LINKS = 5;
var page = 1;	// 현재 페이지
$(document).ready(function(){
	getJson();
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
			page: page,
			RECORDS_PER_PAGE: RECORDS_PER_PAGE
		},
		success: function(data){
			var total_pages = data.total_pages;
			//console.log("total_pages : " + total_pages);
			$("tbody").empty();
			$(data.list).each(function(idx,item){
				var tr = $("<tr></tr>").addClass("row");
				var td1 = $("<td></td>").html(item.r_no);
				var td2 = $("<td></td>").html(item.c_name);
				var a = $("<a></a>").attr("href","detailReview?r_no="+item.r_no).text(item.r_title);
				var td3 = $("<td></td>").html(a);
				var img = $("<img>").attr({
					src: "rank/"+item.rank_icon,
					height: "20px"
				});
				var td4 = $("<td></td>").append(img,item.nickName);
				var td5 = $("<td></td>").html(item.r_regdate);
				var td6 = $("<td></td>").html(item.r_hit);
				tr.append(td1,td2,td3,td4,td5,td6);
				$("tbody").append(tr);
			})
			var num = parseInt(total_pages / PAGE_LINKS);
			if(total_pages % PAGE_LINKS != 0) {
				num += 1;
			}
			//console.log("num : "+num);
			var end_page = PAGE_LINKS * num;
			var begin_page = end_page - (PAGE_LINKS - 1);
			if(end_page > total_pages) {
				end_page = total_pages;
			}

			$("#pageLink").empty();
			if(begin_page > PAGE_LINKS) {
				var previous = $("<a></a>").attr("href", "");
				previous.preventDefault;
				previous.text("[이전]").click(function(){
					page = page - PAGE_LINKS;
					getJson();
				});
				$("#pageLink").append(previous, " ");
			}
			for(var i = begin_page; i <= end_page; i++) {
				var a = $("<a></a>").attr("href", "").attr("idx",i);
				a.preventDefault;
				a.text(i).click(function(){
					page = $(this).attr("idx");
					alert("page : "+page);
					console.log("page : "+page);
					getJson();
				});
				$("#pageLink").append(a, " ");
			}
			if(total_pages > end_page) {
				var next = $("<a></a>").attr("href", "");
				next.preventDefault;
				next.text("[다음]").click(function(){
					page = page + PAGE_LINKS;
					if(page > total_pages) {
						page = total_pages;
					}
					getJson();
				});
				$("#pageLink").append(next, " ");
			}
			//console.log("begin_page : "+begin_page);
			//console.log("end_page : "+end_page);
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