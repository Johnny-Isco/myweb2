<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/include/include-header.jsp" %>
<style>
.blind {overflow: hidden; visibility: hidden;}
</style>
</head>
<body>
<%@include file="/WEB-INF/include/include-title.jsp" %>
<div class="container">
	${weather_info }
</div>

<script>
$(document).ready(function() {
	drawTable();
});

function drawTable() {
	$(".tbl_weather").attr("class", "table");
}
</script>
</body>
</html>