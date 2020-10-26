<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/login.js"></script>
</head>
<body>
<div class="container">
 <h2>오늘의 라이딩 로그인</h2>
  <p>오늘도 힘차게 달려볼까요?</p>
  <form action="/action_page.php" class="was-validated">
    <div class="form-group">
      <label for="member-id">아이디</label>
      <input type="text" class="form-control" id="member-id" placeholder="Enter id" name="member-id"  maxlength="12" required>
      <div class="valid-feedback">입력완료.</div>
      <div class="invalid-feedback">입력해주세요.</div>
    </div>
    <div class="form-group">
      <label for="member-password">비밀번호</label>
      <input type="password" class="form-control" id="member-password" placeholder="Enter password" name="member-password" maxlength="12" required>
      <input type="hidden" id="token" data-token-name="${_csrf.headerName}" placeholder="Password" value="${_csrf.token}">
      <div class="valid-feedback">입력완료.</div>
      <div class="invalid-feedback">입력해주세요.</div>
    </div>
    <a href="/signUp"><button class="btn btn-primary" type="button">회원가입</button></a> <button id="login-button" type="button" class="btn btn-primary">로그인</button>
  </form>
</div>
</body>
</html>