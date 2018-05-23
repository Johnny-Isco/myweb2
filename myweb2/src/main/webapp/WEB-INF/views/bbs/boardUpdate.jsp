<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
<form id="frm">
<table>
	<colgroup>
		<col width="15%" />
		<col width="35%" />
		<col width="15%" />
		<col width="35%" />
	</colgroup>
	
	<caption>게시글 상세</caption>
	
	<tbody>
		<tr>
			<th scope="row">글 번호</th>
			<td>
				${map.IDX }
				<input type="hidden" id="IDX" name="IDX" value="${map.IDX } " />
			</td>
			<th scope="row">조회수</th>
			<td>${map.HIT_CNT }</td>
		</tr>
		<tr>
			<th scope="row">작성자</th>
			<td>${map.CREA_ID }</td>
			<th scope="row">작성시간</th>
			<td>${map.CREA_DTM }</td>
		</tr>
		<tr>
			<th scope="row">제목</th>
			<td colspan="3"><input type="text" class="wdp_90" id="TITLE" name="TITLE" value="${map.TITLE }" /></td>
		</tr>
		<tr>
			<td colspan="4" class="view_text">
				<textarea rows="20" cols="100" title="내용" id="CONTENTS" name="CONTENTS"><c:out value="${map.CONTENTS }" /></textarea>
			</td>
		</tr>
	</tbody>
</table>
</form>

<a href="#" class="btn" id="list">목록으로</a>
<a href="#" class="btn" id="update">저장하기</a>
<a href="#" class="btn" id="delete">삭제하기</a>

<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
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
</script>
</body>
</html>