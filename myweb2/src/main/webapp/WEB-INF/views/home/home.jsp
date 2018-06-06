<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
<style>
.left_layout {width: 30%; float: left;}
.right_layout {width: 70%; float: left;}
.menu_layout {display: table; margin: 0 auto;}
.form-signin {width: 400px; margin: 0 auto;}
</style>
</head>
<body>
<%@ include file="/WEB-INF/include/include-title.jsp" %>
<div class="container">
	<div class="left_layout">
		<h1>게시판입니다.</h1>
		<p class="lead">
			게시판 웹 프로젝트에요.
		</p>
			<!-- 
		<ul>
			<li><a href="#" id="signUpBtn">회원가입</a></li>
			<c:choose>
				<c:when test="${loginInfo == null }">
					<li><a href="#" id="loginBtn">로그인</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="#" id="logoutBtn">로그아웃</a>
				</c:otherwise>
			</c:choose>
			<li><a href="#" id="bbsBtn">게시판</a></li>
		</ul>
		 -->
	</div>
	<c:choose>
		<c:when test="${loginInfo == null }">
			<div class="right_layout">
				<form class="form-signin" id="frm">
					<h2 class="form-signin-heading">로그인</h2>
					<label for="inputID" class="sr-only">ID</label>
					<input type="text" id="user_id" name="ID" class="form-control" placeholder="ID" autofocus="autofocus">
					<label for="inputPassword" class="sr-only">Password</label>
					<input type="password" id="user_pwd" name="PASSWORD" class="form-control" placeholder="Password">
					<div class="checkbox">
						<label><input type="checkbox" value="remember-me">로그인 상태 유지</label>
					</div>
					<button class="btn btn-lg btn-primary btn-block" id="login_btn">로그인</button>
					<button class="btn btn-lg btn-success btn-block" id="signUp_btn">회원가입</button>
				</form>			
			</div>
		</c:when>
		<c:otherwise>
			<div class="right_layout">
				<div class="menu_layout">
					<h1><button class="btn btn-lg btn-default btn-block" id="bbs_btn">게시판</button></h1>
					<h1><button class="btn btn-lg btn-default btn-block" id="logout_btn">로그아웃</button></h1>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script>
$(document).ready(function(e) {
	$("#login_btn").unbind("click").click(function(e) {
		e.preventDefault();
		if ($("#user_id").val().length < 1)
		{
			alert("아이디를 입력해주세요.");
		}
		else if ($("#user_pwd").val().length < 1)
		{
			alert("비밀번호를 입력해주세요.");
		}
		else
		{
			fn_login();			
		}
	});
	
	$("#signUp_btn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="/user/openSignUp.do";
	});
	
	$("#bbs_btn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_bbs();
	});
	
	$("#logout_btn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_logout();
	});
});

// 로그인 함수
function fn_login() {
	$.ajax({
		type	: "POST",
		url		: "/user/login.do",
		data	: $("#frm").serialize(),
		dataType: "json",
		error	: function(request, status, error) {
			alert("서버가 응답하지 않습니다." + "\n" + "다시 시도해주시기 바랍니다." + "\n" 
					+ "code: " + request.status + "\n" 
					+ "message : " + request.responseText + "\n" 
					+ "error: " + error);
		},
		success	: function(result) {
			if(result.status == 0)
			{
				alert(result.msg);
				window.location.href="/home/openHome.do";
			}
			else if(result.status == 1)
			{
				alert(result.msg);
			}
		}
	});
}

// 게시판 이동 함수
function fn_bbs() {
	window.location.href="/bbs/openBoardList.do";
}

// 로그아웃 함수
function fn_logout() {
	if(window.confirm("정말로 로그아웃 하시겠습니까?"))
	{
		window.location.href="/user/logout.do";
	}
}
</script>
</body>
</html>