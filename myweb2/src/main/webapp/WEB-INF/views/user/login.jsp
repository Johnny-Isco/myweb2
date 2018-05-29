<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
<style>
.board_list {width: 500px; margin: 0 auto;}
.btn_area {height: 35px; text-align: center;}
</style>
</head>
<body>
<form id="frm">
<table class="board_list">
	<caption>로그인</caption>
	<tbody>
		<tr>
			<th scope="row">아이디</th>
			<td><input type="text" id="user_id" name="ID" class="wdp_90"></td>
		</tr>
		<tr>
			<th scope="row">비밀번호</th>
			<td><input type="password" id="user_pwd" name="PASSWORD" class="wdp_90"></td>
		</tr>
	</tbody>
</table>
</form>

<div class="btn_area">
	<a id="login_btn" class="btn">로그인</a>
</div>
<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
$(document).ready(function(e) {
	$("#login_btn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_login();
	});
});

// 로그인 함수
function fn_login() {
	if($("#user_id").val().length < 1)
	{
		alert("아이디를 입력해주세요.");
	}
	else if($("#user_pwd").val().length < 1)
	{
		alert("비밀번호를 입력해주세요.");
	}
	else
	{
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
}
</script>
</body>
</html>