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
	<form id="frm" name="frm" enctype="multipart/form-data">
		<table class="table">
			<caption>게시글 상세</caption>
			<tbody>
				<tr>
					<td><input type="text" class="form-control" id="TITLE" name="TITLE" value="${map.TITLE }"></td>
				</tr>
				<tr>
					<td class="view_text">
						<textarea rows="20" cols="100" title="내용" id="CONTENTS" name="CONTENTS" class="form-control"><c:out value="${map.CONTENTS }" /></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="form-group" id="fileDiv">
			<c:forEach var="row" items="${list }" varStatus="var">
				<p>
					<input type="hidden" id="IDX" name="IDX_${var.index }" value="${row.IDX }">
					<a href="#" id="name_${var.index }">
						<c:out value="${row.ORIGINAL_FILE_NAME }" />
					</a>
					<input type="file" id="file_${var.index }" name="file_${var.index }">
					${row.FILE_SIZE }kb
					<button class="btn btn-default" id="delete_${var.index }" onclick="fn_deleteFile(this)">삭제</button>
				</p>
			</c:forEach>
		</div>
		
		<button class="btn btn-default" id="addFile">파일추가</button>
		<button class="btn btn-default" id="list">목록으로</button>
		<button class="btn btn-primary" id="update">저장하기</button>
		<button class="btn btn-danger" id="delete">삭제하기</button>
		
		<input type="hidden" id="IDX" name="IDX" value="${map.IDX }">
		<input type="hidden" id="CREA_ID" name="CREA_ID" value="${loginInfo.ID }">
	</form>
</div>

<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
var gfv_count = "${fn:length(list) + 1 }";

$(document).ready(function() {
	$("#list").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardList();
	});
	
	$("#update").unbind("click").click(function(e) {
		e.preventDefault();
		fn_updateBoard();
	});
	
	$("#delete").unbind("click").click(function(e) {
		e.preventDefault();
		fn_deleteBoard();
	});
	
	$("#addFile").unbind("click").click(function(e) {
		e.preventDefault();
		fn_addFile();
	});
});

// 게시물 목록 화면 이동 함수
function fn_openBoardList() {
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardList.do' />");
	comSubmit.submit();
}

// 게시물 수정 함수
function fn_updateBoard() {
	var comSubmit = new ComSubmit("frm");
	comSubmit.setUrl("<c:url value='/bbs/boardUpdate.do' />");
	comSubmit.submit();
}

// 게시물 삭제 함수
function fn_deleteBoard() {
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/boardDelete.do' />");
	comSubmit.addParam("IDX", $("#IDX").val());
	comSubmit.submit();
}

// 첨부파일 추가 이벤트 함수
function fn_addFile() {
	var str = "<p>"
			+ "<input type='file' id='file_" + (gfv_count++) + "' name='file_" + (--gfv_count) + "'>"
			+ "<button class='btn btn-default' id='delete_" + (gfv_count++) + "' onclick='fn_deleteFile(this)'>삭제</button>"
			+ "</p>";
	
	$("#fileDiv").append(str);
}

// 첨부파일 삭제 이벤트 함수
function fn_deleteFile(obj) {
	$(obj).parent().remove();
}
</script>
</body>
</html>