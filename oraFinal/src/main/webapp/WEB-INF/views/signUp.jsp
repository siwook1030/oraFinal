<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	* {
		margin: 0;
		padding: 0;
	}
	#form {
		margin: 8px auto;
		text-align: center;
	}
	#form input {
		height: 40px;
		width: 300px;
	}
	#radioBox {
		margin: 15px auto 15px auto;
		text-align: center;
	}
	#radioBox form{
		width: 100px;
	}
	#inputNumForm {
		visibility: hidden;
		text-align: center;
		margin: 10px auto;
	}
	#inputNum {
		height: 20px;
		width: 200px;
	}
	#checkNum {
		height: 25px;
		width: 100px;
	}
	#clickForm{
		text-align: center;
		margin: 0 auto;
		width: 400px;
	}
	#clickForm input {
		height: 30px;
		width: 310px;
	}

	#join{

		text-align: center;
		margin: 20px auto;
	}
	#join input{

		height: 45px;
		width: 310px;
	}

</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/js/signUp.js"></script>
</head>
<body>
<h1>ORA 회원가입</h1>
	<hr>
	<form id="signUpForm" name="signUpForm" action="/signUp" method="post">
				<div id="form">
					<input type="text" id="id" name="id" maxlength="12" placeholder="id(8~12자리)">
				</div>
				<div id="form">
					<input id="password" name="password" maxlength="12" type="password" placeholder="password(8~12자리)">
				</div>
				<div id="form">
					<input id="passwordCheck" name="passwordCheck" maxlength="12" type="password" placeholder="password Check">
				</div>
				<div id="form">
					<input id="name" name="name" type="text"  maxlength="6" placeholder="name ex)홍길동">
				</div>
				<div id="radioBox">
					여자<input type="radio" id="gender" name="gender" value="W" checked="checked">
					남자<input type="radio" id="gender" name="gender" value="M">
				</div>
				<div id="form">
					<input id="nickName" name="nickName" type="text" maxlength="8" placeholder="닉네임(최대 8자리)">
				</div>
				<div id="form">
					<input type="tel" id="phone" name="phone" maxlength="11"  placeholder="ex)01012345678" >
					<input type="hidden" id="chekedPhone" value="">
					<input type="hidden" id="chekingPhone" value="N">
				</div>
				<div id="clickForm">
					<input type="button" id="sendPhone" value="인증번호 발송">
				</div>
				<div id="inputNumForm">
					<input type="tel" id="inputNum" name="inputNum" maxlength="6" placeholder="인증번호">
					<input type="button" id="checkNum" value="인증">
				</div>
				
	</form>
				<div id="join">
					<input type="button" id="signUp" value="Sign Up">
				</div>				
</body>
</html>