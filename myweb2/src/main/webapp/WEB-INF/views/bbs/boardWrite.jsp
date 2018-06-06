<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/include/include-title.jsp" %>
<div class="container">
	<form class="form" id="frm" name="frm" enctype="multipart/form-data">
		<table class="table">
			<colgroup>
				<col width="5%">
				<col width="*">
			</colgroup>
			<caption>게시글 작성</caption>
			<tbody>
				<tr>
					<td colspan="2">
						<input type="text" id="TITLE" name="TITLE" class="form-control" placeholder="제목" autofocus="autofocus">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea rows="20" cols="100" title="내용" id="CONTENTS" name="CONTENTS" class="form-control" placeholder="내용"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="form-group" id="fileDiv">
			<p>
				<input type="file" id="file" name="file_0">
				<button class="btn btn-default" id="delete" onclick="fn_deleteFile(this)"> 삭제</button>
			</p>
		</div>
		<br><br>
		
		<button class="btn btn-default" id="addFile">파일추가</button>
		<button class="btn btn-primary" id="write">작성하기</button>
		<button class="btn btn-default" id="list">목록으로</button>
	
		<input type="hidden" id="CREA_ID" name="CREA_ID" value="${loginInfo.ID }">
	</form>
</div>

<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
var gfv_count = 1;

$(document).ready(function() {
	$("#list").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardList();
	});
	
	$("#write").unbind("click").click(function(e) {
		e.preventDefault();
		if ($("#TITLE").val().length < 1)
		{
			alert("제목을 입력해주세요.");
		}
		else if ($("#CONTENTS").val().length < 1)
		{
			alert("내용을 입력해주세요.");
		}
		else
		{
			fn_insertBoard();
		}
	});
	
	$("#addFile").unbind("click").click(function(e) {
		e.preventDefault();
		fn_addFile();
	});
});

// 게시물 목록 화면 함수
function fn_openBoardList() {
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardList.do' />");
	comSubmit.submit();
}

// 게시물 등록 함수
function fn_insertBoard() {
	var comSubmit = new ComSubmit("frm");
	comSubmit.setUrl("<c:url value='/bbs/insertBoard.do' />");
	comSubmit.submit();
}

// 첨부파일 등록 추가 이벤트 함수
function fn_addFile() {
	var str = "<p>"
		+ "<input type='file' name='file_" + (gfv_count++) + "'>"
		+ "<button class='btn btn-default' onclick='fn_deleteFile(this)'>삭제</button>"
		+ "</p>";
	
	$("#fileDiv").append(str);
	/*
	$("button[name='delete']").unbind("click").click(function(e) {
		e.preventDefault();
		fn_deleteFile($(this));
	});
	*/
}

// 첨부파일 삭제 이벤트 함수
function fn_deleteFile(obj) {
	$(obj).parent().remove();
}
</script>
</body>
</html>