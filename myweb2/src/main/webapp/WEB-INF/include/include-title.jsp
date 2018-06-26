<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
body {margin-top: 100px;}
</style>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="#">MyWeb</a>
	</div>
	<div id="navbar" class="collapse navbar-collapse">
		<ul class="nav navbar-nav">
			<li><a href="#" id="nav_home_btn">HOME</a></li>
			<!-- 
			<li><a href="#" id="nav_signUp_btn">회원가입</a></li>
			 -->
			<c:choose>
				<c:when test="${loginInfo == null }">
					<li><a href="#" id="nav_login_btn">로그인</a></li>	
				</c:when>
				<c:otherwise>
					<li><a href="#" id="nav_logout_btn">로그아웃</a></li>	
				</c:otherwise>
			</c:choose>
			<li><a href="#" id="nav_bbs_btn">게시판</a>
			<li><a href="#" id="nav_weather_btn">날씨정보</a></li>
		</ul>
	</div>
</nav>

<script>
$(document).ready(function() {
	$("#nav_home_btn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="/home/openHome.do";
	});
	
	/*
	$("#nav_signUp_btn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="/user/openSignUp.do";
	});
	*/
	
	$("#nav_login_btn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="/home/openHome.do";
	});
	
	$("#nav_logout_btn").unbind("click").click(function(e) {
		e.preventDefault();
		if(window.confirm("정말로 로그아웃 하시겠습니까?"))
		{
			window.location.href="/user/logout.do";
		}
	});
	
	$("#nav_bbs_btn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="/bbs/openBoardList.do";
	});
	
	$("#nav_weather_btn").unbind("click").click(function(e) {
		e.preventDefault();
		window.location.href="/crawler/openWeather.do";
	});
});
</script>