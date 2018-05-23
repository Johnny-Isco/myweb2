<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
<form id="frm" name="frm" enctype="multipart/form-data">
<table class="board_view">
	<colgroup>
		<col width="15" />
		<col width="*" />
	</colgroup>
	
	<caption>게시글 작성</caption>
	
	<tbody>
		<tr>
			<th scope="row">제목</th>
			<td><input type="text" id="TITLE" name="TITLE" class="wdp_90" /></td>
		</tr>
		<tr>
			<td colspan="2" class="view_text">
				<textarea rows="20" cols="100" title="내용" id="CONTENTS" name="CONTENTS"></textarea>
			</td>
		</tr>
	</tbody>
</table>
<div id="fileDiv">
	<p>
		<input type="file" id="file" name="file_0">
		<a href="#" class="btn" id="delete" name="delete"> 삭제</a>
	</p>
</div>
<br><br>

<a href="#" class="btn" id="addFile">파일추가</a>
<a href="#" class="btn" id="write">작성하기</a>
<a href="#" class="btn" id="list">목록으로</a>

</form>

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
		fn_insertBoard();
	});
	
	$("#addFile").unbind("click").click(function(e) {
		e.preventDefault();
		fn_addFile();
	});
	
	$("a[name='delete']").unbind("click").click(function(e) {
		e.preventDefault();
		fn_deleteFile($(this));
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
		+ "<a href='#' class='btn' name='delete'>삭제</a>"
		+ "</p>";
	
	$("#fileDiv").append(str);
	$("a[name='delete']").unbind("click").click(function(e) {
		e.preventDefault();
		fn_deleteFile($(this));
	});
}

// 첨부파일 삭제 이벤트 함수
function fn_deleteFile(obj) {
	obj.parent().remove();
}
</script>
</body>
</html>