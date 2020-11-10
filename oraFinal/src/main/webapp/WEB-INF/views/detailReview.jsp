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
	height: auto;
	text-align: left;
}
.button {
	height: 30px;
	float: right;
}
.reply {
	padding-bottom: 3px;
}
.blank {
	width: 40px;
	height: 40px;
}
.replyGroup {
	float: left;
}
.replyTextArea {
	float: none;
}
.btnReplyWrap {
	float: right;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
var querystring = location.search;		// r_no=1
var n = querystring.indexOf("=");		// 4
var r_no = querystring.substring(n+1);	// 1 : 게시판번호 저장 변수
$(document).ready(function(){
	detailReviewReply();
	let $textarea = $("<textarea></textarea>").attr({rows: 3, cols: 65, required: "required"});
	let $div = $("<div></div>").addClass("btnReplyWrap");
	let $button = $("<button></button>").addClass("btnReply").text("등록");
	$div.append($button);
	$("#replyToBoardArea").append($textarea, $div).attr("rr_ref", 0);

	$(document).on("click", ".btnReply", function(event){
		let rr_ref = $(this).closest(".replyToReplyArea").attr("rr_ref");
		let rr_content = $(this).closest(".replyToReplyArea").children("textarea").val();
		insertReviewReply(rr_ref, rr_content);
	});

	// display: none / block 으로 댓글창 보이기 사라지기 << 할차례
	
	


	/*
	$(document).on("click", "#btnReplyToBoard", function(event){
		$.ajax({
			url: "",
			data: {r_no}
		})

	})
	*/
	/*var textarea = $("<textarea></textarea>").attr({
		rows: "3",
		cols: "65"
	});
	var button = $("<button></button>").text("등록");
	$(".btnReply").click(function(){
		$(this).parent(".reply").children(".replyTextArea").append(textarea,button);
	});
	$("#btnReply").click(function(){
		$("#replyTextArea").append(textarea,button);
	});
	$(".btnReply").click(function(event){
		event.preventDefault();
	});*/
});
function detailReviewReply(){
	$.ajax({
		url: "/detailReviewReply",
		data: {r_no: r_no},
		success: function(data){
			$("#replyArea").empty();
			$("#total_reply").html("댓글&nbsp;"+data.total_reply);
			$(data.rrlist).each(function(idx,item){
				var $div = $("<div></div>");
				if(item.rr_step > 0) {
					$div.css("margin-left", "25px");
				}
				var $div_c1 = $("<div></div>");
				var $img = $("<img>").attr({
					"src": "rank/" + item.rank_icon,
					"height": 25
				})
				var text = item.nickName + "&nbsp;&nbsp;&nbsp;&nbsp;" + item.date_diff_str;
				$div_c1.append($img, text);
				var $div_c2 = $("<div></div>").text(item.rr_content).css({
					"margin-top": "10px",
					"margin-bottom": "10px"
				});
				var $div_c3 = $("<div></div>");
				var $div_c3_c1 = $("<div></div>");
				$div.append($div_c1, $div_c2);
				$("#replyArea").append($div);
			})
		}
	})
}
function insertReviewReply(rr_ref, rr_content){
	$.ajax({
		url: "/insertReviewReply",
		data: {
			r_no: r_no,
			rr_ref: rr_ref,
			rr_content: rr_content
		},
		success: function(data){
			$(".replyToReplyArea").children("textarea").val("");
			detailReviewReply();
		}
	})
}
</script>
</head>
<body>
<jsp:include page="header.jsp"/>
<section>
		<br><br>
		<p style="font-size: 20px">후기 게시판&nbsp;&gt;&nbsp;<font color="#c85725">후기 상세</font></p>
		<p style="font-size: 15px">라이딩 경험을 공유해요.</p>
		
		<br><br>
		<!-- 게시글 시작 -->
		<!-- 제목 -->
		<p style="font-size: 30px">${rvo.r_title }</p><br>	
		<!-- 닉네임, 등록일자, 조회수 -->
			<img src="rank/${rvo.rank_icon }" height="25">
			${rvo.nickName }&nbsp;&nbsp;
			${rvo.date_diff_str }&nbsp;&nbsp;
			조회수 ${rvo.r_hit }
		<br>
		<hr>
		<!-- 코스명 -->
		<div style="padding: 3px;">코스 : ${rvo.c_name }</div>
		<hr>
		
		<br>
		<!-- 등록사진 -->
		<c:forEach var="rfvo" items="${rflist }">
			<img src="${rfvo.rf_path }/${rfvo.rf_savename}" width="400" height="400">
		</c:forEach>
		
		<br><br><br>
		<!-- 게시글내용 -->
		${rvo.r_content }
		<br><br><br><br>
		
		<div id="replyTextArea"></div>
		<!-- 수정,삭제 버튼 -->
		<c:if test="${rvo.id == m.id }">
			<a href="deleteReview?r_no=${rvo.r_no }"><img src="buttons/delete.png" class="button"></a>
			<a href="updateReview?r_no=${rvo.r_no }"><img src="buttons/edit.png" class="button"></a>
		</c:if>
		<br><br>
	
		<!-- 댓글 시작 -->
		<h3 id="total_reply"></h3>
		<hr>
		<div id="replyArea"></div>
		<hr><br>
		<!-- 게시글 댓글 등록 -->
		<c:if test="${m != null }">
			<div id="replyToBoardArea" class="replyToReplyArea"></div>
			<!-- 
			<textarea rows="3" cols="65"></textarea>
			<div class="btnReplyWrap">
				<button id="btnReplyToBoard">등록</button>
			</div>
			 -->
		</c:if>
		
		
		<!--  
		<c:forEach var="rrvo" items="${rrlist }">
			<div class="reply">
				<c:if test="${rrvo.rr_step > 0 }">
					<div class="blank replyGroup"></div>
				</c:if>
				<div class="replyGroup">
					<img src="rank/${rrvo.rank_icon }" height="25">${rrvo.nickName }
					&nbsp;&nbsp;&nbsp;&nbsp;${rrvo.rr_regdate }
					<br>
					<c:if test="${rrvo.rr_file != null }">
						<img src="reviewRep/${rrvo.rr_file }" width="100" height="100">
					</c:if>
					${rrvo.rr_content }<br>
				</div>
				<c:if test="${m != null }">
					<a href="" class="btnReply"><img src="buttons/reply.png" width="50px" align="right" class="btnReply"></a>
				</c:if>
				<div class="replyTextArea"></div>
			</div>
			<br><br><br>
		</c:forEach>
		-->
		
		<!-- 
		댓글등록
			<form action="insertMeeting_repOk.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="m_no">
				<input type="hidden" name="id">
				<textarea rows="5" cols="60" name="mr_content"></textarea><br>
				<input type="file" name="mr_file1">&nbsp;
				<input type="submit" value="등록">
			</form>
		 -->
</section>


<jsp:include page="footer.jsp"/>
</body>
</html>