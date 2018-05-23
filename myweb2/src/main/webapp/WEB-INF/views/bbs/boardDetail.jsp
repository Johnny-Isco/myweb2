<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
<table class="board_view">
	<colgroup>
		<col width="15%" />
		<col width="35%" />
		<col width="15%" />
		<col width="35%" />
	</colgroup>
	
	<caption>게시글 상세</caption>
	
	<tbody>
		<tr>
			<th scope="row">글번호</th>
			<td>${map.IDX }</td>
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
			<td colspan="3"><c:out value="${map.TITLE }" />	</td>
		</tr>
		<tr>
			<td colspan="4"><c:out value="${map.CONTENTS }" /></td>
		</tr>
	</tbody>
</table>

<a href="#" class="btn" id="list">목록으로</a>
<a href="#" class="btn" id="update">수정하기</a>

<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
$(document).ready(function(e) {
	$("#list").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardList();
	});
	
	$("#update").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardUpdate();
	});
});

// 게시물 목록 이동 함수
function fn_openBoardList() {
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardList.do' />");
	comSubmit.submit();
}

// 게시물 수정 화면 이동 함수
function fn_openBoardUpdate() {
	var idx = "${map.IDX}";
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardUpdate.do' />");
	comSubmit.addParam("IDX", idx);
	comSubmit.submit();
}
</script>
</body>
</html>