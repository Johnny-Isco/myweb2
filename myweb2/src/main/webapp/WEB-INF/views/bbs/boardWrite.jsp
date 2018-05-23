<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
<form id="frm">
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

<a href="#" class="btn" id="write">작성하기</a>
<a href="#" class="btn" id="list">목록으로</a>

</form>

<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
$(document).ready(function() {
	$("#list").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardList();
	});
	
	$("#write").unbind("click").click(function(e) {
		e.preventDefault();
		fn_insertBoard();
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

</script>
</body>
</html>