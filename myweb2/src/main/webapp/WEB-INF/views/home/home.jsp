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
</body>
<script>
$(document).ready(function() {
	$("#signUpBtn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="/user/openSignUp.do";
	});
	
	$("#loginBtn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="/user/openLogin.do";
	});
	
	$("#logoutBtn").unbind("click").click(function(e) {
		e.preventDefault();
		if(window.confirm("정말로 로그아웃 하시겠습니까?"))
		{
			window.location.href="/user/logout.do";
		}
	});
	
	$("#bbsBtn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="/bbs/openBoardList.do";
	});
});
</script>
</html>