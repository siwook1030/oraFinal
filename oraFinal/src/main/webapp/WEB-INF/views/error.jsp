<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
<title>Insert title here</title>
	<style type="text/css">
		/* 공통 */
		section {
			margin: 0 auto;
			width: 1000px;
			text-align: left;
		}
		
		/* 개별 */
		#error {
			width: 400px;
			height: 150px;
			margin: 200px auto;
			padding: 30px;
			text-align: center;
			color: white;
			background-color: #88bea6;
		}
		#id {
			margin-bottom: 5px;
		}
		p {
			margin: 10px;
		}
		hr {
			border: 1px solid white;
			margin: 10px auto 40px;
		}
	</style>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<section>
		<div id="error">
			<h3 id="title">* error *</h3>
			<hr>
			<p>이용에 불편을 드려 죄송합니다.</p>
			<p>${msg }</p>
		</div>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
</html>