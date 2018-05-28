<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
<ul>
	<li><a href="#" id="signUpBtn">회원가입</a></li>
	<li><a href="#" id="loginBtn">로그인</a></li>
	<li><a href="#" id="bbsBtn">게시판</a></li>
</ul>
</body>
<script>
$(document).ready(function() {
	$("#signUpBtn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="../user/openSignUp.do";
	});
	
	$("#loginBtn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="";
	});
	
	$("#bbsBtn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="../bbs/openBoardList.do";
	});
});
</script>
</html>