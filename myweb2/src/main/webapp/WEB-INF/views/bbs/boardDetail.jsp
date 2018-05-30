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
		<tr>
			<th scope="row">첨부파일</th>
			<td colspan="3">
				<c:forEach var="row" items="${list }">
					<p>
						<input type="hidden" id="IDX" value="${row.IDX }" />
						<a href="#" name="file"><c:out value="${row.ORIGINAL_FILE_NAME }" /></a>
						(${row.FILE_SIZE }kb)
					</p>
				</c:forEach>
			</td>
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
	
	$("a[name='file']").unbind("click").click(function(e) {
		e.preventDefault();
		fn_downloadFile($(this));
	});
});

// 게시물 목록 이동 함수
function fn_openBoardList() {
	window.location.href="/bbs/openBoardList.do?curPage=" + "${curPage}";
}

// 게시물 수정 화면 이동 함수
function fn_openBoardUpdate() {
	var idx = "${map.IDX}";
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardUpdate.do' />");
	comSubmit.addParam("IDX", idx);
	comSubmit.submit();
}

// 첨부파일 다운로드 함수
function fn_downloadFile(obj) {
	var idx = obj.parent().find("#IDX").val();
	var comSubmit = new ComSubmit();
	var formCount = $("#commonForm");
	comSubmit.setUrl("<c:url value='/common/downloadFile.do' />");
	comSubmit.addParam("IDX", idx);
	comSubmit.submit();
	
	/*
	$.ajax({
		type	: "POST",
		url		: "/common/downloadFile.do",
		data	: {"IDX": idx},
		success	: function(result) {
			alert(result.msg);
			
		},
		error	: function(XHR, textStatus, error) {
			alert(textStatus + " : " +error);
		}
	});
	*/
	/*
	 - 파일 다운로드 후 Form태그의  addParam 태그 삭제
	 1. 파일 다운로드 후 Form태그의 addParam 태그를 삭제하지 않을 경우 다음 파일을 다운로드 받을 때 
	 이전에 받은 파일이 다운로드 되는 이슈가 발생함.
	*/
	if (formCount.length > 0)
	{
	 formCount.children().remove();
	}
}
</script>
</body>
</html>