<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
<style>
.table {width: 500px; margin: 0 auto;}
.table tfoot {text-align: center;}
.signUp_agree {text-align: center;}
.signUp_agree_textarea {text-align: center;}
.signUp_agree_textarea textarea {resize: none;}
</style>
</head>
<body>
<%@ include file="/WEB-INF/include/include-title.jsp" %>
<div class="container">
	<form id="frm">
		<div class="row">
			<div class="col-md-12">
				<table class="table">
					<caption>회원가입</caption>
					<thead>
						<tr>
							<td colspan="3" class="signUp_agree">약관동의</td>
						</tr>
						<tr>
							<td colspan="3" class="signUp_agree_textarea"><textarea rows="20" cols="100" readonly="readonly">회원가입 약관동의 내용</textarea></td>
						</tr>
						<tr>
							<td colspan="3" class="signUp_agree_checkbox"><input type="checkbox" id="agree_checkbox" placeholder="">약관에 동의</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">이름</th>
							<td><input type="text" id="user_name" name="NAME" class="form-control" placeholder="이름을 입력해주세요." autofocus="autofocus"></td>
							<td></td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td><input type="text" id="user_tel" name="TEL" class="form-control" placeholder="ex) 010-1234-1234"></td>
							<td></td>
						</tr>
						<tr>
							<th scope="row">아이디</th>
							<td><input type="text" id="user_id" name="ID" class="form-control" placeholder="아이디를 입력해주세요."></td>
							<td><button id="user_id_checkBtn" class="btn btn-primary">중복확인</button></td>
						</tr>
						<tr>
							<th scope="row">비밀번호</th>
							<td><input type="password" id="user_pwd" name="PASSWORD" class="form-control" placeholder="비밀번호를 입력해주세요."></td>
							<td></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="3">
								<button class="btn btn-success" id="signUpBtn">회원가입</button>
								<button class="btn" id="homeBtn">취소</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</form>
</div>
<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
$(document).ready(function() {
	$("#user_id_checkBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_userIDCheck();
	});
	
	$("#signUpBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_signUp();
	});
	
	$("#homeBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_cancel();
	});
});

// 아이디 중복체크 함수
function fn_userIDCheck() {
	var userId = $("#user_id").val();
	var userData = {"ID": userId};
	
	if(userId.length < 1)
	{
		alert("아이디를 입력해주시기 바랍니다.");
	}
	else
	{
		$.ajax({
			type	: "POST",
			url		: "/user/checkUserID.do",
			data	: userData,
			dataType: "json",
			success	: function(result) {
				if(result.RESULT == 0)
				{
					$("#user_id").attr("readonly", true);
					alert("사용이 가능한 아이디입니다.");
				}
				else if(result.RESULT == 1)
				{
					alert("이미 존재하는 아이디입니다.");
				}
				else
				{
					alert("에러가 발생하였습니다.");
				}
			},
			error	: function(request, status, error) {
				alert("서버가 응답하지 않습니다." + "\n" + "다시 시도해주시기 바랍니다." + "\n" 
						+ "code: " + request.status + "\n" 
						+ "message : " + request.responseText + "\n" 
						+ "error: " + error);
			}
		});
	}
}

// 회원가입 함수
function fn_signUp() {
	if($("#agree_checkbox").prop("checked") == false)
	{
		alert("약관에 동의해주시기 바랍니다.");
	}
	else if($("#user_name").val().length < 1)
	{
		alert("이름을 작성해주세요.");
	}
	else if($("#user_tel").val().length < 1)
	{
		alert("전화번호를 작성해주세요.");
	}
	else if($("#user_id").val().length < 1)
	{
		alert("사용하실 아이디를 작성해주세요.");
	}
	else if($("#user_pwd").val().length < 1)
	{
		alert("사용하실 비밀번호를 작성해주세요.");
	}
	else if(!$("#user_id").attr("readonly"))
	{
		alert("아이디 중복체크를 해주세요.");
	}
	else
	{
		if(window.confirm("회원가입을 하시겠습니까?"))
		{
			$.ajax({
				type	: "POST",
				url		: "../user/signUp.do",
				data	: $("#frm").serialize(),
				dataType: "json",
				success	: function(result) {
					alert(result.msg);
					window.location.href="/home/openHome.do";
				},
				error	: function(request, status, error) {
					alert("서버가 응답하지 않습니다." + "\n" + "다시 시도해주시기 바랍니다." + "\n" 
							+ "code: " + request.status + "\n" 
							+ "message : " + request.responseText + "\n" 
							+ "error: " + error);
				}
			});
		}
	}
}

// 취소 함수
function fn_cancel() {
	if(window.confirm("메인 화면으로 돌아가시겠습니까?"))
	{
		window.location.href="/home/openHome.do";
	}
}
</script>
</body>
</html>