<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach var="c" items="${courseList }">
		코스번호 :   ${c.c_no }
		<c:forEach var="cp" items="${c.c_photo }">
			코스 뭐야:  ${cp.cp_name }
		</c:forEach>
		
	</c:forEach>
</body>
</html>