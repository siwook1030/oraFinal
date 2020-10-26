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
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var textarea = $("<textarea></textarea>").attr({
		rows: "3",
		cols: "60"
	});
	var button = $("<button></button>").text("등록");
	$("#replyTextArea").append(textarea,button);

	$(".btnReply").click(function(){
		$(this).parent(".reply").children(".replyTextArea").append(textarea,button);
	});
});
</script>
</head>
<body>
<jsp:include page="header.jsp"/>
<section>
		<br><br>
		<p style="font-size: 20px">후기 게시판&nbsp;&gt;&nbsp;<font color="#c85725">후기 상세</font></p>
		<p style="font-size: 15px">라이딩 경험을 공유해요.</p>
		
		<br><br>
	
		<p style="font-size: 30px">${rvo.r_title }</p><br>	
			<img src="rank/${rvo.rank_icon }" height="25">
			${rvo.nickName }&nbsp;&nbsp;
			${rvo.r_regdate }&nbsp;&nbsp;
			조회수 ${rvo.r_hit }
	
		<br>
		
		<hr>
		<div style="padding: 3px;">코스 : ${rvo.c_name }</div>
		<hr>
		
		<br>
		<c:forEach var="rfvo" items="${rflist }">
			<img src="${rfvo.rf_path }/${rfvo.rf_savename}" width="400" height="400">
		</c:forEach>
		
		<br><br><br>
		${rvo.r_content }
		<br><br><br><br>
		
		<!-- 수정,삭제 버튼 -->
		<c:if test="${rvo.id == m.id }">
			<a href="deleteReview?r_no=${rvo.r_no }"><img src="buttons/delete.png" class="button"></a>
			<a href="updateReview?r_no=${rvo.r_no }"><img src="buttons/edit.png" class="button"></a>
		</c:if>
		<br><br>
	
		
		<h3>댓글&nbsp;${rvo.total_reply }</h3>
		<hr>
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
				<img src="buttons/reply.png" width="50px" align="right" class="btnReply">
				<div class="replyTextArea"></div>
			</div>
			<br><br><br>
		</c:forEach>
		<div id="replyTextArea"></div>
		
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